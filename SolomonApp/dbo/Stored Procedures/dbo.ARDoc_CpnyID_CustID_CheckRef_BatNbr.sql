 Create Procedure ARDoc_CpnyID_CustID_CheckRef_BatNbr @parm1 varchar ( 10), @parm2 varchar (15), @parm3 varchar ( 10), @parm4 varchar(10) as
    Select * from ARDoc where
        CpnyID like @parm1
        and CustId like @parm2
        and DocType  in ('PA', 'PP')
        and RefNbr like @parm3
        and BatNbr like @parm4
        order by CustId, DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_CpnyID_CustID_CheckRef_BatNbr] TO [MSDSL]
    AS [dbo];

