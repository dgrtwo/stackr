#' Query general info for a Stack Exchange site
#'
#' Query for general information from a site, such as the number of users,
#' answers, and questions, and statistics for activity per minute
#'
#' @param site Stack Exchange site to query (default Stack Overflow)
#' @param ... Additional API arguments (not used)
#'
#' @return A one-row \code{data.frame} containing statistics
#' about the site.
#'
#' @export
stack_info <- function(site = "stackoverflow", ...) {
    stack_GET("info", site = site, ...)
}
