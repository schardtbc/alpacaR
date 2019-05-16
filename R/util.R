
#' return first argument that is not null
#'
#' @export
coalesce <- function(a,b,...) {
  if (!is.null(a)){
    return(a)
  }
  if (missing(b)){
    return (NULL)
  }
  coalesce(b,...)
}
