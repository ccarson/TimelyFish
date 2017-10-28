 /****** Object:  Stored Procedure dbo.Terms_ApplyTo_NoDiscount    Script Date: 1/5/07  ******/
Create Procedure Terms_ApplyTo_NoDiscount
@parm1 varchar (1), @parm2 varchar (2) as
       Select * from Terms
            Where ApplyTo IN (@parm1,'B')
	    and   DiscPct = '0'
            and   TermsID   LIKE @parm2
       Order by TermsID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Terms_ApplyTo_NoDiscount] TO [MSDSL]
    AS [dbo];

