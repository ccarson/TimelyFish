CREATE TABLE [dbo].[cftSafedataFO] (
    [BarnNbr]       VARCHAR (10) NOT NULL,
    [Crtd_DT]       DATETIME     NOT NULL,
    [Call_DT]       DATETIME     NOT NULL,
    [SDI_Nbr]       VARCHAR (6)  NOT NULL,
    [Reason]        INT          NOT NULL,
    [Duration]      INT          NOT NULL,
    [SiteContactID] VARCHAR (6)  NOT NULL,
    CONSTRAINT [cftSafedataFO_PK] PRIMARY KEY CLUSTERED ([SDI_Nbr] ASC) WITH (FILLFACTOR = 80)
);

