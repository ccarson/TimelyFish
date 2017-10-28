
CREATE Trigger EDPurchOrd_Insert On PurchOrd For Insert As
Set NOCOUNT ON
Insert Into EDPurchOrd 
Select 	' ' 'AcctNbr', ' ' 'AgreeNbr', '01/01/1900' 'ArrivalDate', 0 'BackOrderFlag', 
	' ' 'BatchNbr', ' ' 'BidNbr', '01/01/1900' 'CancelDate', ' ' 'ChangeNbr', 
	' ' 'ContractNbr', '01/01/1900' 'ConvertedDate', GetDate() 'CreationDate', ' ' 'CrossDock', 
	Inserted.Crtd_DateTime 'Crtd_Datetime', Inserted.Crtd_Prog 'Crtd_Prog', Inserted.Crtd_User 'Crtd_User', '01/01/1900' 'DeliveryDate',
	' ' 'DeptNbr', ' ' 'DistributorNbr', '01/01/1900' 'EffDate', ' ' 'EndCustPackNbr', 
	'01/01/1900' 'EndCustPODate', ' ' 'EndCustPONbr', ' ' 'EndCustSONbr', '01/01/1900' 'ExpirDate', 
	IsNull(EDVendor.FOBLocQual,' ') 'FOBLocQual', 0 'Height', ' ' 'HeightUOM', '01/01/1900' 'LastEDIDate', 
	0 'Len', ' ' 'LenUOM', Inserted.Lupd_DateTime 'Lupd_Datetime', Inserted.Lupd_Prog 'Lupd_Prog', 
	Inserted.Lupd_User 'Lupd_User', 0 'NbrContainer', ' ' 'OutboundProcNbr', Inserted.PONbr 'PONbr', 
	' ' 'POSuff', '01/01/1900' 'PromoEndDate', ' ' 'PromoNbr', '01/01/1900' 'PromoStartDate', 
	' ' 'PurReqNbr', ' ' 'QuoteNbr', '01/01/1900' 'RequestDate', IsNull(Carrier.CarrierId,' ') 'Routing', 
	' ' 'RoutingIdCode', ' ' 'RoutingIdQual', ' ' 'RoutingSeqCode', ' ' 'S4Future01', 
	' ' 'S4Future02', 0 'S4Future03', 0 'S4Future04', 0 'S4Future05', 
	0 'S4Future06', '01/01/1900' 'S4Future07', '01/01/1900' 'S4Future08', 0 'S4Future09', 
	0 'S4Future10', ' ' 'S4Future11', ' ' 'S4Future12', ' ' 'SalesDivision', 
	' ' 'Salesman', ' ' 'SalesRegion', ' ' 'SalesTerritory', '01/01/1900' 'ScheduleDate', 
	'01/01/1900' 'ShipDate', IsNull(EDVendor.ShipMethPay,' ') 'ShipMthPay', '01/01/1900' 'ShipNBDate', '01/01/1900' 'ShipNLDate', 
	'01/01/1900' 'ShipWeekOf', ' ' 'TranMethCode', ' ' 'User1', '01/01/1900' 'User10', 
	' ' 'User2', ' ' 'User3', ' ' 'User4', 0 'User5', 
	0 'User6', ' ' 'User7', ' ' 'User8', '01/01/1900' 'User9', 
	0 'Volume', ' ' 'VolumeUOM', 0 'Weight', ' ' 'WeightUOM', 
	0 'Width', ' ' 'WidthUOM', ' ' 'WONbr', NULL 'tstamp'
From Inserted Left Outer Join EDVendor On Inserted.VendId = EDVendor.VendId Left Outer Join ShipVia On Inserted.CpnyId = ShipVia.CpnyId And Inserted.ShipVia = ShipVia.ShipViaId Left Outer Join Carrier On ShipVia.CarrierId = Carrier.CarrierId 
Where Not Exists(Select * From EDPurchOrd Where PONbr = Inserted.PONbr)
