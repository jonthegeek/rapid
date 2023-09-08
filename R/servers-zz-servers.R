#' An object representing a collection of servers
#'
#' Connectivity information for an API.
#'
#' @param url A character vector of urls.
#' @param description A character vector of (usually brief) descriptions of
#'   those urls.
#' @param variables A [server_variables()] object.
#'
#' @return A `servers` S7 object, with properties `url`, `description`, and
#'   `variables`.
#' @export
#'
#' @examples
#' servers(
#'   url = c(
#'     "https://development.gigantic-server.com/v1",
#'     "https://staging.gigantic-server.com/v1",
#'     "https://api.gigantic-server.com/v1"
#'   ),
#'   description = c(
#'     "Development server",
#'     "Staging server",
#'     "Production server"
#'   )
#' )
#' servers(
#'   url = "https://{username}.gigantic-server.com:{port}/{basePath}",
#'   description = "The production API server",
#'   variables = server_variables(string_replacements(
#'     name = c("username", "port", "basePath"),
#'     default = c("demo", "8443", "v2"),
#'     description = c(
#'       "The active user's folder.",
#'       NA, NA
#'     ),
#'     enum = list(
#'       NULL,
#'       c("8443", "443"),
#'       NULL
#'     )
#'   ))
#' )
servers <- S7::new_class(
  "servers",
  package = "rapid",
  properties = list(
    url = class_character,
    description = class_character,
    variables = server_variables
  ),
  validator = function(self) {
    validate_parallel(
      self,
      "url",
      optional = c("description", "variables")
    )
  }
)

#' @export
`length.rapid::servers` <- function(x) {
  length(x@url)
}

#' Coerce lists and character vectors to servers
#'
#' `as_servers()` turns an existing object into a `servers`. This is in
#' contrast with [servers()], which builds a `servers` from individual
#' properties.
#'
#' @param x The object to coerce. Must be empty or have names "name", "email",
#'   and/or "url". Extra names are ignored.
#'
#' @return A `servers` as returned by [servers()].
#' @export
#'
#' @examples
#' as_servers()
#' as_servers(list(name = "Jon Harmon", email = "jonthegeek@gmail.com"))
as_servers <- S7::new_generic("as_servers", dispatch_args = "x")

S7::method(as_servers, servers) <- function(x) {
  x
}

S7::method(as_servers, class_list | class_character) <- function(x) {
  servers(
    url = purrr::map_chr(x, "url"),
    description = purrr::map_chr(x, "description"),
    variables = as_server_variables(purrr::map(x, "variables"))
  )
}

S7::method(as_servers, class_missing) <- function(x) {
  servers()
}

S7::method(as_servers, class_any) <- function(x) {
  if (is.null(x)) {
    return(servers())
  }
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls servers}."
  )
}
