 create procedure Subacct_spk0 @parm1 varchar (24)  as
select * from Subacct
where Sub = @parm1
order by Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Subacct_spk0] TO [MSDSL]
    AS [dbo];

