#' @include components-security_scheme_type.R
NULL

#' API key security schemes
#'
#' Defines one or more API key security schemes that can be used by the
#' operations.
#'
#' @inheritParams security_scheme_type
#' @param parameter_name Character (required). The names of the header, query or
#'   cookie parameters to be used.
#' @param `in` Character (required). The location of the API key. Valid values
#'   are "query", "header" or "cookie".
#'
#' @return An `api_key_security_scheme` S7 object, with fields `name`,
#'   `description`, `parameter_name`, and `in`.
#' @export
#'
#' @seealso [as_api_key_security_scheme()] for coercing objects to
#'   `api_key_security_scheme`.
#'
#' @examples
#' api_key_security_scheme(
#'   "api_key_example",
#'   description = "API key security scheme example",
#'   parameter_name = "Authorization",
#'   `in` = "header"
#' )
api_key_security_scheme <- S7::new_class(
  name = "api_key_security_scheme",
  package = "rapid",
  parent = security_scheme_type,
  properties = list(
    parameter_name = class_character,
    `in` = class_character
  ),
  constructor = function(name = class_missing,
                         parameter_name = class_missing,
                         `in` = class_missing,
                         ...,
                         description = class_missing) {
    check_dots_empty()
    name <- name %||% character()
    parameter_name <- parameter_name %||% character()
    `in` <- `in` %||% character()
    description <- description %||% character()
    S7::new_object(
      S7::S7_object(),
      name = name,
      parameter_name = parameter_name,
      `in` = `in`,
      description = description
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = c("parameter_name", "in")
    ) %|0|% validate_in_fixed(
      self,
      "in",
      c("query", "header", "cookie")
    )
  }
)

S7::method(length, api_key_security_scheme) <- function(x) {
  length(x@name)
}

#' Coerce lists to API key security schemes
#'
#' `as_api_key_security_scheme()` turns an existing object into a
#' `api_key_security_scheme`. This is in contrast with
#' [api_key_security_scheme()], which builds a `api_key_security_scheme` from
#' individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @param x The object to coerce. Must be empty or be a list of named lists,
#'   each with names "description", "name", and/or "in". Additional names are
#'   ignored.
#'
#' @return A `api_key_security_scheme` as returned by
#'   [api_key_security_scheme()].
#' @export
as_api_key_security_scheme <- S7::new_generic(
  "as_api_key_security_scheme",
  dispatch_args = "x"
)

S7::method(as_api_key_security_scheme, api_key_security_scheme) <- function(x) {
  x
}

S7::method(as_api_key_security_scheme, class_list) <- function(x) {
  call <- rlang::caller_env()
  x <- purrr::map(
    x,
    function(x) {
      .validate_for_as_class(
        x,
        api_key_security_scheme,
        x_arg = "x[[i]]",
        call = call
      )
    }
  )

  nameless <- unname(x)
  api_key_security_scheme(
    name = names(x),
    description = .extract_along_chr(nameless, "description"),
    parameter_name = purrr::map_chr(nameless, "name"),
    `in` = purrr::map_chr(nameless, "in")
  )
}

S7::method(as_api_key_security_scheme, class_missing | NULL) <- function(x) {
  api_key_security_scheme()
}

S7::method(as_api_key_security_scheme, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls api_key_security_scheme}."
  )
}
