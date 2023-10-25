.url_to_string <- function(x) {
  summary(x)$description
}

.url_fetch <- function(x) {
  rlang::try_fetch(
    jsonlite::fromJSON(url(x), simplifyDataFrame = FALSE),
    error = function(e) {
      yaml::read_yaml(url(x))
    }
  )
}
