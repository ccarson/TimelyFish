CREATE TABLE [dbo].[MrgBreedingTransaction] (
    [Record_Sta]        TINYINT     NULL,
    [Remote_Cmp]        INT         IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]            VARCHAR (3) NOT NULL,
    [FormSerialID]      VARCHAR (8) NOT NULL,
    [Time_Stamp]        DATETIME    NULL,
    [AlternateIDSuffix] CHAR (1)    NULL
);

