security_scheme_details <- S7::new_class(
  "security_scheme_details",
  package = "rapid",
  parent = class_list,
  constructor = function(...) {
    if (...length() == 1 && is.list(..1)) {
      return(S7::new_object(..1))
    }
    S7::new_object(list(...))
  },
  validator = function(self) {
    bad_security_schemes <- !purrr::map_lgl(
      S7::S7_data(self),
      ~ S7::S7_inherits(.x, security_scheme) || is.null(.x)
    )
    if (any(bad_security_schemes)) {
      bad_locations <- which(bad_security_schemes)
      c(
        cli::format_inline(
          "All values must be {.cls security_scheme} objects."
        ),
        cli::format_inline("Bad values at {bad_locations}.")
      )
    }
  }
)

as_security_scheme_details <- S7::new_generic(
  "as_security_scheme_details",
  dispatch_args = "x"
)

S7::method(as_security_scheme_details, security_scheme_details) <- function(x) {
  x
}

S7::method(as_security_scheme_details, class_list) <- function(x) {
  if (!length(x) || !any(lengths(x))) {
    return(security_scheme_details())
  }
  security_scheme_details(
    purrr::map(x, as_security_scheme)
  )
}

S7::method(as_security_scheme_details, class_missing | NULL) <- function(x) {
  security_scheme_details()
}

S7::method(as_security_scheme_details, class_any) <- function(x) {
  cli::cli_abort(
    "Can't coerce {.arg x} {.cls {class(x)}} to {.cls security_scheme_details}."
  )
}
