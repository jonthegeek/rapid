#' @include properties.R
#' @include components-parameters.R
NULL

class_parameters_reusable <- S7::new_class(
  name = "parameters_reusable",
  package = "rapid",
  properties = list(
    parameter_component_name = class_character,
    parameters = class_parameters
  ),
  validator = function(self) {
    validate_parallel(
      self,
      "parameter_component_name",
      required = c("parameters")
    )
  }
)

S7::method(length, class_parameters_reusable) <- function(x) {
  length(x@parameter_component_name)
}
