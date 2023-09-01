validate_parallel <- function(obj,
                              key,
                              required = NULL,
                              optional = NULL) {
  validate_lengths(
    obj = obj,
    key = key,
    required_same = required,
    optional_same = optional
  )
}
