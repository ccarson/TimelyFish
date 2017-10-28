 Create Proc PRDoc_BatNbr_EmpID @parm1 varchar ( 10), @parm2 varchar ( 10) as
        Select * from PRDoc where BatNbr = @parm1 and EmpID = @parm2 and
        Status <> 'V'
        order by BatNbr, EmpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_BatNbr_EmpID] TO [MSDSL]
    AS [dbo];

