CREATE   Procedure [dbo].[pXF213UpdateLoad]
      @parmOrder As varchar(10), @parmload As varchar(6),@parmuserid As varchar(10),@parmtime AS varchar(8)

----------------------------------------------------------------------------------------
--    Purpose: Update feed loads sent to WEM
--    Author: Sue Matter
--    Date: 7/20/2006
--    Program Usage: XF213
--    Parms: @parmOrder Feed order number
--    Parms: @parmload Feed load number
----------------------------------------------------------------------------------------


AS
Update cftFeedLoad
Set Rlsed='1',Rlsed_DateTime=GetDate(),Status='R',Lupd_DateTime=GetDate(),Lupd_Prog='XF213',Lupd_User=@parmuserid,CF03=@parmtime
Where OrdNbr=@parmOrder AND LoadNbr=@parmload



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213UpdateLoad] TO [MSDSL]
    AS [dbo];

