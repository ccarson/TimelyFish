CREATE TABLE [dbo].[cftFeedPlanLink] (
    [crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [crtd_User]     CHAR (20)     NOT NULL,
    [FeedPlanID]    CHAR (4)      NOT NULL,
    [FlowID]        CHAR (3)      NOT NULL,
    [GenderID]      CHAR (6)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (20)     NULL,
    [MillID]        CHAR (6)      NOT NULL,
    [SystemID]      CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftFeedPlanLink0] PRIMARY KEY CLUSTERED ([FlowID] ASC, [GenderID] ASC, [MillID] ASC, [SystemID] ASC) WITH (FILLFACTOR = 80)
);

