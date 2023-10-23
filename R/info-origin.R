#' @include properties.R
NULL

#' Source information for the API description
#'
#' A `class_origin` object provides information about the primary source
#' document(s) used to build an API.
#'
#' @inheritParams rlang::args_dots_empty
#' @param url Character (required). The URL(s) where the document(s) can be
#'   found.
#' @param format Character scalar (optional). The format of the document.
#'   Presently this will likely always be "openapi".
#' @param version Character scalar (optional). The specification version
#'   (relative to the `format`) used in defining the document. Not to be
#'   confused with the version of the API description itself. Most often this
#'   will be "3.0" (as in "OpenAPI Specification version 3.0"), "3.1", or a
#'   patch version of those.
#'
#' @return A `class_origin` S7 object describing where to find the API
#'   description, with fields `url`, `format`, and `version`.
#' @export
#'
#' @seealso [as_origin()] for coercing objects to `class_origin`.
#'
#' @examples
#' class_origin(
#'   "https://api.open.fec.gov/swagger/",
#'   format = "openapi",
#'   version = "3.0"
#' )
class_origin <- S7::new_class(
  "class_origin",
  package = "rapid",
  properties = list(
    url = character_scalar_property("url"),
    format = character_scalar_property("format"),
    version = character_scalar_property("version")
  ),
  constructor = function(url = character(),
                         ...,
                         format = character(),
                         version = character()) {
    check_dots_empty()
    if (is.list(url) && length(url) == 1) {
      url <- unname(unlist(url))
    }

    S7::new_object(
      S7::S7_object(),
      url = url %|0|% character(),
      format = format %|0|% character(),
      version = version %|0|% character()
    )
  },
  validator = function(self) {
    validate_parallel(self, "url", optional = c("format", "version"))
  }
)

S7::method(length, class_origin) <- function(x) {
  length(x@url)
}

#' Coerce lists and character vectors to class_origin
#'
#' `as_origin()` turns an existing object into a `class_origin`. This is in
#' contrast with [class_origin()], which builds a `class_origin` from individual
#' properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "url", "format",
#'   and/or "version", or names that can be coerced to those names via
#'   [snakecase::to_snake_case()]. Extra names are ignored. This object should
#'   describe a single origin for this API description.
#'
#' @return A `class_origin` as returned by [class_origin()].
#' @export
#'
#' @examples
#' as_origin()
#' as_origin(
#'   list(
#'     list(
#'       format = "openapi",
#'       url = "https://api.open.fec.gov/swagger/",
#'       version = "3.0"
#'     )
#'   )
#' )
as_origin <- S7::new_generic("as_origin", dispatch_args = "x")

S7::method(as_origin, class_origin) <- function(x) {
  x
}

S7::method(as_origin, class_list | class_character) <- function(x) {
  # Case 1: Passed in as a simple character vector, or that wrapped in a list.
  if (length(x) == 1 && lengths(x) == 1 && is.character(unlist(x))) {
    x <- list(url = unname(unlist(x)))
  }
  # Case 2: apis.guru provides a list of lists, but we currently only support
  # the case where that list has 1 entry.
  if (length(x) == 1 && lengths(x) > 1) {
    x <- x[[1]]
  }

  as_rapid_class(x, class_origin)
}

S7::method(as_origin, class_missing | NULL) <- function(x) {
  class_origin()
}

S7::method(as_origin, class_any) <- function(x,
                                             ...,
                                             arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls class_origin}."
  )
}
