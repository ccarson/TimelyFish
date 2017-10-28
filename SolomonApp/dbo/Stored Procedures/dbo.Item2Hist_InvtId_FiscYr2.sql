 /****** Object:  Stored Procedure dbo.Item2Hist_InvtId_FiscYr2    Script Date: 9/11/98     ******/
Create Procedure Item2Hist_InvtId_FiscYr2 @parm1 varchar ( 30), @parm2 varchar ( 10) , @parm3 varchar (04) As
Select * from Item2Hist Where
        InvtID = @parm1 And
        SiteID = @parm2 And
	FiscYR = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Item2Hist_InvtId_FiscYr2] TO [MSDSL]
    AS [dbo];

