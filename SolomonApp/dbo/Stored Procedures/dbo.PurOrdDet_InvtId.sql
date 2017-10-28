 /****** Object:  Stored Procedure dbo.PurOrdDet_InvtId    Script Date: 4/16/98 7:50:26 PM ******/
create proc PurOrdDet_InvtId @parm1 varchar ( 30) as
        Select * from PurOrdDet where InvtId = @parm1
                Order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_InvtId] TO [MSDSL]
    AS [dbo];

