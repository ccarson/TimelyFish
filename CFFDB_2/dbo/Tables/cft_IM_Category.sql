CREATE TABLE [dbo].[cft_IM_Category] (
    [ID]       INT          IDENTITY (1, 1) NOT NULL,
    [IdeaID]   INT          NOT NULL,
    [Category] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_dbo.cft_IM_Category] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_dbo.cft_IM_Category_dbo.cft_IM_Ideas_IdeaID] FOREIGN KEY ([IdeaID]) REFERENCES [dbo].[cft_IM_Ideas] ([IdeaID]) ON DELETE CASCADE
);

