 create procedure Customer_spk0 @parm1 varchar (15)  as
select * from Customer
where CustId = @parm1
order by CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_spk0] TO [MSDSL]
    AS [dbo];

