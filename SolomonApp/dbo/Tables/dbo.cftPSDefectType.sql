CREATE TABLE [dbo].[cftPSDefectType] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DefectTypeID]  CHAR (2)      NOT NULL,
    [DetailTypeID]  CHAR (2)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (10)     NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [PkrContactID]  CHAR (6)      NOT NULL,
    [PkrDefectCode] CHAR (30)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSDefectType0] PRIMARY KEY CLUSTERED ([DefectTypeID] ASC) WITH (FILLFACTOR = 90)
);

