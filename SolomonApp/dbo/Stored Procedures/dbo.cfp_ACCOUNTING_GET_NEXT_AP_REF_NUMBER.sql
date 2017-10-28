

-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/27/2008
-- Description:	
--	APSetup table in SolomonApp database has a column named "LastRefNbr".  
--	Boyer says we increase that number by one and that is our new Ref number.  
--	lock the table when we do this so users in Solomon won't be doing the same thing at the same time and mess up the data.

-- =======================================================================
CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_GET_NEXT_AP_REF_NUMBER]
AS
BEGIN

BEGIN TRANSACTION
	DECLARE @NewRefNbr CHAR(10)
	SELECT @NewRefNbr = MAX(CAST(LastRefNbr AS INT)) + 1 FROM SolomonApp.dbo.APSetup WITH (TABLOCKX)

	UPDATE SolomonApp.dbo.APSetup WITH (TABLOCKX)
	SET LastRefNbr = dbo.cffn_FORMAT_REF_NUMBER (@NewRefNbr)
--	SET LastRefNbr = dbo.cffn_FORMAT_BATCH_NUMBER(@NewRefNbr)	-- 20130708 smr cornapp issue, we need more than the 6 digit limit.

	INSERT INTO [SolomonApp].[dbo].[APRefNbr]
	(
		[Crtd_DateTime]
       ,[Crtd_Prog]
       ,[Crtd_User]
       ,[LUpd_DateTime]
       ,[LUpd_Prog]
       ,[LUpd_User]
       ,[RefNbr]
       ,[S4Future01]
       ,[S4Future02]
       ,[S4Future03]
       ,[S4Future04]
       ,[S4Future05]
       ,[S4Future06]
       ,[S4Future07]
       ,[S4Future08]
       ,[S4Future09]
       ,[S4Future10]
       ,[S4Future11]
       ,[S4Future12]
       ,[User1]
       ,[User2]
       ,[User3]
       ,[User4]
       ,[User5]
       ,[User6]
       ,[User7]
       ,[User8]
	)
    VALUES
    (
		'01/01/1900'
       ,''
       ,''
       ,'01/01/1900'
       ,''
       ,''
	   ,dbo.cffn_FORMAT_REF_NUMBER(@NewRefNbr)
--	   ,dbo.cffn_FORMAT_BATCH_NUMBER(@NewRefNbr)
       ,''
       ,''
       ,0
       ,0
       ,0
       ,0
       ,'01/01/1900'
       ,'01/01/1900'	
       ,0
       ,0
       ,''
       ,''
       ,''
       ,''
       ,0
       ,0
       ,''
       ,''
       ,'01/01/1900'
       ,'01/01/1900' 
	)

	SELECT @NewRefNbr 'NewRefNumber'
COMMIT

END



