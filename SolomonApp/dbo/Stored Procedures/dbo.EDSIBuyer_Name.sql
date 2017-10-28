 CREATE Proc EDSIBuyer_Name @Buyer varchar(10) As
Select Buyer, BuyerName From SIBuyer Where Buyer = @Buyer


