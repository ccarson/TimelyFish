CREATE TABLE [dbo].[cftPGFarmInv] (
    [CF01]          CHAR (30)     NOT NULL,
    [CF02]          CHAR (10)     NOT NULL,
    [CF03]          SMALLDATETIME NOT NULL,
    [CF04]          SMALLINT      NOT NULL,
    [CF05]          FLOAT (53)    NOT NULL,
    [ConfNo]        CHAR (8)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CurrentInv]    INT           NOT NULL,
    [InvDate]       SMALLDATETIME NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [Mortality]     INT           NOT NULL,
    [PigGroupID]    CHAR (10)     NOT NULL,
    [SiteContactID] CHAR (6)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);

