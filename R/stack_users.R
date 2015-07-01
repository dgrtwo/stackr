#' Query information about users from the Stack Exchange API
#'
#' Query for a list of users, or information related to one or more
#' specific users.
#'
#' @param id A vector containing one or more user IDs
#' @param special One of many options to describe what information to
#' extract from each user
#' @template api_options
#'
#' @return A \code{data.frame} containing each returned user
#'
#' @return A \code{data.frame} of users
#'
#' @export
stack_users <- function(id = NULL, special = NULL, ...) {
    special_id<- c("top-answer-tags", "top-question-tags", "top-tags",
                            "privileges", "notifications")
    special_ids <- c("answers", "badges", "comments", "favorites", "mentioned",
                     "network-activity", "posts", "questions", "reputation",
                     "reputation-history", "suggested-edits", "tags",
                     special_id)

    special_no_ids <- c("moderators")

    if ((!is.null(special) && (special %in% special_id)) && length(id) > 1) {
        stop(paste(special, "can be used only with a single ID"))
    }

    url <- combine_url("users", id, special, special_ids, special_no_ids)

    stack_GET(url, ...)
}
