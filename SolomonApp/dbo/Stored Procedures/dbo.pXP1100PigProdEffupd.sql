--*************************************************************
--	Purpose:Update cftPigProdEff records 
--	Author: Jim Maher
--	Date: 10/13/06
--	Usage: PigProdPodMaint\Form1\General\cntrlEffGrid
--	Parms: @parm1 (PodID) 
--	       @parm2 (GenderTypeID)
--             @parm3 (ADG)
--             @parm4 (FeedEfficiency)
--
--	Used in conjunction with the grid on this form.
--	      
--*************************************************************

CREATE PROCEDURE dbo.pXP1100PigProdEffupd
	(@parm1 as varchar(3),
	@parm2 as varchar(1),
	@parm3 as float,
	@parm4 as float)

AS
Update cftPigProdEff set ADG=@parm3, FeedEfficiency=@parm4
where PodID=@parm1 and GenderTypeID=@parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP1100PigProdEffupd] TO [MSDSL]
    AS [dbo];

