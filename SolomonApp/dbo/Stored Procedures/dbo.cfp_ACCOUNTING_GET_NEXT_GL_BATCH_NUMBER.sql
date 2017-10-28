-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/27/2008
-- Description:	
--	GLSetup table in SolomonApp database has a column named "LastBatNbr".  
--	Boyer says we increase that number by one and that is our new Batch number.  
--	lock the table when we do this so users in Solomon won't be doing the same thing at the same time and mess up the data.

-- =======================================================================
CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_GET_NEXT_GL_BATCH_NUMBER]
AS
BEGIN

BEGIN TRANSACTION
	DECLARE @NewBatNbr CHAR(10)
	SELECT @NewBatNbr = MAX(CAST(LastBatNbr AS INT)) + 1 FROM SolomonApp.dbo.GLSetup WITH (TABLOCKX)

	UPDATE SolomonApp.dbo.GLSetup WITH (TABLOCKX)
	SET LastBatNbr = dbo.cffn_FORMAT_BATCH_NUMBER(@NewBatNbr)

	SELECT @NewBatNbr 'NewBatchNumber'
COMMIT

END

