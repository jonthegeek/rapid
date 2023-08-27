# enable usage of <S7_object>@name in package code
#' @rawNamespace if (getRversion() < "4.3.0") importFrom("S7", "@")
NULL

.onAttach <- function(libname, pkgname) {
  if (getRversion() < "4.3.0")
    require(S7)
}

.onLoad <- function(...) {
  S7::methods_register()
}
