#' R API definition object
#'
#' An object that represents an API.
#'
#' @inheritParams .shared-parameters
#' @param info An `info` object defined by [info()].
#' @param servers A `servers` object defined by [servers()].
#'
#' @return A `rapid` S7 object, with properties `info` and `servers`.
#' @export
#'
#' @examples
#' rapid()
#' rapid(
#'   info = info(title = "A", version = "1"),
#'   servers(
#'     url = "https://development.gigantic-server.com/v1"
#'   )
#' )
#' rapid(
#'   info = info(title = "A", version = "1"),
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
    info = info,
    servers = servers
  ),
  constructor = function(info = class_missing,
                         servers = class_missing,
                         ...,
                         apid_url = NULL,
                         apid_list = NULL) {
    if (!is.null(apid_url)) {
      apid_url <- stbl::stabilize_chr_scalar(
        apid_url,
        regex = .url_regex
      )
      apid_list <- yaml::read_yaml(apid_url)
    }
    if (!is.null(apid_list)) {
      info <- info(apid_list = apid_list)
      servers <- servers(apid_list = apid_list)
    }
    S7::new_object(NULL, info = info, servers = servers)
  },
  validator = function(self) {
    validate_lengths(
      self,
      key_name = "info",
      optional_any = "servers"
    )
  }
)

#' @export
`length.rapid::rapid` <- function(x) {
  length(x@info)
}
