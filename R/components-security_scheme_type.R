#' Security scheme objects
#'
#' This is an abstract class that is used to define specific types of security
#' schemes. Note: each security scheme object can hold multiple schemes of that
#' type.
#'
#' @param name Character vector (required). The names of the members of this
#'   scheme, used to identify valid schemes for a given operation.
#' @param description Character vector (optional). A description for each
#'   security scheme. [CommonMark syntax](https://spec.commonmark.org/) may be
#'   used for rich text representation.
#'
#' @export
#' @seealso [api_key_security_scheme()]
security_scheme_type <- S7::new_class(
  name = "security_scheme_type",
  package = "rapid",
  properties = list(
    name = class_character,
    description = class_character
  ),
  abstract = TRUE,
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      optional = "description"
    )
  }
)

# TODO: as_security_scheme() to coerce lists to security schemes, using `type`
# to choose the class constructor to call. Don't bother with this 'til they're
# all done, though.
