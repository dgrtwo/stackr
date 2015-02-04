#' Query privileges for a Stack Exchange site
#'
#' Query for reputation-based privileges from a Stack Exchange site.
#'
#' @param site Stack Exchange site to query (default Stack Overflow)
#' @param ... Additional API arguments (not used)
#'
#' @return A one-row \code{data.frame} containing statistics
#' about the site.
#'
#' @export
stack_privileges <- function(site = "stackoverflow", ...) {
    stack_GET("privileges", site = site, ...)
}
