 Create Proc EDSODiscCode_Validate @DiscountId varchar(1) As
Select Count(*) From SODiscCode Where DiscountId = @DiscountId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSODiscCode_Validate] TO [MSDSL]
    AS [dbo];

