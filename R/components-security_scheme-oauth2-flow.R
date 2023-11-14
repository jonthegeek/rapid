#' @include components-security_scheme-oauth2-scopes.R
#' @include properties.R
NULL

#' OAuth2 flow object
#'
#' This is an abstract class that is used to define specific types of OAuth2
#' flow objects.
#'
#' @param refresh_url Character scalar (optional). The URL to be used for
#'   obtaining refresh tokens. This must be in the form of a URL. The OAuth2
#'   standard requires the use of TLS.
#' @param scopes An optional [class_scopes()] object with the available scopes
#'   for the OAuth2 security scheme.
#'
#' @keywords internal
#' @seealso [class_oauth2_token_flow()], [class_oauth2_implicit_flow()], and
#'   [class_oauth2_authorization_code_flow()]
abstract_oauth2_flow <- S7::new_class(
  name = "oauth2_flow",
  package = "rapid",
  properties = list(
    refresh_url = character_scalar_property("refresh_url"),
    scopes = class_scopes
  ),
  abstract = TRUE
)
