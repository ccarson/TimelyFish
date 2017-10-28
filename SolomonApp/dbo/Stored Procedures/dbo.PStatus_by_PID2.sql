 /****** Object:  Stored Procedure dbo.PStatus_by_PID2    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.PStatus_by_PID2    Script Date: 4/7/98 12:56:04 PM ******/
Create Proc  PStatus_by_PID2 @parm1 varchar ( 10), @parm2 varchar ( 47), @parm3 varchar ( 21) as
Select * from PStatus
WHERE PID               like @parm1

AND   UserId            like @parm2
AND   InternetAddress   like @parm3
AND   Status            <> 'S'
           order by PID,
                    UserId,
                    InternetAddress


