CREATE PROCEDURE WS_Attach_LinkFlag @webServiceName varchar(255), @tableName varchar(128) AS
SELECT TOP 1
LinkFlag
FROM vs_AttachConfig
WHERE
	AttachmentType = 'W'
	AND (	(ScreenNumber = @webServiceName
			AND TableName = @tableName)
		OR ScreenNumber = 'DEFAULT')
ORDER BY
	CASE ScreenNumber WHEN 'DEFAULT' THEN 1 ELSE 0 END,
	CASE TableName WHEN 'DEFAULT' THEN 1 ELSE 0 END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_Attach_LinkFlag] TO [MSDSL]
    AS [dbo];

