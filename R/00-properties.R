# These should probably be defined in a separate package.

character_scalar_property <- function(x_arg, regex = NULL) {
  S7::new_property(
    class = S7::class_character,
    setter = function(self, value) {
      # TODO: Watch S7 dev to see if this can be less hacky.
      call <- rlang::caller_env(3)
      value <- stbl::stabilize_chr_scalar(
        value,
        allow_null = FALSE,
        regex = regex,
        x_arg = x_arg,
        call = call
      )
      S7::prop(self, x_arg, check = FALSE) <- value
      self
    }
  )
}

character_property <- function(x_arg, regex = NULL) {
  S7::new_property(
    class = S7::class_character,
    setter = function(self, value) {
      # TODO: Watch S7 dev to see if this can be less hacky.
      call <- rlang::caller_env(3)
      value <- stbl::stabilize_chr(
        value,
        allow_null = FALSE,
        regex = regex,
        x_arg = x_arg,
        call = call
      )
      S7::prop(self, x_arg, check = FALSE) <- value
      self
    }
  )
}

.url_regex <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),{}]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"

url_scalar_property <- function(x_arg) {
  character_scalar_property(x_arg, regex = .url_regex)
}

url_property <- function(x_arg) {
  character_property(x_arg, regex = .url_regex)
}

enum_property <- function(x_arg) {
  S7::new_property(
    class = S7::class_list,
    setter = function(self, value) {
      call <- rlang::caller_env(3)
      if (!is.null(value) && !is.list(value)) {
        value <- list(value)
      }
      value <- purrr::map(
        value,
        \(enumerations) {
          enumerations <- stbl::stabilize_chr(
            enumerations,
            allow_na = FALSE,
            x_arg = x_arg,
            call = call
          )
          enumerations
        }
      )
      S7::prop(self, x_arg, check = FALSE) <- value
      self
    }
  )
}
