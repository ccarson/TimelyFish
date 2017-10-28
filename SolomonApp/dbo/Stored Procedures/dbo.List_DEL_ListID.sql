 /****** Object:  Stored Procedure dbo.List_DEL_ListID    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.List_DEL_ListID    Script Date: 4/7/98 12:51:20 PM ******/
Create Proc List_DEL_ListID @parm1 varchar ( 40) as
       Delete list from List
           where ListID  LIKE  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[List_DEL_ListID] TO [MSDSL]
    AS [dbo];

