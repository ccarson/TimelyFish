CREATE TABLE [stage].[ORIGIN_FARMS] (
    [Origin_site_id]      INT    NOT NULL,
    [Origin_farm_name]    VARCHAR (30)     NOT NULL,
	[farm_id]          INT   NOT NULL,
    [SequentialGUID]   UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]       AS               (CONVERT([nvarchar](36),[SequentialGUID])),
    PRIMARY KEY CLUSTERED ([Origin_site_id], [farm_id])
);