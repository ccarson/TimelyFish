CREATE TABLE [dbo].[RefaxAudit] (
    [RefaxAuditID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FormSerialID] VARCHAR (8)   NULL,
    [FarmID]       VARCHAR (4)   NULL,
    [CurrentDate]  VARCHAR (3)   NULL,
    [Comment]      VARCHAR (100) NULL,
    [FormName]     VARCHAR (50)  NULL,
    [PrintStatus]  SMALLINT      CONSTRAINT [DF_RefaxAudit_PrintStatus] DEFAULT (0) NULL,
    CONSTRAINT [PK_RefaxAudit] PRIMARY KEY CLUSTERED ([RefaxAuditID] ASC) WITH (FILLFACTOR = 90)
);

