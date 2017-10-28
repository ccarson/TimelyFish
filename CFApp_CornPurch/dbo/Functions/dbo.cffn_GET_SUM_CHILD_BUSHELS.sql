
-- =============================================
-- Author:		Sergey Neskin
-- Create date: 09/11/2008
-- Description:	Get sum child contracted bushels
-- =============================================
CREATE FUNCTION [dbo].[cffn_GET_SUM_CHILD_BUSHELS]
(
	@SequenceNumber int,
	@FeedMillID char(10)
)
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT @Result = SUM(Bushels)
	FROM dbo.cft_CONTRACT        
	WHERE NOT SubsequenceNumber IS NULL 
		AND ContractStatusID IN (1, 2)
		AND SequenceNumber = @SequenceNumber
		AND FeedMillID = @FeedMillID
	IF @Result IS NULL
	BEGIN
		SET @Result = 0
	END

	RETURN @Result

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_SUM_CHILD_BUSHELS] TO [db_sp_exec]
    AS [dbo];

