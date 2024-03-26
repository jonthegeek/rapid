# class_paths() returns an empty paths

    Code
      test_result <- class_paths()
      test_result
    Output
      data frame with 0 columns and 0 rows

# as_paths() errors informatively for bad classes

    Code
      as_paths(1:2)
    Condition
      Error in `as_paths()`:
      ! Can't coerce `1:2` <integer> to <rapid::paths>.

---

    Code
      as_paths(mean)
    Condition
      Error in `as_paths()`:
      ! Can't coerce `mean` <function> to <rapid::paths>.

---

    Code
      as_paths(TRUE)
    Condition
      Error in `as_paths()`:
      ! Can't coerce `TRUE` <logical> to <rapid::paths>.

