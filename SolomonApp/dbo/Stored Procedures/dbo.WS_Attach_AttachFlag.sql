CREATE PROCEDURE WS_Attach_AttachFlag @webServiceName varchar(255), @tableName varchar(128) AS
SELECT TOP 1
AttachFlag
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
    ON OBJECT::[dbo].[WS_Attach_AttachFlag] TO [MSDSL]
    AS [dbo];

