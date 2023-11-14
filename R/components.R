#' @include components-security_schemes.R
NULL

#' An element to hold various schemas for the API
#'
#' Holds a set of reusable objects for different aspects of the OAS. All objects
#' defined within the components object will have no effect on the API unless
#' they are explicitly referenced from properties outside the components object.
#' We currently only support the security_schemes object within the components
#' object (see [class_security_schemes()]).
#'
#' @inheritParams rlang::args_dots_empty
#' @param security_schemes An object to hold reusable security scheme objects
#'   created by [class_security_schemes()].
#'
#' @return A `components` S7 object with various schemas for the API.
#' @export
#'
#' @seealso [as_components()] for coercing objects to
#'   `components` objects.
#'
#' @examples
#' class_components()
#' class_components(
#'   security_schemes = class_security_schemes(
#'     name = "a",
#'     details = class_security_scheme_details(
#'       class_api_key_security_scheme("parm", "query")
#'     )
#'   )
#' )
class_components <- S7::new_class(
  "components",
  package = "rapid",
  properties = list(
    security_schemes = class_security_schemes
  ),
  constructor = function(...,
                         security_schemes = class_security_schemes()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      security_schemes = as_security_schemes(security_schemes)
    )
  }
)

S7::method(length, class_components) <- function(x) {
  sum(lengths(S7::props(x)) > 0)
}

#' Coerce lists to components objects
#'
#' `as_components()` turns an existing object into a
#' `components` object. This is in contrast with
#' [class_components()], which builds a `components` from
#' individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list containing a single
#'   list named "security_schemes", or a name that can be coerced to
#'   "security_schemes" via [snakecase::to_snake_case()]. Additional names are
#'   ignored.
#'
#' @return A `components` object as returned by
#'   [class_components()].
#' @export
#'
#' @examples
#' as_components()
#' as_components(list(
#'   securitySchemes = list(
#'     accountAuth = list(
#'       description = "Account JWT token",
#'       flows = list(
#'         password = list(
#'           scopes = list(
#'             Catalog = "Access all read-only content",
#'             Commerce = "Perform account-level transactions",
#'             Playback = "Allow playback of restricted content",
#'             Settings = "Modify account settings"
#'           ),
#'           tokenUrl = "/account/authorization"
#'         )
#'       ),
#'       type = "oauth2"
#'     ),
#'     profileAuth = list(
#'       description = "Profile JWT token",
#'       flows = list(
#'         password = list(
#'           scopes = list(
#'             Catalog = "Modify profile preferences and activity"
#'           ),
#'           tokenUrl = "/account/profile/authorization"
#'         )
#'       ),
#'       type = "oauth2"
#'     ),
#'     resetPasswordAuth = list(
#'       `in` = "header",
#'       name = "authorization",
#'       type = "apiKey"
#'     ),
#'     verifyEmailAuth = list(
#'       `in` = "header",
#'       name = "authorization",
#'       type = "apiKey"
#'     )
#'   )
#' ))
as_components <- function(x,
                          ...,
                          arg = caller_arg(x),
                          call = caller_env()) {
  as_api_object(x, class_components, ..., arg = arg, call = call)
}
