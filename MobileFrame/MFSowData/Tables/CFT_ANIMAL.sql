﻿CREATE TABLE [deleted].[CFT_ANIMAL](
	[ID] [nvarchar](36) NOT NULL,
	[CREATE_DATE] [datetime] NOT NULL,
	[LAST_UPDATE] [datetime] NOT NULL,
	[CREATED_BY] [bigint] NOT NULL,
	[LAST_UPDATED_BY] [bigint] NOT NULL,
	[DELETED_BY] [bigint] NOT NULL,
	[BIRTHDATE] [datetime] NULL,
	[GENETICSID] [nvarchar](36) NULL,
	[ORIGIN] [nvarchar](50) NULL,
	[SEX] [nvarchar](10) NULL,
	[ORIGINID] [nvarchar](36) NULL,
	[PIGCHAMP_ID] [bigint] NULL,
	[PRINTFLAG] [nvarchar](1) NULL,
	[DEVICEFARMID] [nvarchar](36) NULL,
	[ACTIVE] [nvarchar](1) NULL,
 CONSTRAINT [CFT_ANIMAL_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
