CREATE TABLE [dbo].[cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF] (
    [TaskID]     CHAR (10)  NOT NULL,
    [PGStatusID] CHAR (2)   NOT NULL,
    [Phase]      CHAR (30)  NOT NULL,
    [Avg_TI]     FLOAT (53) NULL,
    [Avg_TO]     FLOAT (53) NULL,
    [Avg_PS]     FLOAT (53) NULL,
    [GroupType]  CHAR (12)  NOT NULL
);

