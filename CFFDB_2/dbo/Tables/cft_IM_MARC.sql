CREATE TABLE [dbo].[cft_IM_MARC] (
    [ID]     INT          IDENTITY (1, 1) NOT NULL,
    [IdeaID] INT          NOT NULL,
    [userID] VARCHAR (50) NOT NULL,
    [M]      INT          NOT NULL,
    [A]      INT          NOT NULL,
    [R]      INT          NOT NULL,
    [C]      INT          NOT NULL,
    CONSTRAINT [PK_dbo.cft_IM_MARC] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_dbo.cft_IM_MARC_dbo.cft_IM_Ideas_IdeaID] FOREIGN KEY ([IdeaID]) REFERENCES [dbo].[cft_IM_Ideas] ([IdeaID]) ON DELETE CASCADE
);

