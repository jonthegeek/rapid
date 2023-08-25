# api_info() requires URLs for TOS

    Code
      api_info(terms_of_service = mean)
    Condition <rlang_error>
      Error in `api_info()`:
      ! Can't coerce `terms_of_service` <function> to <character>.

---

    Code
      api_info(terms_of_service = c("A", "B"))
    Condition <rlang_error>
      Error in `api_info()`:
      ! `terms_of_service` must be a single <character>.
      x `terms_of_service` has 2 values.

---

    Code
      api_info(terms_of_service = "not a real url")
    Condition <rlang_error>
      Error in `api_info()`:
      ! `terms_of_service` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1

# api_info() returns an empty api_info.

    Code
      test_result <- api_info()
      test_result
    Output
      <rapid::api_info>
       @ contact         : <rapid::api_contact>
       .. @ name : chr(0) 
       .. @ email: chr(0) 
       .. @ url  : chr(0) 
       @ description     : chr(0) 
       @ license         : <rapid::api_license>
       .. @ name      : chr(0) 
       .. @ identifier: chr(0) 
       .. @ url       : chr(0) 
       @ summary         : chr(0) 
       @ terms_of_service: chr(0) 
       @ title           : chr(0) 
       @ version         : chr(0) 

