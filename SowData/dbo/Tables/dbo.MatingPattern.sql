CREATE TABLE [dbo].[MatingPattern] (
    [Id]       INT         IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [GenLevel] VARCHAR (2) NULL,
    [Dam]      CHAR (10)   NULL,
    [Sire]     CHAR (10)   NULL,
    [Litter]   CHAR (10)   NULL
);

