 create procedure PJBUDSUM_dpjtpln @parm1 varchar (16) , @parm2 varchar (2)   as
Delete from PJBUDSUM
WHERE
project = @parm1 and
planNbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBUDSUM_dpjtpln] TO [MSDSL]
    AS [dbo];

