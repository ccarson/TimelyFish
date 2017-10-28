 /****** Object:  Stored Procedure dbo.BankTran_ImportRef    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc BankTran_ImportRef @parm1 varchar ( 20) as
Select * from BankTran
where ImportRef like @parm1


