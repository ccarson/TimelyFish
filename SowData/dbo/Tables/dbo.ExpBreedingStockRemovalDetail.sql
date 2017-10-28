CREATE TABLE [dbo].[ExpBreedingStockRemovalDetail] (
    [RecordID]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]       NUMERIC (10) NULL,
    [FormSerialID]  INT          NULL,
    [CSID]          VARCHAR (30) NULL,
    [RowNbr]        VARCHAR (30) NULL,
    [WeekNbr]       VARCHAR (2)  NULL,
    [CurrentDate]   VARCHAR (3)  NULL,
    [FarmID]        VARCHAR (3)  NULL,
    [SowID]         VARCHAR (6)  NULL,
    [AlternateID]   VARCHAR (6)  NULL,
    [RemovalTypeID] VARCHAR (8)  NULL,
    [ReasonID_1]    NUMERIC (2)  NULL,
    [ReasonID_2]    NUMERIC (2)  NULL,
    [Verify_Wks]    VARCHAR (30) NULL
);


GO
create trigger dbo.trIns_ExpBreedingStockRemovalDetail ON dbo.ExpBreedingStockRemovalDetail
	FOR INSERT 
	As
	INSERT INTO dbo.PCUploadBreedStockRemoval (Form_Id,FormSerialID,CSID,Verify_Wks,RowNbr,FarmID,SowID,AlternateID,
		EventDay,EventWeek,RemovalTypeID, ReasonID1, ReasonID2,DateInserted,TransferStatus)
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.RowNbr, i.FarmID, i.SowID, i.AlternateID,
	i.CurrentDate, i.WeekNbr, i.RemovalTypeID, i.ReasonID_1, i.ReasonID_2, GetDate(), 0
	FROM INSERTED i
	LEFT JOIN dbo.PCUploadBreedStockRemoval d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null
