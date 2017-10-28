CREATE TABLE [dbo].[KSYNCFIELDS] (
    [TABLENAME]         VARCHAR (32)  NOT NULL,
    [FIELDNAME]         VARCHAR (32)  NOT NULL,
    [NAME]              VARCHAR (32)  NULL,
    [LABEL]             VARCHAR (32)  NULL,
    [DEFAULT_TYPE]      CHAR (2)      NULL,
    [DEFAULT_VALUE]     VARCHAR (254) NULL,
    [IS_UPDATABLE]      CHAR (1)      NULL,
    [IS_REQUIRED]       CHAR (1)      NULL,
    [IS_HIDDEN]         CHAR (1)      NULL,
    [ALLOW_FKEY_ASSIGN] CHAR (1)      NULL,
    [ALLOW_LOOKUPLINK]  CHAR (1)      NULL,
    [ALLOW_DATALINK]    CHAR (1)      NULL,
    [PARAM_TYPE]        CHAR (2)      DEFAULT ('N') NULL,
    [RESULT_PARAM]      CHAR (2)      DEFAULT ('N') NULL,
    [V_TYPE]            INT           NULL,
    [V_SIZE]            INT           NULL,
    [REMARKS]           VARCHAR (254) NULL,
    PRIMARY KEY CLUSTERED ([TABLENAME] ASC, [FIELDNAME] ASC) WITH (FILLFACTOR = 90)
);

