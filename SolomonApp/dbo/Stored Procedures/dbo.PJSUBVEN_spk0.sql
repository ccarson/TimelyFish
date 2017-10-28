 create procedure PJSUBVEN_spk0 @parm1 varchar (15)  as
select * from PJSUBVEN
where vendid = @parm1
order by vendid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBVEN_spk0] TO [MSDSL]
    AS [dbo];

