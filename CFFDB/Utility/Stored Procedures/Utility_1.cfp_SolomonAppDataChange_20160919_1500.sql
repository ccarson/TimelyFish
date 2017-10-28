


CREATE PROCEDURE 
	[Utility].[cfp_SolomonAppDataChange_20160919_1500]
AS
/*
************************************************************************************************************************************

  Procedure:    Utility.cfp_SolomonAppDataChange_20160919_1500
     Author:    Chris Carson -- SQL code originally written by Nick Braam
    Purpose:    Update production SolomonApp.dbo.ARTran
	
				Correcting ARTran detail records to reflect maintenance credits where the task was not set up
					in Sky.  This update adds 'MC' to the User5 field on SolomonApp.dbo.ARTran for affected records.
					This allows invoices to print and adjust balances correctly.
					
				

    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-09-19			Executed in production


    Notes:
	
	Help Desk Reference # G9JG642292

************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

--This statement should return 6 rows, which are the problem records we've identified in SL
SELECT	*
FROM	SolomonApp.dbo.ARTran
WHERE	BatNbr = '077411'
		AND	CuryTranAmt < 0 ;


--This statement makes the changes and displays the output.
BEGIN TRANSACTION ; 

	UPDATE	SolomonApp.dbo.ARTran
	SET		User5			= 'MC'
		  , LUpd_DateTime	= GETDATE() 
		  , LUpd_Prog		= 'TSQL'
		  , LUpd_User		= 'CCARSON'
	OUTPUT	inserted.user5, deleted.user5, inserted.LUpd_DateTime, deleted.LUpd_DateTime, inserted.LUpd_User, deleted.LUpd_User
	WHERE	BatNbr = '077411'
			AND CuryTranAmt < 0 ;

--return the updated problem records 
SELECT	*
FROM	SolomonApp.dbo.ARTran
WHERE	BatNbr = '077411'
		AND	CuryTranAmt < 0 ;


--ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ; 

RETURN 0 ;