﻿CREATE TABLE [dbo].[ExpMasterBreedingDetailAdditions] (
    [RecordID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]           NUMERIC (10) NULL,
    [FormSerialID]      INT          NULL,
    [CSID]              VARCHAR (30) NULL,
    [RowNbr]            VARCHAR (30) NULL,
    [WeekNbr]           VARCHAR (2)  NULL,
    [CurrentDate]       VARCHAR (3)  NULL,
    [FarmID]            VARCHAR (3)  NULL,
    [SowID]             VARCHAR (6)  NULL,
    [AlternateID]       VARCHAR (6)  NULL,
    [OriginName]        VARCHAR (24) NULL,
    [Genetics]          VARCHAR (6)  NULL,
    [Cycle]             VARCHAR (1)  NULL,
    [Service1Date]      VARCHAR (3)  NULL,
    [Service1SemenID]   VARCHAR (6)  NULL,
    [Service1BreederID] VARCHAR (3)  NULL,
    [Service1AMPMFlag]  VARCHAR (2)  NULL,
    [Service2Date]      VARCHAR (3)  NULL,
    [Service2SemenID]   VARCHAR (6)  NULL,
    [Service2BreederID] VARCHAR (3)  NULL,
    [Service2AMPMFlag]  VARCHAR (2)  NULL,
    [Service3Date]      VARCHAR (3)  NULL,
    [Service3SemenID]   VARCHAR (6)  NULL,
    [Service3BreederID] VARCHAR (3)  NULL,
    [Service3AMPMFlag]  VARCHAR (2)  NULL,
    [Verify_Wks]        VARCHAR (30) NULL
);


GO


CREATE TRIGGER [dbo].[trIns_ExpMasterBreedingDetailAdditions]
ON [dbo].[ExpMasterBreedingDetailAdditions]
FOR INSERT
AS
	-- INSERT ONLY THE NEW ROWS - 
	INSERT INTO dbo.PCUploadMasterBreedAdditions (Form_Id,FormSerialID,CSID,Verify_Wks,RowNbr,FarmID,SowID,AlternateID,Genetics,
		EventDay,EventWeek,Service1Date,Service1SemenID,Cycle,Service1AMPMFlag,Service1TransferStatus,
		Service2Date,Service2SemenID,Service2AMPMFlag,Service2TransferStatus,
		Service3Date,Service3SemenID,Service3AMPMFlag,Service3TransferStatus,
		DateInserted,Origin
		,service1breederid, service2breederid, service3breederid)	-- added 11/12/2014 are per user request, missing required fields
	SELECT i.Form_Id, i.FormSerialID, i.CSID, i.Verify_Wks, i.RowNbr, i.FarmID, i.SowID, i.AlternateID, i.Genetics,
	i.CurrentDate, i.WeekNbr, i.CurrentDate, i.Service1SemenID, i.Cycle, i.Service1AMPMFlag,0,
	i.Service2Date,i.Service2SemenID,i.Service2AMPMFlag,0,
	i.Service3Date,i.Service3SemenID,i.Service3AMPMFlag,0,GetDate(),i.OriginName
	, i.service1breederid, i.service2breederid, i.service3breederid
	FROM INSERTED i
	LEFT JOIN dbo.PCUploadMasterBreedAdd d ON i.Form_Id = d.Form_Id 
		AND i.FarmID = d.FarmID
		AND i.FormSerialID = d.FormSerialID 
		AND i.RowNbr = d.RowNbr 
	WHERE d.FarmID Is Null

	-- Update the records that already exist to set the values for the service 2 information
	UPDATE p
	SET p.Service2Date = i.Service2Date, p.Service2SemenID = i.Service2SemenID,  p.Service2AMPMFlag = i.Service2AMPMFlag
	, p.service2breederid = i.service2breederid	-- added 11/12/2014 are per user request, missing required fields
	FROM dbo.PCUploadMasterBreedAdditions p
	JOIN Inserted i ON i.Form_Id = p.Form_Id 
		AND i.FarmID = p.FarmID
		AND i.FormSerialID = p.FormSerialID 
		AND i.RowNbr = p.RowNbr 
	Where p.Service2TransferStatus = 0 AND i.Service2Date Is Not Null

	-- Update the records that already exist to set the values for the service 3 information
	UPDATE p
	SET p.Service3Date = i.Service3Date, p.Service3SemenID = i.Service3SemenID, p.Service3AMPMFlag = i.Service3AMPMFlag
	, p.service3breederid = i.service3breederid	-- added 11/12/2014 are per user request, missing required fields
	FROM dbo.PCUploadMasterBreedAdditions p
	JOIN Inserted i ON i.Form_Id = p.Form_Id 
		AND i.FarmID = p.FarmID
		AND i.FormSerialID = p.FormSerialID 
		AND i.RowNbr = p.RowNbr 
	Where p.Service3TransferStatus = 0 AND i.Service3Date Is Not Null



