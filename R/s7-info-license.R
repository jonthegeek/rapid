s7_character_scalar <- S7::new_class(
  "s7_character_scalar",
  package = "rapid",
  properties = list(
    x = S7::class_character
  ),
  constructor = function(x = character(),
                         x_arg = rlang::caller_arg(x),
                         call = rlang::caller_env()) {
    if (rlang::env_name(call) == "global") {
      x_arg <- "x"
    }
    x <- stbl::to_chr_scalar(
      x,
      allow_null = FALSE,
      x_arg = x_arg,
      call = call
    )
    S7::new_object(NULL, x = x)
  },
  validator = function(self) {
    if (length(self@x) > 1) {
      return("@x must be a single string")
    }
    return(NULL)
  }
)

s7_character_scalar_property <- function(x_arg, call = rlang::caller_env()) {
  force(call)
  S7::new_property(
    class = S7::class_any,
    setter = function(self, value) {
      value <- s7_character_scalar(value, x_arg = x_arg, call = call)
      S7::prop(self, x_arg) <- value
      self
    }
  )
}

s7_info_license <- S7::new_class(
  "s7_info_license",
  package = "rapid",
  properties = list(
    name = s7_character_scalar_property("name")
  )
)
