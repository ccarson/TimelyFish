 create procedure PJTEXT_Sall  @parm1 varchar (4)   as
select * from PJTEXT
where    msg_num Like  @parm1
order by   msg_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTEXT_Sall] TO [MSDSL]
    AS [dbo];

