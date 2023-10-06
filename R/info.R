#' @include info-contact.R
#' @include info-license.R
#' @include info-origin.R
#' @include properties.R
NULL

#' Information about the API
#'
#' The object provides metadata about the API. The metadata may be used by the
#' clients if needed, and may be presented in editing or documentation
#' generation tools for convenience.
#'
#' @inheritParams rlang::args_dots_empty
#' @param title Character scalar. The title of the API. Required when the object
#'   is not empty.
#' @param version Character scalar. The version of the API description (which is
#'   distinct from the OpenAPI Specification version or the API implementation
#'   version).  Required when the object is not empty.
#' @param contact The contact information for the exposed API, generated via
#'   [contact()].
#' @param description Character scalar (optional). A description of the API.
#'   [CommonMark syntax](https://spec.commonmark.org/) may be used for rich text
#'   representation.
#' @param license The license information for the exposed API, generated via
#'   [license()].
#' @param summary Character scalar (optional). A short summary of the API.
#' @param terms_of_service Character scalar (optional). A URL to the Terms of
#'   Service for the API.
#' @param origin The url and related information about the document used to
#'   build the API description. This is used to resolve relative paths in the
#'   API description. Note: This is not part of the OpenAPI Specification, but
#'   is sometimes supplied as "x-origin".
#'
#' @return An `info` S7 object with metadata describing a single API.
#' @export
#'
#' @seealso [as_info()] for coercing objects to `info`.
#'
#' @examples
#' info()
#' info(
#'   title = "My Cool API",
#'   version = "1.0.2",
#'   license = license(
#'     name = "Apache 2.0",
#'     url = "https://opensource.org/license/apache-2-0/"
#'   )
#' )
#' info(
#'   title = "My Abbreviated API",
#'   version = "2.0.0",
#'   origin = "https://root.url"
#' )
info <- S7::new_class(
  "info",
  package = "rapid",
  properties = list(
    title = character_scalar_property("title"),
    version = character_scalar_property("version"),
    contact = contact,
    description = character_scalar_property("description"),
    license = license,
    summary = character_scalar_property("summary"),
    terms_of_service = character_scalar_property("terms_of_service"),
    origin = class_origin
  ),
  constructor = function(title = character(),
                         version = character(),
                         ...,
                         contact = class_missing,
                         description = character(),
                         license = class_missing,
                         summary = character(),
                         terms_of_service = character(),
                         origin = class_origin()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      title = title %||% character(),
      version = version %||% character(),
      contact = as_contact(contact),
      description = description %||% character(),
      license = as_license(license),
      summary = summary %||% character(),
      terms_of_service = terms_of_service %||% character(),
      origin = as_origin(origin)
    )
  },
  validator = function(self) {
    validate_lengths(
      self,
      "title",
      required_same = "version",
      optional_any = c(
        "contact",
        "description",
        "license",
        "summary",
        "terms_of_service",
        "origin"
      )
    )
  }
)

S7::method(length, info) <- function(x) {
  max(lengths(S7::props(x)))
}

#' Coerce lists and character vectors to info objects
#'
#' `as_info()` turns an existing object into an `info` object. This is in
#' contrast with [info()], which builds an `info` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "title",
#'   "version", "contact", "description", "license", "summary",
#'   "terms_of_service", and/or "origin" (or "x-origin", which will be coerced
#'   to "origin"), or names that can be coerced to those names via
#'   [snakecase::to_snake_case()]. Extra names are ignored. This object should
#'   describe a single API.
#'
#' @return An `info` object as returned by [info()].
#' @export
#'
#' @examples
#' as_info()
#' as_info(list(title = "My Cool API", version = "1.0.0"))
as_info <- S7::new_generic("as_info", dispatch_args = "x")

S7::method(as_info, info) <- function(x) {
  x
}

S7::method(as_info, class_list | class_character) <- function(x) {
  .as_class(x, info, extra_names = c("x-origin" = "origin"))
}

S7::method(
  as_info,
  class_missing | NULL | S7::new_S3_class("S7_missing")
) <- function(x) {
  info()
}

S7::method(as_info, class_any) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls info}."
  )
}
