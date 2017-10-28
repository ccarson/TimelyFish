 /****** Object:  Stored Procedure dbo.TempCheckDocAllBat2    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure TempCheckDocAllBat2 @parm1 varchar ( 10)  As
Select * From APCheck Where
BatNbr = @parm1
Order By APCheck.VendId, APCheck.CheckRefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TempCheckDocAllBat2] TO [MSDSL]
    AS [dbo];

