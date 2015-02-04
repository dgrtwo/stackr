#' @param ... Additional arguments to API (see below)
#'
#' @details API querying methods allow the following additional options:
#' \describe{
#'   \item{site}{ID of Stack Exchange site (by default, Stack Overflow)}
#'   \item{sort}{field to sort by}
#'   \item{order}{whether the \code{sort} field should be arranged in descending
#' ("desc") or ascending ("asc") order}
#'   \item{min}{Minimum value of the \code{sort} field}
#'   \item{max}{Maximum value of the \code{sort} field}
#'   \item{fromdate}{Starting date}
#'   \item{todate}{Ending date}
#'   \item{page}{Which page to start from}
#'   \item{pagesize}{Size of each page to extract (max 100)}
#'   \item{num_pages}{Number of pages to extract}
#' }
