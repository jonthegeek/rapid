#' R API definition object
#'
#' An object that represents an API.
#'
#' @param info An `api_info` object defined by [api_info()].
#' @param servers A `servers` object defined by [servers()].
#'
#' @return A `rapid` S7 object, with properties `info` and `servers`.
#' @export
#'
#' @examples
#' rapid()
#' rapid(
#'   info = api_info(title = "A", version = "1"),
#'   servers(
#'     url = "https://development.gigantic-server.com/v1"
#'   )
#' )
#' rapid(
#'   info = api_info(title = "A", version = "1"),
#'   servers(
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
#'   )
#' )
rapid <- S7::new_class(
  "rapid",
  package = "rapid",
  properties = list(
    info = api_info,
    servers = servers
  ),
  validator = function(self) {
    validate_lengths(
      self,
      key = "info",
      # In this case the max length is redundant, since api_info can only have
      # length 0 or 1.
      key_max_length = 1,
      optional_any = "servers"
    )
  }
)

#' @export
`length.rapid::rapid` <- function(x) {
  length(x@info)
}
