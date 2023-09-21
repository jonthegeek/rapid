#' @include components-security_scheme-oauth2-flows.R
NULL

#' OAuth2 implicit flows object
#'
#' An `oauth2_implicit_flows` object describes the configuration for the OAuth
#' Implicit flow.
#'
#' @inheritParams oauth2_flows
#' @inheritParams rlang::args_dots_empty
#' @param authorization_url Character vector (required). The authorization URL
#'   to be used for this flow. This must be in the form of a URL. The OAuth2
#'   standard requires the use of TLS.
#'
#' @export
#' @examples
#' oauth2_implicit_flows(
#'   authorization_url = "https://example.com/authorize",
#'   refresh_url = "https://example.com/refresh"
#' )
oauth2_implicit_flows <- S7::new_class(
  name = "oauth2_implicit_flows",
  package = "rapid",
  parent = oauth2_flows,
  properties = list(
    authorization_url = class_character
  ),
  constructor = function(authorization_url = class_missing,
                         ...,
                         refresh_url = class_missing,
                         scopes = class_missing) {
    check_dots_empty()
    authorization_url <- authorization_url %||% character()
    refresh_url <- refresh_url %||% character()
    scopes <- scopes %||% scopes_list()
    S7::new_object(
      S7::S7_object(),
      authorization_url = authorization_url,
      refresh_url = refresh_url,
      scopes = scopes
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "authorization_url",
      optional = c("refresh_url", "scopes")
    )
  }
)

# TODO: length
#
# TODO: as
