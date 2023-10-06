.as_class <- function(x,
                      target_S7_class,
                      ...,
                      arg = rlang::caller_arg(x),
                      call = rlang::caller_env()) {
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

  valid_names <- snakecase::to_snake_case(
    c(S7::prop_names(target_S7_class()), names(extra_names))
  )

  if (rlang::is_named2(x)) {
    force(x_arg)
    x <- rlang::set_names(x, snakecase::to_snake_case)
    ignored_names <- names(x)[!names(x) %in% valid_names]
    x <- as.list(x)[names(x) %in% valid_names]
    if (length(extra_names)) {
      extra_names <- rlang::set_names(
        snakecase::to_snake_case(extra_names),
        snakecase::to_snake_case(names(extra_names))
      )
      to_rename <- names(x) %in% names(extra_names)
      names(x)[to_rename] <- extra_names[names(x)[to_rename]]
    }
    x <- x %|0|% NULL
    if (length(ignored_names)) {
      cli::cli_warn(
        c(
          "{.arg {x_arg}} expects names {.or {.val {valid_names}}}.",
          "*" = "Ignored names: {.val {ignored_names}}."
        ),
        class = "rapid_warning_extra_names"
      )
    }

    return(x)
  }

  cli::cli_abort(
    c(
      "{.arg {x_arg}} must have names {.or {.val {valid_names}}}.",
      "*" = "Any other names are ignored."
    ),
    class = "rapid_error_missing_names",
    call = call
  )
}
