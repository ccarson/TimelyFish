CREATE   Procedure [dbo].[pXF213UpdateOrder]
      @parmOrder As varchar(10), @parmdate smalldatetime

----------------------------------------------------------------------------------------
--    Purpose: Update feed orders sent to WEM
--    Author: Sue Matter
--    Date: 7/20/2006
--    Program Usage: XF213
--    Parms: @parmOrder Feed order number
----------------------------------------------------------------------------------------

AS
Update cftFeedOrder
Set CF09='2',Lupd_DateTime=@parmdate,Lupd_Prog='XF213' 
Where OrdNbr=@parmOrder



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213UpdateOrder] TO [MSDSL]
    AS [dbo];

