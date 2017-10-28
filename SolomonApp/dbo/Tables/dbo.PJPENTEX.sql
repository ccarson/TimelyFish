CREATE TABLE [dbo].[PJPENTEX] (
    [COMPUTED_DATE] SMALLDATETIME NOT NULL,
    [COMPUTED_PC]   FLOAT (53)    NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [ENTERED_PC]    FLOAT (53)    NOT NULL,
    [fee_percent]   FLOAT (53)    NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [NOTEID]        INT           NOT NULL,
    [PE_ID11]       CHAR (30)     NOT NULL,
    [PE_ID12]       CHAR (30)     NOT NULL,
    [PE_ID13]       CHAR (16)     NOT NULL,
    [PE_ID14]       CHAR (16)     NOT NULL,
    [PE_ID15]       CHAR (4)      NOT NULL,
    [PE_ID16]       FLOAT (53)    NOT NULL,
    [PE_ID17]       FLOAT (53)    NOT NULL,
    [PE_ID18]       SMALLDATETIME NOT NULL,
    [PE_ID19]       SMALLDATETIME NOT NULL,
    [PE_ID20]       INT           NOT NULL,
    [PE_ID21]       CHAR (30)     NOT NULL,
    [PE_ID22]       CHAR (30)     NOT NULL,
    [PE_ID23]       CHAR (16)     NOT NULL,
    [PE_ID24]       CHAR (16)     NOT NULL,
    [PE_ID25]       CHAR (4)      NOT NULL,
    [PE_ID26]       FLOAT (53)    NOT NULL,
    [PE_ID27]       FLOAT (53)    NOT NULL,
    [PE_ID28]       SMALLDATETIME NOT NULL,
    [PE_ID29]       SMALLDATETIME NOT NULL,
    [PE_ID30]       INT           NOT NULL,
    [PJT_ENTITY]    CHAR (32)     NOT NULL,
    [PROJECT]       CHAR (16)     NOT NULL,
    [REVISION_DATE] SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjpentex0] PRIMARY KEY CLUSTERED ([PROJECT] ASC, [PJT_ENTITY] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_PJPENTEX_01]
    ON [dbo].[PJPENTEX]([PJT_ENTITY] ASC);

