 /****** Object:  Stored Procedure dbo.TermsDet_TermsID_InstallNbr    Script Date: 4/7/98 12:42:26 PM ******/
Create Procedure TermsDet_TermsID_InstallNbr
@parm1 varchar (2), @parm2beg smallint, @parm2end smallint as
Select * from TermsDet where TermsID = @parm1 and InstallNbr Between @parm2beg and @parm2end
Order by TermsID, InstallNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TermsDet_TermsID_InstallNbr] TO [MSDSL]
    AS [dbo];

