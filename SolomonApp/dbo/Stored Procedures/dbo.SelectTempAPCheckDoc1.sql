 /****** Object:  Stored Procedure dbo.SelectTempAPCheckDoc1    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure SelectTempAPCheckDoc1 @parm1 varchar ( 15), @parm2 varchar ( 15) As
Select * From APCheck
Where VendId = @parm1 and
CheckRefNbr = @parm2 and
Status = 'T'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SelectTempAPCheckDoc1] TO [MSDSL]
    AS [dbo];

