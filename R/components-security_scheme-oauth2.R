#' @include components-security_scheme.R
#' @include components-security_scheme-oauth2-implicit_flow.R
#' @include components-security_scheme-oauth2-token_flow.R
#' @include components-security_scheme-oauth2-authorization_code_flow.R
NULL

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
                         implicit_flow = class_missing,
                         password_flow = class_missing,
                         client_credentials_flow = class_missing,
                         authorization_code_flow = class_missing,
                         description = class_missing) {
    check_dots_empty()
    implicit_flow <- implicit_flow %||% oauth2_implicit_flow()
    password_flow <- password_flow %||% oauth2_token_flow()
    client_credentials_flow <- client_credentials_flow %||% oauth2_token_flow()
    authorization_code_flow <- authorization_code_flow %||%
      oauth2_authorization_code_flow()
    S7::new_object(
      S7::S7_object(),
      implicit_flow = implicit_flow,
      password_flow = password_flow,
      client_credentials_flow = client_credentials_flow,
      authorization_code_flow = authorization_code_flow
    )
  }
)
