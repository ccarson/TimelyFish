 /****** Object:  Stored Procedure dbo.PriceClass_Customer   ******/
Create Proc PriceClass_Customer @parm1 varchar ( 6) as
    Select * from PriceClass where PriceClassType = 'C' and PriceClassId like @parm1 order by PriceClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PriceClass_Customer] TO [MSDSL]
    AS [dbo];

