 create procedure PJLABDIS_SI01 @parm1 varchar (6)  as
select  Count(*) from PJLABDIS
where   fiscalno =  @parm1 and
status_gl = 'U'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_SI01] TO [MSDSL]
    AS [dbo];

