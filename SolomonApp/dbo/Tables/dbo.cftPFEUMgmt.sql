CREATE TABLE [dbo].[cftPFEUMgmt] (
    [CallTakenByUser] CHAR (10)     NOT NULL,
    [Crtd_Date]       SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [DateIneligible]  SMALLDATETIME NOT NULL,
    [DateOfPLCall]    SMALLDATETIME NOT NULL,
    [DateOfTop]       SMALLDATETIME NOT NULL,
    [FirstPLDelvDate] SMALLDATETIME NOT NULL,
    [LUpd_Date]       SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [PayleanSFP]      SMALLINT      NOT NULL,
    [PFEUIneligible]  SMALLINT      NOT NULL,
    [PigGroupID]      CHAR (10)     NOT NULL,
    [TopVerified]     SMALLINT      NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [cftPFEUMgmt0] PRIMARY KEY CLUSTERED ([PigGroupID] ASC) WITH (FILLFACTOR = 90)
);

