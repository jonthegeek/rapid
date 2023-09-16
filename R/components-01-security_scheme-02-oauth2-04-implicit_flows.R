ouath2_implicit_flows <- S7::new_class(
  name = "ouath2_implicit_flows",
  package = "rapid",
  parent = oauth2_flows,
  properties = list(
    authorization_url = class_character
  ),
  constructor = function(authorization_url = class_missing,
                         ...,
                         refresh_url = class_missing,
                         scopes = class_missing) {
    check_dots_empty()
    authorization_url <- authorization_url %||% character()
    refresh_url <- refresh_url %||% character()
    scopes <- scopes %||% scopes_list()
    S7::new_object(
      S7::S7_object(),
      authorization_url = authorization_url,
      refresh_url = refresh_url,
      scopes = scopes
    )
  },
  validator = function(self) {
    validate_parallel(
      self,
      "authorization_url",
      optional = c("refresh_url", "scopes")
    )
  }
)

# TODO: length
#
# TODO: as
