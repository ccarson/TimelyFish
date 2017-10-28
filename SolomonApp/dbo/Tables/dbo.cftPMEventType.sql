CREATE TABLE [dbo].[cftPMEventType] (
    [Active]        SMALLINT      NOT NULL,
    [crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     VARCHAR (8)   NOT NULL,
    [crtd_User]     VARCHAR (20)  NOT NULL,
    [Descr]         VARCHAR (50)  NULL,
    [IDPMEvent]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     VARCHAR (8)   NULL,
    [Lupd_User]     VARCHAR (20)  NULL,
    [PMEvent]       VARCHAR (20)  NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPMEventType0] PRIMARY KEY CLUSTERED ([IDPMEvent] ASC) WITH (FILLFACTOR = 80)
);

