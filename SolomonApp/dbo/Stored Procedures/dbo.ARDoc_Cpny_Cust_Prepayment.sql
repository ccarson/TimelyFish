 /****** Object:  Stored Procedure dbo.ARDoc_Cpny_Cust_Prepayment    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARDoc_Cpny_Cust_Prepayment  @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4 varchar ( 2), @parm5 varchar ( 4), @parm6 varchar ( 10) as
    Select * from ARDoc where
    	CpnyID = @parm1
    	and CustId like @parm2
        and docclass = @parm3
        and doctype like @parm4
		and CuryId = @parm5
        and RefNbr like @parm6
        order by CustId, DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Cpny_Cust_Prepayment] TO [MSDSL]
    AS [dbo];

