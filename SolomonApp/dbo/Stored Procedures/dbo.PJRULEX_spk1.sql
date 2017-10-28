 create procedure PJRULEX_spk1 @parm1 varchar (16)   as
select * from PJRULEX
where project =  @parm1
order by project, line_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRULEX_spk1] TO [MSDSL]
    AS [dbo];

