 /****** Object:  Stored Procedure dbo.TermsDet_DEL_TermsID    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc TermsDet_DEL_TermsID @parm1 varchar (2) As
     Delete from TermsDet
     Where TermsID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TermsDet_DEL_TermsID] TO [MSDSL]
    AS [dbo];

