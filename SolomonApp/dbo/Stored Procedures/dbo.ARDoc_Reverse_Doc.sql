 Create Procedure ARDoc_Reverse_Doc @parm2 varchar (15), @parm3 varchar ( 10), @parm4 varchar ( 10) as
    Select * from ARDoc where
	CustId = @parm2
        and DocType = @parm3
        and RefNbr = @parm4
        and Rlsed = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Reverse_Doc] TO [MSDSL]
    AS [dbo];

