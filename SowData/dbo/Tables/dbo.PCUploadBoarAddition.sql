CREATE TABLE [dbo].[PCUploadBoarAddition] (
    [RecordID]        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Id]         NUMERIC (18)  NULL,
    [FormSerialID]    INT           NULL,
    [CSID]            VARCHAR (30)  NULL,
    [Verify_Wks]      VARCHAR (30)  NULL,
    [Origin]          VARCHAR (30)  NULL,
    [RowNbr]          VARCHAR (30)  NULL,
    [FarmID]          VARCHAR (8)   NULL,
    [BoarID]          VARCHAR (12)  NULL,
    [Genetics]        VARCHAR (20)  NULL,
    [EventDay]        VARCHAR (3)   NULL,
    [EventWeek]       VARCHAR (2)   NULL,
    [BoarStatus]      VARCHAR (20)  NULL,
    [DateInserted]    SMALLDATETIME NULL,
    [TransferStatus]  SMALLINT      NULL,
    [DateTransferred] SMALLDATETIME NULL,
    CONSTRAINT [PK_PCUploadBoarAddition] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);

