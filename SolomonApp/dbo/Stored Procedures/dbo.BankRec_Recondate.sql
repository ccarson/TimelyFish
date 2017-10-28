 /****** Object:  Stored Procedure dbo.BankRec_Recondate    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc BankRec_Recondate @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24) as
Select * from BankRec
where cpnyid like @parm1
and Bankacct like @parm2
and Banksub like @parm3
Order by BankAcct DESC, Banksub DESC, ReconDate desc


