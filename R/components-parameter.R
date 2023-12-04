#' @include components-schema.R
NULL

#' A single operation parameter
#'
#' A parameter for use in one or more `path` or `operation` objects.
#'
#' @param parameter_name Character scalar. The name of the parameter. Parameter
#'   names are case sensitive.
#' @param location Factor (or coercible to factor). The location of the
#'   parameter in the API call. Possible values are "query", "header", "path",
#'   or "cookie".
#' @param schema [class_schema()]. The schema defining the data type of the
#'   parameter.
#' @param style Factor (or coercible to factor, optional). Describes how the
#'   parameter value will be serialized depending on the type of the parameter
#'   value. Possible values are "matrix", "label", "form", "simple",
#'   "spaceDelimited", "pipeDelimited", or "deepObject". Default values (set
#'   automatically by [parameter_style_default()] based on the value of
#'   `location`): for query - "form"; for path - "simple"; for header -
#'   "simple"; for cookie - "form".
#' @param description Character scalar (optional). A brief description of the
#'   parameter. This could contain examples of use. [CommonMark
#'   syntax](https://spec.commonmark.org/) may be used for rich text
#'   representation.
#' @param required Logical scalar (optional). Determines whether this parameter
#'   is mandatory. If the parameter location is "path", this property is
#'   required and its value must be `TRUE`. Otherwise, the property may be
#'   included, and its default value is `FALSE`. Default values are set
#'   automatically by [parameter_required_default()] based on the valu of
#'   `location`.
#' @param allow_empty_value Logical scalar (optional). Sets the ability to pass
#'   empty-valued parameters. This is valid only for "query"parameters, and
#'   allows sending a parameter with an empty value. Default `FALSE`.
#' @param allow_reserved Logical scalar (optional). Determines whether the
#'   parameter value should allow reserved characters, as defined by
#'   [RFC3986](https://www.rfc-editor.org/rfc/rfc3986) `:/?#[]@!$&'()*+,;=` to
#'   be included without percent-encoding. This property only applies to "query"
#'   and "path" parameters.  Default `FALSE`.
#' @param explode Logical scalar (optional). When this is `TRUE`, parameter
#'   values of type "array" or "object" generate separate parameters for each
#'   value of the array or key-value pair of the map. For other types of
#'   parameters this property has no effect. When `style` is "form", the default
#'   value is `TRUE`. For all other `styles`, the default value is `FALSE`
#'   (determined automatically via [parameter_explode_default()]).
#' @param deprecated Logical scalar (optional). Specifies that a parameter is
#'   deprecated and should be transitioned out of usage. Default `FALSE`.
#'
#' @return A `parameter` S7 object that describes a path or operation parameter.
#' @export
#'
#' @seealso [as_parameter()] for coercing objects to `parameter`.
#'
#' @examples
#' class_parameter()
#' class_parameter(
#'   parameter_name = "event_date",
#'   location = "query",
#'   schema = class_schema("string", format = "date-time"),
#'   required = TRUE
#' )
class_parameter <- S7::new_class(
  name = "parameter",
  package = "rapid",
  properties = list(
    parameter_name = character_scalar_property("parameter_name"),
    location = enum_property(
      "location",
      c("query", "header", "path", "cookie")
    ),
    schema = class_schema,
    # Media type encodings also have this style property. Consider making it a class.
    style = enum_property(
      "style",
      c("matrix", "label", "form", "simple", "spaceDelimited", "pipeDelimited",
        "deepObject")
    ),
    description = character_scalar_property("description"),
    required = logical_scalar_property("required"),
    allow_empty_value = logical_scalar_property("allow_empty_value"),
    allow_reserved = logical_scalar_property("allow_reserved"),
    explode = logical_scalar_property("explode"),
    deprecated = logical_scalar_property("deprecated")
  ),
  constructor = function(parameter_name = character(),
                         location = c("query", "header", "path", "cookie"),
                         schema = class_schema(),
                         ...,
                         style = parameter_style_default(location),
                         description = character(),
                         required = parameter_required_default(location),
                         allow_empty_value = FALSE,
                         allow_reserved = FALSE,
                         explode = parameter_explode_default(style),
                         deprecated = FALSE) {
    check_dots_empty()
    # Don't set the defaults if the call is empty.
    if (missing(parameter_name)) {
      location <- character()
      style <- character()
      required <- logical()
      allow_empty_value <- logical()
      allow_reserved <- logical()
      explode <- logical()
      deprecated <- logical()
    } else {
      location <- rlang::arg_match(location)
    }
    S7::new_object(
      S7::S7_object(),
      parameter_name = parameter_name,
      location = location,
      schema = as_schema(schema),
      style = style,
      description = description,
      required = required,
      allow_empty_value = allow_empty_value,
      allow_reserved = allow_reserved,
      explode = explode,
      deprecated = deprecated
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "parameter_name",
      required = c(
        "location", "schema", "style", "required",
        "allow_empty_value", "allow_reserved", "explode", "deprecated"
      ),
      optional = "description"
    )
  }
)

S7::method(length, class_parameter) <- function(x) {
  length(x@location)
}

#' Choose the default style of a parameter
#'
#' This helper function chooses the default value for the `style` property of a
#' [class_parameter()] based on the `location` property.
#'
#' @inheritParams class_parameter
#'
#' @return A character with one of "form" or "simple", or a length-0 character
#'   vector.
#' @export
#'
#' @examples
#' parameter_style_default()
#' parameter_style_default("query")
#' parameter_style_default("header")
#' parameter_style_default("path")
#' parameter_style_default("cookie")
parameter_style_default <- function(location = c("query", "header",
                                                 "path", "cookie")) {
  if (!missing(location) && length(location)) {
    location <- rlang::arg_match(location)
    return(
      switch(location,
             query = "form",
             header = "simple",
             path = "simple",
             cookie = "form")
    )
  }
  return(character())
}

#' Choose the default required value of a parameter
#'
#' This helper function chooses the default value for the `required` property of
#' a [class_parameter()] based on the `location` property.
#'
#' @inheritParams class_parameter
#'
#' @return `TRUE` for "path", `FALSE` for any other value, or a length-0 logical
#'   vector if location is not defined.
#' @export
#'
#' @examples
#' parameter_required_default()
#' parameter_required_default("query")
#' parameter_required_default("header")
#' parameter_required_default("path")
#' parameter_required_default("cookie")
parameter_required_default <- function(location = c("query", "header",
                                                    "path", "cookie")) {
  if (!missing(location) && length(location)) {
    location <- rlang::arg_match(location)
    return(location == "path")
  }
  return(logical())
}

#' Choose the default explode value of a parameter
#'
#' This helper function chooses the default value for the `explode` property of
#' a [class_parameter()] based on the `style` property.
#'
#' @inheritParams class_parameter
#'
#' @return `TRUE` for "form", `FALSE` for any other value, or a length-0 logical
#'   vector if style is not defined.
#' @export
#'
#' @examples
#' parameter_explode_default()
#' parameter_explode_default("form")
#' parameter_explode_default("simple")
#' parameter_explode_default("spaceDelimited")
parameter_explode_default <- function(style) {
  if (!missing(style) && length(style)) {
    return(style == "form")
  }
  return(logical())
}

#' Coerce lists and character vectors to parameters
#'
#' `as_parameter()` turns an existing object into a `parameter`. This is in
#' contrast with [class_parameter()], which builds a `parameter` from individual
#' properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "parameter_name"
#'   (or "name"), "location" (or "in"), "schema", "style", "description",
#'   "required", "allow_empty_value", "allow_reserved", "explode", and/or
#'   "deprecated", or names that can be coerced to those names via
#'   [snakecase::to_snake_case()]. Extra names are ignored. This object should
#'   describe a single parameter.
#'
#' @return A `parameter` as returned by [class_parameter()].
#' @export
#'
#' @examples
#' as_parameter()
#' as_parameter(list(
#'   name = "event_date",
#'   `in` = "query",
#'   schema = list(type = "string", format = "date-time"),
#'   required = TRUE
#' ))
as_parameter <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  as_api_object(
    x,
    class_parameter,
    ...,
    alternate_names = c("name" = "parameter_name", "in" = "location"),
    arg = arg,
    call = call
  )
}
