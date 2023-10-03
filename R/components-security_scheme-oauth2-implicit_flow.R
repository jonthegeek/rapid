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
  constructor = function(authorization_url = character(),
                         ...,
                         refresh_url = character(),
                         scopes = character()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      authorization_url = authorization_url,
      refresh_url = refresh_url,
      scopes = as_scopes(scopes)
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

S7::method(length, oauth2_implicit_flow) <- function(x) {
  length(x@authorization_url)
}

#' Coerce lists to OAuth2 token flow
#'
#' `as_oauth2_implicit_flow()` turns an existing object into an
#' `oauth2_implicit_flow`. This is in contrast with [oauth2_implicit_flow()],
#' which builds an `oauth2_implicit_flow` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list of named lists,
#'   each with names "refresh_url", "scopes", and/or "authorizatoin_url", or
#'   names that can be coerced to those names via [snakecase::to_snake_case()].
#'   Additional names are ignored.
#'
#' @return An `oauth2_implicit_flow` as returned by [oauth2_implicit_flow()].
#' @export
as_oauth2_implicit_flow <- S7::new_generic(
  "as_oauth2_implicit_flow",
  dispatch_args = "x"
)

S7::method(as_oauth2_implicit_flow, oauth2_implicit_flow) <- function(x) {
  x
}

S7::method(as_oauth2_implicit_flow, class_list | class_character) <- function(x) {
  .as_class(x, oauth2_implicit_flow)
}

S7::method(as_oauth2_implicit_flow, class_missing | NULL | S7::new_S3_class("S7_missing")) <- function(x) {
  oauth2_implicit_flow()
}

S7::method(as_oauth2_implicit_flow, class_any) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls oauth2_implicit_flow}."
  )
}
