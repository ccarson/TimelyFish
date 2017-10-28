CREATE TABLE [dbo].[EssbaseGeneticUploadTemp] (
    [RecordID] BIGINT     IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Week]     CHAR (10)  NOT NULL,
    [FarmID]   CHAR (10)  NOT NULL,
    [FarmSow]  CHAR (25)  NOT NULL,
    [Genetics] CHAR (20)  NOT NULL,
    [Account]  CHAR (20)  NOT NULL,
    [Value]    FLOAT (53) NOT NULL
);

