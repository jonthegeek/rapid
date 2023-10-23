validate_parallel <- function(obj, key_name, required = NULL, optional = NULL) {
  validate_lengths(
    obj = obj,
    key_name = key_name,
    required_same = required,
    optional_same = optional
  )
}
