CREATE TABLE [caredata].[LOOKUP_MERGE_RULES] (
    [lookup_category] VARCHAR (30) NOT NULL,
    [name_from]       VARCHAR (40) NOT NULL,
    [name_to]         VARCHAR (40) NOT NULL,
    [delete_from]     BIT          CONSTRAINT [DF_LOOKUP_MERGE_RULES_delete_from] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_LOOKUP_MERGE_RULES] PRIMARY KEY CLUSTERED ([lookup_category] ASC, [name_from] ASC) WITH (FILLFACTOR = 80)
);

