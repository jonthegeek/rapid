validate_parallel <- function(obj,
                              key,
                              required = NULL,
                              optional = NULL) {
  key_len <- .prop_lengths(obj, key)
  required_lens <- .prop_lengths(obj, required)

  if (!all(required_lens == key_len)) {
    return(.msg_same(key, key_len, required, required_lens))
  }

  optional_lens <- .prop_lengths(obj, optional)

  if (key_len) {
    return(
      .msg_same_or_empty(key, key_len, optional, optional_lens)
    )
  }

  return(
    .msg_empty(key, c(required, optional), c(required_lens, optional_lens))
  )
}

.prop_lengths <- function(obj, prop_names) {
  purrr::map_int(
    prop_names,
    \(prop_name) {
      length(S7::prop(obj, prop_name))
    }
  )
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

.msg_empty <- function(key_name, prop_names, prop_lengths) {
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
