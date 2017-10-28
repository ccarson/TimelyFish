 CREATE PROCEDURE EDOutbound_Cust_Invoice @parm1 varchar(15)  AS
select * from EDOutbound where custid = @parm1 and  Trans in ('810','880')


