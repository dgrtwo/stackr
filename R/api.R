# API utilities

#' Parse the results of a Stack Exchange API query into a data.frame.
#'
#' The additional metadata, such as "has_more", "quota_max", and
#' "quota_remaining" is included in a list as the attribute "metadata".
#'
#' @param req a request from httr::GET
#'
#' @importFrom httr content
#' @importFrom jsonlite fromJSON
stack_parse <- function(req) {
    text <- content(req, as = "text")

    if (identical(text, "")) stop("No output to parse", call. = FALSE)

    j <- fromJSON(text)
    if (!is.null(j$error_id)) {
        stop(paste0("Error ", j$error_id, ": ", j$error_message))
    }
    items <- j$items

    if (length(items) == 0 || nrow(items) == 0) {
        return(NULL)
    }

    # fix tags to be comma-separated
    if (!is.null(items$tags)) {
        items$tags <- sapply(items$tags, paste, collapse = ",")
    }
    # "shallow user" ends up being a data.frame. Turn it into separate
    # columns
    if (any(sapply(items, is.data.frame))) {
        items <- do.call(cbind, items)
    }
    # replace dots, as in owner.user_id, with _
    colnames(items) <- gsub("\\.", "_", colnames(items))
    # convert all dates, which fortunately always end in _date
    for (col in colnames(items)) {
        if (grepl("_date$", col)) {
            items[[col]] <- as.POSIXct(items[[col]], origin = "1970-01-01")
        }
    }

    # add metadata as an attribute
    attr(items, "metadata") <- j[-1]

    items
}


#' Make a GET request to the Stack Exchange API
#'
#' @param path the query path, such as "answers/" or "users/{id}"
#' @param site site to query; by default Stack Overflow
#' @param page which page to start from
#' @param num_pages number of consecutive pages to query; by default 1
#' @param ... additional parameters to the method
#'
#' @importFrom httr GET
#' @import dplyr
stack_GET <- function(path, site = "stackoverflow", page = 1, num_pages = 1, ...) {
    # auth <- github_auth(pat)
    base_path <- "https://api.stackexchange.com/2.2/"
    query <- list(site = site, page = page, ...)

    stack_key <- Sys.getenv("STACK_EXCHANGE_KEY")
    if (stack_key != "") {
        query$key <- stack_key
    }

    tbls <- NULL
    tbl <- NULL
    while (num_pages > 0) {
        req <- GET(base_path, path = path, query = query)

        tbl <- stack_parse(req)
        tbls <- c(tbls, list(tbl))

        if (!attr(tbl, "metadata")$has_more) {
            # finished pagination, can quit
            break
        }

        # set up for next iteration
        query$page <- query$page + 1
        num_pages <- num_pages - 1
    }

    # combine them all
    ret <- as.data.frame(dplyr::bind_rows(tbls))
    attr(ret, "metadata") <- attr(tbl, "metadata")
    ret
}


#' construct a query URL for a request, including checking special
#' operations
#'
#' @param base base of query, such as "answers" or "questions"
#' @param id vector of IDs to search
#' @param special special parameter, which specifies the action (such as
#' retrieving an associated object with an ID)
#' @param special_ids vector of possible special parameters that require IDs
#' @param special_no_ids vector of possible special parameters that don't
#' require IDs
combine_url <- function(base, id, special = NULL, special_ids = c(),
                        special_no_ids = c()) {
    url <- paste0(base, "/")

    if (!is.null(id)) {
        url <- paste0(url, paste(id, collapse = ";"), "/")
    }

    if (!is.null(special)) {
        special <- match.arg(special, c(special_ids, special_no_ids))

        if (is.null(id)) {
            if (!(special %in% special_no_ids)) {
                stop(paste(special, "requires one or more IDs"))
            }
        } else {
            if (!(special %in% special_ids)) {
                stop(paste(special, "does not accept IDs"))
            }
        }
        url <- paste0(url, special)
    }

    url
}
