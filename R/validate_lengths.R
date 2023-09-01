validate_lengths <- function(obj,
                             key,
                             key_max_length = NULL,
                             required_same = NULL,
                             required_any = NULL,
                             optional_same = NULL,
                             optional_any = NULL) {
  key_len <- .prop_lengths(obj, key)

  if (!is.null(key_max_length) && key_len > key_max_length) {
    return(
      c(
        cli::format_inline(
          "{.arg {key}} must have at most {key_max_length) value{?s}."
        ),
        .msg_sizes(key, key_len)
      )
    )
  }

  if (!key_len) {
    return(.msg_empty(
      key,
      c(required_same, required_any, optional_same, optional_any),
      .prop_lengths(
        obj,
        c(required_same, required_any, optional_same, optional_any)
      )
    ))
  }

  if (!is.null(required_same)) {
    required_same_lens <- .prop_lengths(obj, required_same)
    if (!all(required_same_lens == key_len)) {
      return(.msg_same(key, key_len, required_same, required_same_lens))
    }
  }

  if (!is.null(required_any)) {
    required_any_lens <- .prop_lengths(obj, required_any)
    if (!all(required_any_lens)) {
      return(.msg_non_empty(key, required_any, required_any_lens))
    }
  }

  if (!is.null(optional_same)) {
    optional_same_lens <- .prop_lengths(obj, optional_same)
    if (any(optional_same_lens & optional_same_lens != key_len)) {
      return(
        .msg_same_or_empty(key, key_len, optional_same, optional_same_lens)
      )
    }
  }
}

.msg_same <- function(key_name, key_length, prop_names, prop_lengths) {
  bad_lengths <- prop_lengths != key_length
  not_same <- prop_names[bad_lengths]
  return(
    c(
      cli::format_inline(
        "{.arg {not_same}} must have the same length as {.arg {key_name}}"
      ),
      .msg_sizes(key_name, key_length),
      .msg_sizes(not_same, prop_lengths[bad_lengths])
    )
  )
}

.msg_non_empty <- function(key_name, prop_names, prop_lengths) {
  bad_lengths <- !prop_lengths
  if (any(bad_lengths)) {
    empty <- prop_names[bad_lengths]
    return(cli::format_inline(
      "When {.arg {key_name}} is defined, {.arg {empty}} must not be empty."
    ))
  }
}

.msg_same_or_empty <- function(key_name, key_length, prop_names, prop_lengths) {
  bad_lengths <- prop_lengths & prop_lengths != key_length
  if (any(bad_lengths)) {
    bad_size <- prop_names[bad_lengths]
    return(
      c(
        cli::format_inline(
          "{.arg {bad_size}} must be empty or have the same length as {.arg {key_name}}"
        ),
        .msg_sizes(key_name, key_length),
        .msg_sizes(bad_size, prop_lengths[bad_lengths])
      )
    )
  }
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
