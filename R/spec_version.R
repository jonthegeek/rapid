#' Construct the spec_version object for a rapid
#'
#' A `spec_version` describes the specification schema from which the rapid was
#' derived.
#'
#' @param spec_type A single string describing the type of spec, such as
#'   "openapi", "swagger", or some other value.
#' @param spec_version A single character or other value indicating the version
#'   number, such as "2.0" or "3.0.3" or "3". The value is validated for openapi
#'   or swagger types, but left as-is for other types.
#' @param new_type A logical indicating whether this is a new type of spec
#'   (something other than "openapi" or "swagger").
#'
#' @return An object consisting of a single version with a class specifying the
#'   type of specification, or `NULL`.
#' @export
#'
#' @examples
#' rapid_spec_version()
#' rapid_spec_version("openapi", 3)
#' rapid_spec_version("openapi", "3.0.3")
#' rapid_spec_version("swagger", 2)
#' rapid_spec_version("R-like", "funny-looking kid", new_type = TRUE)
rapid_spec_version <- function(spec_type = NULL,
                               spec_version = NULL,
                               new_type = FALSE) {
  if (is.null(spec_type) && is.null(spec_version)) {
    return(NULL)
  }
  .check_scalar(spec_version)
  .check_spec_type(spec_type, new_type)
  class(spec_version) <- c(spec_type, attr(spec_version, "class"))
  return(.validate_spec_version(spec_version))
}

.check_spec_type <- function(spec_type,
                             new_type,
                             arg = caller_arg(spec_type),
                             call = caller_env()) {
  check_string(spec_type, allow_empty = FALSE, arg = arg, call = call)
  .check_spec_type_known(spec_type, new_type, arg, call)
  return(invisible(TRUE))
}

.check_spec_type_known <- function(spec_type,
                                   new_type,
                                   arg = caller_arg(spec_type),
                                   call = caller_env()) {
  if (!new_type && !(spec_type %in% c("openapi", "swagger"))) {
    cli::cli_warn(c(
      "{.arg {arg}} should usually be one of {.val openapi} or {.val swagger}.",
      i = "{.arg {arg}} is {.val {spec_type}}.",
      i = "To silence this warning, set {.arg new_type} to {.code TRUE}."
    ))
  }
  return(invisible(TRUE))
}

.validate_spec_version <- function(spec_version,
                                   arg = caller_arg(spec_version),
                                   call = caller_env()) {
  UseMethod(".validate_spec_version")
}

.validate_spec_version.openapi <- function(spec_version,
                                           arg = caller_arg(spec_version),
                                           call = caller_env()) {
  return(.validate_spec_version_numeric(spec_version, "openapi", 3, arg, call))
}

.validate_spec_version.swagger <- function(spec_version,
                                           arg = caller_arg(spec_version),
                                           call = caller_env()) {
  spec_version <- .validate_spec_version_numeric(
    spec_version, "swagger", 2, arg, call
  )
  # We only actually support swagger 2.
  if (spec_version[[1]] == 2) {
    return(spec_version)
  }
  cli::cli_abort(c(
    "{.arg arg} must be exactly 2.0, not {spec_version}."
  ))
}

.validate_spec_version_numeric <- function(spec_version,
                                           spec_type,
                                           digits,
                                           arg = caller_arg(spec_version),
                                           call = caller_env()) {
  spec_version <- .validate_spec_version_numericable(
    spec_version, spec_type, arg, call
  )
  return(
    .validate_spec_version_numeric_digits(
      spec_version, spec_type, digits,
      arg, call
    )
  )
}

# TODO: A lot of this is probably abstractable into a set of numeric_version
# checkers.

.validate_spec_version_numericable <- function(spec_version,
                                               spec_type,
                                               arg = caller_arg(spec_version),
                                               call = caller_env()) {
  rlang::try_fetch(
    numeric_version(spec_version),
    error = function(cnd) {
      cli::cli_abort(
        c(
          "{spec_type} specs must be coercible to a numeric version.",
          "*" = "{.arg {arg}} is {.obj_type_friendly {unclass(spec_version)}}.",
          "*" = "The value of {.arg {arg}} is {.val {spec_version}}.",
          i = "Provide a number such as 3 or a string such as {.val 3.0.3}."
        ),
        call = call
      )
    }
  )
}

.validate_spec_version_numeric_digits <- function(spec_version,
                                                  spec_type,
                                                  digits,
                                                  arg = caller_arg(spec_version),
                                                  call = caller_env()) {
  these_digits <- length(unclass(spec_version)[[1]])
  .check_digits_extra(these_digits, digits, spec_type, arg, call)
  spec_version <- .coerce_digits(spec_version, these_digits, digits)
  class(spec_version) <- c(spec_type, "numeric_version")
  return(spec_version)
}

.check_digits_extra <- function(these_digits, digits, spec_type, arg, call) {
  if (these_digits > digits) {
    cli::cli_abort(c(
      "{spec_type} specs must have {digits} digits, not {these_digits}.",
      x = "{.arg {arg}} has too many digits."
    ), call = call)
  }
  return(invisible(TRUE))
}

.coerce_digits <- function(spec_version, these_digits, digits) {
  if (these_digits < digits) {
    missing_dig <- setdiff(
      seq_len(digits), seq_len(these_digits)
    )
    spec_version[1, missing_dig] <- 0
  }
  return(spec_version)
}

.validate_spec_version.default <- function(spec_version,
                                           arg = caller_arg(spec_version),
                                           call = caller_env()) {
  # For now we don't care what they do here.
  return(spec_version)
}
