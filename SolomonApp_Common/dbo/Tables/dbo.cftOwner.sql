CREATE TABLE [dbo].[cftOwner] (
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [InsuranceProgramID] CHAR (2)      NOT NULL,
    [Lupd_DateTime]      SMALLDATETIME NOT NULL,
    [Lupd_Prog]          CHAR (8)      NOT NULL,
    [Lupd_User]          CHAR (10)     NOT NULL,
    [OwnerContactID]     CHAR (6)      NOT NULL,
    [PercentOwnership]   FLOAT (53)    NOT NULL,
    [PrimaryContactFlag] SMALLINT      NOT NULL,
    [SiteContactID]      CHAR (6)      NOT NULL,
    [TotalAcresFarmed]   FLOAT (53)    NOT NULL,
    [TotalAcresOwned]    FLOAT (53)    NOT NULL,
    [TotalAcresRented]   FLOAT (53)    NOT NULL,
    [tstamp]             ROWVERSION    NULL,
    CONSTRAINT [cftOwner0] PRIMARY KEY CLUSTERED ([OwnerContactID] ASC, [SiteContactID] ASC) WITH (FILLFACTOR = 90)
);

