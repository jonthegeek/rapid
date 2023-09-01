.prop_length_max <- function(obj) {
  max(
    .prop_lengths(obj, S7::prop_names(obj))
  )
}
