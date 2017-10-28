CREATE TABLE [dbo].[cft_SowParity_20140216] (
    [site_id]     INT      NOT NULL,
    [identity_id] INT      NOT NULL,
    [event_id]    INT      NOT NULL,
    [eventdate]   DATETIME NOT NULL,
    [weekofdate]  DATETIME NOT NULL,
    [parity]      BIGINT   NULL,
    [enddate]     DATETIME NULL,
    [endweek]     DATETIME NULL,
    CONSTRAINT [PK_cft_SowParity] PRIMARY KEY CLUSTERED ([site_id] ASC, [identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80)
);

