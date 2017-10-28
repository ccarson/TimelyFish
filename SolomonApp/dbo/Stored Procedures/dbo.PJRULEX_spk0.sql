 create procedure PJRULEX_spk0 @parm1 varchar (16) , @parm2beg smallint , @parm2end smallint   as
select * from PJRULEX
where project =  @parm1 and
line_num  between  @parm2beg and @parm2end
order by project, line_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRULEX_spk0] TO [MSDSL]
    AS [dbo];

