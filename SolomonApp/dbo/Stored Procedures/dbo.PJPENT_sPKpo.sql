 create procedure PJPENT_sPKpo @parm1 varchar (16) , @PARM2 varchar (32)  as
SELECT * from PJPENT
WHERE    project =  @parm1 and
pjt_entity =  @parm2 and
status_pa = 'A' and
status_po = 'A'
ORDER BY project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sPKpo] TO [MSDSL]
    AS [dbo];

