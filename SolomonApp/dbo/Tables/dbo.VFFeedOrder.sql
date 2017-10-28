CREATE TABLE [dbo].[VFFeedOrder] (
    [SiteID]     CHAR (10) NULL,
    [BarnID]     CHAR (10) NULL,
    [OrdDate]    CHAR (10) NULL,
    [FeedType]   CHAR (10) NULL,
    [Qty]        CHAR (10) NULL,
    [NeedDate]   CHAR (10) NULL,
    [PigGroupID] CHAR (10) NOT NULL,
    CONSTRAINT [PK_VFFeedOrder] PRIMARY KEY CLUSTERED ([PigGroupID] ASC) WITH (FILLFACTOR = 90)
);

