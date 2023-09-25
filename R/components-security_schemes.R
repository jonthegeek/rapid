#' @include components-security_scheme.R

security_schemes <- S7::new_class(
  name = "security_schemes",
  package = "rapid",
  properties = list(
    name = class_character,
    security_scheme = security_scheme | NULL,
    description = class_character
  ),
  constructor = function(name = class_missing,
                         security_scheme = class_missing,
                         ...,
                         description = class_missing) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      name = name,
      security_scheme = security_scheme %|0|% NULL,
      description = description
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "security_scheme",
      optional = "description"
    )
  }
)
