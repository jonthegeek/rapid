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
  .check_tibblify_version(call = call)
  rlang::try_fetch(
    {
      tibblify::parse_openapi_spec(.prepare_spec_for_tibblify(x))
    },
    error = function(cnd) {
      cli::cli_abort(
        "Failed to parse paths from OpenAPI spec.",
        class = "rapid_error_bad_tibblify",
        call = call
      )
    }
  )
}

.check_tibblify_version <- function(call = caller_env()) {
  expected_body <- c(
    "{",
    "openapi_spec <- read_spec(file)",
    "version <- openapi_spec$openapi",
    "if (is_null(version) || version < \"3\") {\n    cli_abort(\"OpenAPI versions before 3 are not supported.\")\n}",
    "if (is_installed(\"memoise\")) {\n    memoise::forget(parse_schema_memoised)\n}",
    "out <- purrr::map(openapi_spec$paths, ~{\n    parse_path_item_object(path_item_object = .x, openapi_spec = openapi_spec)\n})",
    "fast_tibble(list(endpoint = names2(out), operations = unname(out)))"
  )
  actual_body <- as.character(body(tibblify::parse_openapi_spec))

  if (!identical(actual_body, expected_body)) {
    cli::cli_abort(
      c(
        "Incorrect tibblify version.",
        i = "This package requires an in-progress version of the package tibblify.",
        i = "To parse this spec, first {.run pak::pak('mgirlich/tibblify#191')}."
      ),
      class = "rapid_error_bad_tibblify",
      call = call
    )
  }
}

.prepare_spec_for_tibblify <- function(x) {
  if ("paths" %in% names(x)) {
    x$paths <- .prepare_paths_for_tibblify(x$paths)
  }
  return(x)
}

.prepare_paths_for_tibblify <- function(paths) {
  purrr::map(
    paths,
    .prepare_path_for_tibblify
  )
}

.prepare_path_for_tibblify <- function(path) {
  methods <- c("get", "put", "post", "delete", "options", "head", "patch", "trace")
  path[intersect(names(path), methods)] <- purrr::map(
    path[intersect(names(path), methods)],
    .prepare_method_for_tibblify
  )
}

.prepare_method_for_tibblify <- function(method) {
  if (is.null(method$tags)) {
    method$tags <- "general"
  }
  method$responses <- purrr::map(
    method$responses,
    .prepare_response_for_tibblify
  )
  return(method)
}

.prepare_response_for_tibblify <- function(response) {
  if (!is.null(response$`$ref`)) {
    if (.is_url_string(response$`$ref`)) {
      other_parts <- response[setdiff(names(response), "$ref")]
      response <- c(.url_fetch(response$`$ref`), other_parts)
    }
  }
  response$description <- response$description %||% "Undescribed"
  return(response)
}

# nocov end

S7::method(.parse_paths, class_any) <- function(paths, ...) {
  return(tibble::tibble())
}
