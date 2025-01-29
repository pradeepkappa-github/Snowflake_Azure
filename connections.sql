create or replace storage integration azure_int
  type = external_stage
  storage_provider = azure
  enabled = true
  azure_tenant_id = '5ad64755-3cf6-458b-a350-a28a57150036'
  storage_allowed_locations = ('azure://blobsnowflakepradeeptes.blob.core.windows.net/snowflakeintegration');

  desc integration azure_int;


  create or replace file format my_csv_format
type = csv field_delimiter = ',' skip_header = 1 null_if = ('NULL', 'null') empty_field_as_null = true;
  
create or replace stage my_azure_stage
storage_integration = azure_int
url = 'azure://blobsnowflakepradeeptes.blob.core.windows.net/snowflakeintegration'
file_format = my_csv_format;
  
select t.$1 as first_name,t.$2 as last_name
from @azure_snowflake.azure_snowflake_schema.my_azure_stage t;

----/* azcopy commands
>C:\Users\prade\Downloads\azcopy_windows_amd64_10.28.0\azcopy_windows_amd64_10.28.0\azcopy.exe login --tenant-id=5ad64755-3cf6-458b-a350-a28a57150036

>C:\Users\prade\Downloads\azcopy_windows_amd64_10.28.0\azcopy_windows_amd64_10.28.0\azcopy.exe copy "C:\Users\prade\Downloads\emp\emp\Employee\*" "https://blobsnowflakepradeeptes.blob.core.windows.net/demo" --from-to=LocalBlob*/

