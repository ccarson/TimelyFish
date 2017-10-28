 create procedure refnbr_spk0 @parm1 varchar (10) as
select * from refnbr
where RefNbr = @parm1
order by RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[refnbr_spk0] TO [MSDSL]
    AS [dbo];

