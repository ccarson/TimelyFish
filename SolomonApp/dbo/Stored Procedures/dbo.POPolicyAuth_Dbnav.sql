 /****** Object:  Stored Procedure dbo.POPolicyAuth_Dbnav    Script Date: 12/17/97 10:48:30 AM ******/
Create Procedure POPolicyAuth_Dbnav @Parm1 Varchar(10), @Parm2Beg SmallDateTime, @Parm2end SmallDateTime, @Parm3 Varchar(2), @Parm4 Varchar(2), @Parm5 Varchar(2), @Parm6 Varchar(10), @Parm7 Varchar(47)
 as
Select * from POPolicyAuth  where
 PolicyID  = @parm1 and
 DocType Like @Parm4 and
 RequestType Like @Parm5 and
 MaterialType LIKE @Parm6 and
 Authority Like @Parm3 and
 effdate BETWEEN @Parm2Beg AND @Parm2End and
 UserID Like @Parm7
 Order by PolicyID, Doctype, RequestType, MaterialType, Authority, effdate, UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPolicyAuth_Dbnav] TO [MSDSL]
    AS [dbo];

