 /****** Object:  Stored Procedure dbo.Terms_Descr    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc Terms_Descr @parm1 varchar (2) As
     Select Descr from Terms
     Where TermsID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Terms_Descr] TO [MSDSL]
    AS [dbo];

