CREATE TABLE [dbo].[cftFuelRate] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [EffectiveWeek] SMALLDATETIME NOT NULL,
    [FuelRate]      FLOAT (53)    NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftFuelRate0] PRIMARY KEY CLUSTERED ([EffectiveWeek] ASC) WITH (FILLFACTOR = 90)
);

