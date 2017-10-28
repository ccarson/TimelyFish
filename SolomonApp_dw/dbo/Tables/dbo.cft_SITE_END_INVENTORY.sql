CREATE TABLE [dbo].[cft_SITE_END_INVENTORY] (
    [FeedMill]     CHAR (100)    NULL,
    [SiteID]       CHAR (100)    NULL,
    [BarnNbr]      CHAR (100)    NULL,
    [RoomNbr]      CHAR (100)    NULL,
    [PigGroupID]   CHAR (100)    NULL,
    [SiteBarnRoom] CHAR (100)    NULL,
    [FacilityType] CHAR (100)    NULL,
    [Capacity]     INT           NULL,
    [WeekEndDate]  SMALLDATETIME NULL,
    [EndInventory] INT           NULL
);

