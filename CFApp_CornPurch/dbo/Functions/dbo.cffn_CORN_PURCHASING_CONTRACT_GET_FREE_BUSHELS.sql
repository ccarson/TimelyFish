
-- =============================================
-- Author:		Sergey Neskin
-- Create date: 09/10/2008
-- Description:	Return free bushels left on a contract.
-- =============================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-09-15  Doran Dahle Removed the Rounding on the SubContracts.  Gemini Ticket CORNPURCH-2014  
						

===============================================================================
*/
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS]
(
	@ContractID int
)
RETURNS decimal(18,4)
AS
BEGIN
	DECLARE @Result			decimal(18,4)
	DECLARE @Tickets		decimal(18,4)
    DECLARE @SubContracts	decimal(18,4)
 
	SELECT @Tickets = ISNULL(SUM(DryBushels), 0)
	FROM dbo.cft_PARTIAL_TICKET 
	WHERE ContractID = @ContractID

	SELECT @SubContracts = ISNULL(SUM(C.Bushels), 0)
	FROM dbo.cft_CONTRACT C
		INNER JOIN (
			SELECT FeedMillID, SequenceNumber
			FROM dbo.cft_CONTRACT
			WHERE ContractID = @ContractID AND SubsequenceNumber IS NULL
		) C1 ON C.FeedMillID = C1.FeedMillID 
		AND C.SequenceNumber = C1.SequenceNumber 
		AND C.SubsequenceNumber IS NOT NULL 
		AND ContractStatusID IN (1,2)
  
	--SET @SubContracts = ROUND(@SubContracts, 0) -- sum of bushels assigned to tickets should be rounded to nearest whole number (see UC009)

	SELECT @Result = Bushels - @Tickets - @SubContracts
	FROM dbo.cft_CONTRACT
	WHERE ContractID = @ContractID
	
	RETURN @Result
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS] TO [db_sp_exec]
    AS [dbo];

