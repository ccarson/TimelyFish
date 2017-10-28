CREATE TABLE [dbo].[cftPfosRationCheck] (
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     VARCHAR (8)   NOT NULL,
    [Crtd_user]     VARCHAR (20)  NOT NULL,
    [Lupd_datetime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     VARCHAR (8)   NOT NULL,
    [Lupd_user]     VARCHAR (20)  NOT NULL,
    [RationID]      VARCHAR (30)  NOT NULL,
    [RationIC]      VARCHAR (30)  NOT NULL,
    [Tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPfosRationCheck0] PRIMARY KEY CLUSTERED ([RationID] ASC, [RationIC] ASC) WITH (FILLFACTOR = 80)
);

