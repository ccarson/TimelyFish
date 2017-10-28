 /****** Object:  Stored Procedure dbo.PStatus_by_PID1    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.PStatus_by_PID1    Script Date: 4/7/98 12:56:04 PM ******/
Create Proc  PStatus_by_PID1 @parm1 varchar ( 10), @parm2 varchar ( 47), @parm3 varchar ( 21), @parm4 smallint, @parm5 varchar ( 1) as
Select * from PStatus
WHERE PID               like @parm1
AND   UserId            like @parm2
AND   InternetAddress   like @parm3
AND   SessionCntr          = @parm4
AND   Status            like @parm5
           order by PID,
                    UserId,
                    InternetAddress,
                    SessionCntr


