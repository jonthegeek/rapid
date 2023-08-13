.add_class <- function(x, new_class, ...) {
  check_dots_used()
  UseMethod(".add_class")
}

#' @export
.add_class.list <- function(x, new_class, ...) {
  class(x) <- unique(c(new_class, class(x)))
  return(x)
}

#' @export
.add_class.default <- function(x, ...) {
  stop("I haven't implemented this for anything but list.")
}
