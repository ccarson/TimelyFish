 create procedure PJCOMROL_SPK2 @parm1 varchar (4)  as
select * from PJCOMROL
where    fsyear_num = @parm1
order by fsyear_num,
project,
acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMROL_SPK2] TO [MSDSL]
    AS [dbo];

