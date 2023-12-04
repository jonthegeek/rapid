#' @include properties.R
NULL

#' A simple object for referencing other components in the API description
#'
#' The `reference` object allows for reuse of components between different parts
#' of the API description. These objects are currently simple character
#' references, but may be change structure in the future to automatically
#' resolve references.
#'
#' @param ref_uri Character scalar. The reference identifier. This must be in
#'   the form of a URI.
#' @param summary Character scalar (optional). A short summary which by default
#'   should override that of the referenced component. If the referenced
#'   object-type does not allow a summary field, then this field has no effect.
#' @param description Character scalar (optional). A description which by
#'   default should override that of the referenced component. [CommonMark
#'   syntax](https://spec.commonmark.org/) may be used for rich text
#'   representation. If the referenced object-type does not allow a description
#'   field, then this field has no effect.
#'
#' @return A `reference` S7 object pointing (by name) to another part of the
#'   `rapid` object.
#' @export
#'
#' @seealso [as_reference()] for coercing objects to `reference`.
#'
#' @examples
#' class_reference("#/components/schemas/Pet")
class_reference <- S7::new_class(
  name = "reference",
  package = "rapid",
  properties = list(
    ref_uri = character_scalar_property("ref_uri"),
    summary = character_scalar_property("summary"),
    description = character_scalar_property("description")
  ),
  validator = function(self) {
    validate_parallel(
      self,
      "ref_uri",
      optional = c("summary", "description")
    )
  }
)

S7::method(length, class_reference) <- function(x) {
  length(x@ref_uri)
}

#' Coerce lists and character vectors to references
#'
#' `as_reference()` turns an existing object into a `reference`. This is in contrast
#' with [class_reference()], which builds a `reference` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "type",
#'   "nullable", "description", and/or "format", or names that can be coerced to
#'   those names via [snakecase::to_snake_case()]. Extra names are ignored. This
#'   object should describe a single reference.
#'
#' @return A `reference` as returned by [class_reference()].
#' @export
#'
#' @examples
#' as_reference()
#' as_reference(list(`$ref` = "#/components/schemas/Pet"))
as_reference <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  as_api_object(
    x,
    class_reference,
    ...,
    alternate_names = c("$ref" = "ref_uri"),
    arg = arg,
    call = call
  )
}
