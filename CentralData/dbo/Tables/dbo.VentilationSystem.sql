CREATE TABLE [dbo].[VentilationSystem] (
    [VentilationSystemID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [VentilationSystemDescription] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_VentilationSystem] PRIMARY KEY CLUSTERED ([VentilationSystemID] ASC) WITH (FILLFACTOR = 90)
);

