CREATE TABLE [dbo].[cft_IM_Campaigns] (
    [CampaignID]  INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (MAX) NULL,
    [Description] NVARCHAR (MAX) NULL,
    [status]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.cft_IM_Campaigns] PRIMARY KEY CLUSTERED ([CampaignID] ASC) WITH (FILLFACTOR = 90)
);

