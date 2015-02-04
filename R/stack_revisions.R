#' Query revisions from the Stack Exchange API
#'
#' Query for revisions (edits), based on particular IDs
#'
#' @param id A vector containing one or more IDs of revisions
#' @template api_options
#'
#' @return A \code{data.frame} of revisions (TODO)
#'
#' @details Note that unlike IDs of other types in the API, revision IDs are
#' strings.
#'
#' @export
stack_revisions <- function(id, ...) {
    if (missing(id) || is.null(id)) {
        stop("stack_revisions requires one or more IDs")
    }
    url <- combine_url("revisions", id)
    stack_GET(url, ...)
}
