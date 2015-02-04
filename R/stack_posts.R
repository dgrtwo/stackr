#' Query posts from the Stack Exchange API
#'
#' Query for posts, either questions or answers, based on IDs.
#'
#' @param id A vector containing one or more IDs, or none to query
#' all questions and answers
#' @param special One of \code{c("comments", "revisions", "suggested-edits")}, to
#' return that information associated with the specified answers rather than the
#' answers themselves
#' @template api_options
#'
#' @return A \code{data.frame} of questions or answers (TODO)
#'
#' @export
stack_posts <- function(id = NULL, special = NULL, ...) {
    special_ids <- c("comments", "revisions", "suggested-edits")
    url <- combine_url("posts", id, special, special_ids)
    stack_GET(url, ...)
}
