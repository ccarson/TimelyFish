 /****** Object:  Stored Procedure dbo.POPolicyAppr_Dbnav    Script Date: 12/17/97 10:48:30 AM ******/
Create Procedure POPolicyAppr_Dbnav @Parm1 Varchar(10), @Parm2Beg SmallDateTime, @Parm2end SmallDateTime, @Parm3 Varchar(2), @Parm4 Varchar(2), @Parm5 Varchar(2), @Parm6 Varchar(10)
 as
Select * from POPolicyAppr  where PolicyID = @parm1 and
 DocType Like @Parm4 and
 RequestType Like @Parm5 and
 MaterialType LIKE @Parm6 and
 Authority Like @Parm3 and
 effdate BETWEEN @Parm2Beg AND @Parm2End
 Order by PolicyID, Doctype, RequestType, MaterialType, Authority, effdate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPolicyAppr_Dbnav] TO [MSDSL]
    AS [dbo];

