# Somewhere in oauth2 there's a half-written as_ function which caused me to
# investigate this.

#' Security scheme objects
#'
#' This is an abstract class that is used to define specific types of security
#' schemes.
#'
#' @export
#' @seealso [api_key_security_scheme()]
security_scheme <- S7::new_class(
  name = "security_scheme",
  package = "rapid",
  abstract = TRUE
)
