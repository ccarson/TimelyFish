 CREATE PROCEDURE EDOutbound_Cust_ASN @parm1 varchar(15)  AS

select * from EDOutbound where custid = @parm1 and  Trans in ('856','857')


