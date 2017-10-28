
--*************************************************************
--	Purpose:Reverse project entry
--	Author: Sue Matter
--	Date: 12/26/2005
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr), @parm2 (LineNbr)
--	      
--*************************************************************

CREATE PROCEDURE pXP135PJCHARGDRev
	@parm1 varchar(10), @parm2 As Integer
	AS
	Select p.* 
	from pjchargd p
	Where p.batch_id = @parm1
	AND p.detail_num = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PJCHARGDRev] TO [MSDSL]
    AS [dbo];

