CREATE TABLE [dbo].[cftFeedFlowSite] (
    [Crtd_dateTime]      DATETIME     NOT NULL,
    [Crtd_User]          VARCHAR (20) NOT NULL,
    [Disabled_dateTime]  DATETIME     NULL,
    [ReEnabled_dateTime] DATETIME     NULL,
    [Lupd_dateTime]      DATETIME     NULL,
    [Lupd_User]          VARCHAR (20) NULL,
    [ContactID]          INT          NOT NULL,
    [Tstamp]             ROWVERSION   NOT NULL,
    CONSTRAINT [PK_cftFeedFlowSite] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 80),
    FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Site] ([ContactID])
);

