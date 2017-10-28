
CREATE FUNCTION [dbo].[CuryRateTbl] 
( 	
 	@parm1 varchar ( 4), 
	@parm2 varchar ( 4), 
	@parm3 varchar ( 6), 
	@parm4 smalldatetime
)
RETURNS TABLE 
AS
RETURN 
(
 	    Select Top(1) * from CuryRate
        where FromCuryId like @parm1
        and ToCuryId like @parm2
        and RateType like @parm3
        and EffDate <= @parm4
    order by FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC
)


