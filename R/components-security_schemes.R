#' @include components-security_scheme_details.R
NULL

#' Reusable security schemes for an API
#'
#' The object provides reusable security schemes for the API. These schemes may
#' be referenced by name in the top-level `security` object or within `paths`
#' objects.
#'
#' @inheritParams rlang::args_dots_empty
#' @param name Character vector (required). Names by which security schemes will
#'   be referenced.
#' @param details The details of each security scheme, as a
#'   [class_security_scheme_details()] object.
#' @param description Character vector (optional). A short description for the
#'   security schemes. [CommonMark syntax](https://spec.commonmark.org/) may be
#'   used for rich text representation.
#'
#' @return A `security_schemes` S7 object with details about security available
#'   for operations.
#' @export
#' @examples
#' class_security_schemes()
#' class_security_schemes(
#'   name = c(
#'     "accountAuth",
#'     "resetPasswordAuth"
#'   ),
#'   details = class_security_scheme_details(
#'     class_oauth2_security_scheme(
#'       password_flow = class_oauth2_token_flow(
#'         token_url = "/account/authorization",
#'         scopes = class_scopes(
#'           name = c("Catalog", "Commerce", "Playback", "Settings"),
#'           description = c(
#'             "Access all read-only content",
#'             "Perform account-level transactions",
#'             "Allow playback of restricted content",
#'             "Modify account settings"
#'           )
#'         )
#'       )
#'     ),
#'     class_api_key_security_scheme(
#'       parameter_name = "authorization",
#'       location = "header"
#'     )
#'   )
#' )
class_security_schemes <- S7::new_class(
  name = "security_schemes",
  package = "rapid",
  properties = list(
    name = class_character,
    details = class_security_scheme_details,
    description = class_character
  ),
  constructor = function(name = character(),
                         details = class_security_scheme_details(),
                         ...,
                         description = character()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      name = name %||% character(),
      details = as_security_scheme_details(details),
      description = description %||% character()
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "details",
      optional = "description"
    )
  }
)

S7::method(length, class_security_schemes) <- function(x) {
  length(x@name)
}

#' Coerce lists to security_schemes objects
#'
#' `as_security_schemes()` turns an existing object into a `security_schemes`
#' object. This is in contrast with [class_security_schemes()], which builds a
#' `security_schemes` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a named list, where each
#'   element describes a security scheme object. This object should describe the
#'   security schemes for a single API.
#'
#' @return A `security_schemes` object as returned by
#'   [class_security_schemes()].
#' @export
#'
#' @examples
#' as_security_schemes()
#' as_security_schemes(
#'   list(
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
#' )
as_security_schemes <- S7::new_generic("as_security_schemes", "x")

S7::method(
  as_security_schemes,
  class_list
) <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  force(arg)
  # This is the first one where we're fundamentally rearranging things, so watch
  # out for new things to standardize (and then delete this comment)!
  if (!length(x) || !any(lengths(x))) {
    return(class_security_schemes())
  }

  if (rlang::is_named2(x)) {
    scheme_names <- rlang::names2(x)
    x <- unname(x)
    descriptions <- .extract_along_chr(x, "description")
    return(
      class_security_schemes(
        name = scheme_names,
        details = x,
        description = descriptions
      )
    )
  }
  cli::cli_abort(
    c("{.arg {arg}} must have names."),
    call = call
  )
}

S7::method(
  as_security_schemes,
  class_any
) <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  as_api_object(x, class_security_schemes, ..., arg = arg, call = call)
}
