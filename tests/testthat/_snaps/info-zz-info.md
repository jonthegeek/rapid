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

# api_info() returns an empty api_info

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

# Can construct an api_contact from an api spec

    Code
      test_result <- api_info(apid_list = apid_list_guru)
      test_result
    Output
      <rapid::api_info>
       @ contact         : <rapid::api_contact>
       .. @ name : chr "APIs.guru"
       .. @ email: chr "mike.ralphson@gmail.com"
       .. @ url  : chr "https://APIs.guru"
       @ description     : chr "Wikipedia for Web APIs. Repository of API definitions in OpenAPI format.\n**Warning**: If you want to be notifi"| __truncated__
       @ license         : <rapid::api_license>
       .. @ name      : chr "CC0 1.0"
       .. @ identifier: chr(0) 
       .. @ url       : chr "https://github.com/APIs-guru/openapi-directory#licenses"
       @ summary         : chr(0) 
       @ terms_of_service: chr(0) 
       @ title           : chr "APIs.guru"
       @ version         : chr "2.2.0"

---

    Code
      test_result <- api_info(apid_list = apid_list_awsmh)
      test_result
    Output
      <rapid::api_info>
       @ contact         : <rapid::api_contact>
       .. @ name : chr "Mike Ralphson"
       .. @ email: chr "mike.ralphson@gmail.com"
       .. @ url  : chr "https://github.com/mermade/aws2openapi"
       @ description     : chr "<p>The AWS Migration Hub API methods help to obtain server and application migration status and integrate your "| __truncated__
       @ license         : <rapid::api_license>
       .. @ name      : chr "Apache 2.0 License"
       .. @ identifier: chr(0) 
       .. @ url       : chr "http://www.apache.org/licenses/"
       @ summary         : chr(0) 
       @ terms_of_service: chr(0) 
       @ title           : chr "AWS Migration Hub"
       @ version         : chr "2017-05-31"

