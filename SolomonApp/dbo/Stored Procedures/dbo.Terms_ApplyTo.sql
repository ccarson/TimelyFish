 /****** Object:  Stored Procedure dbo.Terms_ApplyTo    Script Date: 4/7/98 12:42:26 PM ******/
Create Procedure Terms_ApplyTo
@parm1 varchar (1), @parm2 varchar (2) as
       Select * from Terms
            Where ApplyTo IN (@parm1,'B')
            and   TermsID   LIKE @parm2
       Order by TermsID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Terms_ApplyTo] TO [MSDSL]
    AS [dbo];

