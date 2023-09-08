.validate_for_as_class <- function(x,
                                   target_S7_class,
                                   x_arg = rlang::caller_arg(x),
                                   call = rlang::caller_env()) {
  if (!length(x)) {
    return(NULL)
  }

  valid_names <- S7::prop_names(target_S7_class())

  if (rlang::is_named2(x)) {
    force(x_arg)
    x <- rlang::set_names(x, snakecase::to_snake_case)
    if (any(names(x) %in% valid_names)) {
      return(as.list(x)[names(x) %in% valid_names])
    }
  }

  cli::cli_abort(
    c(
      "{.arg {x_arg}} must have names {.or {.val {valid_names}}}.",
      "*" = "Any other names are ignored."
    ),
    call = call
  )
}
