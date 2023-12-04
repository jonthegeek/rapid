#' @include properties.R
NULL

#' A set of variables for server URL template substitution
#'
#' A `string_replacements` object describes server variable properties used for
#' substitution in a single server’s URL template.
#'
#' @inheritParams rlang::args_dots_empty
#' @param name Character vector (required). The names of the variables.
#' @param default Character vector (required). The default value to use for
#'   substitution of each variable, which shall be sent if an alternate value is
#'   not supplied. Note this behavior is different than the Schema Object’s
#'   treatment of default values, because in those cases parameter values are
#'   optional. If the `enum` is defined, the value must exist in the enum’s
#'   values.
#' @param enum List of (potentially empty) character vectors (optional). An
#'   enumeration of valid string values to be used if the substitution options
#'   are from a limited set.
#' @param description Character vector (optional). An optional description for
#'   each server variable. [CommonMark syntax](https://spec.commonmark.org/) may
#'   be used for rich text representation.
#'
#' @return A `string_replacements` S7 object describing a collection of string
#'   variables for a single server, with fields `name`, `default`, `enum`, and
#'   `description`.
#' @export
#'
#' @seealso [as_string_replacements()] for coercing objects to
#'   `string_replacements`, and [class_server_variables()] for creating
#'   collections of `string_replacements`.
#'
#' @examples
#' class_string_replacements(
#'   "username",
#'   "demo",
#'   enum = c("demo", "other"),
#'   description = "The active user's folder."
#' )
class_string_replacements <- S7::new_class(
  "string_replacements",
  package = "rapid",
  properties = list(
    name = class_character,
    default = class_character,
    enum = enum_property_rename("enum"),
    description = class_character
  ),
  constructor = function(name = character(),
                         default = character(),
                         ...,
                         enum = list(),
                         description = character()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      name = name %||% character(),
      default = default %||% character(),
      enum = enum,
      description = description %||% character()
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "default",
      optional = c("enum", "description")
    ) %|0|% validate_in_enums(
      self,
      value_name = "default",
      enum_name = "enum"
    )
  }
)

S7::method(length, class_string_replacements) <- function(x) {
  length(x@name)
}

#' Coerce lists to string_replacements
#'
#' `as_string_replacements()` turns an existing object into a
#' `string_replacements`. This is in contrast with
#' [class_string_replacements()], which builds a `string_replacements` from
#' individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list of named lists,
#'   each with names "enum", "default", or "description", or names that can be
#'   coerced to those names via [snakecase::to_snake_case()]. Additional names
#'   are ignored.
#'
#' @return A `string_replacements` as returned by [class_string_replacements()].
#' @export
#'
#' @examples
#' as_string_replacements()
#' as_string_replacements(
#'   list(
#'     username = c(
#'       default = "demo",
#'       description = "Name of the user."
#'     ),
#'     port = list(
#'       default = "8443",
#'       enum = c("8443", "443")
#'     )
#'   )
#' )
as_string_replacements <- S7::new_generic("as_string_replacements", "x")

S7::method(as_string_replacements, class_list) <- function(x) {
  nameless <- unname(x)
  class_string_replacements(
    name = names(x),
    default = purrr::map_chr(nameless, "default"),
    enum = purrr::map(nameless, "enum"),
    description = .extract_along_chr(nameless, "description")
  )
}

S7::method(as_string_replacements, class_any) <- function(x,
                                                          ...,
                                                          arg = caller_arg(x),
                                                          call = caller_env()) {
  as_api_object(x, class_string_replacements, ..., arg = arg, call = call)
}
