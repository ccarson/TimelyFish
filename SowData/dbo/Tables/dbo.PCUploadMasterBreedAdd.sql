CREATE TABLE [dbo].[PCUploadMasterBreedAdd] (
    [RecordID]                INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]                 NUMERIC (18)  NULL,
    [FormSerialID]            VARCHAR (30)  NULL,
    [CSID]                    VARCHAR (30)  NULL,
    [Verify_Wks]              VARCHAR (30)  NULL,
    [RowNbr]                  VARCHAR (30)  NULL,
    [FarmID]                  VARCHAR (8)   NULL,
    [SowID]                   VARCHAR (12)  NULL,
    [AlternateID]             VARCHAR (20)  NULL,
    [Genetics]                VARCHAR (6)   NULL,
    [EventDay]                VARCHAR (3)   NULL,
    [EventWeek]               VARCHAR (2)   NULL,
    [Service1Date]            VARCHAR (3)   NULL,
    [Service1SemenID]         VARCHAR (6)   NULL,
    [Service1Cycle]           VARCHAR (1)   NULL,
    [Service1AMPMFlag]        VARCHAR (2)   NULL,
    [Service1TransferStatus]  SMALLINT      NULL,
    [Service1DateTransferred] SMALLDATETIME NULL,
    [Service2Date]            VARCHAR (3)   NULL,
    [Service2SemenID]         VARCHAR (6)   NULL,
    [Service2AMPMFlag]        VARCHAR (2)   NULL,
    [Service2TransferStatus]  SMALLINT      NULL,
    [Service2DateTransferred] SMALLDATETIME NULL,
    [Service3Date]            VARCHAR (3)   NULL,
    [Service3SemenID]         VARCHAR (6)   NULL,
    [Service3AMPMFlag]        VARCHAR (2)   NULL,
    [Service3TransferStatus]  SMALLINT      NULL,
    [Service3DateTransferred] SMALLDATETIME NULL,
    [DateInserted]            SMALLDATETIME NULL,
    [Origin]                  VARCHAR (3)   NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PCUploadMasterBreedAdd', @level2type = N'COLUMN', @level2name = N'Genetics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PCUploadMasterBreedAdd', @level2type = N'COLUMN', @level2name = N'Genetics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PCUploadMasterBreedAdd', @level2type = N'COLUMN', @level2name = N'Genetics';

