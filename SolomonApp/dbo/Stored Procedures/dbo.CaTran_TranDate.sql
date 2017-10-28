 /****** Object:  Stored Procedure dbo.CaTran_TranDate    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CaTran_TranDate @parm1 varchar ( 10), @parm2 varchar(10), @Parm3 varchar ( 24), @parm4 smalldatetime  as
    Select * from CaTran where cpnyid like @parm1 and bankacct like @parm2 and banksub like @parm3
   and trandate = @parm4 and rlsed =  1     and entryid <> 'ZZ'
     Order by cpnyid, BankAcct, Banksub, trandate


