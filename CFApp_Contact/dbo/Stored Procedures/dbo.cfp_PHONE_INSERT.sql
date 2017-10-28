
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/22/2008
-- Description:	Creates new phone record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_PHONE_INSERT
(
	@PhoneID		int		OUT,
	@PhoneNbr		varchar(10),
	@Extension		varchar(50),
	@SpeedDial		int,
	@CreatedBy		varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_PHONE
	(
		[PhoneNbr]
		,[Extension]
		,[SpeedDial]	
		,[CreatedBy]
	) 
	VALUES 
	(
		@PhoneNbr
		,@Extension
		,@SpeedDial
		,@CreatedBy
	)
	set @PhoneID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PHONE_INSERT] TO [db_sp_exec]
    AS [dbo];

