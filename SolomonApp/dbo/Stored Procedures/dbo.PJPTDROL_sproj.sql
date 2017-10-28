 create procedure PJPTDROL_sproj @parm1 varchar (16)   as
select * from  PJPTDROL
where PJPTDROL.project =  @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sproj] TO [MSDSL]
    AS [dbo];

