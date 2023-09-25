#' @include components-security_scheme_details.R

security_scheme_collection <- S7::new_class(
  name = "security_scheme_collection",
  package = "rapid",
  properties = list(
    name = class_character,
    security_scheme_details = security_scheme_details,
    description = class_character
  ),
  constructor = function(name = class_missing,
                         security_scheme_details = class_missing,
                         ...,
                         description = class_missing) {
    check_dots_empty()
    S7::new_object(
      S7::S7_object(),
      name = name,
      security_scheme_details = security_scheme_details %|0|%
        security_scheme_details(),
      description = description
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "name",
      required = "security_scheme_details",
      optional = "description"
    )
  }
)

as_security_scheme_collection <- S7::new_generic("as_security_scheme_collection", dispatch_args = "x")

S7::method(as_security_scheme_collection, security_scheme_collection) <- function(x) {
  x
}

S7::method(as_security_scheme_collection, class_list) <- function(x) {
  # This is the first one where we're fundamentally rearranging things, so watch
  # out for new things to standardize (and then delete this comment)!
  if (!length(x) || !any(lengths(x))) {
    return(security_scheme_collection())
  }

  if (rlang::is_named2(x)) {
    scheme_names <- rlang::names2(x)
    x <- unname(x)
    descriptions <- .extract_along_chr(x, "description")
    schemes <- as_security_scheme_details(x)
    return(
      security_scheme_collection(
        name = scheme_names,
        security_scheme_details = schemes,
        description = descriptions
      )
    )
  }
  cli::cli_abort(c("{.arg {x}} must have names."))
}

S7::method(as_security_scheme_collection, class_missing | NULL) <- function(x) {
  security_scheme_collection()
}

S7::method(as_security_scheme_collection, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls contact}."
  )
}
