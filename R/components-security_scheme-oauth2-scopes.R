#' OAuth2 flow scopes objects
#'
#' The available scopes for an OAuth2 flow.
#'
#' @param name Character vector (required). The name of the scope.
#' @param description Character vector (required). A short description of the
#'   scope.
#'
#' @return A `scopes` S7 object, with fields `name` and `description`.
#' @seealso [as_scopes()] for coercing objects to `scopes`.
#' @export
#' @examples
#' class_scopes(
#'   name = c(
#'     "https://www.googleapis.com/auth/youtube",
#'     "https://www.googleapis.com/auth/youtube.channel-memberships.creator",
#'     "https://www.googleapis.com/auth/youtube.force-ssl",
#'     "https://www.googleapis.com/auth/youtube.readonly",
#'     "https://www.googleapis.com/auth/youtube.upload",
#'     "https://www.googleapis.com/auth/youtubepartner",
#'     "https://www.googleapis.com/auth/youtubepartner-channel-audit"
#'   ),
#'   description = c(
#'     "Manage your YouTube account",
#'     "See a list of your current active channel members",
#'     "See, edit, and permanently delete your YouTube videos",
#'     "View your YouTube account",
#'     "Manage your YouTube videos",
#'     "View and manage your assets and associated content on YouTube",
#'     "View private information of your YouTube channel"
#'   )
#' )
class_scopes <- S7::new_class(
  name = "scopes",
  package = "rapid",
  properties = list(
    name = class_character,
    description = class_character
  ),
  constructor = function(name = character(),
                         description = character()) {
    S7::new_object(
      S7::S7_object(),
      name = name %|0|% character(),
      description = description %|0|% character()
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "description"
    )
  }
)

S7::method(length, class_scopes) <- function(x) {
  length(x@name)
}

#' Coerce lists and character vectors to scopes
#'
#' `as_scopes()` turns an existing object into a `scopes`. This is in contrast
#' with [class_scopes()], which builds a `scopes` from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be coercible to a named character vector.
#'
#' @return A `scopes` as returned by [class_scopes()].
#' @export
as_scopes <- S7::new_generic("as_scopes", "x")

S7::method(
  as_scopes,
  class_list | class_character
) <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  force(arg)
  x <- unlist(x)
  x <- stabilize_chr(x, x_arg = arg)
  if (!rlang::is_named2(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a named character vector.",
      call = call
    )
  }
  class_scopes(
    name = names(x),
    description = unname(x)
  )
}

S7::method(as_scopes, class_any) <- function(x,
                                             ...,
                                             arg = caller_arg(x),
                                             call = caller_env()) {
  as_api_object(x, class_scopes, ..., arg = arg, call = call)
}
