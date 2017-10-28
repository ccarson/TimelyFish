CREATE TABLE [dbo].[ExpBreedingStockAdditionDetail] (
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
    [Genetics]     VARCHAR (6)  NULL,
    [Origin]       VARCHAR (24) NULL,
    [Birthdate]    VARCHAR (3)  NULL,
    [Verify_Wks]   VARCHAR (30) NULL
);


GO
create trigger dbo.trIns_ExpBreedingStockAdditionDetail ON dbo.ExpBreedingStockAdditionDetail
	FOR INSERT 
	As
	INSERT INTO dbo.PCUploadBreedStockAddition (Form_Id,FormSerialID,CSID,Verify_Wks,RowNbr,FarmID,SowID,AlternateID,
		Genetics,Origin,BirthDate,EventDay,EventWeek,DateInserted,TransferStatus)
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.RowNbr, i.FarmID, i.SowID, i.AlternateID,
	i.Genetics, i.Origin, i.BirthDate, i.CurrentDate, i.WeekNbr, GetDate(), 0
	FROM INSERTED i
	LEFT JOIN dbo.PCUploadBreedStockAddition d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null
