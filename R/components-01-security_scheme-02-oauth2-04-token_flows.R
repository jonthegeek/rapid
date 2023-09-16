ouath2_token_flows <- S7::new_class(
  name = "ouath2_token_flows",
  package = "rapid",
  parent = oauth2_flows,
  properties = list(
    token_url = class_character
  ),
  constructor = function(token_url = class_missing,
                         ...,
                         refresh_url = class_missing,
                         scopes = class_missing) {
    check_dots_empty()
    token_url <- token_url %||% character()
    refresh_url <- refresh_url %||% character()
    scopes <- scopes %||% scopes_list()
    S7::new_object(
      S7::S7_object(),
      token_url = token_url,
      refresh_url = refresh_url,
      scopes = scopes
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "token_url",
      optional = c("refresh_url", "scopes")
    )
  }
)

# TODO: length
#
# TODO: as_
