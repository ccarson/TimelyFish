 /****** Object:  Stored Procedure dbo.ARDoc_DueDate    Script Date: 4/7/98 12:49:19 PM ******/
Create Proc ARDoc_DueDate @parm1 smalldatetime, @parm2 smalldatetime as
Select * from ARDoc where duedate between @parm1
 and @parm2
Order by CpnyID, BankAcct, Banksub, Refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_DueDate] TO [MSDSL]
    AS [dbo];

