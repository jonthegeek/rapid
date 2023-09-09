#' Contact information for the API
#'
#' Validate the contact information for an API.
#'
#' @param name Character scalar (optional). The identifying name of the contact
#'   person/organization.
#' @param url Character scalar (optional). The URL pointing to the contact
#'   information.
#' @param email Character scalar (optional). The email address of the contact
#'   person/organization. This
#'   *must* be in the form of an email address.
#'
#' @return A `contact` S7 object, with fields `name`, `email`, and `url`.
#' @export
#'
#' @seealso [as_contact()] for coercing objects to `contact`.
#'
#' @examples
#' contact(
#'   "API Support",
#'   "support@example.com",
#'   "https://www.example.com/support"
#' )
contact <- S7::new_class(
  "contact",
  package = "rapid",
  properties = list(
    name = character_scalar_property("name"),
    email = character_scalar_property(
      "email",
      regex = "^[^@]+@[^@]+$"
    ),
    url = character_scalar_property("url")
  )
)

#' @export
`length.rapid::contact` <- function(x) {
  .prop_length_max(x)
}

#' Coerce lists and character vectors to contacts
#'
#' `as_contact()` turns an existing object into a `contact`. This is in
#' contrast with [contact()], which builds a `contact` from individual
#' properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @param x The object to coerce. Must be empty or have names "name", "email",
#'   and/or "url". Extra names are ignored.
#'
#' @return A `contact` as returned by [contact()].
#' @export
#'
#' @examples
#' as_contact()
#' as_contact(list(name = "Jon Harmon", email = "jonthegeek@gmail.com"))
as_contact <- S7::new_generic("as_contact", dispatch_args = "x")

S7::method(as_contact, contact) <- function(x) {
  x
}

S7::method(as_contact, class_list | class_character) <- function(x) {
  x <- .validate_for_as_class(x, contact)
  contact(name = x[["name"]], email = x[["email"]], url = x[["url"]])
}

S7::method(as_contact, class_missing) <- function(x) {
  contact()
}

S7::method(as_contact, NULL) <- function(x) {
  contact()
}

S7::method(as_contact, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls contact}."
  )
}
