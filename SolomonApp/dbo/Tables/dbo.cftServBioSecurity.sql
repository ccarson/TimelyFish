CREATE TABLE [dbo].[cftServBioSecurity] (
    [BioSecurityID] CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_UserID]   CHAR (10)     NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_UserID]   CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftServBioSecurity0] PRIMARY KEY CLUSTERED ([BioSecurityID] ASC) WITH (FILLFACTOR = 90)
);

