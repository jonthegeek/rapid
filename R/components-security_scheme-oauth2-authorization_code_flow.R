#' @include components-security_scheme-oauth2-flow.R
NULL

#' OAuth2 authorization code flow object
#'
#' An `oauth2_authorization_code_flow` object describes the configuration for
#' the OAuth Authorization Code flow. Previously called `accessCode` in OpenAPI
#' 2.0.
#'
#' @inheritParams oauth2_flow
#' @inheritParams rlang::args_dots_empty
#' @inheritParams oauth2_implicit_flow
#' @inheritParams oauth2_token_flow
#'
#' @export
#' @examples
#' oauth2_authorization_code_flow(
#'   authorization_url = "https://example.com/authorize",
#'   token_url = "https://example.com/token",
#'   refresh_url = "https://example.com/refresh"
#'   scopes = scopes(
#'     name = c("server:read", "server:write"),
#'     description = c("Read server settings", "Write server settings")
#'   )
#' )
oauth2_authorization_code_flow <- S7::new_class(
  name = "oauth2_token_flow",
  package = "rapid",
  parent = oauth2_flow,
  properties = list(
    authorization_url = character_scalar_property("authorization_url"),
    token_url = character_scalar_property("token_url")
  ),
  constructor = function(authorization_url = class_missing,
                         token_url = class_missing,
                         ...,
                         refresh_url = class_missing,
                         scopes = class_missing) {
    check_dots_empty()
    authorization_url <- authorization_url %||% character()
    token_url <- token_url %||% character()
    refresh_url <- refresh_url %||% character()
    scopes <- scopes %||% scopes()
    S7::new_object(
      S7::S7_object(),
      authorization_url = authorization_url,
      token_url = token_url,
      refresh_url = refresh_url,
      scopes = scopes
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "authorization_url",
      required = "token_url",
      optional = c("refresh_url", "scopes")
    )
  }
)

# TODO: length
#
# TODO: as_
