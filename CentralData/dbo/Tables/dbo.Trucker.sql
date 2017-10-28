CREATE TABLE [dbo].[Trucker] (
    [TruckerID]      INT          NOT NULL,
    [Internal]       SMALLINT     NULL,
    [Market]         SMALLINT     NULL,
    [Feed]           SMALLINT     NULL,
    [DefaultTrailer] VARCHAR (20) NULL,
    CONSTRAINT [PK_Trucker] PRIMARY KEY CLUSTERED ([TruckerID] ASC) WITH (FILLFACTOR = 90)
);

