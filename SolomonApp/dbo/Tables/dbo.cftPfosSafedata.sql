CREATE TABLE [dbo].[cftPfosSafedata] (
    [BinNbr]        VARCHAR (10) NOT NULL,
    [Crtd_DT]       DATETIME     NOT NULL,
    [Call_DT]       DATETIME     NOT NULL,
    [SDI_Nbr]       VARCHAR (6)  NOT NULL,
    [PigGroupID]    INT          NOT NULL,
    [Statusflg]     CHAR (1)     NOT NULL,
    [SiteContactID] VARCHAR (6)  NOT NULL,
    CONSTRAINT [cftPfosSafedata0] PRIMARY KEY CLUSTERED ([SDI_Nbr] ASC) WITH (FILLFACTOR = 80)
);

