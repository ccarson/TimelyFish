 CREATE PROCEDURE EDSODiscCode_DiscountIDAll @DiscountID varchar(1) AS
select * from sodisccode where discountid like @DiscountID order by discountid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSODiscCode_DiscountIDAll] TO [MSDSL]
    AS [dbo];

