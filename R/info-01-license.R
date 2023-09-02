# Anything at 01 can only have dependencies at 00.

#' License information for the API
#'
#' Validate the license information for an API.
#'
#' @inheritParams rlang::args_dots_empty
#' @param name The license name used for the API.
#' @param identifier An
#'   [SPDX](https://spdx.org/spdx-specification-21-web-version#h.jxpfx0ykyb60)
#'   license expression for the API. The `identifier` field is mutually
#'   exclusive of the `url` field.
#' @param url A URL to the license used for the API. This *must* be in the form
#'   of a URL. The `url` field is mutually exclusive of the `identifier` field.
#'
#' @return An `api_license` S7 object, with fields `name`, `identifier`, and
#'   `url`.
#' @export
#'
#' @examples
#' api_license(
#'   "Apache 2.0",
#'   identifier = "Apache-2.0"
#' )
#' api_license(
#'   "Apache 2.0",
#'   url = "https://opensource.org/license/apache-2-0/"
#' )
api_license <- S7::new_class(
  "api_license",
  package = "rapid",
  properties = list(
    name = character_scalar_property("name"),
    identifier = character_scalar_property("identifier"),
    url = url_scalar_property("url")
  ),
  constructor = function(name = character(),
                         ...,
                         identifier = character(),
                         url = character()) {
    check_dots_empty()
    S7::new_object(NULL, name = name, identifier = identifier, url = url)
  },
  validator = function(self) {
    if (length(self@identifier) && length(self@url)) {
      return("At most one of @identifier and @url must be supplied.")
    }
    validate_parallel(self, key = "name", optional = c("identifier", "url"))
  }
)

#' @export
`length.rapid::api_license` <- function(x) {
  length(x@name)
}
