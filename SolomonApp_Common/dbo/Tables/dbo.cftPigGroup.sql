﻿CREATE TABLE [dbo].[cftPigGroup] (
    [ActCloseDate]        SMALLDATETIME NOT NULL,
    [ActStartDate]        SMALLDATETIME NOT NULL,
    [BarnNbr]             CHAR (6)      NOT NULL,
    [CF01]                CHAR (30)     NOT NULL,
    [CF02]                CHAR (30)     NOT NULL,
    [CF03]                CHAR (10)     NOT NULL,
    [CF04]                CHAR (10)     NOT NULL,
    [CF05]                SMALLDATETIME NOT NULL,
    [CF06]                SMALLDATETIME NOT NULL,
    [CF07]                INT           NOT NULL,
    [CF08]                INT           NOT NULL,
    [CF09]                SMALLINT      NULL,
    [CF10]                SMALLINT      NOT NULL,
    [CF11]                FLOAT (53)    NOT NULL,
    [CF12]                FLOAT (53)    NOT NULL,
    [Comment]             CHAR (60)     NOT NULL,
    [CostFlag]            SMALLINT      NOT NULL,
    [CpnyID]              CHAR (10)     NOT NULL,
    [Crtd_DateTime]       SMALLDATETIME NOT NULL,
    [Crtd_Prog]           CHAR (8)      NOT NULL,
    [Crtd_User]           CHAR (10)     NOT NULL,
    [Description]         CHAR (30)     NOT NULL,
    [EstCloseDate]        SMALLDATETIME NOT NULL,
    [EstInventory]        INT           NOT NULL,
    [EstStartDate]        SMALLDATETIME NOT NULL,
    [EstStartWeight]      INT           NOT NULL,
    [EstTopDate]          SMALLDATETIME NOT NULL,
    [EUCallbyUser]        CHAR (10)     NOT NULL,
    [EUDateInel]          SMALLDATETIME NOT NULL,
    [EUDatePLCall]        SMALLDATETIME NOT NULL,
    [EUDateTop]           SMALLDATETIME NOT NULL,
    [EUFirstPLDeliv]      SMALLDATETIME NOT NULL,
    [EUPFEUInel]          SMALLINT      NOT NULL,
    [EUPLSFP]             SMALLINT      NOT NULL,
    [EUTopVerified]       SMALLINT      NOT NULL,
    [FeedGrouping]        CHAR (10)     NOT NULL,
    [FeedMillContactID]   CHAR (6)      NOT NULL,
    [FeedPlanID]          CHAR (4)      NOT NULL,
    [GenderConfirmedFlag] SMALLINT      NOT NULL,
    [InitialPigValue]     FLOAT (53)    NOT NULL,
    [LegacyGroupID]       CHAR (15)     NOT NULL,
    [Lupd_DateTime]       SMALLDATETIME NOT NULL,
    [Lupd_Prog]           CHAR (8)      NOT NULL,
    [Lupd_User]           CHAR (10)     NOT NULL,
    [MasterPigGroupID]    CHAR (3)      NOT NULL,
    [NoteID]              INT           NOT NULL,
    [OverRideEstQty]      SMALLINT      NOT NULL,
    [PGStatusID]          CHAR (2)      NOT NULL,
    [PigFlowTypeID]       CHAR (3)      NOT NULL,
    [PigGenderTypeID]     CHAR (6)      NOT NULL,
    [PigGroupID]          CHAR (10)     NOT NULL,
    [PigProdPhaseID]      CHAR (3)      NOT NULL,
    [PigProdPodID]        CHAR (3)      NOT NULL,
    [PigSystemID]         CHAR (10)     NOT NULL,
    [PriorFeedQty]        FLOAT (53)    NOT NULL,
    [ProjectID]           CHAR (16)     NOT NULL,
    [PurchCountry]        CHAR (3)      NOT NULL,
    [PurchFlag]           SMALLINT      NOT NULL,
    [SingleStock]         SMALLINT      CONSTRAINT [DF_cftPigGroup_SingleStock] DEFAULT (0) NOT NULL,
    [SplitSrcPigGroupID]  CHAR (10)     NOT NULL,
    [SiteContactID]       CHAR (6)      NOT NULL,
    [TaskID]              CHAR (32)     NOT NULL,
    [UseActualsFlag]      SMALLINT      NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [cftPigGroup0] PRIMARY KEY CLUSTERED ([PigGroupID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftPigGroup1]
    ON [dbo].[cftPigGroup]([PigGroupID] ASC, [SiteContactID] ASC, [PGStatusID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftpiggroup_pgstatusid_incl]
    ON [dbo].[cftPigGroup]([PGStatusID] ASC)
    INCLUDE([CpnyID], [PigGenderTypeID], [PigGroupID], [PigProdPodID], [TaskID]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftPigGroup_CF522]
    ON [dbo].[cftPigGroup]([PigProdPhaseID] ASC)
    INCLUDE([CostFlag], [PGStatusID], [SiteContactID]);


GO
CREATE NONCLUSTERED INDEX [idx_cftpiggroup_barnnbr_site_esdate_incl]
    ON [dbo].[cftPigGroup]([BarnNbr] ASC, [EstStartDate] ASC, [SiteContactID] ASC)
    INCLUDE([PigGroupID]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftpiggroup_taskid_incl]
    ON [dbo].[cftPigGroup]([TaskID] ASC)
    INCLUDE([Description], [PigGroupID], [EstStartDate], [PGStatusID]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftpiggroup_cf08]
    ON [dbo].[cftPigGroup]([CF08] ASC, [PGStatusID] ASC, [PigProdPhaseID] ASC)
    INCLUDE([PigGroupID]) WITH (FILLFACTOR = 90);

