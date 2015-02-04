#' Query suggested edits from the Stack Exchange API
#'
#' Query for suggested edits, either based on IDs or on other filters.
#'
#' @param id A vector containing one or more IDs, or none to query
#' all suggested edits
#' @template api_options
#'
#' @return A \code{data.frame} of questions or answers (TODO)
#'
#' @details The options for the "sort" field are \code{c("creation",
#' "approval", "rejection")}, with \code{"creation"} the default.
#'
#' @export
stack_suggested_edits <- function(id = NULL, ...) {
    url <- combine_url("suggested-edits", id)
    stack_GET(url, ...)
}
