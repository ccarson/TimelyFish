CREATE TABLE [dbo].[cftPMChanges] (
    [PMChangesID]       BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PMID]              CHAR (10)     NOT NULL,
    [PMLoadID]          CHAR (10)     NOT NULL,
    [PrevMovementDate]  SMALLDATETIME NOT NULL,
    [PrevDestContactID] CHAR (10)     NULL,
    [PrevEstimatedQty]  SMALLINT      NULL,
    [ChangeDate]        SMALLDATETIME NULL,
    CONSTRAINT [PK_cftPMChanges_1] PRIMARY KEY CLUSTERED ([PMChangesID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_cftPMChanges_PMID_PMLoadID]
    ON [dbo].[cftPMChanges]([PMID] ASC, [PMLoadID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_cftPMChanges_PrevMovementDate]
    ON [dbo].[cftPMChanges]([PrevMovementDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_cftPMChanges_ChangeDate]
    ON [dbo].[cftPMChanges]([ChangeDate] ASC) WITH (FILLFACTOR = 90);

