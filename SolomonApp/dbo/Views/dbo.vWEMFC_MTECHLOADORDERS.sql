
--*************************************************************
--	Purpose:ALTER  Access to WEM Read Only Transaction Data
--		
--	Author: Sue Matter
--	Date: 9/11/2006
--	Usage: Daily Transaction Update Solomon App	 
--	Parms: 
--*************************************************************


CREATE VIEW [dbo].[vWEMFC_MTECHLOADORDERS]
	AS
	SELECT [Infinity Rec No], [Bin Feed Amount 1], [Bin Feed Amount 2], [Bin Feed Amount 3], [Bin Feed Amount 4], [Creation Date], [Farm No], [Farm Type], [Feed Delivery Area], [Feed Mill Code], [Feed Type], [Flock Type], [Formula No], [House No], [Last Mod Date], [Load Date], [Load No], [Miscellaneous], [Pen No], [Projection Flag], [Projection Rec No], [Ref No], [Replica Source ID], [Replication Date Time], [Sflock No], [Shipping Flag], [Ticket Comment], isnull([User ID],'dflt') as [User ID], [ts], [DeliveryDate], [Gross], [FeedLoadInfinityRecNo], [Miles], [Tare], [TruckNo], [DriverNo], [InvoiceNo], [ScaleOperator], [Void], [Processed], [C1], [C2], [C3], [C4], [C5], [C6], [C7], [C8], [C9], [C10], [SQLTransferDTime], [SQLRowCounter], [RowSeqNum_IO], [SQLRowVersion]
FROM 	OPENQUERY([W15624FSERVER\WEMSQLENGINE],'Select * from MTECHLOADORDERS')


