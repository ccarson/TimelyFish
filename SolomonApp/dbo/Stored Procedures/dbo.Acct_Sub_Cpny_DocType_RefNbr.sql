 /****** Object:  Stored Procedure dbo.Acct_Sub_Cpny_DocType_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure Acct_Sub_Cpny_DocType_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10), @parm4 varchar (10) as
Select * from APDoc where Acct = @parm1
and Sub = @parm2
and CpnyID LIKE @parm3
and DocType in ('EP','HC', 'CK', 'ZC')
and Status Not In ('V')
and Rlsed = 1
and RefNbr like @parm4
order by Acct, Sub, DocType, RefNbr


