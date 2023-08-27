#' Contact information for the API
#'
#' Validate the contact information for an API.
#'
#' @param name The identifying name of the contact person/organization.
#' @param url The URL pointing to the contact information. This *must* be in the
#'   form of a URL.
#' @param email The email address of the contact person/organization. This
#'   *must* be in the form of an email address.
#'
#' @return An `api_contact` S7 object, with fields `name`, `email`, and
#'   `url`.
#' @export
#'
#' @examples
#' api_contact(
#'   "API Support",
#'   "support@example.com",
#'   "https://www.example.com/support"
#' )
api_contact <- S7::new_class(
  "api_contact",
  package = "rapid",
  properties = list(
    name = character_scalar_property("name"),
    email = character_scalar_property(
      "email",
      regex = "^[^@]+@[^@]+$"
    ),
    url = url_scalar_property("url")
  )
)
