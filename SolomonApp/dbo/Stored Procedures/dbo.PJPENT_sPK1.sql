 create procedure PJPENT_sPK1 @parm1 varchar (16) , @PARM2 varchar (32)   as
select * from PJPENT
where    project     =     @parm1
and    pjt_entity  like  @parm2
and    status_pa   =    'A'
order by project,
pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sPK1] TO [MSDSL]
    AS [dbo];

