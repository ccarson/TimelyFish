 /****** Object:  Stored Procedure dbo.Acct_Sub_Cpny_Type_Status    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure Acct_Sub_Cpny_Type_Status @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar(10), @parm4 varchar ( 10) AS
Select * from APDoc Where
Acct = @parm1 and
Sub = @parm2 and
CpnyID LIKE @parm3 and
(DocType = 'CK' or DocType = 'HC' or DocType = 'EP') and
Status = 'O' and
Rlsed = 1 and
refnbr like @parm4
order by refnbr, doctype


