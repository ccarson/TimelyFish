
-- =======================================================
-- Author:		<Doran Dahle>
-- Create date: <08/03/2011>
-- Description:	<Inserts a Market Optimizer Input record>
-- =======================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-26  Doran Dahle Added SiteName
						Removed P1,P2,P3,P4,WT
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_INPUT_INSERT]
(
	@LID					        int,
	@QTY							int,
	@OB								int,
	@SiteName						varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_MARKET_OPTIMIZER_INPUT
	(
		[LID],
		[QTY],
		[OB],
		[SiteName]
	)
	VALUES 
	(	
		@LID,
		@QTY,
		@OB,
		@SiteName
	)
END






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_INPUT_INSERT] TO [db_sp_exec]
    AS [dbo];

