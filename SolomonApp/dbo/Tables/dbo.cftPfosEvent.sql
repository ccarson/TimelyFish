CREATE TABLE [dbo].[cftPfosEvent] (
    [Active]        SMALLINT      NOT NULL,
    [crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     VARCHAR (8)   NOT NULL,
    [crtd_User]     VARCHAR (20)  NOT NULL,
    [Descr]         VARCHAR (50)  NULL,
    [IDPfosEvent]   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     VARCHAR (8)   NULL,
    [Lupd_User]     VARCHAR (20)  NULL,
    [PfosEvent]     VARCHAR (20)  NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPfosEvent0] PRIMARY KEY CLUSTERED ([IDPfosEvent] ASC) WITH (FILLFACTOR = 80)
);

