DECLARE @html NVARCHAR(MAX);
DECLARE @profile_name NVARCHAR(100) = 'YourDatabaseMailProfile'; -- Укажите ваш профиль Database Mail
DECLARE @recipients NVARCHAR(100) = 'recipient@example.com'; -- Укажите email получателя

-- Формируем HTML-таблицу
SET @html = 
    N'<html>
    <head>
        <style>
            table {border-collapse: collapse; width: 100%; font-family: Arial, sans-serif;}
            th, td {border: 1px solid black; padding: 8px; text-align: left;}
            th {background-color: #f2f2f2;}
        </style>
    </head>
    <body>
        <h3>Index Metadata Report</h3>
        <table>
            <tr>
                <th>Table Name</th>
                <th>Index Name</th>
                <th>Index Type</th>
                <th>Column Name</th>
            </tr>';

-- Добавляем строки с индексами
SELECT @html = @html + 
    N'<tr>
        <td>' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + N'</td>
        <td>' + QUOTENAME(i.name) + N'</td>
        <td>' + i.type_desc + N'</td>
        <td>' + QUOTENAME(c.name) + N'</td>
    </tr>'
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE i.type > 0 -- Исключаем heap (отсутствие индекса)
ORDER BY s.name, t.name, i.name;

-- Закрываем HTML
SET @html = @html + N'</table></body></html>';

-- Отправка email
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = @profile_name,
    @recipients = @recipients,
    @subject = 'Index Metadata Report',
    @body = @html,
    @body_format = 'HTML';
