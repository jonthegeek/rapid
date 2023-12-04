# class_parameters() requires both name and location

    Code
      class_parameters(location = "query")
    Condition
      Error:
      ! <rapid::parameters> object is invalid:
      - When `name` is not defined, `location` must be empty.
      - `location` has 1 value.

# class_parameters() without args returns an empty parameters object

    Code
      test_result <- class_parameters()
      test_result
    Output
      <rapid::parameters>
       @ name             : chr(0) 
       @ location         : Factor w/ 4 levels "query","header",..: 
       .. - attr(*, "initialized")= logi TRUE
       @ description      : chr(0) 
       @ required         : logi(0) 
       @ allow_empty_value: logi(0) 
       @ deprecated       : logi(0) 

