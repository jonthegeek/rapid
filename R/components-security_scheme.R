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

as_security_scheme <- S7::new_generic("as_security_scheme", dispatch_args = "x")

S7::method(as_security_scheme, security_scheme) <- function(x) {
  x
}

S7::method(as_security_scheme, class_list) <- function(x) {
  if (!length(x) || !any(lengths(x))) {
    return(NULL)
  }
  switch(
    snakecase::to_snake_case(x$type),
    api_key = as_api_key_security_scheme(x),
    # http = as_http_security_scheme(x),
    # mutual_tls = as_mutual_tls_security_scheme(x),
    oauth_2 = as_oauth2_security_scheme(x),
    oauth2 = as_oauth2_security_scheme(x) #,
    # open_id_connect = as_open_id_connect_security_scheme(x)
  )
}

S7::method(as_security_scheme, class_missing | NULL) <- function(x) {
  security_scheme()
}

S7::method(as_security_scheme, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls security_scheme}."
  )
}
