# These should probably be defined in a separate package.

character_scalar_property <- function(x_arg, ...) {
  S7::new_property(
    class = class_character,
    setter = function(self, value) {
      call <- rlang::caller_env(3)
      value <- value %||% character()
      value <- stbl::stabilize_chr_scalar(
        value,
        allow_null = FALSE,
        x_arg = x_arg,
        call = call,
        ...
      )
      S7::prop(self, x_arg) <- value
      self
    }
  )
}

enum_property <- function(x_arg) {
  S7::new_property(
    class = class_list,
    setter = function(self, value) {
      call <- rlang::caller_env(3)
      if (!is.null(value) && !is.list(value)) {
        value <- list(value)
      }
      value <- purrr::map(
        value,
        function(enumerations) {
          enumerations <- stbl::stabilize_chr(
            enumerations,
            allow_na = FALSE,
            x_arg = x_arg,
            call = call
          )
          enumerations
        }
      )
      if (!any(lengths(value))) {
        value <- list()
      }
      S7::prop(self, x_arg, check = FALSE) <- value
      self
    }
  )
}
