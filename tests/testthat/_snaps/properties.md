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

# enum_property_rename() returns expected object

    Code
      test_result <- enum_property_rename("propname")
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

