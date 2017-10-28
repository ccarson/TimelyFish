-- =============================================
-- Author:	Brain Cesafsky
-- Create date: 7/16/2007
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FAX_UPDATE]
(
	@FAX_ID						[varchar](50),
	@FAX_PROCESSED 				[char](1),
	@FAX_PROCESSED_DATE			[smalldatetime]
)
AS
BEGIN
	UPDATE dbo.FAX_INFORMATION
	SET FAX_PROCESSED = @FAX_PROCESSED,
		FAX_PROCESSED_DATE = @FAX_PROCESSED_DATE
	WHERE FAX_ID = @FAX_ID
END






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FAX_UPDATE] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[FAX_UPDATE] TO [se\analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FAX_UPDATE] TO [MyFaxService]
    AS [dbo];

