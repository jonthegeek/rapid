#' @include properties.R
NULL

#' Contact information for the API
#'
#' A `contact` object provides contact information for the API.
#'
#' @param name Character scalar (optional). The identifying name of the contact
#'   person or organization.
#' @param url Character scalar (optional). The URL pointing to the contact
#'   information.
#' @param email Character scalar (optional). The email address of the contact
#'   person/organization. This must be in the form of an email address.
#'
#' @return A `contact` S7 object describing who to contact for information about
#'   the API, with fields `name`, `email`, and `url`.
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

S7::method(length, contact) <- function(x) {
  max(lengths(S7::props(x)))
}

#' Coerce lists and character vectors to contacts
#'
#' `as_contact()` turns an existing object into a `contact`. This is in contrast
#' with [contact()], which builds a `contact` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "name", "email",
#'   and/or "url", or names that can be coerced to those names via
#'   [snakecase::to_snake_case()]. Extra names are ignored. This object should
#'   describe a single point of contact.
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
  .as_class(x, contact)
}

S7::method(
  as_contact,
  class_missing | NULL | S7::new_S3_class("S7_missing")
) <- function(x) {
  contact()
}

S7::method(as_contact, class_any) <- function(x,
                                              ...,
                                              arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls contact}."
  )
}
