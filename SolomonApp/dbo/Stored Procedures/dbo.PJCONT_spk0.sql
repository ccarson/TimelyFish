 create procedure PJCONT_spk0 @parm1 varchar (16)  as
select * from PJCONT
where contract = @parm1
order by contract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONT_spk0] TO [MSDSL]
    AS [dbo];

