CREATE TABLE [dbo].[cft_PIG_GROUP_CENSUS] (
    [PigGroupID]          CHAR (10)      NOT NULL,
    [PigProdPhaseID]      CHAR (3)       NOT NULL,
    [PhaseDesc]           CHAR (30)      NULL,
    [SiteContactID]       CHAR (6)       NULL,
    [SvcManager]          VARCHAR (100)  NULL,
    [SrSvcManager]        VARCHAR (100)  NULL,
    [Description]         CHAR (30)      NULL,
    [PodDescription]      CHAR (30)      NULL,
    [PICYear_Week]        CHAR (6)       NOT NULL,
    [CurrentInv]          INT            NULL,
    [PigDeaths]           INT            NULL,
    [CumulativePigDeaths] INT            NULL,
    [HeadStarted]         INT            NULL,
    [PigFlowID]           INT            NULL,
    [NurserySource]       VARCHAR (4000) NULL,
    [PigFlowStartDate]    DATETIME       NULL,
    [reportinggroupid]    INT            NULL,
    CONSTRAINT [PK_cft_PIG_GROUP_CENSUS] PRIMARY KEY CLUSTERED ([PigGroupID] ASC, [PigProdPhaseID] ASC, [PICYear_Week] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_PIG_GROUP_CENSUS_SiteContactID]
    ON [dbo].[cft_PIG_GROUP_CENSUS]([SiteContactID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_cft_PIG_GROUP_CENSUS_PigFlowID]
    ON [dbo].[cft_PIG_GROUP_CENSUS]([PigFlowID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ix_cft_PIG_GROUP_CENSUS_PicYear_Week_Include]
    ON [dbo].[cft_PIG_GROUP_CENSUS]([PICYear_Week] ASC)
    INCLUDE([PigGroupID], [PigProdPhaseID], [SiteContactID], [SvcManager], [SrSvcManager], [PodDescription], [CurrentInv], [PigDeaths], [CumulativePigDeaths], [HeadStarted], [PigFlowID], [NurserySource], [PigFlowStartDate], [reportinggroupid]) WITH (FILLFACTOR = 100);

