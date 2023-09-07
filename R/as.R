.validate_named_list <- function(x,
                                 valid_names,
                                 x_arg = rlang::caller_arg(x),
                                 call = rlang::caller_env()) {
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
  return(as.list(x))
}
