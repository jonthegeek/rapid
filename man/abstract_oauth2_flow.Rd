% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components-security_scheme-oauth2-flow.R
\name{abstract_oauth2_flow}
\alias{abstract_oauth2_flow}
\title{OAuth2 flow object}
\usage{
abstract_oauth2_flow(refresh_url = class_missing, scopes = class_missing)
}
\arguments{
\item{refresh_url}{Character scalar (optional). The URL to be used for
obtaining refresh tokens. This must be in the form of a URL. The OAuth2
standard requires the use of TLS.}

\item{scopes}{An optional \code{\link[=class_scopes]{class_scopes()}} object with the available scopes
for the OAuth2 security scheme.}
}
\description{
This is an abstract class that is used to define specific types of OAuth2
flow objects.
}
\seealso{
\code{\link[=class_oauth2_token_flow]{class_oauth2_token_flow()}}, \code{\link[=class_oauth2_implicit_flow]{class_oauth2_implicit_flow()}}, and
\code{\link[=class_oauth2_authorization_code_flow]{class_oauth2_authorization_code_flow()}}
}
\keyword{internal}
