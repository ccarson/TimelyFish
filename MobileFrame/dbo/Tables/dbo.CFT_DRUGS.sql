CREATE TABLE [dbo].[CFT_DRUGS] (
    [ID]                   BIGINT        IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]          DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]          DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]           BIGINT        DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY]      BIGINT        DEFAULT ((0)) NOT NULL,
    [DELETED_BY]           BIGINT        DEFAULT ((-1)) NOT NULL,
    [NAME]                 NVARCHAR (80) NULL,
    [MAXTIMESPERDAY]       INT           NULL,
    [MAXDAYS]              INT           NULL,
    [GILTMINDOSE]          INT           NULL,
    [GILTMAXDOSE]          INT           NULL,
    [SOWMINDOSE]           INT           NULL,
    [SOWMAXDOSE]           INT           NULL,
    [ROUTE]                NVARCHAR (2)  NULL,
    [WITHDRAWAL]           INT           NULL,
    [GILTCOSTPERTREATMENT] MONEY         NULL,
    [SOWCOSTPERTREATMENT]  MONEY         NULL,
    [ACTIVEDATE]           DATETIME      NULL,
    [DEACTIVEDATE]         DATETIME      NULL,
    CONSTRAINT [CFT_DRUGS_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

