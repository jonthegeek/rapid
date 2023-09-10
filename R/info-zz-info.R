#' Information about the API
#'
#' The object provides metadata about the API. The metadata *may* be used by the
#' clients if needed, and *may* be presented in editing or documentation
#' generation tools for convenience.
#'
#' @inheritParams rlang::args_dots_empty
#' @param title The title of the API. Required when the object is not empty.
#' @param version The version of the API document (which is distinct from the
#'   OpenAPI Specification version or the API implementation version).  Required
#'   when the object is not empty.
#' @param contact The contact information for the exposed API, generated via
#'   [contact()].
#' @param description A description of the API. [CommonMark
#'   syntax](https://spec.commonmark.org/) *may* be used for rich text
#'   representation.
#' @param license The license information for the exposed API, generated via
#'   [license()].
#' @param summary A short summary of the API.
#' @param terms_of_service A URL to the Terms of Service for the API.
#'
#' @return An `info` S7 object.
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
    terms_of_service = character_scalar_property("terms_of_service")
  ),
  constructor = function(title = class_missing,
                         version = class_missing,
                         ...,
                         contact = class_missing,
                         description = class_missing,
                         license = class_missing,
                         summary = class_missing,
                         terms_of_service = class_missing) {
    check_dots_empty()
    S7::new_object(
      NULL,
      title = title,
      version = version,
      contact = contact,
      description = description,
      license = license,
      summary = summary,
      terms_of_service = terms_of_service
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
        "terms_of_service"
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
#' @param x The object to coerce. Must be empty or have names "title",
#'   "version", "contact", "description", "license", "summary", and/or
#'   "terms_of_service". Extra names are ignored.
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
  x <- .validate_for_as_class(x, info)

  info(
    title = x[["title"]],
    version = x[["version"]],
    contact = as_contact(x[["contact"]]),
    description = x[["description"]],
    license = as_license(x[["license"]]),
    summary = x[["summary"]],
    terms_of_service = x[["terms_of_service"]]
  )
}

S7::method(as_info, class_missing | NULL) <- function(x) {
  info()
}

S7::method(as_info, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls info}."
  )
}
