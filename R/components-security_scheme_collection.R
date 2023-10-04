#' @include components-security_scheme_details.R
NULL

# TODO: Create an overall components object (incomplete for now), and add it to
# rapid.

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
#'   [security_scheme_details()] object.
#' @param description Character vector (optional). A short description for the
#'   security schemes. [CommonMark syntax](https://spec.commonmark.org/) may be
#'   used for rich text representation.
#'
#' @return A `security_scheme_collection` S7 object with details about security
#'   available for operations.
#' @export
#' @examples
#' security_scheme_collection()
#' security_scheme_collection(
#'   name = c(
#'     "accountAuth",
#'     "resetPasswordAuth"
#'   ),
#'   details = security_scheme_details(
#'     oauth2_security_scheme(
#'       password_flow = oauth2_token_flow(
#'         token_url = "/account/authorization",
#'         scopes = scopes(
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
#'     api_key_security_scheme(
#'       parameter_name = "authorization",
#'       location = "header"
#'     )
#'   )
#' )
security_scheme_collection <- S7::new_class(
  name = "security_scheme_collection",
  package = "rapid",
  properties = list(
    name = class_character,
    details = security_scheme_details,
    description = class_character
  ),
  constructor = function(name = character(),
                         details = security_scheme_details(),
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

S7::method(length, security_scheme_collection) <- function(x) {
  length(x@name)
}

#' Coerce lists to security_scheme_collection objects
#'
#' `as_security_scheme_collection()` turns an existing object into a
#' `security_scheme_collection` object. This is in contrast with
#' [security_scheme_collection()], which builds a `security_scheme_collection`
#' from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a named list, where each
#'   element describes a security scheme object. This object should describe the
#'   security schemes for a single API.
#'
#' @return A `security_scheme_collection` object as returned by
#'   [security_scheme_collection()].
#' @export
#'
#' @examples
#' as_security_scheme_collection()
#' as_security_scheme_collection(
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
#'             Catalog = "Modify profile preferences and activity (bookmarks, watch list)"
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
as_security_scheme_collection <- S7::new_generic(
  "as_security_scheme_collection",
  dispatch_args = "x"
)

S7::method(
  as_security_scheme_collection,
  security_scheme_collection
) <- function(x) {
  x
}

S7::method(as_security_scheme_collection, class_list) <- function(x) {
  # This is the first one where we're fundamentally rearranging things, so watch
  # out for new things to standardize (and then delete this comment)!
  if (!length(x) || !any(lengths(x))) {
    return(security_scheme_collection())
  }

  if (rlang::is_named2(x)) {
    scheme_names <- rlang::names2(x)
    x <- unname(x)
    descriptions <- .extract_along_chr(x, "description")
    return(
      security_scheme_collection(
        name = scheme_names,
        details = x,
        description = descriptions
      )
    )
  }
  cli::cli_abort(c("{.arg {x}} must have names."))
}

S7::method(as_security_scheme_collection, class_missing | NULL | S7::new_S3_class("S7_missing")) <- function(x) {
  security_scheme_collection()
}

S7::method(as_security_scheme_collection, class_any) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls security_scheme_collection}."
  )
}
