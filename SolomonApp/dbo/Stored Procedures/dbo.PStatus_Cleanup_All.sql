 /****** Object:  Stored Procedure dbo.PStatus_Cleanup_All    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.PStatus_Cleanup_All    Script Date: 4/7/98 12:56:04 PM ******/
Create Proc  PStatus_Cleanup_All @parm1 varchar ( 21) as
Update PStatus set Status = 'I'
WHERE InternetAddress   like @parm1
AND   Status            = 'S'


