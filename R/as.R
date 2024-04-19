#' Convert to a rapid-style object
#'
#' Convert an object into an object with a rapid-style class.
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_error_context
#' @param x The object to coerce. Must be empty, or be a named list or character
#'   vector having names corresponding to the parameter of the `target_class`,
#'   or names that can be coerced to those names via
#'   [snakecase::to_snake_case()]. Extra names are ignored.
#' @param target_class The S7 class to which the object should be converted.
#' @param alternate_names Character vector (optional). An optional named
#'   character vector, where the names are the names as they might appear in
#'   `x`, and the values are the corresponding properties.
#'
#' @return An object with the specified `target_class`.
#' @export
as_api_object <- S7::new_generic(
  "as_api_object",
  "x",
  function(x,
           target_class,
           ...,
           alternate_names = NULL,
           arg = caller_arg(x),
           call = caller_env()) {
    if (missing(x)) {
      return(target_class())
    }
    force(arg)
    rlang::check_dots_empty(call = call)
    if (S7_inherits(x, target_class)) {
      return(x)
    }
    S7::S7_dispatch()
  }
)

S7::method(
  as_api_object,
  class_list | class_character
) <- function(x,
              target_class,
              ...,
              alternate_names = NULL,
              arg = caller_arg(x),
              call = caller_env()) {
  force(arg)
  x <- .validate_for_as_class(
    x,
    target_class,
    alternate_names = alternate_names,
    x_arg = arg,
    call = call
  )
  rlang::inject({
    target_class(!!!x)
  })
}

S7::method(
  as_api_object,
  NULL | S7::new_S3_class("S7_missing")
) <- function(x,
              target_class,
              ...,
              alternate_names = NULL,
              arg = caller_arg(x),
              call = caller_env()) {
  target_class()
}

S7::method(as_api_object, class_any) <- function(x,
                                                 target_class,
                                                 ...,
                                                 alternate_names = NULL,
                                                 arg = caller_arg(x),
                                                 call = caller_env()) {
  target_class_nm <- class(target_class())[[1]]
  cli::cli_abort(
    "Can't coerce {.arg {arg}} {.cls {class(x)}} to {.cls {target_class_nm}}.",
    class = "rapid_error_unknown_coercion",
    call = call
  )
}

.validate_for_as_class <- function(x,
                                   target_class,
                                   alternate_names = NULL,
                                   x_arg = caller_arg(x),
                                   call = caller_env()) {
  if (!length(x)) {
    return(NULL)
  }

  valid_names <- snakecase::to_snake_case(
    c(S7::prop_names(target_class()), names(alternate_names))
  )

  if (rlang::is_named2(x)) {
    force(x_arg)
    x <- rlang::set_names(x, snakecase::to_snake_case)
    ignored_names <- names(x)[!names(x) %in% valid_names]
    x <- as.list(x)[names(x) %in% valid_names]
    if (length(alternate_names)) {
      alternate_names <- rlang::set_names(
        snakecase::to_snake_case(alternate_names),
        snakecase::to_snake_case(names(alternate_names))
      )
      to_rename <- names(x) %in% names(alternate_names)
      names(x)[to_rename] <- alternate_names[names(x)[to_rename]]
    }
    x <- x %|0|% NULL
    if (length(ignored_names)) {
      cli::cli_warn(
        c(
          "{.arg {x_arg}} expects names {.or {.val {valid_names}}}.",
          "*" = "Ignored names: {.val {ignored_names}}."
        ),
        class = "rapid_warning_extra_names"
      )
    }

    return(x)
  }

  cli::cli_abort(
    c(
      "{.arg {x_arg}} must have names {.or {.val {valid_names}}}.",
      "*" = "Any other names are ignored."
    ),
    class = "rapid_error_missing_names",
    call = call
  )
}
