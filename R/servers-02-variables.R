# TODO: Implement as_*.

#' A collection of server variables for multiple servers
#'
#' A list of server variable objects, each of which is constructed with
#' [server_variable()].
#'
#' @param ... One or more [server_variable()] objects, or a list of
#'   [server_variable()] objects.
#'
#' @return A `variables` S7 object, which is a validated list of
#'   [server_variable()] objects.
#' @export
#'
#' @examples
#' variables(
#'   list(server_variable(), server_variable())
#' )
variables <- S7::new_class(
  "variables",
  package = "rapid",
  parent = class_list,
  constructor = function(...) {
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
