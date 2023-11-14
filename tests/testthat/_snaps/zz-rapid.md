# class_rapid() requires info objects for info

    Code
      class_rapid(info = mean)
    Condition
      Error in `class_rapid()`:
      ! Can't coerce `info` <function> to <rapid::info>.

# class_rapid() requires info when anything is defined

    Code
      class_rapid(servers = class_servers(url = c(
        "https://development.gigantic-server.com/v1",
        "https://staging.gigantic-server.com/v1",
        "https://api.gigantic-server.com/v1"), description = c("Development server",
        "Staging server", "Production server")))
    Condition
      Error:
      ! <rapid::rapid> object is invalid:
      - When `info` is not defined, `servers` must be empty.
      - `servers` has 3 values.

# security must reference components@security_schemes

    Code
      class_rapid(info = class_info(title = "A", version = "1"), components = class_components(
        security_schemes = class_security_schemes(name = "the_defined_one", details = class_security_scheme_details(
          class_api_key_security_scheme("this_one", location = "header")))),
      security = class_security(name = "an_undefined_one"))
    Condition
      Error:
      ! <rapid::rapid> object is invalid:
      - `security` must be one of the `security_schemes` defined in `components`.
      - "an_undefined_one" is not in "the_defined_one".

# class_rapid() returns an empty rapid

    Code
      test_result <- class_rapid()
      test_result
    Output
      <rapid::rapid>
       @ info      : <rapid::info>
       .. @ title           : chr(0) 
       .. @ version         : chr(0) 
       .. @ contact         : <rapid::contact>
       .. .. @ name : chr(0) 
       .. .. @ email: chr(0) 
       .. .. @ url  : chr(0) 
       .. @ description     : chr(0) 
       .. @ license         : <rapid::license>
       .. .. @ name      : chr(0) 
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr(0) 
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ origin          : <rapid::origin>
       .. .. @ url    : chr(0) 
       .. .. @ format : chr(0) 
       .. .. @ version: chr(0) 
       @ servers   : <rapid::servers>
       .. @ url        : chr(0) 
       .. @ description: chr(0) 
       .. @ variables  : <rapid::server_variables>  list()
       @ components: <rapid::components>
       .. @ security_schemes: <rapid::security_schemes>
       .. .. @ name       : chr(0) 
       .. .. @ details    : <rapid::security_scheme_details>  list()
       .. .. @ description: chr(0) 
       @ security  : <rapid::security>
       .. @ name                   : chr(0) 
       .. @ required_scopes        : list()
       .. @ rapid_class_requirement: chr "security_scheme"

# as_rapid() errors informatively for bad classes

    Code
      as_rapid(1:2)
    Condition
      Error in `as_rapid()`:
      ! Can't coerce `1:2` <integer> to <rapid::rapid>.

---

    Code
      as_rapid(mean)
    Condition
      Error in `as_rapid()`:
      ! Can't coerce `mean` <function> to <rapid::rapid>.

---

    Code
      as_rapid(TRUE)
    Condition
      Error in `as_rapid()`:
      ! Can't coerce `TRUE` <logical> to <rapid::rapid>.

# as_rapid() errors informatively for unnamed input

    Code
      as_rapid(list(letters))
    Condition
      Error:
      ! `x` must be comprised of properly formed, supported elements.
      Caused by error in `as_rapid()`:
      ! `list(letters)` must have names "info", "servers", "components", or "security".
      * Any other names are ignored.

---

    Code
      as_rapid(list(list("https://example.com", "A cool server.")))
    Condition
      Error:
      ! `x` must be comprised of properly formed, supported elements.
      Caused by error in `as_rapid()`:
      ! `list(list("https://example.com", "A cool server."))` must have names "info", "servers", "components", or "security".
      * Any other names are ignored.

# as_rapid() works for yaml urls

    Code
      test_result
    Output
      <rapid::rapid>
       @ info      : <rapid::info>
       .. @ title           : chr "AWS Migration Hub"
       .. @ version         : chr "2017-05-31"
       .. @ contact         : <rapid::contact>
       .. .. @ name : chr "Mike Ralphson"
       .. .. @ email: chr "mike.ralphson@gmail.com"
       .. .. @ url  : chr "https://github.com/mermade/aws2openapi"
       .. @ description     : chr "<p>The AWS Migration Hub API methods help to obtain server and application migration status and integrate your "| __truncated__
       .. @ license         : <rapid::license>
       .. .. @ name      : chr "Apache 2.0 License"
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr "http://www.apache.org/licenses/"
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr "https://aws.amazon.com/service-terms/"
       .. @ origin          : <rapid::origin>
       .. .. @ url    : chr "https://raw.githubusercontent.com/aws/aws-sdk-js/master/apis/AWSMigrationHub-2017-05-31.normal.json"
       .. .. @ format : chr(0) 
       .. .. @ version: chr(0) 
       @ servers   : <rapid::servers>
       .. @ url        : chr [1:4] "http://mgh.{region}.amazonaws.com" ...
       .. @ description: chr [1:4] "The AWS Migration Hub multi-region endpoint" ...
       .. @ variables  : <rapid::server_variables> List of 4
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr "The AWS region"
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr "The AWS region"
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr "The AWS region"
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr "The AWS region"
       @ components: <rapid::components>
       .. @ security_schemes: <rapid::security_schemes>
       .. .. @ name       : chr "hmac"
       .. .. @ details    : <rapid::security_scheme_details> List of 1
       .. .. .. $ : <rapid::api_key_security_scheme>
       .. .. ..  ..@ parameter_name: chr "Authorization"
       .. .. ..  ..@ location      : chr "header"
       .. .. @ description: chr "Amazon Signature authorization v4"
       @ security  : <rapid::security>
       .. @ name                   : chr "hmac"
       .. @ required_scopes        :List of 1
       .. .. $ : chr(0) 
       .. @ rapid_class_requirement: chr "security_scheme"

# as_rapid() works for json urls

    Code
      test_result
    Output
      <rapid::rapid>
       @ info      : <rapid::info>
       .. @ title           : chr "AWS Migration Hub"
       .. @ version         : chr "2017-05-31"
       .. @ contact         : <rapid::contact>
       .. .. @ name : chr "Mike Ralphson"
       .. .. @ email: chr "mike.ralphson@gmail.com"
       .. .. @ url  : chr "https://github.com/mermade/aws2openapi"
       .. @ description     : chr "<p>The AWS Migration Hub API methods help to obtain server and application migration status and integrate your "| __truncated__
       .. @ license         : <rapid::license>
       .. .. @ name      : chr "Apache 2.0 License"
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr "http://www.apache.org/licenses/"
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr "https://aws.amazon.com/service-terms/"
       .. @ origin          : <rapid::origin>
       .. .. @ url    : chr "https://raw.githubusercontent.com/aws/aws-sdk-js/master/apis/AWSMigrationHub-2017-05-31.normal.json"
       .. .. @ format : chr(0) 
       .. .. @ version: chr(0) 
       @ servers   : <rapid::servers>
       .. @ url        : chr [1:4] "http://mgh.{region}.amazonaws.com" ...
       .. @ description: chr [1:4] "The AWS Migration Hub multi-region endpoint" ...
       .. @ variables  : <rapid::server_variables> List of 4
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr "The AWS region"
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr "The AWS region"
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr "The AWS region"
       .. .. $ : <rapid::string_replacements>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr "The AWS region"
       @ components: <rapid::components>
       .. @ security_schemes: <rapid::security_schemes>
       .. .. @ name       : chr "hmac"
       .. .. @ details    : <rapid::security_scheme_details> List of 1
       .. .. .. $ : <rapid::api_key_security_scheme>
       .. .. ..  ..@ parameter_name: chr "Authorization"
       .. .. ..  ..@ location      : chr "header"
       .. .. @ description: chr "Amazon Signature authorization v4"
       @ security  : <rapid::security>
       .. @ name                   : chr "hmac"
       .. @ required_scopes        :List of 1
       .. .. $ : chr(0) 
       .. @ rapid_class_requirement: chr "security_scheme"

# as_rapid() stores origin info for urls

    Code
      test_result
    Output
      <rapid::rapid>
       @ info      : <rapid::info>
       .. @ title           : chr "OpenFEC"
       .. @ version         : chr "1.0"
       .. @ contact         : <rapid::contact>
       .. .. @ name : chr(0) 
       .. .. @ email: chr(0) 
       .. .. @ url  : chr(0) 
       .. @ description     : chr "This application programming interface (API) allows you to explore the way candidates and committees fund their"| __truncated__
       .. @ license         : <rapid::license>
       .. .. @ name      : chr(0) 
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr(0) 
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ origin          : <rapid::origin>
       .. .. @ url    : chr "https://api.open.fec.gov/swagger/"
       .. .. @ format : chr(0) 
       .. .. @ version: chr(0) 
       @ servers   : <rapid::servers>
       .. @ url        : chr(0) 
       .. @ description: chr(0) 
       .. @ variables  : <rapid::server_variables>  list()
       @ components: <rapid::components>
       .. @ security_schemes: <rapid::security_schemes>
       .. .. @ name       : chr(0) 
       .. .. @ details    : <rapid::security_scheme_details>  list()
       .. .. @ description: chr(0) 
       @ security  : <rapid::security>
       .. @ name                   : chr [1:3] "ApiKeyHeaderAuth" "ApiKeyQueryAuth" "apiKey"
       .. @ required_scopes        :List of 3
       .. .. $ : chr(0) 
       .. .. $ : chr(0) 
       .. .. $ : chr(0) 
       .. @ rapid_class_requirement: chr "security_scheme"

# as_rapid() works for empty optional fields

    Code
      test_result
    Output
      <rapid::rapid>
       @ info      : <rapid::info>
       .. @ title           : chr "OpenFEC"
       .. @ version         : chr "1.0"
       .. @ contact         : <rapid::contact>
       .. .. @ name : chr(0) 
       .. .. @ email: chr(0) 
       .. .. @ url  : chr(0) 
       .. @ description     : chr "This application programming interface (API) allows you to explore the way candidates and committees fund their"| __truncated__
       .. @ license         : <rapid::license>
       .. .. @ name      : chr(0) 
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr(0) 
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ origin          : <rapid::origin>
       .. .. @ url    : chr "https://api.open.fec.gov/swagger/"
       .. .. @ format : chr "openapi"
       .. .. @ version: chr "3.0"
       @ servers   : <rapid::servers>
       .. @ url        : chr "https://api.open.fec.gov/v1"
       .. @ description: chr(0) 
       .. @ variables  : <rapid::server_variables>  list()
       @ components: <rapid::components>
       .. @ security_schemes: <rapid::security_schemes>
       .. .. @ name       : chr [1:3] "ApiKeyHeaderAuth" "ApiKeyQueryAuth" "apiKey"
       .. .. @ details    : <rapid::security_scheme_details> List of 3
       .. .. .. $ : <rapid::api_key_security_scheme>
       .. .. ..  ..@ parameter_name: chr "X-Api-Key"
       .. .. ..  ..@ location      : chr "header"
       .. .. .. $ : <rapid::api_key_security_scheme>
       .. .. ..  ..@ parameter_name: chr "api_key"
       .. .. ..  ..@ location      : chr "query"
       .. .. .. $ : <rapid::api_key_security_scheme>
       .. .. ..  ..@ parameter_name: chr "api_key"
       .. .. ..  ..@ location      : chr "query"
       .. .. @ description: chr(0) 
       @ security  : <rapid::security>
       .. @ name                   : chr [1:3] "ApiKeyHeaderAuth" "ApiKeyQueryAuth" "apiKey"
       .. @ required_scopes        :List of 3
       .. .. $ : chr(0) 
       .. .. $ : chr(0) 
       .. .. $ : chr(0) 
       .. @ rapid_class_requirement: chr "security_scheme"

