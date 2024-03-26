#' @include info.R
#' @include servers.R
#' @include components.R
#' @include security.R
NULL

#' R API description object
#'
#' An object that represents an API.
#'
#' @inheritParams rlang::args_dots_empty
#' @param info An `info` object defined by [class_info()].
#' @param servers A `servers` object defined by [class_servers()].
#' @param components A `components` object defined by [class_components()].
#' @param security A `security` object defined by [class_security()].
#'
#' @return A `rapid` S7 object, with properties `info`, `servers`, `components`,
#'   and `security`.
#' @export
#'
#' @seealso [as_rapid()] for coercing objects to `rapid`.
#'
#' @examples
#' class_rapid()
#' class_rapid(
#'   info = class_info(title = "A", version = "1"),
#'   servers = class_servers(
#'     url = "https://development.gigantic-server.com/v1"
#'   )
#' )
#' class_rapid(
#'   info = class_info(title = "A", version = "1"),
#'   servers = class_servers(
#'     url = c(
#'       "https://development.gigantic-server.com/v1",
#'       "https://staging.gigantic-server.com/v1",
#'       "https://api.gigantic-server.com/v1"
#'     ),
#'     description = c(
#'       "Development server",
#'       "Staging server",
#'       "Production server"
#'     )
#'   ),
#'   components = class_components(
#'     security_schemes = class_security_schemes(
#'       name = "a",
#'       details = class_security_scheme_details(
#'         class_api_key_security_scheme("parm", "query")
#'       )
#'     )
#'   )
#' )
class_rapid <- S7::new_class(
  "rapid",
  package = "rapid",
  properties = list(
    info = class_info,
    servers = class_servers,
    components = class_components,
    paths = S7::class_data.frame,
    security = class_security
  ),
  constructor = function(info = class_info(),
                         ...,
                         servers = class_servers(),
                         components = class_components(),
                         paths = data.frame(),
                         security = class_security()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      info = as_info(info),
      servers = as_servers(servers),
      components = as_components(components),
      paths = paths,
      security = as_security(security)
    )
  },
  validator = function(self) {
    c(
      validate_lengths(
        self,
        key_name = "info",
        optional_any = c("components", "paths", "security", "servers")
      ),
      validate_in_specific(
        values = self@security@name,
        enums = self@components@security_schemes@name,
        value_name = "security",
        enum_name = "the {.arg security_schemes} defined in {.arg components}"
      )
    )
  }
)

S7::method(length, class_rapid) <- function(x) {
  length(x@info)
}

#' Coerce lists and urls to rapid objects
#'
#' `as_rapid()` turns an existing object into a `rapid` object. This is in
#' contrast with [class_rapid()], which builds a `rapid` object from individual
#' properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "info" and/or
#'   "servers", or names that can be coerced to those names via
#'   [snakecase::to_snake_case()]. Extra names are ignored. [url()] objects are
#'   read with [jsonlite::fromJSON()] or [yaml::read_yaml()] before conversion.
#'
#' @return A `rapid` object as returned by [class_rapid()].
#' @export
#'
#' @examples
#' as_rapid()
as_rapid <- S7::new_generic("as_rapid", "x")

S7::method(as_rapid, S7::new_S3_class("url")) <- function(x,
                                                          ...,
                                                          arg = caller_arg(x),
                                                          call = caller_env()) {
  url_string <- .url_to_string(x)
  x <- .url_fetch(url_string)
  if (!length(x$info$`x-origin`)) {
    x$info$`x-origin` <- list(url = url_string)
  }
  as_rapid(x, ..., arg = arg, call = call)
}

S7::method(as_rapid, class_list) <- function(x,
                                             ...,
                                             arg = caller_arg(x),
                                             call = caller_env()) {
  x$paths <- .parse_paths(x$paths, x$openapi, x, call)
  rlang::try_fetch(
    {
      x <- as_api_object(x, class_rapid, ..., arg = arg, call = call)
      expand_servers(x)
    },
    rapid_error_missing_names = function(cnd) {
      cli::cli_abort(
        "{.arg x} must be comprised of properly formed, supported elements.",
        class = "rapid_error_unsupported_elements",
        parent = cnd
      )
    }
  )
}

.parse_paths <- S7::new_generic(".parse_paths", "paths")

S7::method(.parse_paths, S7::class_data.frame) <- function(paths, ...) {
  paths
}

S7::method(.parse_paths, class_list) <- function(paths,
                                                 openapi,
                                                 x,
                                                 call = caller_env()) {
  if (!is.null(openapi) && openapi >= "3") {
    return(.parse_openapi_spec(x, call = call))
  }
  return(data.frame())
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
  return(data.frame())
}

S7::method(as_rapid, class_any) <- function(x,
                                            ...,
                                            arg = caller_arg(x),
                                            call = caller_env()) {
  rlang::try_fetch(
    {
      x <- as_api_object(x, class_rapid, ..., arg = arg, call = call)
      expand_servers(x)
    },
    rapid_error_missing_names = function(cnd) {
      cli::cli_abort(
        "{.arg x} must be comprised of properly formed, supported elements.",
        class = "rapid_error_unsupported_elements",
        parent = cnd
      )
    }
  )
}
