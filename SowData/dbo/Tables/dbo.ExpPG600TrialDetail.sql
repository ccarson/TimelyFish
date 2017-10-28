CREATE TABLE [dbo].[ExpPG600TrialDetail] (
    [RowNbr]       NUMERIC (30) NULL,
    [SowID]        CHAR (6)     NULL,
    [AlternateID]  CHAR (6)     NULL,
    [Treatment]    NVARCHAR (2) NULL,
    [CSID]         VARCHAR (30) NULL,
    [Verify_Wks]   VARCHAR (30) NULL,
    [Form_Id]      NUMERIC (10) NULL,
    [FarmID]       CHAR (3)     NULL,
    [CurrentDate]  NUMERIC (3)  NULL,
    [WeekNbr]      CHAR (2)     NULL,
    [FormSerialID] VARCHAR (8)  NULL
);


GO
CREATE TRIGGER trIns_ExpPG600TrialDetail ON dbo.ExpPG600TrialDetail 
	FOR INSERT 
	As
	-- Create the Treatment event
	INSERT INTO dbo.PCUploadPG600Trial (Form_Id,FormSerialID,CSID,Verify_Wks,RowNbr,FarmID,SowID,AlternateID,
		EventDay,EventWeek,Treatment,
		DateInserted,TransferStatus)
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.RowNbr, i.FarmID, i.SowID, i.AlternateID, 
	i.CurrentDate, i.WeekNbr, IsNull(i.Treatment,0),	
	GetDate(), 0
	FROM INSERTED i
	
	LEFT JOIN dbo.PCUploadPG600Trial d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null

