#' @include components-security_scheme.R
#' @include components-security_scheme-oauth2-implicit_flow.R
#' @include components-security_scheme-oauth2-token_flow.R
#' @include components-security_scheme-oauth2-authorization_code_flow.R
NULL

#' OAuth2 security schemes
#'
#' Defines one or more OAuth2 security schemes that can be used by the
#' operations.
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
      authorization_code_flow = as_oauth2_authorization_code_flow(authorization_code_flow)
    )
  }
)

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
    # TODO: Oops, these should all have x_arg and call args, since there's a
    # potential flow of as_ calls.
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

S7::method(as_oauth2_security_scheme, class_missing | NULL | S7::new_S3_class("S7_missing")) <- function(x) {
  oauth2_security_scheme()
}

S7::method(as_oauth2_security_scheme, class_any) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls api_key_security_scheme}."
  )
}
