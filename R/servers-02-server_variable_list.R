#' A collection of server variables for multiple servers
#'
#' A list of server variable objects, each of which is constructed with
#' [server_variable()].
#'
#' @inheritParams .shared-parameters
#' @param ... One or more [server_variable()] objects, or a list of
#'   [server_variable()] objects.
#'
#' @return A `server_variable_list` S7 object, which is a validated list of
#'   [server_variable()] objects.
#' @export
#'
#' @examples
#' server_variable_list(
#'   list(server_variable(), server_variable())
#' )
server_variable_list <- S7::new_class(
  "server_variable_list",
  package = "rapid",
  parent = S7::class_list,
  constructor = function(..., apid_list = NULL) {
    if (!is.null(apid_list)) {
      return(S7::new_object(
        purrr::map(
          apid_list$servers,
          \(this_server) {
            these_names <- names(this_server$variables)
            vars <- unname(this_server$variables)
            server_variable(
              name = these_names,
              default = purrr::map_chr(vars, "default"),
              enum = purrr::map(vars, "enum")
            )
          }
        )
      ))
    }
    if (...length() == 1 && is.list(..1)) {
      return(S7::new_object(..1))
    }
    S7::new_object(list(...))
  },
  validator = function(self) {
    bad_server_vars <- !purrr::map_lgl(
      S7::S7_data(self),
      ~ S7::S7_inherits(.x, server_variable)
    )
    if (any(bad_server_vars)) {
      bad_locations <- which(bad_server_vars)
      c(
        cli::format_inline(
          "All values must be {.cls server_variable} objects."
        ),
        cli::format_inline("Bad values at {bad_locations}.")
      )
    }
  }
)
