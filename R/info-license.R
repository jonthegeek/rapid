#' License  information for the API
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
#' @return A `rapid_license` object: a list with fields `name`, identifier, and
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
api_license <- function(name, ..., identifier = NULL, url = NULL) {
  name <- to_chr_scalar(name)
  rlang::check_dots_empty()
  rlang::check_exclusive(identifier, url)
  identifier <- to_chr_scalar(identifier)
  url <- stabilize_chr_scalar(
    url,
    regex = "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
  )

  return(
    .new_rapid_license(
      name = name,
      identifier = identifier,
      url = url
    )
  )
}

.new_rapid_license <- function(name, identifier = NULL, url = NULL) {
  return(
    .add_class(
      list(
        name = name,
        identifier = identifier,
        url = url
      ),
      new_class = "rapid_license"
    )
  )
}
