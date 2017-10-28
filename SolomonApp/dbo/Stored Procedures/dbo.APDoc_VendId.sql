 /****** Object:  Stored Procedure dbo.APDoc_VendId    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APDoc_VendId @parm1 varchar ( 15) As
Select * from APDoc where VendId = @parm1
Order by VendID, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_VendId] TO [MSDSL]
    AS [dbo];

