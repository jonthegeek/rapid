#' @include components-security_scheme-oauth2-flow.R
NULL

#' OAuth2 implicit flow object
#'
#' An `oauth2_implicit_flow` object describes the configuration for the OAuth
#' Implicit flow.
#'
#' @inheritParams oauth2_flow
#' @inheritParams rlang::args_dots_empty
#' @param authorization_url Character vector (required). The authorization URL
#'   to be used for this flow. This must be in the form of a URL. The OAuth2
#'   standard requires the use of TLS.
#'
#' @export
#' @examples
#' oauth2_implicit_flow(
#'   authorization_url = "https://example.com/authorize",
#'   refresh_url = "https://example.com/refresh"
#' )
oauth2_implicit_flow <- S7::new_class(
  name = "oauth2_implicit_flow",
  package = "rapid",
  parent = oauth2_flow,
  properties = list(
    authorization_url = character_scalar_property("authorization_url")
  ),
  constructor = function(authorization_url = class_missing,
                         ...,
                         refresh_url = class_missing,
                         scopes = class_missing) {
    check_dots_empty()
    authorization_url <- authorization_url %||% character()
    refresh_url <- refresh_url %||% character()
    scopes <- scopes %||% scopes()
    S7::new_object(
      S7::S7_object(),
      authorization_url = authorization_url,
      refresh_url = refresh_url,
      scopes = scopes
    )
  },
  validator = function(self) {
    validate_lengths(
      self,
      "authorization_url",
      optional_same = "refresh_url",
      optional_any = "scopes"
    )
  }
)

# TODO: length

as_oauth2_implicit_flow <- S7::new_generic(
  "as_oauth2_implicit_flow",
  dispatch_args = "x"
)

S7::method(as_oauth2_implicit_flow, oauth2_implicit_flow) <- function(x) {
  x
}

S7::method(as_oauth2_implicit_flow, class_list) <- function(x) {
  x <- .validate_for_as_class(x, oauth2_implicit_flow)

  oauth2_implicit_flow(
    authorization_url = x$authorization_url,
    refresh_url = x$refresh_url,
    scopes = as_scopes(x$scopes)
  )
}

S7::method(as_oauth2_implicit_flow, class_missing | NULL | S7::new_S3_class("S7_missing")) <- function(x) {
  oauth2_implicit_flow()
}

S7::method(as_oauth2_implicit_flow, class_any) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls api_key_security_scheme}."
  )
}
