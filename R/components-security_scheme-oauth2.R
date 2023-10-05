#' @include components-security_scheme.R
#' @include components-security_scheme-oauth2-implicit_flow.R
#' @include components-security_scheme-oauth2-token_flow.R
#' @include components-security_scheme-oauth2-authorization_code_flow.R
NULL

#' OAuth2 security schemes
#'
#' Defines an OAuth2 security scheme that can be used by the operations.
#'
#' @inheritParams rlang::args_dots_empty
#' @param implicit_flow An `oauth2_implicit_flow` object created with
#'   [oauth2_implicit_flow()].
#' @param password_flow An `oauth2_token_flow` object created with
#'   [oauth2_token_flow()].
#' @param client_credentials_flow An `oauth2_token_flow` object created with
#'   [oauth2_token_flow()].
#' @param authorization_code_flow An `oauth2_authorization_code_flow` object
#'   created with [oauth2_authorization_code_flow()].
#'
#' @return An `oauth2_security_scheme` S7 object, with fields `implicit_flow`,
#'   `password_flow`, `client_credentials_flow`, and `authorization_code_flow`.
#' @export
#'
#' @examples
#' oauth2_security_scheme()
#' oauth2_security_scheme(
#'   password_flow = oauth2_token_flow(token_url = "/tokens/passwords")
#' )
oauth2_security_scheme <- S7::new_class(
  name = "oauth2_security_scheme",
  package = "rapid",
  parent = security_scheme,
  properties = list(
    implicit_flow = oauth2_implicit_flow,
    password_flow = oauth2_token_flow,
    client_credentials_flow = oauth2_token_flow,
    authorization_code_flow = oauth2_authorization_code_flow
  ),
  constructor = function(...,
                         implicit_flow = oauth2_implicit_flow(),
                         password_flow = oauth2_token_flow(),
                         client_credentials_flow = oauth2_token_flow(),
                         authorization_code_flow = oauth2_authorization_code_flow()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      implicit_flow = as_oauth2_implicit_flow(implicit_flow),
      password_flow = as_oauth2_token_flow(password_flow),
      client_credentials_flow = as_oauth2_token_flow(client_credentials_flow),
      authorization_code_flow = as_oauth2_authorization_code_flow(
        authorization_code_flow
      )
    )
  }
)

S7::method(length, oauth2_security_scheme) <- function(x) {
  max(lengths(S7::props(x)))
}

#' Coerce lists to oauth2 security schemes
#'
#' `as_oauth2_security_scheme()` turns an existing object into an
#' `oauth2_security_scheme`. This is in contrast with
#' [oauth2_security_scheme()], which builds an `oauth2_security_scheme` from
#' individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list with an object
#'   named "flows" or a name that can be coerced to "flows" via
#'   [snakecase::to_snake_case()]. Additional names are ignored.
#'
#' @return An `oauth2_security_scheme` as returned by
#'   [oauth2_security_scheme()].
#' @export
as_oauth2_security_scheme <- S7::new_generic(
  "as_oauth2_security_scheme",
  dispatch_args = "x"
)

S7::method(as_oauth2_security_scheme, oauth2_security_scheme) <- function(x) {
  x
}

S7::method(as_oauth2_security_scheme, class_list) <- function(x) {
  if (!length(x) || !any(lengths(x))) {
    return(oauth2_security_scheme())
  }

  if (!("flows" %in% names(x))) {
    cli::cli_abort(
      "{.arg x} must contain a named flows object."
    )
  }
  names(x$flows) <- snakecase::to_snake_case(names(x$flows))
  oauth2_security_scheme(
    implicit_flow = x$flows[["implicit"]],
    password_flow = x$flows[["password"]],
    client_credentials_flow = x$flows[["client_credentials"]],
    authorization_code_flow = x$flows[["authorization_code"]]
  )
}

S7::method(
  as_oauth2_security_scheme,
  class_missing | NULL | S7::new_S3_class("S7_missing")
) <- function(x) {
  oauth2_security_scheme()
}

S7::method(
  as_oauth2_security_scheme,
  class_any
) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls oauth2_security_scheme}."
  )
}
