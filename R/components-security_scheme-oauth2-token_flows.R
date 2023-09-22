#' @include components-security_scheme-oauth2-flows.R
NULL

#' OAuth2 token flows object
#'
#' An `oauth2_token_flows` object describes the configuration for the OAuth
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
#' oauth2_token_flows(
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
oauth2_token_flows <- S7::new_class(
  name = "oauth2_token_flows",
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

S7::method(length, oauth2_token_flows) <- function(x) {
  length(x@token_url)
}

# TODO: fix help in all the as_ functions to point out that we snakecase-ize the
# names.

#' Coerce lists to OAuth2 token flows
#'
#' `as_oauth2_token_flows()` turns an existing object into a
#' `oauth2_token_flows`. This is in contrast with [oauth2_token_flows()], which
#' builds a `oauth2_token_flows` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @param x The object to coerce. Must be empty or be a list of named lists,
#'   each with names "refresh_url", "scopes", and/or "token_url". Additional
#'   names are ignored.
#'
#' @return A `oauth2_token_flows` as returned by [oauth2_token_flows()].
#' @export
as_oauth2_token_flows <- S7::new_generic(
  "as_oauth2_token_flows",
  dispatch_args = "x"
)

S7::method(as_oauth2_token_flows, oauth2_token_flows) <- function(x) {
  x
}

S7::method(as_oauth2_token_flows, class_list) <- function(x) {
  x <- .validate_for_as_class(x, oauth2_token_flows)

  oauth2_token_flows(
    token_url = x$token_url,
    refresh_url = x$refresh_url,
    scopes = scopes_list(as_scopes(x$scopes))
  )
}

S7::method(as_oauth2_token_flows, class_missing | NULL) <- function(x) {
  oauth2_token_flows()
}

S7::method(as_oauth2_token_flows, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls api_key_security_scheme}."
  )
}
