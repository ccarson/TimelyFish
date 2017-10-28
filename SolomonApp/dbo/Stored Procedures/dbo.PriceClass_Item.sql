 /****** Object:  Stored Procedure dbo.PriceClass_Item  ******/
Create Proc PriceClass_Item @parm1 varchar ( 6) as
    Select * from PriceClass where PriceClassType = 'I' and PriceClassId like @parm1 order by PriceClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PriceClass_Item] TO [MSDSL]
    AS [dbo];

