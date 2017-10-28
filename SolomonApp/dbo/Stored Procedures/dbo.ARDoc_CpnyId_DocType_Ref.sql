 /****** Object:  Stored Procedure dbo.ARDoc_CpnyId_DocType_Ref    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARDoc_CpnyId_DocType_Ref @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 2), @parm4 varchar ( 10) as
    Select * from ARDoc where
	  CpnyID = @parm1
	  and CustId = @parm2
        and DocType = @parm3
        and refnbr = @parm4
        and rlsed = 1
        order by CustId, DocType, RefNbr


