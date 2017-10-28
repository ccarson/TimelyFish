 create procedure PJPENT_spkLB @parm1 varchar (16) , @PARM2 varchar (32)  as
SELECT * from PJPENT
WHERE
project =  @parm1 and
pjt_entity Like  @parm2 and
status_pa = 'A' and
status_lb = 'A'
ORDER BY
project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_spkLB] TO [MSDSL]
    AS [dbo];

