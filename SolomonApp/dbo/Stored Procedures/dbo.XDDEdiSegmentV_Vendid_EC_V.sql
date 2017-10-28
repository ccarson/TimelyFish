CREATE PROCEDURE XDDEdiSegmentV_Vendid_EC_V 
	@VendID		varchar(15), 
	@VendAcct	varchar(10),
	@EntryClass	varchar(4), 
	@EDIVersion	varchar(6)
AS
  Select * from XDDEdiSegmentV 
	where Vendid = @VendID
	and VendAcct = @VendAcct
	and EntryClass = @EntryClass
	and EdiVersion = @EDIVersion
  ORDER by Section, SeqNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDEdiSegmentV_Vendid_EC_V] TO [MSDSL]
    AS [dbo];

