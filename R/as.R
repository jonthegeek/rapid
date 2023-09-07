.validate_for_as_class <- function(x,
                                   target_S7_class,
                                   x_arg = rlang::caller_arg(x),
                                   call = rlang::caller_env()) {
  valid_names <- S7::prop_names(target_S7_class())
  if (
    length(x) &&
    (!rlang::is_named(x) || !any(names(x) %in% valid_names))
  ) {
    cli::cli_abort(
      c(
        "{.arg {x_arg}} must have names {.or {.val {valid_names}}}.",
        "*" = "Any other names are ignored."
      ),
      call = call
    )
  }
  return(as.list(x)[names(x) %in% valid_names])
}
