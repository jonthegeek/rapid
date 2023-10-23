validate_in_enums <- function(obj, value_name, enum_name) {
  enums <- S7::prop(obj, enum_name)
  if (length(enums)) {
    missing_msgs <- .check_all_in_enums(S7::prop(obj, value_name), enums)
    if (length(missing_msgs)) {
      return(.msg_some_not_in_enums(value_name, enum_name, missing_msgs))
    }
  }
}

.check_all_in_enums <- function(values, enums) {
  unlist(purrr::map2(
    values, enums,
    .check_one_in_enum
  ))
}
.check_one_in_enum <- function(value, enum) {
  if (length(enum) && !(value %in% enum)) {
    .msg_not_in_enum(value, enum)
  }
}
.msg_not_in_enum <- function(value, enum) {
  cli::format_inline("{.val {value}} is not in {.val {enum}}.")
}

.msg_some_not_in_enums <- function(value_name, enum_name, missing_msgs) {
  c(
    cli::format_inline("{.arg {value_name}} must be in {.arg {enum_name}}."),
    missing_msgs
  )
}

validate_in_fixed <- function(obj,
                              value_name,
                              enums) {
  values <- S7::prop(obj, value_name)
  missing_msgs <- .check_all_in_enums(values, rep(list(enums), length(values)))
  if (length(missing_msgs)) {
    return(.msg_some_not_in_fixed(value_name, enums, missing_msgs))
  }
}

.msg_some_not_in_fixed <- function(value_name,
                                   enums,
                                   missing_msgs,
                                   enum_name = "the designated values") {
  enum_name <- cli::format_inline(enum_name)
  c(
    cli::format_inline("{.arg {value_name}} must be one of {enum_name}."),
    missing_msgs
  )
}

validate_in_specific <- function(values, enums, value_name, ...) {
  missing_msgs <- .check_all_in_enums(values, rep(list(enums), length(values)))
  if (length(missing_msgs)) {
    return(.msg_some_not_in_fixed(value_name, enums, missing_msgs, ...))
  }
}
