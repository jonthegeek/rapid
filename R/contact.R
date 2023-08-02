rapid_contact <- function(name = NULL, url = NULL, email = NULL) {
  if (is.null(name && is.null(url) && is.null(email))) {
    return(NULL)
  }
  check_string(name, allow_null = TRUE)
  # Make scalar versions? Make these always require scalar for now and
  # generalize later?
  .check_url(url, allow_null = TRUE)
  .check_email(email, allow_null = TRUE)
  return(
    .new_rapid_contact(
      name = name,
      url = url,
      email = email
    )
  )
}
