CREATE TABLE [dbo].[CropType] (
    [CropTypeDescription] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_CropType] PRIMARY KEY CLUSTERED ([CropTypeDescription] ASC) WITH (FILLFACTOR = 90)
);

