 Create Proc EDDiscCode_SpecChgCodeHandling @CustId varchar(15), @DiscountId varchar(1) As
Select SpecChgCode, HandlingMethod From EDDiscCode Where Direction = 'O' And
CustId In ('*',@CustId) And DiscountId = @DiscountId Order By DiscountType Desc


