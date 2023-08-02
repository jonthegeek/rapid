# @staticimports pkg:isstatic
#  is_url

.check_scalar <- function(x,
                          arg = rlang::caller_arg(x),
                          call = rlang::caller_env()) {
  len_x <- length(x)
  if (len_x == 1) {
    return(invisible(TRUE))
  }
  cli::cli_abort(c(
    "{.arg {arg}} must be a single value.",
    x = "{.arg {arg}} has length {len_x}."
  ), call = call)
}

.check_url <- function(x,
                       ...,
                       allow_empty = TRUE,
                       allow_na = FALSE,
                       allow_null = FALSE,
                       arg = caller_arg(x),
                       call = caller_env()) {
  UseMethod(".check_url")
}

.check_url.NULL <- function(x,
                            ...,
                            allow_null = FALSE,
                            arg = caller_arg(x),
                            call = caller_env()) {
  return(.check_nullable(x, allow_null, arg, call))
}

.check_url.logical <- function(x,
                               ...,
                               allow_na,
                               arg = caller_arg(x),
                               call = caller_env()) {
  if (!is.na(x)) {
    cli::cli_abort(c(
      "{.arg {arg}} must be a url, not logical."
    ))
  }

  if (allow_na) {
    return(invisible(TRUE))
  }

  cli::cli_abort(c(
    "{.arg {arg}} can't be NA."
  ))
}

.check_url.character <- function(x,
                                 ...,
                                 allow_empty = TRUE,
                                 allow_na = FALSE,
                                 allow_null = FALSE,
                                 arg = caller_arg(x),
                                 call = caller_env()) {
  if (is_url(x)) {
    return(invisible(TRUE))
  }

}

.check_nullable <- function(x,
                            allow_null,
                            arg = caller_arg(x),
                            call = caller_env()) {
  if (allow_null) {
    return(invisible(TRUE))
  }
  cli::cli_abort(c(
    "{.arg {arg} must not be NULL."
  ))
}
