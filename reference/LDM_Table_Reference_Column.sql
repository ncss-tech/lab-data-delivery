--Table Reference Column
SELECT 
(select top 1 d.name from sys.data_spaces d where d.data_space_id =(select top 1 i.data_space_id from sys.indexes i where i.object_id = (SELECT top 1 t.object_id FROM sys.tables t WHERE gg.TABLE_NAME= t.name) and i.index_id < 2)) AS 'TableOnFileGroup',
TABLE_SCHEMA AS 'Schema Name', 
TABLE_NAME AS 'Table Name', 
COLUMN_NAME AS 'Data Element', 
ORDINAL_POSITION AS 'OrdinalPosition',
DATA_TYPE AS 'Data Type', 
ISNULL(CONVERT(char(10),CHARACTER_MAXIMUM_LENGTH),'') AS 'Max Len', ISNULL(CONVERT(char(10),NUMERIC_PRECISION),'') AS 'Prec', ISNULL(CONVERT(char(10),NUMERIC_SCALE),'') AS 'Scale', 
CASE WHEN COLUMNPROPERTY(OBJECT_ID(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1 then 'Y' ELSE '' END AS 'Identity',
CASE IS_NULLABLE WHEN 'YES' THEN '' ELSE 'NOT NULL' END AS 'NOT NULL',
ISNULL((SELECT top 1 object_name(k.referenced_object_id) + '(' + col_name(k.referenced_object_id,k.referenced_column_id) + ')' FROM sys.foreign_key_columns k WHERE object_name(k.parent_object_id) = gg.TABLE_NAME AND col_name(k.parent_object_id,k.parent_column_id) = gg.COLUMN_NAME),'') AS 'References', 
ISNULL(COLUMN_DEFAULT,'') AS 'Default Value' 
FROM information_schema.columns gg
ORDER BY [Schema Name], TABLE_CATALOG, TABLE_NAME, ORDINAL_POSITION 