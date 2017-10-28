 /****** Object:  Stored Procedure dbo.Terms_No_Installment    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc Terms_No_Installment @parm1 varchar ( 1), @parm2 varchar(2) as
    Select * from Terms where  ApplyTo IN (@parm1,'B') and TermsType <> 'M' and TermsId like @parm2  order by TermsId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Terms_No_Installment] TO [MSDSL]
    AS [dbo];

