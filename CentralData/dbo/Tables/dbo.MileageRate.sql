CREATE TABLE [dbo].[MileageRate] (
    [MileageRateID] SMALLINT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LowMiles]      INT      NULL,
    [HighMiles]     INT      NULL,
    [Rate]          MONEY    NULL,
    CONSTRAINT [PK_MileageRate] PRIMARY KEY CLUSTERED ([MileageRateID] ASC) WITH (FILLFACTOR = 90)
);

