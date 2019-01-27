--System Dependency
SELECT OBJECT_NAME(object_id) referencing,
  OBJECT_NAME(referenced_major_id),
  *
FROM sys.sql_dependencies 