 /****** Object:  Stored Procedure dbo.ARDoc_CpnyID_Type_Ref2    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_CpnyID_Type_Ref2 @parm1 varchar ( 10), @parm2 varchar (15), @parm3 varchar ( 10), @parm4 varchar ( 10) as
    Select * from ARDoc where
        CpnyID like @parm1
        and CustId = @parm2
        and DocType like @parm3
        and RefNbr like @parm4
        order by CustId, DocType, RefNbr


