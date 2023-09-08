validate_lengths <- function(obj,
                             key_name,
                             required_same = NULL,
                             required_any = NULL,
                             optional_same = NULL,
                             optional_any = NULL) {
  key_length <- .prop_lengths(obj, key_name)

  if (!key_length) {
    all_others <- c(required_same, required_any, optional_same, optional_any)
    return(.msg_empty(key_name, all_others, .prop_lengths(obj, all_others)))
  }

  issues <- character()

  if (!is.null(required_same)) {
    issues <- c(issues, .check_same(obj, key_name, key_length, required_same))
  }

  if (!is.null(required_any)) {
    issues <- c(issues, .check_non_empty(obj, key_name, required_any))
  }

  if (!is.null(optional_same)) {
    issues <- c(
      issues,
      .check_same_or_empty(obj, key_name, key_length, optional_same)
    )
  }

  return(unique(issues))
}

.check_same <- function(obj, key_name, key_length, prop_names) {
  prop_lengths <- .prop_lengths(obj, prop_names)
  have_bad_lengths <- prop_lengths != key_length
  if (any(have_bad_lengths)) {
    not_same <- prop_names[have_bad_lengths]
    bad_lengths <- prop_lengths[have_bad_lengths]
    return(.msg_must_have_same(key_name, key_length, not_same, bad_lengths))
  }
  return(character())
}
.msg_must_have_same <- function(key_name, key_length, not_same, bad_lengths) {
  c(
    cli::format_inline(
      "{.arg {not_same}} must have the same length as {.arg {key_name}}"
    ),
    .msg_sizes(key_name, key_length),
    .msg_sizes(not_same, bad_lengths)
  )
}

.check_non_empty <- function(obj, key_name, prop_names) {
  prop_lengths <- .prop_lengths(obj, prop_names)
  empty <- prop_names[prop_lengths == 0]
  if (any(empty)) {
    return(.msg_non_empty(key_name, empty))
  }
}
.msg_non_empty <- function(key_name, empty) {
  cli::format_inline(
    "When {.arg {key_name}} is defined, {.arg {empty}} must not be empty."
  )
}

.check_same_or_empty <- function(obj, key_name, key_length, prop_names) {
  prop_lengths <- .prop_lengths(obj, prop_names)
  have_bad_lengths <- prop_lengths & prop_lengths != key_length
  if (any(have_bad_lengths)) {
    return(
      .msg_not_same_or_empty(
        key_name,
        key_length,
        prop_names[have_bad_lengths],
        prop_lengths[have_bad_lengths]
      )
    )
  }
}
.msg_not_same_or_empty <- function(key_name,
                                   key_length,
                                   bad_props,
                                   bad_lengths) {
  c(
    cli::format_inline(
      "{.arg {bad_props}} must be empty or have the same length as {.arg {key_name}}"
    ),
    .msg_sizes(key_name, key_length),
    .msg_sizes(bad_props, bad_lengths)
  )
}

.msg_empty <- function(key_name, prop_names, prop_lengths = NULL) {
  bad_lengths <- prop_lengths > 0
  if (any(bad_lengths)) {
    not_empty <- prop_names[bad_lengths]
    return(
      c(
        cli::format_inline(
          "When {.arg {key_name}} is not defined, {.arg {not_empty}} must be empty."
        ),
        .msg_sizes(not_empty, prop_lengths[bad_lengths])
      )
    )
  }
}

.msg_sizes <- function(prop_names, prop_lengths) {
  purrr::map2_chr(
    prop_names,
    prop_lengths,
    \(prop_name, prop_length) {
      cli::format_inline(
        "{.arg {prop_name}} has {cli::no(prop_length)} value{?s}."
      )
    }
  )
}
