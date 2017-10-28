--*************************************************************
--	Purpose: Find the group inventory by date
--	Author: Sue Matter
--	Date: 8/26/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (transaction date)
--	       
--*************************************************************

CREATE   PROCEDURE cfpGroupDate
		@parm1 smalldatetime
	AS
	SELECT t.*
		from cfv_PigGroup_InvDate2 t
		JOIN cftPGInvTran tr ON t.GroupID=tr.PigGroupID
		Where tr.Reversal<>'1' AND tr.TranDate<=@parm1


 
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfpGroupDate] TO [SE\Analysts]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpGroupDate] TO [MSDSL]
    AS [dbo];

