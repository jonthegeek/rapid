# character_scalar_property() returns expected object

    Code
      test_result <- character_scalar_property("propname")
      test_result
    Output
      <S7_property> 
       $ name     : chr "propname"
       $ class    : <S7_base_class>: <character>
       $ getter   : NULL
       $ setter   : function (self, value)  
       $ validator: NULL
       $ default  : NULL

# logical_scalar_property() returns expected object

    Code
      test_result <- logical_scalar_property("propname")
      test_result
    Output
      <S7_property> 
       $ name     : chr "propname"
       $ class    : <S7_base_class>: <logical>
       $ getter   : NULL
       $ setter   : function (self, value)  
       $ validator: NULL
       $ default  : NULL

# factor_property() returns expected object

    Code
      test_result <- factor_property("propname", levels = factor_levels)
      test_result
    Output
      <S7_property> 
       $ name     : chr "propname"
       $ class    : <S7_S3_class>: S3<factor>
       $ getter   : NULL
       $ setter   : function (self, value)  
       $ validator: function (value)  
       $ default  : Factor w/ 3 levels "a","b","c": 

# factor_property() validates

    Code
      test_result$validator("d")
    Output
      [1] "must have values \"a\", \"b\", or \"c\"."

# enum_property() returns expected object

    Code
      test_result <- enum_property("propname")
      test_result
    Output
      <S7_property> 
       $ name     : chr "propname"
       $ class    : <S7_base_class>: <list>
       $ getter   : NULL
       $ setter   : function (self, value)  
       $ validator: NULL
       $ default  : NULL

# list_of_characters() returns expected object

    Code
      test_result <- list_of_characters("propname")
      test_result
    Output
      <S7_property> 
       $ name     : chr "propname"
       $ class    : <S7_base_class>: <list>
       $ getter   : NULL
       $ setter   : function (self, value)  
       $ validator: NULL
       $ default  : NULL

