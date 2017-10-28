 /****** Object:  Stored Procedure dbo.Update_ARTran_ARAdjust1    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure Update_ARTran_ARAdjust1 @parm1 smalldatetime, @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 10) as
    UPDATE ARAdjust
    SET ARAdjust.AdjgDocDate = @parm1
    from ARAdjust, ARTran WHERE ARAdjust.Custid = @parm2
        AND ARAdjust.AdjgDocType = @Parm3
        AND ARAdjust.AdjgRefNbr = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ARTran_ARAdjust1] TO [MSDSL]
    AS [dbo];

