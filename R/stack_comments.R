#' Query comments from the Stack Exchange API
#'
#' Query for comments, either based on IDs or on other filters.
#'
#' @param id A vector containing one or more IDs, or none to query
#' all comments
#' @template api_options
#'
#' @return A \code{data.frame} of questions or answers (TODO)
#'
#' @export
stack_comments <- function(id = NULL, ...) {
    url <- combine_url("comments", id)
    stack_GET(url, ...)
}
