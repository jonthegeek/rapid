#' Security scheme objects
#'
#' This is an abstract class that is used to define specific types of security
#' schemes.
#'
#' @keywords internal
#' @seealso [class_api_key_security_scheme()], [class_oauth2_security_scheme()]
abstract_security_scheme <- S7::new_class(
  name = "security_scheme",
  package = "rapid",
  abstract = TRUE
)

#' Coerce lists to security_scheme objects
#'
#' `as_security_scheme()` turns an existing object into a `security_scheme`
#' object. It uses the `type` element of such objects to determine which type of
#' security scheme to construct.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a named list, with at
#'   least an element `type`. The `type` element is processed through
#'   [snakecase::to_snake_case()], and then must be one of "api_key", "oauth2",
#'   or "oauth_2".
#'
#' @return A `security_scheme` object as returned by
#'   [class_api_key_security_scheme()] or [class_oauth2_security_scheme()].
#' @export
#'
#' @examples
#' as_security_scheme()
#' as_security_scheme(
#'   list(
#'     description = "Account JWT token",
#'     flows = list(
#'       password = list(
#'         scopes = list(
#'           Catalog = "Access all read-only content",
#'           Commerce = "Perform account-level transactions",
#'           Playback = "Allow playback of restricted content",
#'           Settings = "Modify account settings"
#'         ),
#'         tokenUrl = "/account/authorization"
#'       )
#'     ),
#'     type = "oauth2"
#'   )
#' )
#' as_security_scheme(
#'   list(
#'     description = "Profile JWT token",
#'     flows = list(
#'       password = list(
#'         scopes = list(
#'           Catalog = "Modify profile preferences and activity"
#'         ),
#'         tokenUrl = "/account/profile/authorization"
#'       )
#'     ),
#'     type = "oauth2"
#'   )
#' )
#' as_security_scheme(
#'   list(
#'     `in` = "header",
#'     name = "authorization",
#'     type = "apiKey"
#'   )
#' )
as_security_scheme <- S7::new_generic("as_security_scheme", "x")

S7::method(as_security_scheme, abstract_security_scheme) <- function(x, ...) {
  x
}

S7::method(as_security_scheme, class_list) <- function(x,
                                                       ...,
                                                       arg = caller_arg(x),
                                                       call = caller_env()) {
  if (!length(x) || !any(lengths(x))) {
    return(NULL)
  }
  type <- snakecase::to_snake_case(x$type)
  x$type <- NULL
  switch(type,
    api_key = as_api_key_security_scheme(x, ..., arg = arg, call = call),
    oauth_2 = as_oauth2_security_scheme(x, ..., arg = arg, call = call),
    oauth2 = as_oauth2_security_scheme(x, ..., arg = arg, call = call)
  )
}

S7::method(
  as_security_scheme,
  class_missing | NULL
) <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  NULL
}

S7::method(as_security_scheme, class_any) <- function(x,
                                                      ...,
                                                      arg = caller_arg(x),
                                                      call = caller_env()) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls rapid::security_scheme}.",
    call = call
  )
}
