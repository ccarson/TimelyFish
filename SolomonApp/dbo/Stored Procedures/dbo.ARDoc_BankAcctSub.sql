 /****** Object:  Stored Procedure dbo.ARDoc_BankAcctSub    Script Date: 4/7/98 12:49:19 PM ******/
create Proc ARDoc_BankAcctSub @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24) as
select * from ardoc
where cpnyid = @parm1
and bankacct = @parm2
and banksub = @parm3
and Rlsed = 1
Order by Batnbr


