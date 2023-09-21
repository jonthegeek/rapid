#' @include components-security_scheme-oauth2-scopes_list.R
NULL

#' OAuth2 flows object
#'
#' This is an abstract class that is used to define specific types of OAuth2
#' flows objects. Note: each OAuth2 flows object can hold multiple flows of that
#' type.
#'
#' @param refresh_url Character vector (optional). The URL to be used for
#'   obtaining refresh tokens. This must be in the form of a URL. The OAuth2
#'   standard requires the use of TLS.
#' @param scopes An optional [scopes_list()] object with the available scopes
#'   for the OAuth2 security scheme.
#'
#' @export
#' @seealso [ouath2_token_flows()], [ouath2_implicit_flows()], and
#'   [ouath2_authorization_code_flows()]
oauth2_flows <- S7::new_class(
  name = "oauth2_flows",
  package = "rapid",
  properties = list(
    refresh_url = class_character,
    scopes = scopes_list
  ),
  abstract = TRUE
  # TODO: Validate here, or only in subclasses?
)

# TODO: as_oauth2_flows? Yes, the name of the object says what type it is.
