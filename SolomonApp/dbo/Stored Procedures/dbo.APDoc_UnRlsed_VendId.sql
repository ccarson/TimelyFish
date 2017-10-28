 /****** Object:  Stored Procedure dbo.APDoc_UnRlsed_VendId    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_UnRlsed_VendId @parm1 varchar ( 15) As
Select * from APDoc where
APDoc.VendId = @parm1 and APDoc.Rlsed = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_UnRlsed_VendId] TO [MSDSL]
    AS [dbo];

