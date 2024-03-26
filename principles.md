# rapid design principles

*This is an experiment in making key package design principles explicit, versus only implicit in the code. The goal is to make maintenance easier, when spread out over time and across people. This idea was copied from [usethis](https://github.com/r-lib/usethis/blob/main/principles.md).*

## Class names

I've gone back and forth between "api_{class}" and "{class}" for the class names.
I am currently settled on using "{class}", because the only function I conflict with is `base::license()`, which just prints info about the R license. 
I also belatedly noticed that I had `server()` (singular) where the OAS specification has `servers()`. 
I have updated that. 
Be careful to match the class names to the pluralization in the specification!

Update: Arguments that match function names (which are then called) are no bueno.
I'm using `class_{class}` for the constructor functions, similar to `class_character()`, etc, from S7.
I am doing this strictly, even for plural objects.
I hate the idea of having both singular and plural versions of objects, but I think it's worth it in order to match the schema fairly closely.

## Specification extensions

OAS allows for [Specification Extensions](https://spec.openapis.org/oas/v3.1.0#specificationExtensions), which are extra fields that begin with "x-".
I do not yet support these anywhere, and capture them in `...` in order to throw them away without errors.
Later I should at least check these, and ideally deal with them.

## Single home

Many aspects of an APID can be specified in multiple places.
For example, operation objects have `parameters`, which can either be a parameter object or a reference to a parameter object.
Likewise, path items themselves can have similar `parameters` objects.

Instead of defining them in multiple places, each reference to `parameters` will be a reference to components@parameters@parameter_name.
If an APID has the same name defined in multiple places:

- If the definitions are identical, they will be merged.
- If the definitions are different, an identifier will be added to the name, and the reference will reference the particular example.
- The first one will get the raw name, and then after that we check if the new one matches the existing one.

I have not (at the time of this writing) fully worked out how this will work mechanically, but the goal is for each object to have a `getter` that reads from the single source of truth.

I think during construction these should be allowed, but then, after everything is done, they should be "simplified" into the components.
This is similar to what I do in `as_rapid()` with `expand_servers(x)`.
Instead of just `expand_servers(x)`, I'll want some sort of `finalize_rapid()`, which calls `expand_servers()`, `collate_components()` (or whatever I call it), and maybe other things.

## Notes

This section is for notes as I implement specific things.
My intention is to delete these as I make decisions, and move the decisions up above.

Parameter objects can be defined with a `content` object (`schema`, `example(s)`, `encoding`, and `encoding` is a map of properties in the schema to `contentType`, `style`, `explode` etc), or with a bunch of things (`schema`, `example(s)`, `style`, `explode`). I *think* `contentType` can be inferred from `style` + `location`, maybe? Since it isn't in the body, it's text, right?

Parameters defined in components *can* be references (according to the spec), but I don't see any examples of that in apis.guru.

Parameters can be defined using `content` or `schema`, or as a `$ref` (which is the real definition). `$ref` is only used inside `paths`.

When I implement the paths versions of these definitions (where `$ref` is used), I need to allow for either a reference or a full parameter. To keep things vectorized, I might need to put empty spots in the parameter vector?

I'm intentionally leaving most "schema" info on the table. I'll get more details in a later pass. I'm going to try to keep the unparsed definition for use by users, though.
