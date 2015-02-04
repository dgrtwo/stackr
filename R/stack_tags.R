#' Query tags from the Stack Exchange API
#'
#' Query for tags, either based on names or on other filters.
#'
#' @param name A vector containing one or more names of tags, or none to query
#' from all tags
#' @param special One of \code{c("faq", "related", "synonyms", "wikis")}, to
#' extract information about a particular tag, or one of
#' \code{c("moderator-only", "required", "synonyms")}, to request a list of a
#' particular kind of tags, or all synonyms on the site.
#' @template api_options
#'
#' @return A \code{data.frame} of questions or answers (TODO)
#'
#' @details The options for the "sort" field are \code{c("creation",
#' "approval", "rejection")}, with \code{"creation"} the default.
#'
#' @export
stack_tags <- function(name = NULL, special = NULL, ...) {
    if (!is.null(name) && is.null(special)) {
        # tags has a different naming convention, where "info" extracts from tags
        special <- "info"
    }
    special_ids <- c("faq", "related", "synonyms", "wikis", "info")
    special_no_ids <- c("moderator-only", "required", "synonyms")

    # TODO: top answerers/askers in a tag

    url <- combine_url("tags", name, special, special_ids, special_no_ids)
    stack_GET(url, ...)
}
