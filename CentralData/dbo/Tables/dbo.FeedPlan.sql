CREATE TABLE [dbo].[FeedPlan] (
    [FeedPlanID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FeedPlanDescription] VARCHAR (50) NULL,
    [PFEUIneligible]      SMALLINT     NULL,
    CONSTRAINT [PK_FeedPlan] PRIMARY KEY CLUSTERED ([FeedPlanID] ASC) WITH (FILLFACTOR = 90)
);

