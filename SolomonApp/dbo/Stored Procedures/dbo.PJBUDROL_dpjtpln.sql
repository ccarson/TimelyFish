 create procedure PJBUDROL_dpjtpln @parm1 varchar (16) , @parm2 varchar (2)   as
Delete from PJBUDROL
WHERE
project = @parm1 and
plannBR = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBUDROL_dpjtpln] TO [MSDSL]
    AS [dbo];

