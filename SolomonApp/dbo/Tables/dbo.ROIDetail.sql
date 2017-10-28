CREATE TABLE [dbo].[ROIDetail] (
    [CriteriaLVal] CHAR (100) NOT NULL,
    [CriteriaOp]   CHAR (11)  NOT NULL,
    [Field]        CHAR (41)  NOT NULL,
    [LineID]       INT        NOT NULL,
    [LineNbr]      SMALLINT   NOT NULL,
    [Operator]     CHAR (3)   NOT NULL,
    [PageBreak]    SMALLINT   NOT NULL,
    [RI_ID]        SMALLINT   NOT NULL,
    [SortAscend]   SMALLINT   NOT NULL,
    [SortNbr]      SMALLINT   NOT NULL,
    [TotalBreak]   SMALLINT   NOT NULL,
    [tstamp]       ROWVERSION NOT NULL,
    CONSTRAINT [ROIDetail0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [LineNbr] ASC, [LineID] ASC) WITH (FILLFACTOR = 90)
);

