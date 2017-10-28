 create procedure AR_Balances_spk0 @parm1 varchar (10), @parm2 varchar (15)   as
select * from AR_Balances
where
CpnyId = @parm1 and
CustId = @parm2
order by CpnyId, CustId


