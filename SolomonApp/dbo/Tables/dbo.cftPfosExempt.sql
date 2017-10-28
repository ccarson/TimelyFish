CREATE TABLE [dbo].[cftPfosExempt] (
    [crtd_user]     CHAR (20)  NOT NULL,
    [Crtd_DateTime] DATETIME   NOT NULL,
    [OrdNbr]        CHAR (10)  NOT NULL,
    [tstamp]        ROWVERSION NOT NULL,
    CONSTRAINT [cftPfosExempt0] PRIMARY KEY CLUSTERED ([OrdNbr] ASC) WITH (FILLFACTOR = 100)
);

