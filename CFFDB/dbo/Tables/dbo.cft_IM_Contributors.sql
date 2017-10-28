CREATE TABLE [dbo].[cft_IM_Contributors] (
    [ContributorID] INT            IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (MAX) NULL,
    [Email]         NVARCHAR (MAX) NULL,
    [Phone]         VARCHAR (15)   NULL,
    CONSTRAINT [PK_dbo.cft_IM_Contributors] PRIMARY KEY CLUSTERED ([ContributorID] ASC) WITH (FILLFACTOR = 90)
);

