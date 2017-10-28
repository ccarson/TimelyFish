CREATE TABLE [dbo].[cft_IM_Ideas] (
    [IdeaID]        INT            IDENTITY (1, 1) NOT NULL,
    [CampaignID]    INT            NOT NULL,
    [ContributorID] INT            NOT NULL,
    [Description]   NVARCHAR (MAX) NULL,
    [IdeaDate]      DATETIME       NOT NULL,
    [InitialEmail]  BIT            NOT NULL,
    [EvalEmail]     BIT            NOT NULL,
    [MARC]          VARCHAR (30)   NULL,
    [Status]        VARCHAR (30)   NULL,
    [REWARD]        VARCHAR (30)   NULL,
    [Summary]       VARCHAR (255)  NULL,
    CONSTRAINT [PK_dbo.cft_IM_Ideas] PRIMARY KEY CLUSTERED ([IdeaID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_dbo.cft_IM_Ideas_dbo.cft_IM_Campaigns_CampaignID] FOREIGN KEY ([CampaignID]) REFERENCES [dbo].[cft_IM_Campaigns] ([CampaignID]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.cft_IM_Ideas_dbo.cft_IM_Contributors_ContributorID] FOREIGN KEY ([ContributorID]) REFERENCES [dbo].[cft_IM_Contributors] ([ContributorID]) ON DELETE CASCADE
);

