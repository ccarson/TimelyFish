 CREATE PROCEDURE EDSODiscCode_SingleDiscountID @DiscountID varchar(1) AS
select discountID, Descr  from sodisccode where discountid like @DiscountID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSODiscCode_SingleDiscountID] TO [MSDSL]
    AS [dbo];

