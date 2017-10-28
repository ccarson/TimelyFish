 /****** Object:  Stored Procedure dbo.PurOrdLSDet_PONbr_LineId_MfgrL                           ******/
Create Proc PurOrdLSDet_PONbr_LineId_MfgrL @parm1 varchar ( 10), @parm2 int, @parm3 varchar(25) as
       Select * from PurOrdLSDet
                where PONbr = @parm1
                  and LineId = @parm2
                  and MfgrLotSerNbr = @parm3
                Order By PoNbr, LineId, MfgrLotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_PONbr_LineId_MfgrL] TO [MSDSL]
    AS [dbo];

