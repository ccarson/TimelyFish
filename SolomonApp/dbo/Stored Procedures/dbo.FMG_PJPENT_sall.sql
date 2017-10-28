 create procedure FMG_PJPENT_sall @parm1 varchar (16) , @PARM2 varchar (32)   as
select * from PJPENT
where project =  @parm1 and
pjt_entity Like  @parm2 and
status_pa = 'A' and
status_ar = 'A'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_PJPENT_sall] TO [MSDSL]
    AS [dbo];

