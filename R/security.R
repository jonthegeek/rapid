#' @include properties.R
NULL

#' Security schemes required to execute an operation
#'
#' The object lists the required security schemes to execute an operation or
#' operations.
#'
#' @inheritParams rlang::args_dots_empty
#' @param name Character vector (required). The names must correspond to
#'   security schemes declared in the `security_schemes` property of a
#'   [class_components()].
#' @param required_scopes A list of character vectors, each of which describe
#'   the scopes required for this security scheme. The vector corresponding to a
#'   given `name` can be empty.
#'
#' @return A `security` S7 object with references of security required for
#'   operations.
#' @export
#' @examples
#' class_security()
#' class_security(
#'   name = c("oauth2", "internalApiKey"),
#'   required_scopes = list(
#'     c("user", "user:email", "user:follow"),
#'     character()
#'   )
#' )
class_security <- S7::new_class(
  "security",
  package = "rapid",
  properties = list(
    name = class_character,
    required_scopes = list_of_characters("required_scopes"),
    rapid_class_requirement = S7::new_property(
      getter = function(self) {
        "security_scheme"
      }
    )
  ),
  constructor = function(name = character(), ..., required_scopes = list()) {
    name <- name %|0|% character()
    required_scopes <- required_scopes %|0|%
      purrr::rep_along(name, list(character()))
    S7::new_object(
      S7::S7_object(),
      name = name,
      required_scopes = required_scopes
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "required_scopes"
    )
  }
)

S7::method(length, class_security) <- function(x) {
  length(x@name)
}

#' Coerce lists to as_security objects
#'
#' `as_security()` turns an existing object into a `security` object. This is in
#' contrast with [class_security()], which builds a `security` from individual
#' properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list containing a single
#'   list named "security_schemes", or a name that can be coerced to
#'   "security_schemes" via [snakecase::to_snake_case()]. Additional names are
#'   ignored.
#'
#' @return A `security` object as returned by [class_security()].
#' @export
#'
#' @examples
#' as_security()
#' as_security(
#'   list(
#'     list(
#'       oauth2 = c("user", "user:email", "user:follow")
#'     ),
#'     list(internalApiKey = list())
#'   )
#' )
as_security <- S7::new_generic("as_security", "x")

S7::method(
  as_security,
  class_list
) <- function(x, ..., arg = caller_arg(x)) {
  force(arg)
  x <- .list_remove_wrappers(x)

  if (!rlang::is_named2(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a named list.",
    )
  }
  class_security(
    name = names(x),
    required_scopes = unname(x)
  )
}

S7::method(
  as_security,
  class_any
) <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  as_api_object(x, class_security, ..., arg = arg, call = call)
}
