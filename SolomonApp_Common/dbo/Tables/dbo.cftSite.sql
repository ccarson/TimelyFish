CREATE TABLE [dbo].[cftSite] (
    [AugerRatePerHour]     FLOAT (53)    NOT NULL,
    [AugerType]            CHAR (30)     NOT NULL,
    [CollateralHolderPigs] CHAR (50)     NOT NULL,
    [CollateralHolderProp] CHAR (50)     NOT NULL,
    [CompanyName]          CHAR (25)     NOT NULL,
    [ContactID]            CHAR (6)      NOT NULL,
    [ContractCpnyID]       CHAR (10)     NOT NULL,
    [CpnyID]               CHAR (10)     NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME NOT NULL,
    [Crtd_Prog]            CHAR (8)      NOT NULL,
    [Crtd_User]            CHAR (10)     NOT NULL,
    [DefaultPigCpnyID]     CHAR (10)     NOT NULL,
    [DeliverFeedFlag]      SMALLINT      NOT NULL,
    [FacilityTypeID]       CHAR (3)      NOT NULL,
    [FeedGrouping]         CHAR (30)     NOT NULL,
    [FeedlotRegNbr]        CHAR (20)     NOT NULL,
    [FeedMillContactID]    CHAR (6)      NOT NULL,
    [FeedOrderComments]    CHAR (60)     NOT NULL,
    [FeedOrderDay]         CHAR (10)     NOT NULL,
    [FeedTransferLocation] CHAR (30)     NOT NULL,
    [FeedTransferTons]     FLOAT (53)    NOT NULL,
    [GeneratorTypeID]      CHAR (2)      NOT NULL,
    [GeoState]             CHAR (3)      NOT NULL,
    [Lupd_DateTime]        SMALLDATETIME NOT NULL,
    [Lupd_Prog]            CHAR (8)      NOT NULL,
    [Lupd_User]            CHAR (10)     NOT NULL,
    [OfficeLocation]       CHAR (30)     NOT NULL,
    [OfficeSize]           CHAR (30)     NOT NULL,
    [OverheadPwrLinesFlag] SMALLINT      NOT NULL,
    [OwnershipLevelID]     CHAR (2)      NOT NULL,
    [OwnershipTypeID]      CHAR (2)      NOT NULL,
    [OwningCpnyID]         CHAR (10)     NOT NULL,
    [PFEUClassification]   CHAR (30)     NOT NULL,
    [PigSystemID]          CHAR (2)      NOT NULL,
    [PortChuteFlg]         SMALLINT      NOT NULL,
    [PremiseID]            CHAR (30)     NOT NULL,
    [RoadRestrictionTons]  SMALLINT      NOT NULL,
    [SiteAcres]            FLOAT (53)    NOT NULL,
    [SiteID]               CHAR (4)      NOT NULL,
    [SiteMgrContactID]     CHAR (6)      NOT NULL,
    [SolomonProjectID]     CHAR (16)     NOT NULL,
    [SwapAssessorContID]   INT           NOT NULL,
    [WallMapPinLocation]   CHAR (10)     NOT NULL,
    [WallMapPinNbr]        CHAR (10)     NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [cftSite0] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftSiteBioSecure]
    ON [dbo].[cftSite]([FeedOrderComments] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_cftSite_sitemgrcontactid_contactid]
    ON [dbo].[cftSite]([SiteMgrContactID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90);

