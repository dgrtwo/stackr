#' Query badges from the Stack Exchange API
#'
#' Query for badges from a particular site
#'
#' @param id A vector containing one or more IDs of badges, or none to
#' retrieve all badges in alphabetical order
#' @param special One of \code{c("name", "tags", "recipients")}, to
#' retrive only non-tag badges, only tag badges, or to retrieve recipients
#' of the given badges
#' @template api_options
#'
#' @return A \code{data.frame} of badges (TODO)
#'
#' @export
stack_badges <- function(id = NULL, special = NULL, ...) {
    # note that "recipients" can be used with or without IDs
    special_ids <- c("recipients")
    special_no_ids <- c("name", "tags", "recipients")

    url <- combine_url("badges", id, special, special_ids, special_no_ids)
    stack_GET(url, ...)
}
