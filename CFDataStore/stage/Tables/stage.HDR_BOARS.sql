CREATE TABLE [stage].[HDR_BOARS] (
    [ID]               BIGINT           IDENTITY (1, 1) NOT NULL,
    [identity_id]      INT              NOT NULL,
    [genetics_id]      INT              NULL,
    [herd_category_id] INT              NULL,
    [date_of_birth]    DATETIME         NULL,
    [vasectomized]     SMALLINT         NULL,
    [origin_id]        INT              NULL,
    [MFGUID]           VARCHAR (36)     NULL,
    [unique_id]		UNIQUEIDENTIFIER NULL, 
    [SourceGUID]       AS               (CONVERT([nvarchar](36),[unique_id])),
    CONSTRAINT [PK_HDR_BOARS] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 100)
);





