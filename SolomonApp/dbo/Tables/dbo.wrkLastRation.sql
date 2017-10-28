CREATE TABLE [dbo].[wrkLastRation] (
    [BinNbr]        CHAR (10)  NOT NULL,
    [LastRationDel] CHAR (20)  NULL,
    [LastRationOrd] CHAR (20)  NULL,
    [MillID]        CHAR (10)  NOT NULL,
    [PigGroupId]    CHAR (10)  NOT NULL,
    [RI_ID]         SMALLINT   NOT NULL,
    [SiteContactId] CHAR (6)   NOT NULL,
    [tstamp]        ROWVERSION NULL,
    CONSTRAINT [wrkLastRation0] PRIMARY KEY CLUSTERED ([SiteContactId] ASC, [BinNbr] ASC, [MillID] ASC, [PigGroupId] ASC, [RI_ID] ASC) WITH (FILLFACTOR = 90)
);

