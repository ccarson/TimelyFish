 CREATE Proc EDSalesTax_850Info @TaxId varchar(10) As
Select TaxId, FilingLoc, Case Exemption When 'Y' Then '1' Else '2' End, TaxRate, LocalCode, User1,
User2, User3, User4, User5, User6, User7, User8 From SalesTax Where TaxId = @TaxId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSalesTax_850Info] TO [MSDSL]
    AS [dbo];

