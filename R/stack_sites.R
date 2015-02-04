#' Query sites from the Stack Exchange API
#'
#' Query for a list of sites in the network
#'
#' @param ... Extra options are \code{page} and \code{pagesize}
#'
#' @return A \code{data.frame} of sites
#'
#' @export
stack_sites <- function(...) {
    stack_GET("sites/", site = NULL, ...)
}
