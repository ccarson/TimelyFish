 create procedure PJTEXT_SPK0  @parm1 varchar (4)   as
select * from PJTEXT
where  msg_num  =  @parm1
order by    msg_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTEXT_SPK0] TO [MSDSL]
    AS [dbo];

