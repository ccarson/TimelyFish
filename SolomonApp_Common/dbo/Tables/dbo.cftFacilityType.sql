CREATE TABLE [dbo].[cftFacilityType] (
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Description]    CHAR (30)     NOT NULL,
    [FacilityTypeID] CHAR (3)      NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [PigProdPhaseID] CHAR (3)      NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [cftFacilityType0] PRIMARY KEY CLUSTERED ([FacilityTypeID] ASC) WITH (FILLFACTOR = 90)
);

