
Create Procedure Terms_Single_ApplyTo_w
@parm1 varchar (1), @parm2 varchar (2) as
       Select termsid, descr, DiscPct, DiscIntrv, DiscType, DueIntrv, DueType from Terms 
            Where TermsType = 'S'
            and   ApplyTo IN (@parm1,'B')
            and   TermsID   = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Terms_Single_ApplyTo_w] TO [MSDSL]
    AS [dbo];

