CREATE TABLE [dbo].[cftSafeLoadWgt] (
    [Call_DateTime] SMALLDATETIME NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (20)     NOT NULL,
    [Grading_Count] INT           NULL,
    [GrossWgt]      INT           NULL,
    [IDLoadWgt]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (20)     NULL,
    [PMLoadID]      CHAR (10)     NOT NULL,
    [SDI_Nbr]       CHAR (6)      NULL,
    [Statusflg]     CHAR (1)      NOT NULL,
    [TareWgt]       INT           NULL,
    [Trucker]       CHAR (30)     NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftSafeLoadWgt0] PRIMARY KEY CLUSTERED ([IDLoadWgt] ASC) WITH (FILLFACTOR = 80)
);

