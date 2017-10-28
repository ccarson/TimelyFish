 /****** Object:  Stored Procedure dbo.Terms_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc Terms_All @parm1 varchar ( 2) as
    Select * from Terms where TermsId like @parm1 order by TermsId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Terms_All] TO [MSDSL]
    AS [dbo];

