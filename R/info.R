# rapid_info <- function(title = character(),
#                        version = character(),
#                        ...,
#                        contact = NULL,
#                        description = character(),
#                        license = NULL,
#                        summary = character(), # New in 3.1
#                        terms_of_service = NULL) {
#   # TODO: Um. These things aren't vectors. They're lists with special
#   # properties. I don't think the things in vctrs make sense. new_rcrd is close
#   # but these will NOT have the same lengths within their fields in almost all
#   # cases. Think through what the implications are.
#   check_dots_empty()
#   title <- to_chr_scalar(title)
#   version <- to_chr_scalar(version)
#   description <- to_chr_scalar(description)
#   summary <- to_chr_scalar(summary)
#   terms_of_service <- to_chr_scalar(terms_of_service)
#
#   .new_info(
#     title = title,
#     version = version,
#     contact = contact,
#     description = description,
#     license = license,
#     summary = summary,
#     terms_of_service = terms_of_service
#   )
# }
#
# .new_info <- function(title,
#                       version,
#                       summary,
#                       description,
#                       terms_of_service,
#                       contact,
#                       license,
#                       ...) {
#   vctrs::new_vctr(
#     list(
#       title = title,
#       version = version,
#       summary = summary,
#       description = description,
#       terms_of_service = terms_of_service,
#       contact = contact,
#       license = license,
#       ...
#     ),
#     # Attributes?
#     class = "rapid_info"
#   )
# }
