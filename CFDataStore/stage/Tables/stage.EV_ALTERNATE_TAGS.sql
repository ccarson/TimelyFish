CREATE TABLE [stage].[EV_ALTERNATE_TAGS] (
    [identity_id]    INT              NOT NULL,
    [tattoo]         VARCHAR (15)     NULL,
    [audit_date]     DATETIME         NULL,
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),[SequentialGUID])),
    CONSTRAINT [PK_EV_ALTERNATE_TAGS] PRIMARY KEY CLUSTERED ([identity_id] ASC) WITH (FILLFACTOR = 100)
);













