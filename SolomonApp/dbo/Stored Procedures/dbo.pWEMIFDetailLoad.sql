

--*************************************************************
--	Purpose:ALTER  Access to WEM IF Read Only Transaction Data
--		
--	Author: Sue Matter
--	Date: 11/11/2006
--	Usage: Daily Transaction Update Solomon App	 
--	Parms: 
--*************************************************************

CREATE Procedure [dbo].[pWEMIFDetailLoad]
AS
INSERT INTO [SolomonApp].[dbo].[MTECHLOADORDERS]([Infinity Rec No], [Bin Feed Amount 1], 
[Bin Feed Amount 2], [Bin Feed Amount 3], [Bin Feed Amount 4], [Creation Date], 
[Farm No], [Farm Type], [Feed Delivery Area], [Feed Mill Code], [Feed Type], 
[Flock Type], [Formula No], [House No], [Last Mod Date], [Load Date], [Load No], 
[Miscellaneous], [Pen No], [Projection Flag], [Projection Rec No], [Ref No], 
[Replica Source ID], [Replication Date Time], [Sflock No], [Shipping Flag], 
[Ticket Comment], [User ID], [ts], [DeliveryDate], [Gross], [FeedLoadInfinityRecNo], 
[Miles], [Tare], [TruckNo], [DriverNo], [InvoiceNo], [ScaleOperator], [Void], 
[Processed], [C1], [C2], [C3], [C4], [C5], [C6], [C7], [C8], [C9], [C10], 
[SQLTransferDTime], [SQLRowCounter], [RowSeqNum_IO])

Select [Infinity Rec No], [Bin Feed Amount 1], [Bin Feed Amount 2], 
[Bin Feed Amount 3], [Bin Feed Amount 4], [Creation Date], [Farm No], [Farm Type], 
[Feed Delivery Area], [Feed Mill Code], [Feed Type], [Flock Type], [Formula No], 
[House No], [Last Mod Date], 
CASE WHEN Len([Load Date])<10 THEN CONVERT(datetime,'1/1/1900',101) 
ELSE  [Load Date] END,
[Load No], [Miscellaneous], [Pen No], 
[Projection Flag], [Projection Rec No], [Ref No], [Replica Source ID], 
[Replication Date Time], [Sflock No], [Shipping Flag], [Ticket Comment], 
--[User ID], [ts], ISNULL([DeliveryDate],'1/1/1900'), [Gross], [FeedLoadInfinityRecNo], [Miles], [Tare], 
isnull([User ID],'WEM_001330'), [ts], ISNULL([DeliveryDate],'1/1/1900'), [Gross], [FeedLoadInfinityRecNo], [Miles], [Tare], -- 20150109 smr had to convert nulls to something, SL does not allow nulls
[TruckNo], [DriverNo], [InvoiceNo], [ScaleOperator], [Void], [Processed], [C1], [C2], 
[C3], [C4], [C5], [C6], [C7], [C8], [C9], [C10], [SQLTransferDTime], [SQLRowCounter], 
[RowSeqNum_IO]
From vWEMIF_MTECHLOADORDERS 
WHERE RowSeqNum_IO > (Select Max(RowSeqNum_IO) from SolomonApp.dbo.MTECHLOADORDERS WHERE [Feed Mill Code]='001330')
and [Feed Mill Code]='001330'

