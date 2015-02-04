#' Search a Stack Exchange site via the API
#'
#' Access the Stack Exchange search functionality.
#'
#' @param intitle string to use for searching title
#' @param tagged vector of tags that must be included in questions
#' @param nottagged vector of tags to be excluded from questions
#' @param q free form text parameter that matches questions based on Stack
#' Exchange's (undocumented) algorithm
#' @param accepted boolean to filter for accepted or unaccepted questions
#' @param answers minimum number of answers
#' @param body text that must appear in the body of questions
#' @param closed boolean to filter for open or closed questions
#' @param migrated boolean to filter for questions that were, or were not,
#' migrated to another site
#' @param notice boolean to filter for questions with a post notice
#' @param title text which must appear in a title; redundant with intitle above
#' @param user the id of the user to filter for
#' @param url url that must be included in the question
#' @param views the minimum number of views a question can have
#' @param wiki boolean to filter for questions that are (or are not) community
#' wiki
#' @template api_options
#'
#' @return A \code{data.frame} of questions.
#'
#' @template type_question
#'
#' @details The values that can be used for \code{sort} are:
#' \describe{
#'   \item{activity}{Last activity date}
#'   \item{creation}{Creation date}
#'   \item{votes}{Score}
#'   \item{relevance}{Relevance tab on site (does not allow min or max)}
#' }
#'
#' @export
stack_search <- function(intitle, tagged, nottagged, q, accepted,
                         answers, body, closed, migrated,
                         notice, title, user, url, views, wiki, ...) {
    # pass arguments on to stack_GET
    args <- as.list(match.call())[-1]

    if (is.null(args$tagged) && is.null(args$intitle)) {
        stop("Either tagged or intitle must be set in searches")
    }

    url <- "search/"
    extra_args <- c("q", "accepted", "answers", "body", "closed", "migrated",
                    "notice", "title", "user", "url", "views", "wiki")
    if (any(names(args) %in% extra_args)) {
        url <- paste0(url, "advanced/")

        # replace intitle with title
        if (!is.null(args$intitle)) {
            if (!is.null(args$title)) {
                stop("Cannot provide both title and intitle")
            }
            args$title <- args$intitle
        }
    }
    do.call(stack_GET, c(list(url), args))
}
