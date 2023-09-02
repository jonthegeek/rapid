#' A collection of server variables for multiple servers
#'
#' Connectivity information for an API.
#'
#' @inheritParams .shared-parameters
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
  constructor = function(url = class_missing,
                         description = class_missing,
                         variables = class_missing,
                         ...,
                         apid_list = NULL) {
    if (!is.null(apid_list) && !is.null(apid_list$servers)) {
      url <- .extract_along_chr(apid_list$servers, "url")
      description <- .extract_along_chr(apid_list$servers, "description")
      variables <- server_variable_list(apid_list = apid_list)
    }
    S7::new_object(
      NULL,
      url = url,
      description = description,
      variables = variables
    )
  },
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
