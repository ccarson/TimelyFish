 /****** Object:  Stored Procedure dbo.TermsDet_TermsID    Script Date: 4/7/98 12:42:26 PM ******/
Create Procedure TermsDet_TermsID
@parm1 varchar (2) as
Select * from TermsDet where TermsID = @parm1
Order by TermsID, InstallNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TermsDet_TermsID] TO [MSDSL]
    AS [dbo];

