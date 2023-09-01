#' A collection of server variables for multiple servers
#'
#' Connectivity information for an API.
#'
#' @param url A list of [server_variable()] objects.
#' @param description A list of [server_variable()] objects.
#' @param variables [server_variable_list()] object.
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
    url = url_property("url"),
    description = character_property("description"),
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

#' @export
`length.rapid::servers` <- function(x) {
  length(x@url)
}
