 create procedure PJCOMSUM_SPK2 @parm1 varchar (4)  as
select * from PJCOMSUM
where    fsyear_num = @parm1
order by fsyear_num,
project,
pjt_entity,
acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMSUM_SPK2] TO [MSDSL]
    AS [dbo];

