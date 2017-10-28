 /****** Object:  Stored Procedure dbo.Delete_SOAddress    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Delete_SOAddress @parm1 varchar(15) as
    Delete from SOAddress where CustID = @parm1


