 /****** Object:  Stored Procedure dbo.ARDoc_CpnyId_DocType_Cury_Ref    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CpnyId_DocType_Cury_Ref2 @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 4), @parm5 varchar ( 10), @parm6 varchar (10) as
    Select * from ARDoc where
	  CpnyID like @parm1
	  and CustId = @parm2
        and DocType = @parm3
        and CuryId = @parm4
		and ((ApplBatNbr = @parm5 and ApplBatNbr <> '') or (ApplBatNbr = '' and Rlsed = 1 and CuryDocBal <> 0))
		and refnbr like @parm6
		order by CustId, DocType, RefNbr


