CREATE TABLE [dbo].[WrkBenefit] (
    [BenId]        CHAR (10)  NOT NULL,
    [BenType]      CHAR (1)   NOT NULL,
    [CpnyID]       CHAR (10)  NOT NULL,
    [EarnTypeId]   CHAR (10)  NOT NULL,
    [LineNbr]      SMALLINT   NOT NULL,
    [MaxCarryOver] FLOAT (53) NOT NULL,
    [MaxCumAvail]  FLOAT (53) NOT NULL,
    [MonthsEmp]    SMALLINT   NOT NULL,
    [NoteId]       INT        NOT NULL,
    [RateAnn]      FLOAT (53) NOT NULL,
    [RateBwk]      FLOAT (53) NOT NULL,
    [RateHour]     FLOAT (53) NOT NULL,
    [RateMon]      FLOAT (53) NOT NULL,
    [RateSmon]     FLOAT (53) NOT NULL,
    [RateWeek]     FLOAT (53) NOT NULL,
    [tstamp]       ROWVERSION NOT NULL,
    CONSTRAINT [WrkBenefit0] PRIMARY KEY CLUSTERED ([BenId] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);

