oauth2_flows <- S7::new_class(
  name = "oauth2_flows",
  package = "rapid",
  properties = list(
    refresh_url = class_character,
    scopes = scopes_list
  ),
  abstract = TRUE
)

# TODO: as_oauth2_flows? Yes, the name of the object says what type it is.
