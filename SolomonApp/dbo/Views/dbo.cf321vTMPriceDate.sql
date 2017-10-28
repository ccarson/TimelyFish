
Create View cf321vTMPriceDate 
as
Select Distinct convert(varchar(10),DateEff,101) as DateLookup, DateEff, MillID
FRom cftTMPricing 

