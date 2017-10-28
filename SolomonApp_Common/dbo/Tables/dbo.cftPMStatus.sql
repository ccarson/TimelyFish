CREATE TABLE [dbo].[cftPMStatus] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PMStatusID]    CHAR (2)      NOT NULL,
    [PMTypeID]      CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NULL
);


GO
CREATE CLUSTERED INDEX [cftPMStatus0]
    ON [dbo].[cftPMStatus]([PMStatusID] ASC) WITH (FILLFACTOR = 90);

