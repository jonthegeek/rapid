.prop_lengths <- function(obj, prop_names = S7::prop_names(obj)) {
  lengths(S7::props(obj)[prop_names])
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
  if (all(lengths(y) == 0)) {
    return(character())
  }
  purrr::map_chr(
    y,
    .empty_to_na
  )
}

.empty_to_na <- function(x) {
  x %|0|% NA
}

.list_remove_wrappers <- function(x) {
  if (is.list(x) && !rlang::is_named(x)) {
    x <- purrr::list_c(x)
    x <- .list_remove_wrappers(x)
  }
  x
}

.is_relative_url <- function(x) {
  grepl("^/", x)
}
