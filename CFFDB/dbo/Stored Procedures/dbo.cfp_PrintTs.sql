



create PROCEDURE [dbo].[cfp_PrintTs]
	@Message	varchar(2000), 
	@TStamp		datetime = NULL
AS

/*
===============================================================================
Purpose:    Prints out a message with the current or passed in datetime.

Inputs:     @Message - Required
            @TStamp  - Optional
Outputs:    Message to the console or log
Returns:    N/A
Environ:    Test or Production

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2010-08-03  Dan Bryskin Initial Release
===============================================================================
*/

DECLARE @ts	varchar(25)

IF @TStamp IS NULL BEGIN SET @TStamp = GETDATE() END
SET @ts = CONVERT(VARCHAR(25),@TStamp, 121)
SET @Message = @ts + ': ' + @Message

RAISERROR (@Message, 0, 1) WITH NOWAIT


