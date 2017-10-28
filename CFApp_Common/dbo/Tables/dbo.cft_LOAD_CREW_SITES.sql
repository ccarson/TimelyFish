CREATE TABLE [dbo].[cft_LOAD_CREW_SITES] (
    [LoadCrewSiteID]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LoadCrewID]       INT          NOT NULL,
    [ContactID]        INT          NOT NULL,
    [AssignedFromDate] DATETIME     NULL,
    [AssignedToDate]   DATETIME     NULL,
    [CreatedBy]        VARCHAR (50) NOT NULL,
    [CreatedDateTime]  DATETIME     CONSTRAINT [DF_cft_LOAD_CREW_SITES_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]        VARCHAR (50) NULL,
    [UpdatedDateTime]  DATETIME     NULL,
    CONSTRAINT [PK_cft_LOAD_CREW_SITES_1] PRIMARY KEY CLUSTERED ([LoadCrewSiteID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_LOAD_CREW_SITES_cft_LOAD_CREW] FOREIGN KEY ([LoadCrewID]) REFERENCES [dbo].[cft_LOAD_CREW] ([LoadCrewID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_LOAD_CREW_SITES_ContactID]
    ON [dbo].[cft_LOAD_CREW_SITES]([ContactID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_LOAD_CREW_SITES_LoadCrewID_ContactID]
    ON [dbo].[cft_LOAD_CREW_SITES]([LoadCrewID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90);

