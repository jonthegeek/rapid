#' @include zz-rapid.R
NULL

#' Expand server urls to absolute paths
#'
#' `expand_servers()` uses the `origin` property of a `rapid` object to expand
#' the `servers` `url` property to an absolute path.
#'
#' @inheritParams rlang::args_error_context
#' @inheritParams rlang::args_dots_empty
#' @param x The object to update. Must be a `rapid`.
#'
#' @return A `rapid` object as returned by [class_rapid()], with absolute server
#'   paths.
#' @export
#' @family rapid
expand_servers <- S7::new_generic("expand_servers", "x")

S7::method(expand_servers, class_rapid) <- function(x) {
  if (length(x@servers@url)) {
    relative_servers <- .is_relative_url(x@servers@url)
    origin_url <- x@info@origin@url
    if (length(origin_url)) {
      base_url <- url_absolute("..", origin_url)
      x@servers@url[relative_servers] <- paste0(
        base_url,
        x@servers@url[relative_servers]
      )
      x@servers@url[relative_servers] <- gsub(
        pattern = "(?<!\\:)//",
        replacement = "/",
        x = x@servers@url[relative_servers],
        perl = TRUE
      )
    }
  }
  return(x)
}

S7::method(expand_servers, class_any) <- function(x,
                                                  arg = caller_arg(x),
                                                  call = caller_env()) {
  cli::cli_abort(
    "{.arg {arg}} {.cls {class(x)}} must be a {.cls rapid}.",
    call = call
  )
}
