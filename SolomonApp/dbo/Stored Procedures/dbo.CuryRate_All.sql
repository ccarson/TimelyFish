 /****** Object:  Stored Procedure dbo.CuryRate_All    Script Date: 4/7/98 12:43:41 PM ******/
Create Proc CuryRate_All as
    Select * from CuryRate
    order by FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC


