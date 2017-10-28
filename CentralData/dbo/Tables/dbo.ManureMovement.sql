CREATE TABLE [dbo].[ManureMovement] (
    [ManureMovementID]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureMovementTypeID]    INT          NOT NULL,
    [OtherDescription]        VARCHAR (30) NULL,
    [SiteIDFrom]              VARCHAR (4)  NULL,
    [SiteContactIDFrom]       INT          NULL,
    [ManureStructureFrom]     INT          NULL,
    [SiteContactIDTo]         INT          NULL,
    [SiteIDTo]                VARCHAR (4)  NULL,
    [ManureStructureTo]       INT          NULL,
    [ManureApplicationPlanID] INT          NULL,
    [StartPitMeasurement]     FLOAT (53)   NULL,
    [FinishPitMeasurement]    FLOAT (53)   NULL,
    [Comment]                 VARCHAR (60) NULL,
    CONSTRAINT [PK_ManureRemoval] PRIMARY KEY CLUSTERED ([ManureMovementID] ASC) WITH (FILLFACTOR = 90)
);

