 /****** Object:  Stored Procedure dbo.APDoc_Delete    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_Delete @parm1 varchar ( 255) as
Select * from APDoc where OpenDoc = 0 and Rlsed = 1 and DocClass = 'N'
and PerClosed <= @parm1 and PerClosed <> ' '
Order by OpenDoc, Rlsed, Selected, Status, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Delete] TO [MSDSL]
    AS [dbo];

