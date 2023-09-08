#' R API definition object
#'
#' An object that represents an API.
#'
#' @inheritParams rlang::args_dots_empty
#' @param info An `info` object defined by [info()].
#' @param servers A `servers` object defined by [servers()].
#'
#' @return A `rapid` S7 object, with properties `info` and `servers`.
#' @export
#'
#' @examples
#' rapid()
#' rapid(
#'   info = info(title = "A", version = "1"),
#'   servers = servers(
#'     url = "https://development.gigantic-server.com/v1"
#'   )
#' )
#' rapid(
#'   info = info(title = "A", version = "1"),
#'   servers = servers(
#'     url = c(
#'       "https://development.gigantic-server.com/v1",
#'       "https://staging.gigantic-server.com/v1",
#'       "https://api.gigantic-server.com/v1"
#'     ),
#'     description = c(
#'       "Development server",
#'       "Staging server",
#'       "Production server"
#'     )
#'   )
#' )
rapid <- S7::new_class(
  "rapid",
  package = "rapid",
  properties = list(
    info = info,
    servers = servers
  ),
  constructor = function(info = class_missing, ..., servers = class_missing) {
    check_dots_empty()
    S7::new_object(NULL, info = info, servers = servers)
  },
  validator = function(self) {
    validate_lengths(
      self,
      key_name = "info",
      optional_any = "servers"
    )
  }
)

#' @export
`length.rapid::rapid` <- function(x) {
  length(x@info)
}

#' Coerce lists and urls to rapid objects
#'
#' `as_rapid()` turns an existing object into a `rapid` object. This is in
#' contrast with [rapid()], which builds a `rapid` object from individual
#' properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @param x The object to coerce. Must be empty or have names "info" and/or
#'   "servers". Extra names are ignored.
#'
#' @return A `rapid` object as returned by [rapid()].
#' @export
#'
#' @examples
#' as_rapid()
as_rapid <- S7::new_generic("as_rapid", dispatch_args = "x")

S7::method(as_rapid, rapid) <- function(x) {
  x
}

S7::method(as_rapid, class_list) <- function(x) {
  x <- .validate_for_as_class(x, rapid)

  rapid(
    info = as_info(x[["info"]]),
    servers = as_servers(x[["servers"]])
  )
}

S7::method(as_rapid, S7::new_S3_class("url")) <- function(x) {
  x <- yaml::read_yaml(x)
  as_rapid(x)
}

S7::method(as_rapid, class_missing | class_null) <- function(x) {
  rapid()
}

S7::method(as_rapid, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls rapid}."
  )
}