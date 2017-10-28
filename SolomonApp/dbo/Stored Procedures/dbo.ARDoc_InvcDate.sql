 /****** Object:  Stored Procedure dbo.ARDoc_InvcDate    Script Date: 4/7/98 12:49:19 PM ******/
Create Proc ARDoc_InvcDate @parm1 smalldatetime, @parm2 smalldatetime as
Select * from ARDoc where Docdate between @parm1 and @parm2
Order by CpnyID, BankAcct, Banksub, Refnbr


