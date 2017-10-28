CREATE TABLE [dbo].[ExpMasterFarrowDetail] (
    [RecordID]     INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]      NUMERIC (10) NULL,
    [FormSerialID] INT          NULL,
    [CSID]         VARCHAR (30) NULL,
    [RowNbr]       VARCHAR (30) NULL,
    [WeekNbr]      VARCHAR (2)  NULL,
    [CurrentDate]  VARCHAR (3)  NULL,
    [FarmID]       VARCHAR (3)  NULL,
    [SowID]        VARCHAR (6)  NULL,
    [AlternateID]  VARCHAR (6)  NULL,
    [BornAliveQty] NUMERIC (2)  NULL,
    [StillBornQty] NUMERIC (2)  NULL,
    [MummyQty]     NUMERIC (2)  NULL,
    [RoomNbr]      NUMERIC (2)  NULL,
    [CrateNbr]     NUMERIC (2)  NULL,
    [FosterOn]     NUMERIC (2)  NULL,
    [FosterOff]    NUMERIC (2)  NULL,
    [Verify_Wks]   VARCHAR (30) NULL
);


GO
create trigger dbo.trIns_ExpMasterFarrowDetail ON dbo.ExpMasterFarrowDetail
	FOR INSERT 
	As
	-- Create the Farrow event (which includes info for LOCATION Event, and possible FOSTER event)
	INSERT INTO dbo.PCUploadMasterFarrow (Form_Id,FormSerialID,CSID,Verify_Wks,RowNbr,FarmID,SowID,AlternateID,
		EventDay,EventWeek,QtyBornAlive,QtyStillBorn,QtyMummy,RoomNbr,CrateNbr,FosterOn,FosterOff,
		DateInserted,TransferStatus)
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.RowNbr, i.FarmID, i.SowID, i.AlternateID, 
	i.CurrentDate, i.WeekNbr, IsNull(i.BornAliveQty,0), IsNull(i.StillBornQty,0),	IsNull(i.MummyQty,0), 
	i.RoomNbr, i.CrateNbr, i.FosterOn, i.FosterOff, GetDate(), 0
	FROM INSERTED i
	
	LEFT JOIN dbo.PCUploadMasterFarrow d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null
