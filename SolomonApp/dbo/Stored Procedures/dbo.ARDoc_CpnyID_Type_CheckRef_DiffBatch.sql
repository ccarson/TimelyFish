 Create Procedure ARDoc_CpnyID_Type_CheckRef_DiffBatch @parm1 varchar ( 10), @parm2 varchar (15), @parm3 varchar ( 10), @parm4 varchar ( 10), @parm5 varchar(10) as
    Select * from ARDoc where
        CpnyID like @parm1
        and CustId = @parm2
        and DocType like @parm3
        and RefNbr like @parm4
        and BatNbr <> @parm5
        order by CustId, DocType, RefNbr


