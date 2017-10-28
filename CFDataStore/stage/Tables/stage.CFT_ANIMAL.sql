CREATE TABLE [stage].[CFT_ANIMAL] (
  [ID] [nvarchar](36) NOT NULL,
	[CREATE_DATE] [datetime] NOT NULL ,
	[LAST_UPDATE] [datetime] NOT NULL,
	[CREATED_BY] [bigint] NOT NULL ,
	[LAST_UPDATED_BY] [bigint] NOT NULL ,
	[DELETED_BY] [bigint] NOT NULL,
	[BIRTHDATE] [datetime] NULL,
	[GENETICSID] [nvarchar](36) NULL,
	[SEX] [nvarchar](10) NULL,
	[ORIGIN] [nvarchar](50) NULL,
	[ORIGINID] [nvarchar](36) NULL,
	[PIGCHAMP_ID] [bigint] NULL,
	[PRINTFLAG] [nvarchar](1) NULL,
	[DEVICEFARMID] [nvarchar](36) NULL,
	[ACTIVE] [nvarchar](1) NULL,
    CONSTRAINT [CFT_ANIMAL_PK] PRIMARY KEY CLUSTERED ([ID] ASC)
);



