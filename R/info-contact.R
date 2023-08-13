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
#' @return A `rapid_contact` object: a list with fields `name`, `url`, and
#'   `email`.
#' @export
#'
#' @examples
#' api_contact(
#'   "API Support",
#'   "https://www.example.com/support",
#'   "support@example.com"
#' )
api_contact <- function(name = NULL, url = NULL, email = NULL) {
  name <- to_chr_scalar(name)
  url <- stabilize_chr_scalar(
    url,
    regex = "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
  )
  email <- stabilize_chr_scalar(
    email,
    regex = "^[^@]+@[^@]+$"
  )

  return(
    .new_rapid_contact(
      name = name,
      url = url,
      email = email
    )
  )
}

.new_rapid_contact <- function(name, url, email) {
  return(
    .add_class(
      list(
        name = name,
        url = url,
        email = email
      ),
      new_class = "rapid_contact"
    )
  )
}
