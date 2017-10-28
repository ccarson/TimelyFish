CREATE TABLE [dbo].[DBAudit] (
    [RecordID]    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RecordOwner] VARCHAR (30)  NOT NULL,
    [RecordDate]  DATETIME      NOT NULL,
    [RecordUser]  VARCHAR (30)  NOT NULL,
    [RecordText]  VARCHAR (255) NOT NULL,
    [tstamp]      ROWVERSION    NOT NULL,
    CONSTRAINT [DBAudit0] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);

