# rapid() requires api_info objects for info

    Code
      rapid(info = mean)
    Condition <simpleError>
      Error:
      ! <rapid::rapid> object properties are invalid:
      - @info must be <rapid::api_info>, not <closure>

# rapid() requires info when anything is defined

    Code
      rapid(servers = servers(url = c("https://development.gigantic-server.com/v1",
        "https://staging.gigantic-server.com/v1",
        "https://api.gigantic-server.com/v1"), description = c("Development server",
        "Staging server", "Production server")))
    Condition
      Error:
      ! <rapid::rapid> object is invalid:
      - When `info` is not defined, `servers` must be empty.
      - `servers` has 3 values.

# rapid() returns an empty rapid

    Code
      test_result <- rapid()
      test_result
    Output
      <rapid::rapid>
       @ info   : <rapid::api_info>
       .. @ contact         : <rapid::api_contact>
       .. .. @ name : chr(0) 
       .. .. @ email: chr(0) 
       .. .. @ url  : chr(0) 
       .. @ description     : chr(0) 
       .. @ license         : <rapid::api_license>
       .. .. @ name      : chr(0) 
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr(0) 
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ title           : chr(0) 
       .. @ version         : chr(0) 
       @ servers: <rapid::servers>
       .. @ url        : chr(0) 
       .. @ description: chr(0) 
       .. @ variables  : <rapid::server_variable_list>  list()

# Can construct a rapid from an apid_list

    Code
      test_result <- rapid(apid_list = apid_list_guru)
      test_result
    Output
      <rapid::rapid>
       @ info   : <rapid::api_info>
       .. @ contact         : <rapid::api_contact>
       .. .. @ name : chr "APIs.guru"
       .. .. @ email: chr "mike.ralphson@gmail.com"
       .. .. @ url  : chr "https://APIs.guru"
       .. @ description     : chr "Wikipedia for Web APIs. Repository of API definitions in OpenAPI format.\n**Warning**: If you want to be notifi"| __truncated__
       .. @ license         : <rapid::api_license>
       .. .. @ name      : chr "CC0 1.0"
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr "https://github.com/APIs-guru/openapi-directory#licenses"
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ title           : chr "APIs.guru"
       .. @ version         : chr "2.2.0"
       @ servers: <rapid::servers>
       .. @ url        : chr "https://api.apis.guru/v2"
       .. @ description: chr(0) 
       .. @ variables  : <rapid::server_variable_list> List of 1
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr(0) 
       .. ..  ..@ default    : chr(0) 
       .. ..  ..@ enum       : list()
       .. ..  ..@ description: chr(0) 

---

    Code
      test_result <- rapid(apid_list = apid_list_awsmh)
      test_result
    Output
      <rapid::rapid>
       @ info   : <rapid::api_info>
       .. @ contact         : <rapid::api_contact>
       .. .. @ name : chr "Mike Ralphson"
       .. .. @ email: chr "mike.ralphson@gmail.com"
       .. .. @ url  : chr "https://github.com/mermade/aws2openapi"
       .. @ description     : chr "<p>The AWS Migration Hub API methods help to obtain server and application migration status and integrate your "| __truncated__
       .. @ license         : <rapid::api_license>
       .. .. @ name      : chr "Apache 2.0 License"
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr "http://www.apache.org/licenses/"
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ title           : chr "AWS Migration Hub"
       .. @ version         : chr "2017-05-31"
       @ servers: <rapid::servers>
       .. @ url        : chr [1:4] "http://mgh.{region}.amazonaws.com" ...
       .. @ description: chr [1:4] "The AWS Migration Hub multi-region endpoint" ...
       .. @ variables  : <rapid::server_variable_list> List of 4
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr(0) 
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr(0) 
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr(0) 
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr(0) 

# Can construct a rapid from an apid_url

    Code
      test_result <- rapid(apid_url = "https://api.apis.guru/v2/openapi.yaml")
      test_result
    Output
      <rapid::rapid>
       @ info   : <rapid::api_info>
       .. @ contact         : <rapid::api_contact>
       .. .. @ name : chr "APIs.guru"
       .. .. @ email: chr "mike.ralphson@gmail.com"
       .. .. @ url  : chr "https://APIs.guru"
       .. @ description     : chr "Wikipedia for Web APIs. Repository of API definitions in OpenAPI format.\n**Warning**: If you want to be notifi"| __truncated__
       .. @ license         : <rapid::api_license>
       .. .. @ name      : chr "CC0 1.0"
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr "https://github.com/APIs-guru/openapi-directory#licenses"
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ title           : chr "APIs.guru"
       .. @ version         : chr "2.2.0"
       @ servers: <rapid::servers>
       .. @ url        : chr "https://api.apis.guru/v2"
       .. @ description: chr(0) 
       .. @ variables  : <rapid::server_variable_list> List of 1
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr(0) 
       .. ..  ..@ default    : chr(0) 
       .. ..  ..@ enum       : list()
       .. ..  ..@ description: chr(0) 

---

    Code
      test_result <- rapid(apid_url = "https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.yaml")
      test_result
    Output
      <rapid::rapid>
       @ info   : <rapid::api_info>
       .. @ contact         : <rapid::api_contact>
       .. .. @ name : chr "Mike Ralphson"
       .. .. @ email: chr "mike.ralphson@gmail.com"
       .. .. @ url  : chr "https://github.com/mermade/aws2openapi"
       .. @ description     : chr "<p>The AWS Migration Hub API methods help to obtain server and application migration status and integrate your "| __truncated__
       .. @ license         : <rapid::api_license>
       .. .. @ name      : chr "Apache 2.0 License"
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr "http://www.apache.org/licenses/"
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ title           : chr "AWS Migration Hub"
       .. @ version         : chr "2017-05-31"
       @ servers: <rapid::servers>
       .. @ url        : chr [1:4] "http://mgh.{region}.amazonaws.com" ...
       .. @ description: chr [1:4] "The AWS Migration Hub multi-region endpoint" ...
       .. @ variables  : <rapid::server_variable_list> List of 4
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr(0) 
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "us-east-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:23] "us-east-1" "us-east-2" "us-west-1" "us-west-2" ...
       .. ..  ..@ description: chr(0) 
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr(0) 
       .. .. $ : <rapid::server_variable>
       .. ..  ..@ name       : chr "region"
       .. ..  ..@ default    : chr "cn-north-1"
       .. ..  ..@ enum       :List of 1
       .. .. .. .. $ : chr [1:2] "cn-north-1" "cn-northwest-1"
       .. ..  ..@ description: chr(0) 

