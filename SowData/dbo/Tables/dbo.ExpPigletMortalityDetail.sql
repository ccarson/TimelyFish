CREATE TABLE [dbo].[ExpPigletMortalityDetail] (
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
    [DeathQty]     NUMERIC (2)  NULL,
    [DeathReason]  NUMERIC (2)  NULL,
    [NurseOff]     NUMERIC (2)  NULL,
    [Verify_Wks]   VARCHAR (30) NULL
);


GO
create trigger dbo.trIns_ExpPigletMortalityDetail ON dbo.ExpPigletMortalityDetail
	FOR INSERT 
	As

	INSERT INTO dbo.PCUploadPigletMortality (Form_Id,FormSerialID,CSID,Verify_Wks,RowNbr,FarmID,SowID,AlternateID,
		EventDay,EventWeek,DeathQty,DeathReasonID,NurseOff,
		DateInserted,TransferStatus)
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.RowNbr, i.FarmID, i.SowID, i.AlternateID, 
	i.CurrentDate, i.WeekNbr, i.DeathQty,i.DeathReason,i.NurseOff,GetDate(),0
	FROM INSERTED i
	
	LEFT JOIN dbo.PCUploadPigletMortality d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null
