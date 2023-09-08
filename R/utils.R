.prop_lengths <- function(obj, prop_names) {
  purrr::map_int(
    prop_names,
    \(prop_name) {
      length(S7::prop(obj, prop_name))
    }
  )
}

# I was about to write this when I discovered it unexported in rlang. I used
# their name in case it ever becomes standard.
`%|0|%` <- function(x, y) {
  if (!length(x)) {
    y
  } else {
    x
  }
}

.extract_along_chr <- function(x, el) {
  y <- purrr::map(x, el)
  if (purrr::every(y, is.null)) {
    return(character())
  }
  purrr::map_chr(
    y,
    \(this) {
      this %||% NA
    }
  )
}

.extract <- function(x, el) {
  x$el %||% NA
}
