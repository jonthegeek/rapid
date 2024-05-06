#' The available paths and operations for the API
#'
#' Holds the relative paths to the individual endpoints and their operations.
#' The path is appended to the URL from the [class_servers()] object in order to
#' construct the full URL. The paths may be empty.
#'
#' @param ... A data.frame, or arguments to pass to [tibble::tibble()].
#'
#' @return A `paths` S7 object with details about API endpoints.
#' @export
#' @family paths
#'
#' @examples
#' class_paths()
#' class_paths(
#'   tibble::tibble(
#'     endpoint = c("/endpoint1", "/endpoint2"),
#'     operations = list(
#'       tibble::tibble(operation_properties = 1:2),
#'       tibble::tibble(operation_properties = 3:5)
#'     )
#'   )
#' )
class_paths <- S7::new_class(
  "paths",
  package = "rapid",
  parent = class_data.frame,
  constructor = function(...) {
    if (...length() == 1 && is.data.frame(..1)) {
      return(S7::new_object(tibble::as_tibble(..1)))
    }
    S7::new_object(tibble::tibble(...))
  }
)

#' Coerce objects to paths
#'
#' `as_paths()` turns an existing object into a `paths` object. This is in
#' contrast with [class_paths()], which builds a `paths` object from individual
#' properties. In practice, [class_paths()] and `as_paths()` are currently
#' functionally identical. However, in the future, `as_paths()` will coerce
#' other valid objects to the expected shape.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or be a `data.frame()`.
#'
#' @return A `paths` object as returned by [class_paths()].
#' @export
#' @family paths
#'
#' @examples
#' as_paths()
#' as_paths(mtcars)
as_paths <- S7::new_generic("as_paths", "x")

S7::method(as_paths, class_data.frame) <- function(x,
                                                   ...,
                                                   arg = caller_arg(x),
                                                   call = caller_env()) {
  class_paths(x)
}

S7::method(as_paths, class_any) <- function(x,
                                            ...,
                                            arg = caller_arg(x),
                                            call = caller_env()) {
  as_api_object(x, class_paths, ..., arg = arg, call = call)
}

.parse_paths <- S7::new_generic(".parse_paths", "paths")

S7::method(.parse_paths, class_data.frame | class_paths) <- function(paths,
                                                                     ...) {
  paths
}

S7::method(.parse_paths, class_list) <- function(paths,
                                                 openapi,
                                                 x,
                                                 call = caller_env()) {
  if (!is.null(openapi) && openapi >= "3") {
    return(.parse_openapi_spec(x, call = call))
  }
  return(tibble::tibble())
}

.parse_openapi_spec <- function(x, call = caller_env()) { # nocov start
  rlang::try_fetch(
    {
      tibblify::parse_openapi_spec(x)
    },
    error = function(cnd) {
      cli::cli_abort(
        "Failed to parse paths from OpenAPI spec.",
        class = "rapid_error_bad_tibblify",
        call = call
      )
    }
  )
} # nocov end

S7::method(.parse_paths, class_any) <- function(paths, ...) {
  return(tibble::tibble())
}
