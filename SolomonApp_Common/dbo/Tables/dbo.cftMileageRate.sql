CREATE TABLE [dbo].[cftMileageRate] (
    [CommRate]      INT           NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [HHRate]        INT           NOT NULL,
    [HighMiles]     SMALLINT      NOT NULL,
    [LowMiles]      SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [Rate]          FLOAT (53)    NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftMileageRate0] PRIMARY KEY CLUSTERED ([LowMiles] ASC) WITH (FILLFACTOR = 90)
);

