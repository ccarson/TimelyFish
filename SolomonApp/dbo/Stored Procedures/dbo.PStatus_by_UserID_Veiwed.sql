 /****** Object:  Stored Procedure dbo.PStatus_by_UserID_Veiwed    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.PStatus_by_UserID_Veiwed    Script Date: 4/7/98 12:56:04 PM ******/
Create Proc  PStatus_by_UserID_Veiwed @parm1 varchar ( 47) as
Select * from PStatus
WHERE UserId   like @parm1
AND   ViewDate = ''
AND   Status            <> 'S'
           order by PID,
                    UserId,
                    InternetAddress


