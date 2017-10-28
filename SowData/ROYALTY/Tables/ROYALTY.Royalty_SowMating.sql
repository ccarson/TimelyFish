CREATE TABLE [ROYALTY].[Royalty_SowMating] (
    [Seqno]           INT           NULL,
    [Period]          VARCHAR (64)  NULL,
    [FarmID]          VARCHAR (8)   NULL,
    [SowID]           VARCHAR (12)  NULL,
    [EntryDate]       SMALLDATETIME NULL,
    [EventID]         BIGINT        NOT NULL,
    [EventDate]       SMALLDATETIME NULL,
    [SemenID]         VARCHAR (10)  NULL,
    [SowGenetics]     VARCHAR (20)  NULL,
    [SowEntrySeqno]   INT           NULL,
    [SowEnteryPeriod] VARCHAR (64)  NULL
);

