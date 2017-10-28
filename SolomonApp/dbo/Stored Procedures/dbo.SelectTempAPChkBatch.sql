 --- DCR 4/20/98 Add cpnyid to the parms
/****** Object:  Stored Procedure dbo.SelectTempAPChkBatch    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure SelectTempAPChkBatch @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 10), @parm4 varchar (1)  As
Select * From APCheck
Where APCheck.BatNbr = @parm1 and
APCheck.Vendid = @parm2 and
APCheck.CpnyID = @parm3 and
APCheck.PmtMethod = @parm4
Order By APCheck.VendId, APCheck.CheckRefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SelectTempAPChkBatch] TO [MSDSL]
    AS [dbo];

