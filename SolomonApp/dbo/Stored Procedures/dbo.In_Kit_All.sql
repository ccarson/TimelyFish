 /****** Object:  Stored Procedure dbo.In_Kit_All    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.In_Kit_All    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc In_Kit_All @parm1 varchar ( 30) as
Select * from Kit where KitType = '' and KitId like @parm1
order by KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[In_Kit_All] TO [MSDSL]
    AS [dbo];

