 /****** Object:  Stored Procedure dbo.BankRec_AllRecs    Script Date: 4/7/98 12:49:19 PM ******/
Create Proc BankRec_AllRecs @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24)  as
    Select * from BankRec where CpnyID like @parm1 and Bankacct like @parm2 and Banksub like @parm3
    Order by CpnyID, BankAcct, Banksub, stmtdate


