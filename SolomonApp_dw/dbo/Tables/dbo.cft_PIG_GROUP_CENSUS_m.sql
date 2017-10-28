CREATE TABLE [dbo].[cft_PIG_GROUP_CENSUS_m] (
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
    CONSTRAINT [PK_cft_PIG_GROUP_CENSUS_m] PRIMARY KEY CLUSTERED ([PigGroupID] ASC, [PigProdPhaseID] ASC, [PICYear_Week] ASC) WITH (FILLFACTOR = 100)
);

