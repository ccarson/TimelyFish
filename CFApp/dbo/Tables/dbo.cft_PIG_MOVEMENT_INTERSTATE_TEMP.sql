CREATE TABLE [dbo].[cft_PIG_MOVEMENT_INTERSTATE_TEMP] (
    [PigMovementInterstateID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PMID]                    VARCHAR (10)  NULL,
    [PMLoadID]                VARCHAR (10)  NULL,
    [SourceContactID]         CHAR (10)     NOT NULL,
    [MovementDate]            SMALLDATETIME NOT NULL,
    [DestContactID]           CHAR (10)     NOT NULL,
    [CreatedDateTime]         DATETIME      CONSTRAINT [DF_cft_PIG_MOVEMENT_INTERSTATE_TEMP_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_cft_PIG_MOVEMENT_INTERSTATE_TEMP] PRIMARY KEY CLUSTERED ([PigMovementInterstateID] ASC) WITH (FILLFACTOR = 90)
);

