#' Query answers from the Stack Exchange API
#'
#' Query for a list of answers, or information related to a one or more
#' specific answers.
#'
#' @param id A vector containing one or more answer IDs, or none to query
#' all answers
#' @param special If \code{"comments"}, return the comments on the answers
#' rather than the answers themselves
#' @template api_options
#'
#' @return A \code{data.frame} of answers.
#'
#' @template type_answer
#'
#' @export
stack_answers <- function(id = NULL, special = NULL, ...) {
    url <- combine_url("answers", id, special, c("comments", "questions"))
    stack_GET(url, ...)
}
