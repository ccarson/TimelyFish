CREATE TABLE [dbo].[cft_sowparity_m01] (
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
    [event_type]  INT          NULL
);

