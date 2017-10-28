 create procedure PJBILL_spk0 @parm1 varchar (16)  as
select * from PJBILL
where project = @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_spk0] TO [MSDSL]
    AS [dbo];

