#' Information about the API
#'
#' The object provides metadata about the API. The metadata *may* be used by the
#' clients if needed, and *may* be presented in editing or documentation
#' generation tools for convenience.
#'
#' @param contact The contact information for the exposed API, generated via
#'   [api_contact()].
#' @param description A description of the API. [CommonMark
#'   syntax](https://spec.commonmark.org/) *may* be used for rich text
#'   representation.
#' @param license The license information for the exposed API, generated via
#'   [api_license()].
#' @param summary A short summary of the API.
#' @param terms_of_service A URL to the Terms of Service for the API. This
#'   *must* be in the form of a URL when provided.
#' @param title The title of the API.
#' @param version The version of the API document (which is distinct from the
#'   OpenAPI Specification version or the API implementation version).
#'
#' @return An `api_info` S7 object.
#' @export
#' @examples
#' api_info()
#' api_info(
#'   title = "My Cool API",
#'   license = api_license(
#'     name = "Apache 2.0",
#'     url = "https://opensource.org/license/apache-2-0/"
#'   )
#' )
api_info <- S7::new_class(
  "api_info",
  package = "rapid",
  # Design choice: These are strictly alphabetized, since we allow any to be
  # empty. May later want to order them to match the validated version, where
  # required parameters will come first (before ... during construction).
  properties = list(
    contact = api_contact,
    description = character_scalar_property("description"),
    license = api_license,
    summary = character_scalar_property("summary"),
    terms_of_service = url_scalar_property("terms_of_service"),
    title = character_scalar_property("title"),
    version = character_scalar_property("version")
  )
)

#' @export
`length.rapid::api_info` <- function(x) {
  .prop_length_max(x)
}
