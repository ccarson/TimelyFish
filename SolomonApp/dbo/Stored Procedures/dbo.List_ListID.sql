 /****** Object:  Stored Procedure dbo.List_ListID    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.List_ListID    Script Date: 4/7/98 12:51:20 PM ******/
Create Proc List_ListID @parm1 varchar ( 40) as
       Select * from List
           where ListID  LIKE  @parm1
           order by ListID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[List_ListID] TO [MSDSL]
    AS [dbo];

