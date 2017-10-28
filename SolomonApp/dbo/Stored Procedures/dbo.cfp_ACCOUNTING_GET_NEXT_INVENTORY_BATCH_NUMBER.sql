-- =======================================================================
-- Author:		Matt Dawson
-- Create date: 08/12/2008
-- Description:	
--	INSetup table in SolomonApp database has a column named "LastBatNbr".  
--	Boyer says we increase that number by one and that is our new Batch number.  
--	lock the table when we do this so users in Solomon won't be doing the same thing at the same time and mess up the data.

-- =======================================================================
CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_GET_NEXT_INVENTORY_BATCH_NUMBER]
AS
BEGIN

BEGIN TRANSACTION
	DECLARE @NewBatNbr CHAR(10)
	SELECT @NewBatNbr = MAX(CAST(LastBatNbr AS INT)) + 1 FROM SolomonApp.dbo.INSetup WITH (TABLOCKX)

	UPDATE SolomonApp.dbo.INSetup WITH (TABLOCKX)
	SET LastBatNbr = dbo.cffn_FORMAT_BATCH_NUMBER(@NewBatNbr)

	SELECT @NewBatNbr 'NewBatchNumber'
COMMIT

END

