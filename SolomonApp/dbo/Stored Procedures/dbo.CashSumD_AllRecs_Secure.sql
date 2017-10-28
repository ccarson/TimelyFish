 Create Proc CashSumD_AllRecs_Secure @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 varchar(47), @parm5 varchar(7), @parm6 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select * from CashSumD
where bankacct like @parm2
and banksub like @parm3

and cpnyid in
(select Cpnyid
from vs_share_usercpny
where userid = @parm4
and scrn = @parm5
and seclevel >= @parm6
and cpnyid like @parm1)

Order by CpnyID, BankAcct, Banksub, trandate


