
CREATE PROCEDURE WSL_AttachmentsEnabled @ServiceName varchar(255), @screenNumber varchar(7), @tableName varchar(128)
AS
IF EXISTS (SELECT *
			FROM vs_attachconfig
			WHERE
				AttachmentType = 'W'
				AND (	(ScreenNumber = @ServiceName
						AND TableName = @tableName)
					OR ScreenNumber = 'DEFAULT')
				AND AttachFlag = 'Y')
	AND EXISTS
		(SELECT *
			FROM vs_attachconfig
			WHERE
				AttachmentType = 'S'
				AND (	(ScreenNumber = @screenNumber
						AND TableName = @tableName)
					OR ScreenNumber = 'DEFAULT')
				AND AttachFlag = 'Y')
	BEGIN
		SELECT 'Enabled' as Result
	END
ELSE
	BEGIN
		SELECT 'Disabled' as Result
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_AttachmentsEnabled] TO [MSDSL]
    AS [dbo];

