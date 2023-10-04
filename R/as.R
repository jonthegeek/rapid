.as_class <- function(x, target_S7_class, ..., arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  force(arg)
  x <- .validate_for_as_class(x, target_S7_class, ..., x_arg = arg, call = call)
  rlang::inject({
    target_S7_class(!!!x)
  })
}

.validate_for_as_class <- function(x,
                                   target_S7_class,
                                   extra_names = NULL,
                                   x_arg = rlang::caller_arg(x),
                                   call = rlang::caller_env()) {
  if (!length(x)) {
    return(NULL)
  }

  valid_names <- c(S7::prop_names(target_S7_class()), names(extra_names))

  if (rlang::is_named2(x)) {
    force(x_arg)
    x <- rlang::set_names(x, snakecase::to_snake_case)
    if (any(names(x) %in% valid_names)) {
      x <- as.list(x)[names(x) %in% valid_names]
      if (length(extra_names)) {
        to_rename <- names(x) %in% names(extra_names)
        names(x)[to_rename] <- extra_names[names(x)[to_rename]]
      }
      return(x)
    }
  }

  cli::cli_abort(
    c(
      "{.arg {x_arg}} must have names {.or {.val {valid_names}}}.",
      "*" = "Any other names are ignored."
    ),
    class = "rapid_missing_names",
    call = call
  )
}
