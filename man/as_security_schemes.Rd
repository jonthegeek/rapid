% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components-security_schemes.R
\name{as_security_schemes}
\alias{as_security_schemes}
\title{Coerce lists to security_schemes objects}
\usage{
as_security_schemes(x, ...)
}
\arguments{
\item{x}{The object to coerce. Must be empty or be a named list, where each
element describes a security scheme object. This object should describe the
security schemes for a single API.}

\item{...}{These dots are for future extensions and must be empty.}
}
\value{
A \code{security_schemes} object as returned by
\code{\link[=class_security_schemes]{class_security_schemes()}}.
}
\description{
\code{as_security_schemes()} turns an existing object into a \code{security_schemes}
object. This is in contrast with \code{\link[=class_security_schemes]{class_security_schemes()}}, which builds a
\code{security_schemes} from individual properties.
}
\examples{
as_security_schemes()
as_security_schemes(
  list(
    accountAuth = list(
      description = "Account JWT token",
      flows = list(
        password = list(
          scopes = list(
            Catalog = "Access all read-only content",
            Commerce = "Perform account-level transactions",
            Playback = "Allow playback of restricted content",
            Settings = "Modify account settings"
          ),
          tokenUrl = "/account/authorization"
        )
      ),
      type = "oauth2"
    ),
    profileAuth = list(
      description = "Profile JWT token",
      flows = list(
        password = list(
          scopes = list(
            Catalog = "Modify profile preferences and activity"
          ),
          tokenUrl = "/account/profile/authorization"
        )
      ),
      type = "oauth2"
    ),
    resetPasswordAuth = list(
      `in` = "header",
      name = "authorization",
      type = "apiKey"
    ),
    verifyEmailAuth = list(
      `in` = "header",
      name = "authorization",
      type = "apiKey"
    )
  )
)
}
