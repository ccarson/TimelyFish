CREATE TABLE [dbo].[PCUploadBreedStockAddition] (
    [RecordID]        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]         NUMERIC (18)  NULL,
    [FormSerialID]    VARCHAR (30)  NULL,
    [CSID]            VARCHAR (30)  NULL,
    [Verify_Wks]      VARCHAR (30)  NULL,
    [RowNbr]          VARCHAR (30)  NULL,
    [FarmID]          VARCHAR (8)   NULL,
    [SowID]           VARCHAR (12)  NULL,
    [AlternateID]     VARCHAR (20)  NULL,
    [Genetics]        VARCHAR (20)  NULL,
    [Origin]          VARCHAR (24)  NULL,
    [BirthDate]       VARCHAR (3)   NULL,
    [EventDay]        VARCHAR (3)   NULL,
    [EventWeek]       VARCHAR (2)   NULL,
    [DateInserted]    SMALLDATETIME NULL,
    [TransferStatus]  SMALLINT      NULL,
    [DateTransferred] SMALLDATETIME NULL,
    CONSTRAINT [PK_PCUploadBreedStockAddition] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);

