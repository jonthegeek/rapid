#' @include components-parameter.R
#' @include components-reference.R
NULL

class_parameters <- S7::new_class(
  "parameters",
  package = "rapid",
  parent = class_list,
  constructor = function(...) {
    if (...length() == 1 && is.list(..1)) {
      return(S7::new_object(..1))
    }
    S7::new_object(list(...))
  },
  validator = function(self) {
    bad_parameters <- !purrr::map_lgl(
      S7::S7_data(self),
      ~ S7_inherits(.x, class_parameter) | S7_inherits(.x, class_reference)
    )
    if (any(bad_parameters)) {
      bad_locations <- which(bad_parameters)
      c(
        cli::format_inline(
          "All values must be {.cls parameter} or {.cls reference} objects."
        ),
        cli::format_inline("Bad values at {bad_locations}.")
      )
    }
  }
)
