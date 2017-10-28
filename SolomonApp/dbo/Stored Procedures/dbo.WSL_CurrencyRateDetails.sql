
Create Proc [dbo].[WSL_CurrencyRateDetails] @parm1 varchar ( 4), @parm2 varchar ( 4), @parm3 smalldatetime as
    Select top 1 CuryRate.* from CuryRate inner join cmsetup on RateType = cmsetup.APRtTpDflt
        where FromCuryId like @parm1
        and ToCuryId like @parm2
        and EffDate <= @parm3
		 
    order by FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC
