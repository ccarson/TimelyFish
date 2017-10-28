CREATE TABLE [dbo].[wrkPFEUInel] (
    [BarnNbr]         CHAR (6)   NULL,
    [Comment]         CHAR (60)  NULL,
    [ContactName]     CHAR (30)  NULL,
    [FacType]         CHAR (30)  NULL,
    [Gender]          CHAR (30)  NULL,
    [LegacyGroupId]   CHAR (15)  NULL,
    [PigGroupId]      CHAR (10)  NULL,
    [RI_ID]           SMALLINT   NULL,
    [SiteContactId]   CHAR (6)   NULL,
    [SvcMgrContactID] CHAR (6)   NULL,
    [tstamp]          ROWVERSION NULL
);

