CREATE   Procedure pXF213LoadCheck
	@parmload As varchar(20), @parmDate As smalldatetime

----------------------------------------------------------------------------------------
--	Purpose: Verify no duplicate load numbers
--	Author: Sue Matter
--	Date: 7/20/2006
--	Program Usage: XF213
--	Parms: @parmdate date of load
--	Parms: @parmload Feed load number
----------------------------------------------------------------------------------------

AS
Select LoadNbr
From cftFeedLoad
Where DateReq=@parmdate AND LoadNbr=@parmload


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213LoadCheck] TO [MSDSL]
    AS [dbo];

