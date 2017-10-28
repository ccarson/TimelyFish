CREATE Procedure [dbo].[cfpInsertsmSOAddress]
	@UserID varchar(10),
	@CustID varchar(15),
	@ShipToID varchar(10)

	AS

	IF NOT Exists (Select * from smSOAddress Where CustID = @CustID and ShipToID = @ShipToID)

	INSERT INTO smSOAddress(
	BlanketPONbr, BranchID, CreatedBy, CreatedDate, Crtd_DateTime, Crtd_User, Ctrd_Prog, CustID,
	DefaultCallType, DefaultPrcPlanID, DefaultProjManager, DefaultPytMethod, DefaultSalesPerson,
	DefaultStatusID, DefaultTechnician, DwellingType, GeographicZone, LabMarkupID, Latitude, 
	Longitude, Lupd_DateTime, Lupd_Prog, Lupd_User, MapCoordinates, MapPage, MatMarkupID, 
	MaxServAmount, OriginalMediaID, POEndDate, POStartDate, POOption, PrintFlag, Priority, RouteID,
	SecurityEntryCode, ShiptoID, Sub, TaxID, TenantAuthorizeCall, TImeZone, User1,
	User2, User3, User4, User5, User6, User7, User8)

	SELECT BlanketPONbr = '', BranchID = 'CFF', CreatedBy = 'SQLSP', CreatedDate = GetDate(), 
	Crtd_DateTime = GetDate(), Crtd_User = @UserID, Ctrd_Prog = 'SQLSP', CustID = @CustID, 
	DefaultCallType = 'RP', DefaultPrcPlanID = '', DefaultProjManager= '', DefaultPytMethod = '', 
	DefaultSalesPerson = 'NA', DefaultStatusID = 'OPEN', DefaultTechnician = '', DwellingType = '', 
	GeographicZone = 'BROWN', LabMarkupID = '20', Latitude = '', Longitude = '', Lupd_DateTime = GetDate(), 
	Lupd_Prog = 'SQLSP', Lupd_User = @UserID, MapCoordinates = '', MapPage = '', MatMarkupID = '', MaxServAmount = 0,
	OriginalMediaID = '', POEndDate = '', POStartDate ='', POOption = 'O', PrintFlag = 0, Priority = 2,
	RouteID = '', SecurityEntryCode = '', ShiptoID = @ShipToID , Sub = '', TaxID = 'MN', TenantAuthorizeCall = 'Y',
	TImeZone = '', User1 = '', User2 = '', User3 = 0, User4 = 0, User5 = '', User6 = '', 
	User7 = '01/01/1900', User8 = '01/01/1900'                                    




