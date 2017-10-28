
create procedure PJPENT_sPK3_w @parm1 varchar (16) , @PARM2 varchar (32)  as
SELECT pe_id01, pjt_entity, pjt_entity_desc from PJPENT
WHERE    project =  @parm1 and
pjt_entity =  @parm2 and
status_pa = 'A' and
status_ap = 'A'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sPK3_w] TO [MSDSL]
    AS [dbo];

