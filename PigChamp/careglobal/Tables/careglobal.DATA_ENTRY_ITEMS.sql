CREATE TABLE [careglobal].[DATA_ENTRY_ITEMS] (
    [category]      VARCHAR (30)   CONSTRAINT [DF_DATA_ENTRY_ITEMS_category] DEFAULT ('___Standard') NOT NULL,
    [eventcode]     SMALLINT       NOT NULL,
    [data_item_key] SMALLINT       NOT NULL,
    [column_name]   VARCHAR (40)   CONSTRAINT [DF_DATA_ENTRY_ITEMS_column_name] DEFAULT ('STANDARD') NOT NULL,
    [datatype]      VARCHAR (2)    NOT NULL,
    [lookup_code]   VARCHAR (3)    NULL,
    [prompt]        VARCHAR (90)   NULL,
    [label]         VARCHAR (30)   NOT NULL,
    [mobile_label]  VARCHAR (20)   NULL,
    [position]      TINYINT        CONSTRAINT [DF_DATA_ENTRY_ITEMS_position] DEFAULT ((99)) NOT NULL,
    [active]        BIT            CONSTRAINT [DF_DATA_ENTRY_ITEMS_active] DEFAULT ((0)) NOT NULL,
    [compulsary]    BIT            CONSTRAINT [DF_DATA_ENTRY_ITEMS_compulsary] DEFAULT ((0)) NOT NULL,
    [numberchars]   SMALLINT       NULL,
    [numberdecs]    TINYINT        NULL,
    [min_value]     FLOAT (53)     NULL,
    [max_value]     FLOAT (53)     NULL,
    [options]       VARCHAR (1000) NULL,
    [default_value] VARCHAR (50)   NULL,
    [default_type]  VARCHAR (2)    NULL,
    [required]      BIT            NULL,
    CONSTRAINT [PK_DATA_ENTRY_ITEMS] PRIMARY KEY CLUSTERED ([category] ASC, [eventcode] ASC, [data_item_key] ASC, [column_name] ASC) WITH (FILLFACTOR = 80)
);

