blah <- function(x) {
  yaml::read_yaml(
    x,
    # Don't let read_yaml try to guess formats. Sometimes something is wrong and
    # it breaks the whole thing. The document is telling us formats, so we can
    # apply them once we have them.
    handlers = list(
      int = as.character,
      float = as.character,
      bool = as.character
    )
  )
}
