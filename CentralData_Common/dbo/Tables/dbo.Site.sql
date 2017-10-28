CREATE TABLE [dbo].[Site] (
    [ContactID]                           INT              NOT NULL,
    [SiteID]                              VARCHAR (4)      NOT NULL,
    [AccountingEntityID]                  INT              NOT NULL,
    [DefaultPigCompanyID]                 INT              NULL,
    [FacilityTypeID]                      INT              NOT NULL,
    [OwnershipID]                         INT              NULL,
    [OwnershipLevelID]                    INT              NULL,
    [DepartmentCode]                      INT              CONSTRAINT [DF_Site_DepartmentCode] DEFAULT (0) NULL,
    [PigRelatedGLCode]                    VARCHAR (4)      CONSTRAINT [DF_Site_PigRelatedGLCode] DEFAULT (0) NULL,
    [OtherGLCode]                         VARCHAR (4)      CONSTRAINT [DF_Site_OtherGLCode] DEFAULT (0) NULL,
    [PremiseID]                           VARCHAR (30)     NULL,
    [RoadRestrictionTons]                 INT              NULL,
    [RoundTripHours]                      FLOAT (53)       NULL,
    [RoundTripMiles]                      FLOAT (53)       NULL,
    [RestrictRoundTripHours]              FLOAT (53)       NULL,
    [RestrictRoundTripMiles]              FLOAT (53)       NULL,
    [OneWayMiles]                         FLOAT (53)       NULL,
    [OneWayRestrictionMiles]              FLOAT (53)       NULL,
    [FeedTransferLocation]                VARCHAR (30)     NULL,
    [FeedTransferTons]                    FLOAT (53)       NULL,
    [AugerType]                           VARCHAR (30)     NULL,
    [AugerRatePerHour]                    FLOAT (53)       NULL,
    [DeliverFeedFlag]                     SMALLINT         CONSTRAINT [DF_Site_DeliverFeedFlag] DEFAULT ((-1)) NULL,
    [FeedOrderComments]                   VARCHAR (60)     NULL,
    [FeedMillContactID]                   INT              CONSTRAINT [DF_Site_FeedMillContactID] DEFAULT (1327) NULL,
    [PFEUClassification]                  VARCHAR (30)     CONSTRAINT [DF_Site_PFEUClassification] DEFAULT ('Pending') NOT NULL,
    [OverheadPowerLinesFlag]              SMALLINT         CONSTRAINT [DF_Site_OverheadPowerLinesFlag] DEFAULT (0) NULL,
    [OfficeLocaction]                     VARCHAR (30)     NULL,
    [OfficeSize]                          VARCHAR (30)     NULL,
    [SiteAcres]                           FLOAT (53)       NULL,
    [CollateralHolderProperty]            VARCHAR (50)     NULL,
    [CollateralHolderPigs]                VARCHAR (50)     NULL,
    [MAS90JobNumber]                      VARCHAR (10)     NULL,
    [FeedGrouping]                        VARCHAR (10)     NULL,
    [SiteMgrContactID]                    INT              NULL,
    [GeneratorTypeID]                     INT              NULL,
    [FeedOrderDay]                        VARCHAR (50)     CONSTRAINT [DF_Site_FeedOrderDay] DEFAULT ('Thursday') NULL,
    [WallMapPinNbr]                       VARCHAR (50)     NULL,
    [WallMapPinLocation]                  VARCHAR (50)     NULL,
    [CompanyName]                         VARCHAR (25)     NULL,
    [SolomonProjectID]                    CHAR (16)        NULL,
    [PigSystemID]                         INT              NULL,
    [ContractCpnyID]                      INT              NULL,
    [OwningCpnyID]                        INT              NULL,
    [PortChuteFlg]                        SMALLINT         NULL,
    [GeoState]                            CHAR (3)         NULL,
    [ManureAppComm]                       VARCHAR (50)     NULL,
    [SwapAssessorContID]                  INT              NULL,
    [FeedlotRegNbr]                       VARCHAR (20)     NULL,
    [AutomateInterstatePigMovementReport] BIT              NULL,
    [msrepl_tran_version]                 UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [BioSecurityLevel]                    VARCHAR (20)     NULL,
    CONSTRAINT [PK_Site] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Site_Contact] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contact] ([ContactID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [FeedGrouping]
    ON [dbo].[Site]([FeedGrouping] ASC) WITH (FILLFACTOR = 90);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Site] TO [hybridconnectionlogin_permissions]
    AS [dbo];
