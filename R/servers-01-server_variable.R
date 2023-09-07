# TODO: Implement as_*.

#' A server variable for server URL template substitution
#'
#' Server variable properties used for substitution in the server’s URL
#' template.
#'
#' @inheritParams rlang::args_dots_empty
#' @param name Character vector (required). The names of the variables.
#' @param default Character vector (required). The default value to use for
#'   substitution of each variable, which *shall* be sent if an alternate value
#'   is not supplied. Note this behavior is different than the Schema Object’s
#'   treatment of default values, because in those cases parameter values are
#'   optional. If the `enum` is defined, the value *must* exist in the enum’s
#'   values.
#' @param enum List of (potentially empty) character vectors (optional). An
#'   enumeration of string values to be used if the substitution options are
#'   from a limited set.
#' @param description Character vector (optional). An optional description for
#'   each server variable. [CommonMark syntax](https://spec.commonmark.org/)
#'   *may* be used for rich text representation.
#'
#' @return A `server_variable` S7 object, with fields `name`, `default`, `enum`,
#'   and `description`.
#' @export
#'
#' @examples
#' server_variable(
#'   "username",
#'   "demo",
#'   enum = c("demo", "other"),
#'   description = "The active user's folder."
#' )
server_variable <- S7::new_class(
  "server_variable",
  package = "rapid",
  properties = list(
    name = S7::class_character,
    default = S7::class_character,
    enum = enum_property("enum"),
    description = S7::class_character
  ),
  constructor = function(name = character(),
                         default = character(),
                         ...,
                         enum = NULL,
                         description = character()) {
    check_dots_empty()
    S7::new_object(
      NULL,
      name = name,
      default = default,
      enum = enum,
      description = description
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "default",
      optional = c("enum", "description")
    ) %||% validate_in_enum(
      self,
      value_name = "default",
      enum_name = "enum"
    )
  }
)

#' @export
`length.rapid::server_variable` <- function(x) {
  length(x@name)
}
