# rapid design principles

*This is an experiment in making key package design principles explicit, versus only implicit in the code. The goal is to make maintenance easier, when spread out over time and across people. This idea was copied from [usethis](https://github.com/r-lib/usethis/blob/main/principles.md).*

## Class names

I've gone back and forth between "api_{class}" and "{class}" for the class names.
The rule that seems to be emerging is to add "api_" when necessary, but try not to do so.
This rule still might change.
I also belatedly noticed that I had `server()` (singular) where the OAS specification has `servers()`. 
I have belatedly updated that. 
Be careful to match the class names to the pluralization in the specification.

## Specification extensions

OAS allows for [Specification Extensions](https://spec.openapis.org/oas/v3.1.0#specificationExtensions), which are extra fields that begin with "x-".
I do not yet support these anywhere, and capture them in `...` in order to throw them away without errors.
Later I should at least check these, and ideally deal with them.
