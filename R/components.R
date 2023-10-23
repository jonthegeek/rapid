#' @include components-security_scheme_collection.R
NULL

#' An element to hold various schemas for the API
#'
#' Holds a set of reusable objects for different aspects of the OAS. All objects
#' defined within the components object will have no effect on the API unless
#' they are explicitly referenced from properties outside the components object.
#' We currently only support the security_schemes object within the components
#' object (see [security_scheme_collection()]).
#'
#' @inheritParams rlang::args_dots_empty
#' @param security_schemes An object to hold reusable security scheme objects
#'   created by [security_scheme_collection()].
#'
#' @return A `component_collection` S7 object with various schemas for the API.
#' @export
#'
#' @seealso [as_component_collection()] for coercing objects to
#'   `component_collection` objects.
#'
#' @examples
#' component_collection()
#' component_collection(
#'   security_schemes = security_scheme_collection(
#'     name = "a",
#'     details = security_scheme_details(
#'       api_key_security_scheme("parm", "query")
#'     )
#'   )
#' )
component_collection <- S7::new_class(
  "component_collection",
  package = "rapid",
  properties = list(
    security_schemes = security_scheme_collection
  ),
  constructor = function(...,
                         security_schemes = security_scheme_collection()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      security_schemes = as_security_scheme_collection(security_schemes)
    )
  }
)

S7::method(length, component_collection) <- function(x) {
  sum(lengths(S7::props(x)) > 0)
}

#' Coerce lists to component_collection objects
#'
#' `as_component_collection()` turns an existing object into a
#' `component_collection` object. This is in contrast with
#' [component_collection()], which builds a `component_collection` from
#' individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a list containing a single
#'   list named "security_schemes", or a name that can be coerced to
#'   "security_schemes" via [snakecase::to_snake_case()]. Additional names are
#'   ignored.
#'
#' @return A `component_collection` object as returned by
#'   [component_collection()].
#' @export
#'
#' @examples
#' as_component_collection()
#' as_component_collection(list(
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
as_component_collection <- S7::new_generic(
  "as_component_collection",
  dispatch_args = "x"
)

S7::method(as_component_collection, component_collection) <- function(x) {
  x
}

S7::method(as_component_collection, class_list) <- function(x) {
  as_rapid_class(x, component_collection)
}

S7::method(as_component_collection, class_missing | NULL) <- function(x) {
  component_collection()
}

S7::method(
  as_component_collection,
  class_any
) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls component_collection}."
  )
}
