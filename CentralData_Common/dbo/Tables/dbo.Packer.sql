CREATE TABLE [dbo].[Packer] (
    [ContactID]        INT       NOT NULL,
    [MaxNbrLoads]      INT       NULL,
    [TimeBetweenLoads] INT       NULL,
    [TrackTotals]      INT       NULL,
    [Culls]            INT       NULL,
    [CustID]           CHAR (15) NULL,
    [TrkPaidFlg]       SMALLINT  NULL,
    CONSTRAINT [PK_Packer] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);
