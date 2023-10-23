#' @include info.R
#' @include servers.R
#' @include components.R
#' @include security_requirements.R
NULL

#' R API description object
#'
#' An object that represents an API.
#'
#' @inheritParams rlang::args_dots_empty
#' @param info An `info` object defined by [info()].
#' @param servers A `servers` object defined by [servers()].
#' @param components A `component_collection` object defined by
#'   [component_collection()].
#' @param security A `security_requirements` object defined by
#'   [security_requirements()].
#'
#' @return A `rapid` S7 object, with properties `info`, `servers`, `components`,
#'   and `security`.
#' @export
#'
#' @seealso [as_rapid()] for coercing objects to `rapid`.
#'
#' @examples
#' rapid()
#' rapid(
#'   info = info(title = "A", version = "1"),
#'   servers = servers(
#'     url = "https://development.gigantic-server.com/v1"
#'   )
#' )
#' rapid(
#'   info = info(title = "A", version = "1"),
#'   servers = servers(
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
#'   components = component_collection(
#'     security_schemes = security_scheme_collection(
#'       name = "a",
#'       details = security_scheme_details(
#'         api_key_security_scheme("parm", "query")
#'       )
#'     )
#'   )
#' )
rapid <- S7::new_class(
  "rapid",
  package = "rapid",
  properties = list(
    info = info,
    servers = servers,
    components = component_collection,
    security = security_requirements
  ),
  constructor = function(info = class_missing,
                         ...,
                         servers = class_missing,
                         components = component_collection(),
                         security = security_requirements()) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      info = as_info(info),
      servers = as_servers(servers),
      components = as_component_collection(components),
      security = as_security_requirements(security)
    )
  },
  validator = function(self) {
    c(
      validate_lengths(
        self,
        key_name = "info",
        optional_any = c("components", "security", "servers")
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

S7::method(length, rapid) <- function(x) {
  length(x@info)
}

#' Coerce lists and urls to rapid objects
#'
#' `as_rapid()` turns an existing object into a `rapid` object. This is in
#' contrast with [rapid()], which builds a `rapid` object from individual
#' properties.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty or have names "info" and/or
#'   "servers", or names that can be coerced to those names via
#'   [snakecase::to_snake_case()]. Extra names are ignored.
#'
#' @return A `rapid` object as returned by [rapid()].
#' @export
#'
#' @examples
#' as_rapid()
as_rapid <- S7::new_generic("as_rapid", dispatch_args = "x")

S7::method(as_rapid, rapid) <- function(x) {
  x
}

S7::method(as_rapid, class_list) <- function(x) {
  rlang::try_fetch(
    {
      x <- as_rapid_class(x, rapid)
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

S7::method(as_rapid, S7::new_S3_class("url")) <- function(x) {
  url <- summary(x)$description
  x <- yaml::read_yaml(x)
  if (!length(x$info$`x-origin`)) {
    x$info$`x-origin` <- list(url = url)
  }

  as_rapid(x)
}

S7::method(as_rapid, class_missing | NULL) <- function(x) {
  rapid()
}

S7::method(as_rapid, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls rapid}."
  )
}
