#' @importFrom rlang caller_arg
#' @export
rlang::caller_arg

#' @importFrom rlang caller_env
#' @export
rlang::caller_env

# These should probably be defined in a separate package.

character_scalar_property <- function(x_arg, ...) {
  S7::new_property(
    name = x_arg,
    class = class_character,
    setter = function(self, value) {
      call <- caller_env(3)
      value <- value %||% character()
      value <- stabilize_chr_scalar(
        value,
        allow_null = FALSE,
        x_arg = x_arg,
        call = call,
        ...
      )
      prop(self, x_arg) <- value
      self
    }
  )
}

logical_scalar_property <- function(x_arg, ...) {
  S7::new_property(
    name = x_arg,
    class = class_logical,
    setter = function(self, value) {
      call <- caller_env(3)
      value <- value %||% logical()
      value <- stabilize_lgl_scalar(
        value,
        allow_null = FALSE,
        allow_na = FALSE,
        x_arg = x_arg,
        call = call,
        ...
      )
      prop(self, x_arg) <- value
      self
    }
  )
}

factor_property <- function(arg, levels, max_size = NULL) {
  force(levels)
  force(max_size)
  S7::new_property(
    name = arg,
    class = S7::class_factor,
    setter = function(self, value) {
      call <- caller_env(3)
      value <- value %||% character()
      value <- stabilize_fct(
        value,
        allow_null = FALSE,
        allow_na = FALSE,
        max_size = max_size,
        levels = levels,
        x_arg = arg,
        call = call
      )
      attr(value, "initialized") <- TRUE
      if (is.null(attr(prop(self, arg), "initialized"))) {
        prop(self, arg) <- value
      } else {
        prop(self, arg) <- value
        validate(self)
      }
      self
    },
    validator = function(value) {
      if (!length(value) || all(value %in% levels)) {
        return(NULL)
      }
      format_inline("must have values {.or {.val {levels}}}.")
    },
    # This doesn't actually work yet, see RConsortium/S7#392
    default = factor(levels = levels)
  )
}

enum_property <- function(x_arg) {
  S7::new_property(
    name = x_arg,
    class = class_list,
    setter = function(self, value) {
      call <- caller_env(3)
      if (!is.null(value) && !is.list(value)) {
        value <- list(value)
      }
      value <- purrr::map(
        value,
        function(enumerations) {
          enumerations <- stabilize_chr(
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
      prop(self, x_arg, check = FALSE) <- value
      self
    }
  )
}

list_of_characters <- function(x_arg, ...) {
  S7::new_property(
    name = x_arg,
    class = class_list,
    setter = function(self, value) {
      call <- caller_env(3)
      value <- as.list(value)
      value <- purrr::map(
        value,
        function(x) {
          x <- x %|0|% character()
          stabilize_chr(
            x,
            allow_na = FALSE,
            x_arg = x_arg,
            call = call,
            ...
          )
        }
      )
      prop(self, x_arg) <- value
      self
    }
  )
}

