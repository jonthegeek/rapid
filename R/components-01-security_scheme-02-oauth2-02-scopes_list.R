#' Multiple OAuth2 flow scopes objects
#'
#' The available scopes for multiple OAuth2 flows.
#'
#' @param ... One or more [scopes()] objects, or a list of [scopes()] objects.
#'
#' @return A `scopes_list` S7 object, which is a validated list of
#'   [scopes()] objects.
#' @seealso [as_scopes_list()] for coercing objects to `scopes_list`.
#' @export
#' @examples
#' scopes_list(
#'   scopes(
#'     name = c("server:read", "server:write"),
#'     description = c("Read server settings", "Write server settings")
#'   ),
#'   scopes(
#'     name = c("user:email_read", "user:email_write"),
#'     description = c("Read user email settings", "Write user email settings")
#'   )
#' )
scopes_list <- S7::new_class(
  name = "scopes_list",
  package = "rapid",
  parent = class_list,
  constructor = function(...) {
    if (...length() == 1 && is.list(..1)) {
      return(S7::new_object(..1))
    }
    S7::new_object(list(...))
  },
  validator = function(self) {
    bad_scopes <- !purrr::map_lgl(
      S7::S7_data(self),
      ~ S7::S7_inherits(.x, scopes)
    )
    if (any(bad_scopes)) {
      bad_locations <- which(bad_scopes)
      c(
        cli::format_inline(
          "All values must be {.cls scopes} objects."
        ),
        cli::format_inline("Bad values at {bad_locations}.")
      )
    }
  }
)

#' Coerce lists and character vectors to scopes_lists
#'
#' `as_scopes_list()` turns an existing object into a `scopes_list`
#' object. This is in contrast with [scopes_list()], which builds a
#' `scopes_list` object from individual properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @param x The object to coerce. Must be empty or be a list of objects that can
#'   be coerced to `scopes` objects via [as_scopes()].
#'
#' @return A `scopes_list` object as returned by [scopes_list()].
#' @export
as_scopes_list <- S7::new_generic(
  "as_scopes_list",
  dispatch_args = "x"
)

S7::method(as_scopes_list, scopes_list) <- function(x) {
  x
}

S7::method(as_scopes_list, class_list) <- function(x) {
  if (!length(x) || !any(lengths(x))) {
    return(scopes_list())
  }
  scopes_list(
    purrr::map(x, as_scopes)
  )
}

S7::method(as_scopes_list, class_missing | NULL) <- function(x) {
  scopes_list()
}

S7::method(as_scopes_list, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls scopes_list}."
  )
}
