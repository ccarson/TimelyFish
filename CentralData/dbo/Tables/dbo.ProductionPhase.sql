CREATE TABLE [dbo].[ProductionPhase] (
    [ProductionPhaseID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ProductionPhaseDescription] VARCHAR (50) NULL,
    [ProductionPhaseOrderCode]   SMALLINT     NULL,
    [ProductionSystemID]         SMALLINT     NULL,
    CONSTRAINT [PK_ProductionPhase] PRIMARY KEY CLUSTERED ([ProductionPhaseID] ASC) WITH (FILLFACTOR = 90)
);

