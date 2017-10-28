CREATE TABLE [dbo].[ExpTransferDetail] (
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
    [Origin]       VARCHAR (24) NULL,
    [Verify_Wks]   VARCHAR (30) NULL,
    [DestID]       VARCHAR (3)  NULL
);


GO


CREATE trigger [dbo].[trIns_ExpTransferDetail] ON [dbo].[ExpTransferDetail]
	FOR INSERT 
	As
	INSERT INTO dbo.PCUploadTransfer (Form_Id,FormSerialID,CSID,Verify_Wks,RowNbr,FarmID,SowID,AlternateID, Destination,EventDay,EventWeek,DateInserted,TransferStatus, DestinationID)
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.RowNbr, i.FarmID, i.SowID, i.AlternateID,	i.Origin, i.CurrentDate, i.WeekNbr, GetDate(), 0, i.DestID
	FROM INSERTED i
	LEFT JOIN dbo.PCUploadTransfer d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null

