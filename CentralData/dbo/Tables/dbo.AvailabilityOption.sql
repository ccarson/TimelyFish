CREATE TABLE [dbo].[AvailabilityOption] (
    [AvailabilityOptionID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AvailabilityOptionDescription] VARCHAR (15) NULL,
    CONSTRAINT [PK_AvailabilityOption] PRIMARY KEY CLUSTERED ([AvailabilityOptionID] ASC) WITH (FILLFACTOR = 90)
);

