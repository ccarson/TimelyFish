CREATE TABLE [dbo].[ComponentClass] (
    [ComponentClassID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ComponentClassDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_Component] PRIMARY KEY CLUSTERED ([ComponentClassID] ASC) WITH (FILLFACTOR = 90)
);

