CREATE PROCEDURE XDDEdiDataElemV_Vendid_V_S 
	@VendID 	varchar(15),
	@VendAcct	varchar(10), 
	@EDIVersion	varchar(6), 
	@SegID		varchar(3)
AS
  	Select * from XDDEdiDataElemV, XDDEdiDataElem 
	where XDDEdiDataElemV.EdiVersion = XDDEdiDataElem.EdiVersion 
		and XDDEdiDataElemV.DataElemRN = XDDEdiDataElem.DataElemRN 
		and XDDEdiDataElemV.Vendid = @VendID
		and XDDEdiDataElemV.VendAcct = @VendAcct 
		and XDDEdiDataElemV.EdiVersion = @EDIVersion
		and XDDEdiDataElemV.SegID = @SegID
  	ORDER by XDDEdiDataElemV.SeqNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDEdiDataElemV_Vendid_V_S] TO [MSDSL]
    AS [dbo];

