CREATE TABLE [dbo].[AccountingEntity] (
    [AccountingEntityID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AccountingEntityDescription] VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_AccountingEntity] PRIMARY KEY CLUSTERED ([AccountingEntityID] ASC) WITH (FILLFACTOR = 90)
);
