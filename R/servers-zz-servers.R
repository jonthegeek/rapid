# TODO: Implement as_*.

#' A collection of server variables for multiple servers
#'
#' Connectivity information for an API.
#'
#' @param url A character vector of urls.
#' @param description A character vector of (usually brief) descriptions of
#'   those urls.
#' @param variables A [server_variable_list()] object.
#'
#' @return A `servers` S7 object, with properties `url`, `description`, and
#'   `variables`.
#' @export
#'
#' @examples
#' servers(
#'   url = c(
#'     "https://development.gigantic-server.com/v1",
#'     "https://staging.gigantic-server.com/v1",
#'     "https://api.gigantic-server.com/v1"
#'   ),
#'   description = c(
#'     "Development server",
#'     "Staging server",
#'     "Production server"
#'   )
#' )
#' servers(
#'   url = "https://{username}.gigantic-server.com:{port}/{basePath}",
#'   description = "The production API server",
#'   variables = server_variable_list(server_variable(
#'     name = c("username", "port", "basePath"),
#'     default = c("demo", "8443", "v2"),
#'     description = c(
#'       "The active user's folder.",
#'       NA, NA
#'     ),
#'     enum = list(
#'       NULL,
#'       c("8443", "443"),
#'       NULL
#'     )
#'   ))
#' )
servers <- S7::new_class(
  "servers",
  package = "rapid",
  properties = list(
    url = S7::class_character,
    description = S7::class_character,
    variables = server_variable_list
  ),
  validator = function(self) {
    validate_parallel(
      self,
      "url",
      optional = c("description", "variables")
    )
  }
)

.extract_along_chr <- function(x, el) {
  y <- purrr::map(x, el)
  if (purrr::every(y, is.null)) {
    return(NULL)
  }
  purrr::map_chr(
    y,
    \(this) {
      this %||% NA
    }
  )
}

.extract <- function(x, el) {
  x$el %||% NA
}

#' @export
`length.rapid::servers` <- function(x) {
  length(x@url)
}
