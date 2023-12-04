# class_schema() requires both type and nullable

    Code
      class_schema(type = "string", nullable = NULL)
    Condition
      Error:
      ! <rapid::schema> object is invalid:
      - `nullable` must have the same length as `type`
      - `type` has 1 value.
      - `nullable` has no values.

# class_schema() without args returns an empty schema object

    Code
      test_result <- class_schema()
      test_result
    Output
      <rapid::schema>
       @ type       : Factor w/ 6 levels "string","number",..: 
       .. - attr(*, "initialized")= logi TRUE
       @ nullable   : logi(0) 
       @ description: chr(0) 
       @ format     : chr(0) 

