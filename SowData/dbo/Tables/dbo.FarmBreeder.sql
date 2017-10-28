CREATE TABLE [dbo].[FarmBreeder] (
    [FarmBreederID] INT         IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]        VARCHAR (5) NULL,
    [BreederID]     VARCHAR (3) NULL
);

