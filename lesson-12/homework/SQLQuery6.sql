DECLARE @SQL NVARCHAR(MAX) = '';

-- Generate a dynamic SQL query to fetch metadata from all user databases
SELECT @SQL = @SQL + '
USE [' + name + '];
SELECT 
    ''' + name + ''' AS DatabaseName, 
    s.name AS SchemaName, 
    t.name AS TableName, 
    c.name AS ColumnName, 
    ty.name AS DataType
FROM [' + name + '].sys.schemas s
JOIN [' + name + '].sys.tables t ON s.schema_id = t.schema_id
JOIN [' + name + '].sys.columns c ON t.object_id = c.object_id
JOIN [' + name + '].sys.types ty ON c.user_type_id = ty.user_type_id;
'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb'); -- Exclude system databases

-- Execute the dynamically generated SQL
EXEC sp_executesql @SQL;
