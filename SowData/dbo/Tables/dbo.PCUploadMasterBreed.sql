CREATE TABLE [dbo].[PCUploadMasterBreed] (
    [RecordID]                INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]                 NUMERIC (18)  NULL,
    [FormSerialID]            VARCHAR (30)  NULL,
    [CSID]                    VARCHAR (30)  NULL,
    [Verify_Wks]              VARCHAR (30)  NULL,
    [RowNbr]                  VARCHAR (30)  NULL,
    [FarmID]                  VARCHAR (8)   NULL,
    [SowID]                   VARCHAR (12)  NULL,
    [AlternateID]             VARCHAR (20)  NULL,
    [EventDay]                VARCHAR (3)   NULL,
    [EventWeek]               VARCHAR (2)   NULL,
    [Service1Date]            VARCHAR (3)   NULL,
    [Service1SemenID]         VARCHAR (6)   NULL,
    [Service1BreederID]       VARCHAR (3)   NULL,
    [Service1AMPMFlag]        VARCHAR (2)   NULL,
    [Service1TransferStatus]  SMALLINT      NULL,
    [Service1DateTransferred] SMALLDATETIME NULL,
    [Service2Date]            VARCHAR (3)   NULL,
    [Service2SemenID]         VARCHAR (6)   NULL,
    [Service2BreederID]       VARCHAR (3)   NULL,
    [Service2AMPMFlag]        VARCHAR (2)   NULL,
    [Service2TransferStatus]  SMALLINT      NULL,
    [Service2DateTransferred] SMALLDATETIME NULL,
    [Service3Date]            VARCHAR (3)   NULL,
    [Service3SemenID]         VARCHAR (6)   NULL,
    [Service3BreederID]       VARCHAR (3)   NULL,
    [Service3AMPMFlag]        VARCHAR (2)   NULL,
    [Service3TransferStatus]  SMALLINT      NULL,
    [Service3DateTransferred] SMALLDATETIME NULL,
    [DateInserted]            SMALLDATETIME NULL,
    CONSTRAINT [PK_PCUploadMasterBreed] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_PCUploadMasterBreed01]
    ON [dbo].[PCUploadMasterBreed]([Service2TransferStatus] ASC)
    INCLUDE([RecordID], [Form_Id], [FormSerialID], [RowNbr], [FarmID]);

