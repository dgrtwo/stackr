#' Query questions from the Stack Exchange API
#'
#' Query for a list of questions, or information related to a one or more
#' specific questions.
#'
#' @param id A vector containing one or more answer IDs
#' @param special One of \code{c("answers", "comments", "linked", "related",
#' "timeline")}, describing what information to retrieve about specific questions, or
#' one of \code{c("featured", "no-answers", "unanswered")}, describing a filter
#' to place on returned quesitons.
#' @template api_options
#'
#' @return A \code{data.frame} of questions.
#'
#' @template type_question
#'
#' @export
stack_questions <- function(id = NULL, special = NULL, ...) {
    special_ids <- c("answers", "comments", "linked", "related", "timeline")
    special_no_ids <- c("featured", "no-answers", "unanswered")

    url <- combine_url("questions", id, special, special_ids, special_no_ids)

    stack_GET(url, ...)
}
