 /****** Object:  Stored Procedure dbo.PODeptAppr_Dbnav    Script Date: 12/17/97 10:48:30 AM ******/
Create Procedure PODeptAppr_Dbnav @Parm1 Varchar(10), @Parm2Beg SmallDateTime, @Parm2end SmallDateTime, @Parm3 Varchar(2), @Parm4 Varchar(2), @Parm5 Varchar(2), @Parm6 Varchar(1)
 as
Select * from PODeptAppr  where DeptID  = @parm1 and
 DocType Like @Parm4 and
 RequestType Like @Parm5 and
 Budgeted LIKE @Parm6 and
 Authority Like @Parm3 and
 effdate BETWEEN @Parm2Beg AND @Parm2End
 Order by DeptId, Doctype, RequestType, Budgeted, Authority, effdate


