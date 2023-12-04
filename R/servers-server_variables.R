#' A collection of string replacements for multiple servers
#'
#' A list of string replacements objects, each of which is constructed with
#' [class_string_replacements()].
#'
#' @param ... One or more [class_string_replacements()] objects, or a list of
#'   [class_string_replacements()] objects.
#'
#' @return A `server_variables` S7 object, which is a validated list of
#'   [class_string_replacements()] objects.
#' @export
#'
#' @seealso [as_server_variables()] for coercing objects to `server_variables`.
#'
#' @examples
#' class_server_variables(
#'   list(class_string_replacements(), class_string_replacements())
#' )
class_server_variables <- S7::new_class(
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
      ~ S7_inherits(.x, class_string_replacements)
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

#' Coerce lists to server_variables
#'
#' `as_server_variables()` turns an existing object into a `server_variables`
#' object. This is in contrast with [class_server_variables()], which builds a
#' `server_variables` object from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list of objects that can
#'   be coerced to `string_replacements` objects via [as_string_replacements()].
#'
#' @return A `server_variables` object as returned by [class_server_variables()].
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
as_server_variables <- S7::new_generic("as_server_variables", "x")

S7::method(as_server_variables, class_list) <- function(x) {
  if (!length(x) || !any(lengths(x))) {
    return(class_server_variables())
  }
  class_server_variables(
    purrr::map(x, as_string_replacements)
  )
}

S7::method(as_server_variables, class_any) <- function(x,
                                                       ...,
                                                       arg = caller_arg(x),
                                                       call = caller_env()) {
  as_api_object(x, class_server_variables, ..., arg = arg, call = call)
}
