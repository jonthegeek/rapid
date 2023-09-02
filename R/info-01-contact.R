#' Contact information for the API
#'
#' Validate the contact information for an API.
#'
#' @inheritParams .shared-parameters
#' @param name The identifying name of the contact person/organization.
#' @param url The URL pointing to the contact information. This *must* be in the
#'   form of a URL.
#' @param email The email address of the contact person/organization. This
#'   *must* be in the form of an email address.
#'
#' @return An `api_contact` S7 object, with fields `name`, `email`, and `url`.
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
  ),
  constructor = function(name = class_missing,
                         email = class_missing,
                         url = class_missing,
                         ...) {
    S7::new_object(NULL, name = name, email = email, url = url)
  }
)

#' @export
`length.rapid::api_contact` <- function(x) {
  .prop_length_max(x)
}

#' Coerce lists and character vectors to api_contacts
#'
#' `as_api_contact()` turns an existing object into an `api_contact`. This is in
#' contrast with [api_contact()], which builds an `api_contact` from individual
#' properties.
#'
#' @param x The object to coerce. Must be empty or have names "name", "email",
#'   and/or "url". Extra names are ignored.
#'
#' @return An `api_contact` as returned by [api_contact()].
#' @export
#'
#' @examples
#' as_api_contact()
#' as_api_contact(list(name = "Jon Harmon", email = "jonthegeek@gmail.com"))
as_api_contact <- S7::new_generic("as_api_contact", dispatch_args = "x")

S7::method(as_api_contact, class_list | class_character) <- function(x) {
  if (
    length(x) &&
    (!rlang::is_named(x) || !any(names(x) %in% c("name", "email", "url")))
  ) {
    cli::cli_abort(c(
      "{.arg x} must have names {.val name}, {.val email}, and/or {.val url}.",
      "*" = "Any other names are ignored."
    ))
  }
  x <- as.list(x)
  api_contact(name = x[["name"]], email = x[["email"]], url = x[["url"]])
}

S7::method(as_api_contact, class_missing) <- function(x) {
  api_contact()
}

S7::method(as_api_contact, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls api_contact}."
  )
}
