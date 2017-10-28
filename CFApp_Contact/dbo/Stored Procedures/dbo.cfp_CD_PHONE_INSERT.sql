
-- =========================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/29/2009
-- Description:	CENTRAL DATA - Creates new phone record and returns it's ID.
-- =========================================================================
CREATE PROCEDURE dbo.cfp_CD_PHONE_INSERT
(
	@PhoneID		int		OUT,
	@PhoneNbr		varchar(10),
	@Extension		varchar(50),
	@SpeedDial		int
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT [$(CentralData)].dbo.Phone
	(
		[PhoneNbr]
		,[Extension]
		,[SpeedDial]	
	) 
	VALUES 
	(
		@PhoneNbr
		,@Extension
		,@SpeedDial
	)
	set @PhoneID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_PHONE_INSERT] TO [db_sp_exec]
    AS [dbo];

