#' License information for the API
#'
#' Validate the license information for an API.
#'
#' @inheritParams rlang::args_dots_empty
#' @param name Character scalar (optional). The license name used for the API.
#' @param identifier Character scalar (optional). An
#'   [SPDX](https://spdx.org/spdx-specification-21-web-version#h.jxpfx0ykyb60)
#'   license expression for the API. The `identifier` field is mutually
#'   exclusive of the `url` field.
#' @param url Character scalar (optional). A URL to the license used for the
#'   API. This *must* be in the form of a URL. The `url` field is mutually
#'   exclusive of the `identifier` field.
#'
#' @return A `license` S7 object, with fields `name`, `identifier`, and `url`.
#' @export
#'
#' @examples
#' license(
#'   "Apache 2.0",
#'   identifier = "Apache-2.0"
#' )
#' license(
#'   "Apache 2.0",
#'   url = "https://opensource.org/license/apache-2-0/"
#' )
license <- S7::new_class(
  "license",
  package = "rapid",
  properties = list(
    name = character_scalar_property("name"),
    identifier = character_scalar_property("identifier"),
    url = character_scalar_property("url")
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
    validate_parallel(self, "name", optional = c("identifier", "url"))
  }
)

#' @export
`length.rapid::license` <- function(x) {
  length(x@name)
}

#' Coerce lists and character vectors to licenses
#'
#' `as_license()` turns an existing object into a `license`. This is in contrast
#' with [license()], which builds a `license` from individual properties.
#'
#' @param x The object to coerce. Must be empty or have names "name",
#'   "identifier", and/or "url". Extra names are ignored.
#'
#' @return A `license` as returned by [license()].
#' @export
#'
#' @examples
#' as_license()
#' as_license(list(name = "Apache 2.0", identifier = "Apache-2.0"))
as_license <- S7::new_generic("as_license", dispatch_args = "x")

S7::method(as_license, license) <- function(x) {
  x
}

S7::method(as_license, class_list | class_character) <- function(x) {
  x <- .validate_for_as_class(x, license)
  license(name = x[["name"]], identifier = x[["identifier"]], url = x[["url"]])
}

S7::method(as_license, class_missing | class_null) <- function(x) {
  license()
}

S7::method(as_license, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls license}."
  )
}
