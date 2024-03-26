#' @include properties.R
NULL

#' Reusable input and output data type definitions
#'
#' The `schema` object allows the definition of input and output data types.
#' These types can be objects, but also primitives and arrays. This object is a
#' superset of the [JSON Schema Specification Draft
#' 2020-12](https://datatracker.ietf.org/doc/html/draft-bhutton-json-schema-00).
#'
#' @inheritParams rlang::args_dots_empty
#' @param type Factor (or coercible to factor). The type of object being
#'   defined. Currently must be one of "string", "number", "integer", "boolean",
#'   "array", or "object".
#' @param nullable Logical scalar (default `FALSE`). Whether the parameter can
#'   be set to `NULL`.
#' @param description Character scalar (optional). A description of the object
#'   defined by the schema.
#' @param format Character scalar (optional). The format of the object.
#'   Essentially a sub-type.
#'
#' @return A `schema` S7 object describing the data type, with fields `type`,
#'   `nullable`, `description`, and `format`.
#' @export
#'
#' @seealso [as_schema()] for coercing objects to `schema`.
#'
#' @examples
#' class_schema("string")
#' class_schema("string", nullable = TRUE, description = "A nullable string.")
class_schema <- S7::new_class(
  name = "schema",
  package = "rapid",
  properties = list(
    type = factor_property(
      "type",
      c("string", "number", "integer", "boolean", "array", "object"),
      max_size = 1
    ),
    nullable = logical_scalar_property("nullable"),
    description = character_scalar_property("description"),
    format = character_scalar_property("format")
  ),
  constructor = function(type = c(
                           "string", "number", "integer",
                           "boolean", "array", "object"
                         ),
                         ...,
                         nullable = FALSE,
                         description = character(),
                         format = character()) {
    check_dots_empty()
    if (missing(type)) {
      type <- character()
      nullable <- logical()
    }
    S7::new_object(
      S7::S7_object(),
      type = type,
      nullable = nullable,
      description = description,
      format = format
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "type",
      required = "nullable",
      optional = c("description", "format")
    )
  }
)

S7::method(length, class_schema) <- function(x) {
  length(x@type)
}

#' Coerce lists to schemas
#'
#' `as_schema()` turns an existing object into a `schema`. This is in contrast
#' with [class_schema()], which builds a `schema` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "type",
#'   "nullable", "description", and/or "format", or names that can be coerced to
#'   those names via [snakecase::to_snake_case()]. Extra names are ignored. This
#'   object should describe a single schema.
#'
#' @return A `schema` as returned by [class_schema()].
#' @export
#'
#' @examples
#' as_schema()
#' as_schema(
#'   list(
#'     type = "string",
#'     format = "date-time",
#'     description = "Timestamp when the event will occur."
#'   )
#' )
as_schema <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  as_api_object(x, class_schema, ..., arg = arg, call = call)
}
