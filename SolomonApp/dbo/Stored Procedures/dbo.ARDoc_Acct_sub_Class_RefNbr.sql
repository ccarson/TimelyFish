 /****** Object:  Stored Procedure dbo.ARDoc_Acct_sub_Class_RefNbr    Script Date: 4/7/98 12:49:19 PM ******/
Create Procedure ARDoc_Acct_sub_Class_RefNbr
@parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 varchar ( 1), @parm5 varchar ( 10) as
Select * from ARDoc where cpnyid = @parm1 and bankacct = @parm2 and banksub = @parm3
and DocClass = @parm4
and RefNbr like @parm5
and DocType IN ('PA')
Order by RefNbr


