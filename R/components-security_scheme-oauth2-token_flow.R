#' @include components-security_scheme-oauth2-flow.R
NULL

#' OAuth2 token flow object
#'
#' An `oauth2_token_flow` object describes the configuration for the OAuth
#' Resource Owner Password flow or the OAuth Client Credentials flow (previously
#' called application in OpenAPI 2.0).
#'
#' @inheritParams abstract_oauth2_flow
#' @inheritParams rlang::args_dots_empty
#' @param token_url Character vector (required). The token URL to be used for
#'   this flow. This must be in the form of a URL. The OAuth2 standard requires
#'   the use of TLS.
#'
#' @return An `oauth2_token_flow` object.
#'
#' @export
#' @examples
#' class_oauth2_token_flow(
#'   token_url = "https://example.com/token",
#'   refresh_url = "https://example.com/refresh",
#'   scopes = class_scopes(
#'     name = c("server:read", "server:write"),
#'     description = c("Read server settings", "Write server settings")
#'   )
#' )
class_oauth2_token_flow <- S7::new_class(
  name = "oauth2_token_flow",
  package = "rapid",
  parent = abstract_oauth2_flow,
  properties = list(
    token_url = class_character
  ),
  constructor = function(token_url = character(),
                         ...,
                         refresh_url = character(),
                         scopes = class_scopes()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      token_url = token_url %||% character(),
      refresh_url = refresh_url %||% character(),
      scopes = as_scopes(scopes)
    )
  },
  validator = function(self) {
    validate_lengths(
      self,
      "token_url",
      optional_same = "refresh_url",
      optional_any = "scopes"
    )
  }
)

S7::method(length, class_oauth2_token_flow) <- function(x) {
  length(x@token_url)
}

#' Coerce lists and character vectors to OAuth2 token flows
#'
#' `as_oauth2_token_flow()` turns an existing object into an
#' `oauth2_token_flow`. This is in contrast with [class_oauth2_token_flow()], which
#' builds an `oauth2_token_flow` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list of named lists,
#'   each with names "refresh_url", "scopes", and/or "token_url", or names that
#'   can be coerced to those names via [snakecase::to_snake_case()]. Additional
#'   names are ignored.
#'
#' @return An `oauth2_token_flow` as returned by [class_oauth2_token_flow()].
#' @export
as_oauth2_token_flow <- function(x,
                                 ...,
                                 arg = caller_arg(x),
                                 call = caller_env()) {
  as_api_object(x, class_oauth2_token_flow, ..., arg = arg, call = call)
}
