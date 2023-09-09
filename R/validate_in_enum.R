validate_in_enum <- function(obj,
                             value_name,
                             enum_name) {
  values <- S7::prop(obj, value_name)
  enums <- S7::prop(obj, enum_name)

  if (length(enums)) {
    missing_msgs <- purrr::map2(
      values, enums,
      function(value, enum) {
        if (length(enum) && !(value %in% enum)) {
          cli::format_inline("{.val {value}} is not in {.val {enum}}.")
        }
      }
    ) |>
      unlist()

    if (is.null(missing_msgs)) {
      return(NULL)
    }

    c(
      cli::format_inline("{.arg {value_name}} must be in {.arg {enum_name}}."),
      missing_msgs
    )
  }
}
