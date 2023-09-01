.prop_lengths <- function(obj, prop_names) {
  purrr::map_int(
    prop_names,
    \(prop_name) {
      length(S7::prop(obj, prop_name))
    }
  )
}
