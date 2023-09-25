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
#' @param scopes An optional [scopes()] object with the available scopes for the
#'   OAuth2 security scheme.
#'
#' @export
#' @seealso [oauth2_token_flow()], [oauth2_implicit_flow()], and
#'   [oauth2_authorization_code_flow()]
oauth2_flow <- S7::new_class(
  name = "oauth2_flow",
  package = "rapid",
  properties = list(
    refresh_url = character_scalar_property("refresh_url"),
    scopes = scopes
  ),
  abstract = TRUE
)

# TODO: as_oauth2_flow? Yes, the name of the object says what type it is.
