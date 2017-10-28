CREATE TABLE [ROYALTY].[Royalty_SowMatingAll] (
    [Seqno]       INT           NULL,
    [Period]      VARCHAR (64)  NULL,
    [EventDate]   SMALLDATETIME NULL,
    [FarmID]      VARCHAR (8)   NULL,
    [SowID]       VARCHAR (12)  NULL,
    [EventID]     BIGINT        NOT NULL,
    [SemenId]     VARCHAR (10)  NULL,
    [SowGenetics] VARCHAR (20)  NULL
);

