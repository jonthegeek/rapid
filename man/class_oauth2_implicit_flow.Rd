% Generated by roxygen2: do not edit by hand
% Please edit documentation in
%   R/components-security_scheme-oauth2-implicit_flow.R
\name{class_oauth2_implicit_flow}
\alias{class_oauth2_implicit_flow}
\title{OAuth2 implicit flow object}
\usage{
class_oauth2_implicit_flow(
  authorization_url = character(),
  ...,
  refresh_url = character(),
  scopes = class_scopes()
)
}
\arguments{
\item{authorization_url}{Character vector (required). The authorization URL
to be used for this flow. This must be in the form of a URL. The OAuth2
standard requires the use of TLS.}

\item{...}{These dots are for future extensions and must be empty.}

\item{refresh_url}{Character scalar (optional). The URL to be used for
obtaining refresh tokens. This must be in the form of a URL. The OAuth2
standard requires the use of TLS.}

\item{scopes}{An optional \code{\link[=class_scopes]{class_scopes()}} object with the available scopes
for the OAuth2 security scheme.}
}
\description{
An \code{oauth2_implicit_flow} object describes the configuration for the OAuth
Implicit flow.
}
\examples{
class_oauth2_implicit_flow(
  authorization_url = "https://example.com/authorize",
  refresh_url = "https://example.com/refresh"
)
}
