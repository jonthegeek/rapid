#' Security schemes
#'
#' This is an abstract class that is only used to define specific types of
#' security schemes.
#'
#' @param name Character (required). The name of this scheme, used to identify
#'   valid schemes for a given operation.
#' @param description Character (optional). A description for the security
#'   scheme. [CommonMark syntax](https://spec.commonmark.org/) *may* be used for
#'   rich text representation.
#'
#' @export
#' @seealso [api_key_security_scheme()]
security_scheme <- S7::new_class(
  name = "security_scheme",
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
