 Create Proc CashAcct_By_Name_Secure @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 4), @parm4 varchar(47), @parm5 varchar(7), @parm6 varchar(1), @parm7 varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
select *
from CashAcct inner loop join  Currncy on cashacct.curyid = currncy.curyid
where bankacct like @parm1
and banksub like @parm2
and CashAcct.curyid like @parm3
and cpnyid like @parm7
and active =  1

and cpnyid in
(select Cpnyid
from  vs_share_usercpny
where userid = @parm4
and screennumber = @parm5+'00'
and seclevel >= @parm6
and cpnyid like @parm7)

order by CpnyID, BankAcct, Banksub


