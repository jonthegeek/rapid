#' @include properties.R
#' @include components-security_scheme.R
NULL

#' API key security schemes
#'
#' Defines an API key security scheme that can be used by the operations.
#'
#' @param parameter_name Character vector (required). The names of the header,
#'   query or cookie parameters to be used.
#' @param location Character vector (required). The location of the API key.
#'   Valid values are "query", "header" or "cookie".
#'
#' @return An `api_key_security_scheme` S7 object, with fields `parameter_name`
#'   and `location`.
#' @export
#'
#' @examples
#' api_key_security_scheme(
#'   parameter_name = "Authorization",
#'   location = "header"
#' )
api_key_security_scheme <- S7::new_class(
  name = "api_key_security_scheme",
  package = "rapid",
  parent = security_scheme,
  properties = list(
    parameter_name = character_scalar_property("parameter_name"),
    location = character_scalar_property("location")
  ),
  constructor = function(parameter_name = character(),
                         location = character()) {
    S7::new_object(
      S7::S7_object(),
      parameter_name = parameter_name,
      location = location
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "parameter_name",
      required = "location"
    ) %|0|% validate_in_fixed(
      self,
      "location",
      c("query", "header", "cookie")
    )
  }
)

S7::method(length, api_key_security_scheme) <- function(x) {
  length(x@parameter_name)
}

#' Coerce lists and character vectors to API key security schemes
#'
#' `as_api_key_security_scheme()` turns an existing object into an
#' `api_key_security_scheme`. This is in contrast with
#' [api_key_security_scheme()], which builds an `api_key_security_scheme` from
#' individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list or character vector
#'   with names "name" and either "in" or "location", or names that can be
#'   coerced to those names via [snakecase::to_snake_case()]. Additional names
#'   are ignored.
#'
#' @return An `api_key_security_scheme` as returned by
#'   [api_key_security_scheme()].
#' @export
as_api_key_security_scheme <- S7::new_generic(
  "as_api_key_security_scheme",
  dispatch_args = "x"
)

S7::method(as_api_key_security_scheme, api_key_security_scheme) <- function(x) {
  x
}

S7::method(
  as_api_key_security_scheme,
  class_list | class_character
) <- function(x) {
  .as_class(
    x,
    api_key_security_scheme,
    extra_names = c("in" =  "location", "name" = "parameter_name")
  )
}

S7::method(
  as_api_key_security_scheme,
  class_missing | NULL | S7::new_S3_class("S7_missing")
) <- function(x) {
  api_key_security_scheme()
}

S7::method(
  as_api_key_security_scheme,
  class_any
) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls api_key_security_scheme}."
  )
}
