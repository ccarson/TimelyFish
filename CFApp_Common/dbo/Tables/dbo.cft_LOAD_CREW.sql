CREATE TABLE [dbo].[cft_LOAD_CREW] (
    [LoadCrewID]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LoadCrewName]    VARCHAR (50) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_LOAD_CREW_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    [UpdatedDateTime] DATETIME     NULL,
    CONSTRAINT [PK_cft_LOAD_CREW] PRIMARY KEY CLUSTERED ([LoadCrewID] ASC) WITH (FILLFACTOR = 90)
);

