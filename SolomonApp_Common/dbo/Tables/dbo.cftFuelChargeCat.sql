CREATE TABLE [dbo].[cftFuelChargeCat] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MaxFuelPrice]  FLOAT (53)    NOT NULL,
    [MinFuelPrice]  FLOAT (53)    NOT NULL,
    [Multiplier]    FLOAT (53)    NOT NULL,
    [NoteID]        INT           NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftFuelChargeCat0] PRIMARY KEY CLUSTERED ([LineNbr] ASC) WITH (FILLFACTOR = 90)
);

