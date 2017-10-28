CREATE TABLE [ROYALTY].[Royalty_WeekOfDate] (
    [SeqNo]     INT           IDENTITY (1, 1) NOT NULL,
    [StartWeek] SMALLDATETIME NULL,
    [EndWeek]   SMALLDATETIME NULL,
    [Period]    VARCHAR (64)  NULL
);

