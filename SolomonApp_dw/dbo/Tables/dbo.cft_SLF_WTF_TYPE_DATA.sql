CREATE TABLE [dbo].[cft_SLF_WTF_TYPE_DATA] (
    [FlowGroup]               CHAR (10)     NOT NULL,
    [FlowGroupDescription]    CHAR (50)     NOT NULL,
    [Group_Number]            CHAR (50)     NOT NULL,
    [DestPhase]               CHAR (3)      NOT NULL,
    [DestContactID]           CHAR (6)      NOT NULL,
    [DestFacilityType]        CHAR (30)     NOT NULL,
    [SourcePhase]             CHAR (3)      NULL,
    [SourceContactID]         CHAR (6)      NOT NULL,
    [SourceFacilityType]      CHAR (30)     NULL,
    [SourceDescription]       CHAR (30)     NOT NULL,
    [SourceMaxCapacity]       SMALLINT      NULL,
    [SourceHeadStarted]       INT           NULL,
    [Inv_Day21]               INT           NULL,
    [HS_Cap_Ratio]            FLOAT (53)    NULL,
    [Inv21_Cap_Ratio]         FLOAT (53)    NULL,
    [SourcePigGroup]          CHAR (10)     NULL,
    [SourcePigGroupStartDate] SMALLDATETIME NULL,
    [SourceWtTransIn]         FLOAT (53)    NULL,
    [SourceWtTransOut]        FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([Group_Number] ASC) WITH (FILLFACTOR = 90)
);

