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
    name = class_character,
    default = class_character,
    enum = enum_property("enum"),
    description = class_character
  ),
  constructor = function(name = S7::class_missing,
                         default = S7::class_missing,
                         ...,
                         enum = NULL,
                         description = S7::class_missing) {
    check_dots_empty()
    name <- name %||% character()
    default <- default %||% character()
    description <- description %||% character()
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
    ) %|0|% validate_in_enum(
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

#' Coerce lists and character vectors to server_variables
#'
#' `as_server_variable()` turns an existing object into a `server_variable`.
#' This is in contrast with [server_variable()], which builds a
#' `server_variable` from individual properties.
#'
#' @param x The object to coerce. Must be empty or have names "name", "email",
#'   and/or "url". Extra names are ignored.
#'
#' @return A `server_variable` as returned by [server_variable()].
#' @export
#'
#' @examples
#' as_server_variable()
#' as_server_variable(list(name = "Jon Harmon", email = "jonthegeek@gmail.com"))
as_server_variable <- S7::new_generic("as_server_variable", dispatch_args = "x")

S7::method(as_server_variable, server_variable) <- function(x) {
  x
}

S7::method(as_server_variable, class_list) <- function(x) {
  nameless <- unname(x)
  server_variable(
    name = names(x),
    default = purrr::map_chr(nameless, "default"),
    enum = purrr::map(nameless, "enum"),
    description = .extract_along_chr(nameless, "description")
  )
}

S7::method(as_server_variable, class_missing) <- function(x) {
  server_variable()
}

S7::method(as_server_variable, class_any) <- function(x) {
  if (is.null(x)) {
    return(server_variable())
  }
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls server_variable}."
  )
}
