 Create Proc EDDiscCode_DiscountId @Direction varchar(1), @CustId varchar(15), @SpecChgCode varchar(5) As
Select DiscountId From EDDiscCode Where Direction = @Direction And CustId In ('*',@CustId) And
SpecChgCode = @SpecChgCode Order By DiscountType Desc


