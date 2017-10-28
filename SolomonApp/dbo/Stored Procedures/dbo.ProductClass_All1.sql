 /****** Object:  Stored Procedure dbo.ProductClass_All1    Script Date: 4/4/05 7:41:53 AM ******/
Create Proc ProductClass_All1 @parm1 varchar ( 6) as
    SELECT *
      FROM ProductClass
     WHERE ClassId like @parm1
       AND (PFOvhMatlRate <> 0 OR PVOvhMatlRate <> 0)
     ORDER BY ClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProductClass_All1] TO [MSDSL]
    AS [dbo];

