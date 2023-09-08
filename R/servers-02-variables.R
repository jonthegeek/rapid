# TODO: Implement as_*.

#' A collection of server variables for multiple servers
#'
#' A list of server variable objects, each of which is constructed with
#' [server_variable()].
#'
#' @param ... One or more [server_variable()] objects, or a list of
#'   [server_variable()] objects.
#'
#' @return A `variables` S7 object, which is a validated list of
#'   [server_variable()] objects.
#' @export
#'
#' @examples
#' variables(
#'   list(server_variable(), server_variable())
#' )
variables <- S7::new_class(
  "variables",
  package = "rapid",
  parent = class_list,
  constructor = function(...) {
    if (...length() == 1 && is.list(..1)) {
      return(S7::new_object(..1))
    }
    S7::new_object(list(...))
  },
  validator = function(self) {
    bad_server_vars <- !purrr::map_lgl(
      S7::S7_data(self),
      ~ S7::S7_inherits(.x, server_variable)
    )
    if (any(bad_server_vars)) {
      bad_locations <- which(bad_server_vars)
      c(
        cli::format_inline(
          "All values must be {.cls server_variable} objects."
        ),
        cli::format_inline("Bad values at {bad_locations}.")
      )
    }
  }
)

#' Coerce lists and character vectors to variables
#'
#' `as_variables()` turns an existing object into a `variables`. This is in
#' contrast with [variables()], which builds a `variables` from individual
#' properties.
#'
#' @param x The object to coerce. Must be empty or have names "name", "email",
#'   and/or "url". Extra names are ignored.
#'
#' @return A `variables` as returned by [variables()].
#' @export
#'
#' @examples
#' as_variables()
#' as_variables(list(name = "Jon Harmon", email = "jonthegeek@gmail.com"))
as_variables <- S7::new_generic("as_variables", dispatch_args = "x")

S7::method(as_variables, variables) <- function(x) {
  x
}

S7::method(as_variables, class_list) <- function(x) {
  variables(
    purrr::map(x, as_server_variable)
  )
}

S7::method(as_variables, class_missing) <- function(x) {
  variables()
}

S7::method(as_variables, class_any) <- function(x) {
  if (is.null(x)) {
    return(variables())
  }
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls variables}."
  )
}
