/*
-- =========================================================
-- Author:		Doran Dahle	
-- Create date: 07/21/2011
-- Description:	Inserts Optimizer Load Values
-- =========================================================

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-21  Doran Dahle initial release

===============================================================================
*/

CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_LOAD_VALUES_INSERT]
(
	@LoadID int,
    @LoadDay int,
    @Packer varchar(2),
    @LoadValue int,
    @PigWT int
)
AS
BEGIN
	INSERT INTO [dbo].[cft_MARKET_OPTIMIZER_LOAD_VALUES]
        (
			[LoadID],
			[LoadDay],
			[Packer],
			[LoadValue],
			[PigWT]
		)
     VALUES
        (
			@LoadID,
			@LoadDay,
			@Packer, 
			@LoadValue,
			@PigWT
		)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_LOAD_VALUES_INSERT] TO [db_sp_exec]
    AS [dbo];

