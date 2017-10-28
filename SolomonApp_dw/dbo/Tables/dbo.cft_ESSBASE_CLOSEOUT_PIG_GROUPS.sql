CREATE TABLE [dbo].[cft_ESSBASE_CLOSEOUT_PIG_GROUPS] (
    [LocNbr]                    CHAR (16)     NOT NULL,
    [Site]                      CHAR (50)     NOT NULL,
    [TaskID]                    CHAR (32)     NOT NULL,
    [PGDescription]             CHAR (60)     NOT NULL,
    [MasterGroup]               CHAR (10)     NOT NULL,
    [ActCloseDate]              SMALLDATETIME NOT NULL,
    [ActStartDate]              SMALLDATETIME NOT NULL,
    [BarnNbr]                   CHAR (12)     NOT NULL,
    [PodDescription]            CHAR (30)     NOT NULL,
    [PGStatusID]                CHAR (2)      NOT NULL,
    [System]                    CHAR (30)     NOT NULL,
    [Gender]                    CHAR (30)     NOT NULL,
    [Phase]                     CHAR (30)     NOT NULL,
    [FeedMill]                  CHAR (50)     NOT NULL,
    [PGServManager]             CHAR (50)     NOT NULL,
    [PGSrServManager]           CHAR (50)     NOT NULL,
    [PigFlowDescription]        VARCHAR (100) NOT NULL,
    [ReportingGroupDescription] VARCHAR (100) NOT NULL,
    [GroupType]                 CHAR (12)     NOT NULL,
    [NurFloorType]              CHAR (80)     NOT NULL,
    [BarnFeederType]            CHAR (50)     NOT NULL
);

