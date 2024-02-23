# class_parameter() requires required/automatic fields

    Code
      class_parameter(parameter_name = "a")
    Condition
      Error:
      ! <rapid::parameter> object is invalid:
      - `schema` must have the same length as `parameter_name`
      - `parameter_name` has 1 value.
      - `schema` has no values.

---

    Code
      class_parameter(parameter_name = "a", schema = class_schema(type = "string"),
      location = "bad")
    Condition
      Error in `class_parameter()`:
      ! `location` must be one of "query", "header", "path", or "cookie", not "bad".

---

    Code
      class_parameter(parameter_name = "a", schema = class_schema(type = "string"),
      allow_empty_value = c(TRUE, FALSE))
    Condition
      Error in `class_parameter()`:
      ! `allow_empty_value` must be a single <logical>.
      x `allow_empty_value` has 2 values.

# class_parameter() without args returns an empty parameter object

    Code
      test_result <- class_parameter()
      test_result
    Output
      <rapid::parameter>
       @ parameter_name   : chr(0) 
       @ location         : Factor w/ 4 levels "query","header",..: 
       .. - attr(*, "initialized")= logi TRUE
       @ schema           : <rapid::schema>
       .. @ type       : Factor w/ 6 levels "string","number",..: 
       .. .. - attr(*, "initialized")= logi TRUE
       .. @ nullable   : logi(0) 
       .. @ description: chr(0) 
       .. @ format     : chr(0) 
       @ style            : Factor w/ 7 levels "matrix","label",..: 
       .. - attr(*, "initialized")= logi TRUE
       @ description      : chr(0) 
       @ required         : logi(0) 
       @ allow_empty_value: logi(0) 
       @ allow_reserved   : logi(0) 
       @ explode          : logi(0) 
       @ deprecated       : logi(0) 

