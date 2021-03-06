﻿CREATE TABLE [dbo].[Barn] (
    [BarnID]                  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]               INT           NOT NULL,
    [SiteID]                  VARCHAR (4)   NOT NULL,
    [BarnNbr]                 VARCHAR (6)   NOT NULL,
    [BarnDescription]         VARCHAR (30)  NULL,
    [BarnStyleID]             INT           NULL,
    [FacilityTypeID]          INT           NULL,
    [StatusTypeID]            INT           CONSTRAINT [DF_Barn_StatusTypeID] DEFAULT (1) NOT NULL,
    [StdCap]                  INT           NULL,
    [CapMultiplier]           FLOAT (53)    NULL,
    [MaxCap]                  INT           NULL,
    [LossValue]               INT           NULL,
    [ManuverableWithSemiFlag] SMALLINT      CONSTRAINT [DF_Barn_ManuverableWithSemiFlag] DEFAULT (0) NULL,
    [FinFile]                 VARCHAR (30)  NULL,
    [WFFinFile2]              VARCHAR (30)  NULL,
    [LoadChuteFlag]           SMALLINT      CONSTRAINT [DF_Barn_LoadChuteFlag] DEFAULT (0) NULL,
    [WasteHandlingSys]        VARCHAR (30)  NULL,
    [DeliverFeedFlag]         SMALLINT      CONSTRAINT [DF_Barn_DeliverFeedFlag] DEFAULT ((-1)) NULL,
    [SquareFootage]           FLOAT (53)    NULL,
    [BarnManufacturer]        VARCHAR (30)  NULL,
    [DateBuilt]               VARCHAR (20)  NULL,
    [Width]                   FLOAT (53)    NULL,
    [Length]                  FLOAT (53)    NULL,
    [Height]                  FLOAT (53)    NULL,
    [BarnMgrContactID]        INT           NULL,
    [DefaultFeedPlanID]       VARCHAR (4)   CONSTRAINT [DF_Barn_DefaultFeedPlanID] DEFAULT (0) NULL,
    [DefaultRation]           VARCHAR (20)  NULL,
    [PigChampLocationID]      VARCHAR (4)   NULL,
    [VentilationType]         INT           NULL,
    [AlarmSystemType]         INT           NULL,
    [SpecialRation]           VARCHAR (10)  NULL,
    [SpecialRationBegin]      SMALLDATETIME NULL,
    [SpecialRationEnd]        SMALLDATETIME NULL,
    [DateContracted]          SMALLDATETIME NULL,
    [CenterAlleyWidth]        FLOAT (53)    NULL,
    [EmissionControlTypeID]   INT           CONSTRAINT [DF_Barn_EmissionControlTypeID] DEFAULT (4) NULL,
    [ManureSysTypeID]         INT           NULL,
    CONSTRAINT [PK_Barn] PRIMARY KEY CLUSTERED ([ContactID] ASC, [BarnNbr] ASC) WITH (FILLFACTOR = 90)
);

GO
GRANT SELECT
    ON OBJECT::[dbo].[Barn] TO [hybridconnectionlogin_permissions]
    AS [dbo];
