CREATE TABLE [dbo].[cft_SowParity] (
    [site_id]     INT          NOT NULL,
    [identity_id] INT          NOT NULL,
    [event_id]    INT          NULL,
    [eventdate]   DATETIME     NULL,
    [weekofdate]  DATETIME     NULL,
    [parity]      BIGINT       NOT NULL,
    [enddate]     DATETIME     NULL,
    [endweek]     DATETIME     NULL,
    [farmid]      VARCHAR (8)  NULL,
    [sowid]       VARCHAR (12) NULL,
    [event_type]  INT          NULL,
    CONSTRAINT [PK_cft_SowParity2] PRIMARY KEY CLUSTERED ([site_id] ASC, [identity_id] ASC, [parity] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idx_cft_sowparity_farm_sow_parity2]
    ON [dbo].[cft_SowParity]([farmid] ASC, [sowid] ASC, [parity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idx_cft_sowparity_site_id_evt_par2]
    ON [dbo].[cft_SowParity]([site_id] ASC, [identity_id] ASC, [eventdate] ASC, [event_type] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idx_cft_sowparity]
    ON [dbo].[cft_SowParity]([identity_id] ASC, [enddate] ASC, [event_type] ASC) WITH (FILLFACTOR = 80);

