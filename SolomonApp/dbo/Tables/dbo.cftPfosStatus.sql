CREATE TABLE [dbo].[cftPfosStatus] (
    [Active]        SMALLINT      NOT NULL,
    [crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [crtd_User]     CHAR (20)     NOT NULL,
    [Descr]         CHAR (50)     NULL,
    [IDPfosStatus]  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (20)     NOT NULL,
    [Name]          CHAR (20)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPfosStatus0] PRIMARY KEY CLUSTERED ([IDPfosStatus] ASC) WITH (FILLFACTOR = 80)
);

