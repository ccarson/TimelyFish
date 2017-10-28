 /****** Object:  Stored Procedure dbo.ARDoc_CustId_DocType_Cury_Ref    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CustId_DocType_Cury_Ref @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 4), @parm4 varchar ( 10) as
    Select * from ARDoc where CustId = @parm1
        and DocType = @parm2
        and CuryId = @parm3
        and refnbr = @parm4
        and curydocbal <> 0
        and rlsed = 1
        order by CustId, DocType, RefNbr


