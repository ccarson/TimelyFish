-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FAX_INSERT] 
(
	@FAX_ID							[varchar](50),
	@FARM_ID						[varchar](8),
	@FAX_ORIGINATING_NUMBER			[varchar](10),
	@FAX_PROCESSED					[char](1)
)
AS
BEGIN
    INSERT INTO dbo.FAX_INFORMATION
	(
		[FAX_ID],
		[FARM_ID],
		[FAX_ORIGINATING_NUMBER], 
		[FAX_PROCESSED]
	)
	VALUES 
	(	
		@FAX_ID,
		@FARM_ID,
		@FAX_ORIGINATING_NUMBER,
 		@FAX_PROCESSED
	)
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FAX_INSERT] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[FAX_INSERT] TO [se\analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FAX_INSERT] TO [MyFaxService]
    AS [dbo];

