CREATE TABLE [dbo].[FormExportHeader] (
    [Form_Id]           NUMERIC (18) NULL,
    [CSID]              VARCHAR (30) NULL,
    [FormSerialID]      INT          NULL,
    [FarmID]            VARCHAR (3)  NULL,
    [WeekNbr]           VARCHAR (2)  NULL,
    [CurrentDate]       VARCHAR (3)  NULL,
    [Origin]            VARCHAR (24) NULL,
    [Birthdate]         VARCHAR (3)  NULL,
    [Verify_Wks]        VARCHAR (30) NULL,
    [FormSerialIDMerge] INT          NULL,
    [FormSerialID2]     INT          NULL
);


GO
create trigger dbo.trIns_FormExportHeader ON dbo.FormExportHeader
	FOR INSERT 
	As
	INSERT INTO dbo.PCUploadFormHeader (Form_Id,FormSerialID,FarmID,CurrentDate,Verify_Wks,TransferStatus)
	SELECT i.Form_Id, i.FormSerialID, i.FarmID,i.CurrentDate,i.Verify_Wks,0
	FROM INSERTED i
	LEFT JOIN dbo.PCUploadFormHeader d ON i.Form_Id = d.Form_Id 
		AND i.FormSerialID = d.FormSerialID
		AND i.FarmID = d.FarmID
	WHERE d.FarmID Is Null

--Update TransferStatus to 0 if Form is re-verified (Master Breed)
--Used for printing Report for all Forms that have been verified since last print of report
	UPDATE d
	SET d.TransferStatus=0
	FROM dbo.PCUploadFormHeader d
	JOIN Inserted i ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
	Where d.TransferStatus= -1 
