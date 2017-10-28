CREATE TABLE [dbo].[ExpBoarAdditionDetail] (
    [RecordID]     INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]      NUMERIC (10) NULL,
    [FormSerialID] INT          NULL,
    [CSID]         VARCHAR (30) NULL,
    [RowNbr]       VARCHAR (30) NULL,
    [WeekNbr]      VARCHAR (2)  NULL,
    [CurrentDate]  VARCHAR (3)  NULL,
    [Origin]       VARCHAR (30) NULL,
    [FarmID]       VARCHAR (3)  NULL,
    [BoarID]       VARCHAR (3)  NULL,
    [BoarStatus]   VARCHAR (5)  NULL,
    [Genetics]     VARCHAR (6)  NULL,
    [Verify_Wks]   VARCHAR (30) NULL
);


GO
create trigger dbo.trIns_ExpBoarAdditionDetail ON dbo.ExpBoarAdditionDetail
	FOR INSERT 
	As
	INSERT INTO dbo.PCUploadBoarAddition (Form_Id,FormSerialID,CSID,Verify_Wks,Origin,RowNbr,FarmID,BoarID,Genetics,
		EventDay,EventWeek,BoarStatus,DateInserted,TransferStatus)
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.Origin, i.RowNbr, i.FarmID, i.BoarID, i.Genetics, 
	i.CurrentDate, i.WeekNbr, i.BoarStatus, GetDate(), 0
	FROM INSERTED i
	LEFT JOIN dbo.PCUploadBoarAddition d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null
