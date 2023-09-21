#' @include components-security_scheme-oauth2-flows.R
NULL

#' OAuth2 token flows object
#'
#' An `ouath2_token_flows` object describes the configuration for the OAuth
#' Resource Owner Password flow or the OAuth Client Credentials flow (previously
#' called application in OpenAPI 2.0).
#'
#' @inheritParams oauth2_flows
#' @inheritParams rlang::args_dots_empty
#' @param token_url Character vector (required). The token URL to be used for
#'   this flow. This must be in the form of a URL. The OAuth2 standard requires
#'   the use of TLS.
#'
#' @export
#' @examples
#' ouath2_token_flows(
#'   token_url = "https://example.com/token",
#'   refresh_url = "https://example.com/refresh",
#'   scopes = scopes_list(
#'     scopes(
#'       name = c("server:read", "server:write"),
#'       description = c("Read server settings", "Write server settings")
#'     ),
#'     scopes(
#'       name = c("user:email_read", "user:email_write"),
#'       description = c("Read user email settings", "Write user email settings")
#'     )
#'   )
#' )
ouath2_token_flows <- S7::new_class(
  name = "ouath2_token_flows",
  package = "rapid",
  parent = oauth2_flows,
  properties = list(
    token_url = class_character
  ),
  constructor = function(token_url = class_missing,
                         ...,
                         refresh_url = class_missing,
                         scopes = class_missing) {
    check_dots_empty()
    token_url <- token_url %||% character()
    refresh_url <- refresh_url %||% character()
    scopes <- scopes %||% scopes_list()
    S7::new_object(
      S7::S7_object(),
      token_url = token_url,
      refresh_url = refresh_url,
      scopes = scopes
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "token_url",
      optional = c("refresh_url", "scopes")
    )
  }
)

# TODO: length
#
# TODO: as_
