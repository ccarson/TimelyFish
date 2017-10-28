 create procedure customer_spk9 @parm1 varchar (250) , @parm2 varchar (15)  as
select * from customer
where custid = @parm2
order by custid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[customer_spk9] TO [MSDSL]
    AS [dbo];

