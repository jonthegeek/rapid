#' A collection of string replacements for multiple servers
#'
#' A list of string replacements objects, each of which is constructed with
#' [string_replacements()].
#'
#' @param ... One or more [string_replacements()] objects, or a list of
#'   [string_replacements()] objects.
#'
#' @return A `server_variables` S7 object, which is a validated list of
#'   [string_replacements()] objects.
#' @export
#'
#' @examples
#' server_variables(
#'   list(string_replacements(), string_replacements())
#' )
server_variables <- S7::new_class(
  "server_variables",
  package = "rapid",
  parent = class_list,
  constructor = function(...) {
    if (...length() == 1 && is.list(..1)) {
      return(S7::new_object(..1))
    }
    S7::new_object(list(...))
  },
  validator = function(self) {
    bad_string_replacements <- !purrr::map_lgl(
      S7::S7_data(self),
      ~ S7::S7_inherits(.x, string_replacements)
    )
    if (any(bad_string_replacements)) {
      bad_locations <- which(bad_string_replacements)
      c(
        cli::format_inline(
          "All values must be {.cls string_replacements} objects."
        ),
        cli::format_inline("Bad values at {bad_locations}.")
      )
    }
  }
)

#' Coerce lists and character vectors to server_variables
#'
#' `as_server_variables()` turns an existing object into a `server_variables`
#' object. This is in contrast with [server_variables()], which builds a
#' `server_variables` object from individual properties.
#'
#' @param x The object to coerce. Must be empty or be a list of objects that can
#'   be coerced to `string_replacements` objects via [as_string_replacements()].
#'
#' @return A `server_variables` object as returned by [server_variables()].
#' @export
#'
#' @examples
#' as_server_variables()
#' as_server_variables(
#'   list(
#'     list(
#'       username = c(default = "demo", description = "Name of the user.")
#'     ),
#'     list(
#'       username = c(
#'         default = "demo",
#'         description = "Name of the user."
#'       ),
#'       port = list(
#'         default = "8443",
#'         enum = c("8443", "443")
#'       )
#'     )
#'   )
#' )
as_server_variables <- S7::new_generic("as_server_variables", dispatch_args = "x")

S7::method(as_server_variables, server_variables) <- function(x) {
  x
}

S7::method(as_server_variables, class_list) <- function(x) {
  if (!length(x) || !any(lengths(x))) {
    return(server_variables())
  }
  server_variables(
    purrr::map(x, as_string_replacements)
  )
}

S7::method(as_server_variables, class_missing | class_null) <- function(x) {
  server_variables()
}

S7::method(as_server_variables, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls server_variables}."
  )
}
