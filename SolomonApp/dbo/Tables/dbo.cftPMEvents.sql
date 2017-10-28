CREATE TABLE [dbo].[cftPMEvents] (
    [PM_Event_ID]     INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]       INT             NULL,
    [ParentContactID] INT             NULL,
    [crtd_DateTime]   SMALLDATETIME   NOT NULL,
    [Crtd_Prog]       VARCHAR (8)     NOT NULL,
    [crtd_User]       VARCHAR (20)    NOT NULL,
    [EventID]         INT             NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME   NULL,
    [Lupd_Prog]       VARCHAR (8)     NULL,
    [Lupd_User]       VARCHAR (20)    NULL,
    [PMID]            CHAR (10)       NULL,
    [Event_Value]     DECIMAL (18, 2) NULL,
    [Event_Comment]   VARCHAR (MAX)   NULL,
    CONSTRAINT [PK_cftPMEvents] PRIMARY KEY CLUSTERED ([PM_Event_ID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_cftPMEvents_2_cftPMEventType] FOREIGN KEY ([EventID]) REFERENCES [dbo].[cftPMEventType] ([IDPMEvent])
);

