CREATE TABLE [caredata].[cft_originid_hdr_boars] (
    [identity_id]      INT          NOT NULL,
    [genetics_id]      INT          NULL,
    [herd_category_id] INT          NULL,
    [date_of_birth]    DATETIME     NULL,
    [name]             VARCHAR (30) NULL,
    [notch]            VARCHAR (30) NULL,
    [sire_identity]    VARCHAR (15) NULL,
    [dam_identity]     VARCHAR (15) NULL,
    [halothane]        VARCHAR (1)  NULL,
    [value]            FLOAT (53)   NULL,
    [weight]           FLOAT (53)   NULL,
    [ebv]              FLOAT (53)   NULL,
    [vasectomized]     SMALLINT     NULL,
    [origin_id]        INT          NULL,
    [UDF19436]         VARCHAR (8)  NULL
);

