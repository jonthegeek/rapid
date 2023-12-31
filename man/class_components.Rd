% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R
\name{class_components}
\alias{class_components}
\title{An element to hold various schemas for the API}
\usage{
class_components(..., security_schemes = class_security_schemes())
}
\arguments{
\item{...}{These dots are for future extensions and must be empty.}

\item{security_schemes}{An object to hold reusable security scheme objects
created by \code{\link[=class_security_schemes]{class_security_schemes()}}.}
}
\value{
A \code{components} S7 object with various schemas for the API.
}
\description{
Holds a set of reusable objects for different aspects of the OAS. All objects
defined within the components object will have no effect on the API unless
they are explicitly referenced from properties outside the components object.
We currently only support the security_schemes object within the components
object (see \code{\link[=class_security_schemes]{class_security_schemes()}}).
}
\examples{
class_components()
class_components(
  security_schemes = class_security_schemes(
    name = "a",
    details = class_security_scheme_details(
      class_api_key_security_scheme("parm", "query")
    )
  )
)
}
\seealso{
\code{\link[=as_components]{as_components()}} for coercing objects to
\code{components} objects.
}
