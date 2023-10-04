#' @include properties.R
NULL

security_requirements <- S7::new_class(
  "security_requirements",
  package = "rapid",
  properties = list(
    name = class_character,
    required_scopes = list_of_characters("required_scopes"),
    rapid_class_requirement = S7::new_property(
      getter = function(self) {
        "security_scheme"
      }
    )
  ),
  constructor = function(name = character(), ..., required_scopes = list()) {
    name <- name %|0|% character()
    required_scopes <- required_scopes %|0|%
      purrr::rep_along(name, list(character()))
    S7::new_object(
      S7::S7_object(),
      name = name,
      required_scopes = required_scopes
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "required_scopes"
    )
  }
)

S7::method(length, security_requirements) <- function(x) {
  length(x@name)
}

as_security_requirements <- S7::new_generic(
  "as_security_requirements",
  dispatch_args = "x"
)

S7::method(as_security_requirements, security_requirements) <- function(x) {
  x
}

S7::method(as_security_requirements, class_list) <- function(x, ..., arg = rlang::caller_arg(x)) {
  force(arg)
  x <- .list_remove_wrappers(x)

  if (!rlang::is_named2(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a named list.",
    )
  }
  security_requirements(
    name = names(x),
    required_scopes = unname(x)
  )
}

S7::method(as_security_requirements, class_missing | NULL) <- function(x) {
  security_requirements()
}

S7::method(as_security_requirements, class_any) <- function(x, ..., arg = rlang::caller_arg(x)) {
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls security_requirements}.",
    class = "rapid_error_unknown_coercion"
  )
}
