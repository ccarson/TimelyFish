 /****** Object:  Stored Procedure dbo.CuryAcTb_Specific    Script Date: 4/7/98 12:43:41 PM ******/
Create Procedure CuryAcTb_Specific @parm1 varchar ( 4), @parm2 varchar ( 10) AS
    Select * from CuryAcTb
    Where CuryAcTb.CuryId = @parm1
    and   CuryAcTb.AdjAcct = @parm2



