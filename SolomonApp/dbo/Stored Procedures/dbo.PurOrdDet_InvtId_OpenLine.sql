 /****** Object:  Stored Procedure dbo.PurOrdDet_InvtId_OpenLine    Script Date: 4/16/98 7:50:26 PM ******/
create proc PurOrdDet_InvtId_OpenLine @parm1 varchar(30) as
        Select * from PurOrdDet where InvtId = @parm1 And OpenLine = 1
                Order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_InvtId_OpenLine] TO [MSDSL]
    AS [dbo];

