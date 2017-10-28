 create procedure PJBUDSUM_spk0 @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (32) , @parm4 varchar (16) , @parm5 varchar (2)   as
SELECT * from PJBUDSUM
WHERE
fsyear_num = @parm1 and
project  =  @parm2 and
pjt_entity  =  @parm3 and
acct = @parm4 and
planNbr = @parm5
ORDER BY
fsyear_num,
project,
pjt_entity,
Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBUDSUM_spk0] TO [MSDSL]
    AS [dbo];

