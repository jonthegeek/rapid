#' @include components-security_scheme_type.R
#' @include components-security_scheme-oauth2-implicit_flows.R
NULL

oauth2_security_scheme <- S7::new_class(
  name = "oauth2_security_scheme",
  package = "rapid",
  parent = security_scheme_type,
  properties = list(
    implicit_flow = ouath2_implicit_flows,
    password_flow = ouath2_token_flows,
    client_credentials_flow = ouath2_token_flows,
    authorization_code_flow = ouath2_authorization_code_flows
  ),
  constructor = function(name = class_missing,
                         ...,
                         implicit_flow = class_missing,
                         password_flow = class_missing,
                         client_credentials_flow = class_missing,
                         authorization_code_flow = class_missing,
                         description = class_missing) {
    check_dots_empty()
    name <- name %||% character()
    implicit_flow <- implicit_flow %||% ouath2_implicit_flows()
    password_flow <- password_flow %||% ouath2_token_flows()
    client_credentials_flow <- client_credentials_flow %||% ouath2_token_flows()
    authorization_code_flow <- authorization_code_flow %||%
      ouath2_authorization_code_flows()
    description <- description %||% character()
    S7::new_object(
      S7::S7_object(),
      name = name,
      implicit_flow = implicit_flow,
      password_flow = password_flow,
      client_credentials_flow = client_credentials_flow,
      authorization_code_flow = authorization_code_flow,
      description = description
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      optional = c(
        "implicit_flow",
        "password_flow",
        "client_credentials_flow",
        "authorization_code_flow",
        "description"
      )
    )
    # TODO: Consider validating that at least one of those has length the same
    # as name.
  }
)
