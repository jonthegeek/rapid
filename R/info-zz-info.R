#' Information about the API
#'
#' The object provides metadata about the API. The metadata *may* be used by the
#' clients if needed, and *may* be presented in editing or documentation
#' generation tools for convenience.
#'
#' @inheritParams .shared-parameters
#' @param contact The contact information for the exposed API, generated via
#'   [contact()].
#' @param description A description of the API. [CommonMark
#'   syntax](https://spec.commonmark.org/) *may* be used for rich text
#'   representation.
#' @param license The license information for the exposed API, generated via
#'   [license()].
#' @param summary A short summary of the API.
#' @param terms_of_service A URL to the Terms of Service for the API. This
#'   *must* be in the form of a URL when provided.
#' @param title The title of the API.
#' @param version The version of the API document (which is distinct from the
#'   OpenAPI Specification version or the API implementation version).
#'
#' @return An `info` S7 object.
#' @export
#' @examples
#' info()
#' info(
#'   title = "My Cool API",
#'   license = license(
#'     name = "Apache 2.0",
#'     url = "https://opensource.org/license/apache-2-0/"
#'   )
#' )
info <- S7::new_class(
  "info",
  package = "rapid",
  # Design choice: These are strictly alphabetized, since we allow any to be
  # empty. May later want to order them to match the validated version, where
  # required parameters will come first (before ... during construction).
  properties = list(
    contact = contact,
    description = character_scalar_property("description"),
    license = license,
    summary = character_scalar_property("summary"),
    terms_of_service = url_scalar_property("terms_of_service"),
    title = character_scalar_property("title"),
    version = character_scalar_property("version")
  ),
  constructor = function(contact = class_missing,
                         description = class_missing,
                         license = class_missing,
                         summary = class_missing,
                         terms_of_service = class_missing,
                         title = class_missing,
                         version = class_missing,
                         ...,
                         apid_list = NULL) {
    if (!is.null(apid_list)) {
      contact <- rlang::inject(contact(!!!apid_list$info$contact))
      description <- apid_list$info$description
      license <- rlang::inject(license(!!!apid_list$info$license))
      summary <- apid_list$info$summary
      terms_of_service <- apid_list$info$terms_of_service
      title <- apid_list$info$title
      version <- apid_list$info$version
    }
    S7::new_object(
      NULL,
      contact = contact,
      description = description,
      license = license,
      summary = summary,
      terms_of_service = terms_of_service,
      title = title,
      version = version
    )
  }
)

#' @export
`length.rapid::info` <- function(x) {
  .prop_length_max(x)
}
