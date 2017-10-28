 /****** Object:  Stored Procedure dbo.APDoc_Acct_Sub_DocType_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_Acct_Sub_DocType_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10) as
Select * from APDoc where Acct = @parm1
and Sub = @parm2
and DocType in ('HC','EP', 'CK', 'ZC')
and Status Not In ('V')
and Rlsed = 1
and RefNbr like @parm3
order by Acct, Sub, DocType, RefNbr


