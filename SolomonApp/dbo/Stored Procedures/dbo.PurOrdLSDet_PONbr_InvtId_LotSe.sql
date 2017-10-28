
/****** Object:  Stored Procedure dbo.PurOrdLSDet_PONbr_InvtId_LotSe                           ******/
Create Proc PurOrdLSDet_PONbr_InvtId_LotSe @parm1 varchar ( 10), @parm2 int, @parm3 varchar (30), @parm4 varchar(25) as
       Select * from PurOrdLSDet
                where PONbr = @parm1
                  and LineId = @parm2
                  and InvtId = @parm3
                  and LotSerNbr = @parm4
                order by PONbr, LineId, InvtId, LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_PONbr_InvtId_LotSe] TO [MSDSL]
    AS [dbo];

