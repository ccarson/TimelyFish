CREATE TABLE [dbo].[PJTranEX] (
    [batch_id]       CHAR (10)     NOT NULL,
    [crtd_datetime]  SMALLDATETIME NOT NULL,
    [crtd_prog]      CHAR (8)      NOT NULL,
    [crtd_user]      CHAR (10)     NOT NULL,
    [detail_num]     INT           NOT NULL,
    [equip_id]       CHAR (10)     NOT NULL,
    [fiscalno]       CHAR (6)      NOT NULL,
    [invtid]         CHAR (30)     NOT NULL,
    [lotsernbr]      CHAR (25)     NOT NULL,
    [lupd_datetime]  SMALLDATETIME NOT NULL,
    [lupd_prog]      CHAR (8)      NOT NULL,
    [lupd_user]      CHAR (10)     NOT NULL,
    [orderlineref]   CHAR (5)      NOT NULL,
    [ordnbr]         CHAR (15)     NOT NULL,
    [shipperid]      CHAR (15)     NOT NULL,
    [shipperlineref] CHAR (5)      NOT NULL,
    [siteid]         CHAR (10)     NOT NULL,
    [system_cd]      CHAR (2)      NOT NULL,
    [tr_id11]        CHAR (30)     NOT NULL,
    [tr_id12]        CHAR (30)     NOT NULL,
    [tr_id13]        CHAR (30)     NOT NULL,
    [tr_id14]        CHAR (16)     NOT NULL,
    [tr_id15]        CHAR (16)     NOT NULL,
    [tr_id16]        CHAR (16)     NOT NULL,
    [tr_id17]        CHAR (4)      NOT NULL,
    [tr_id18]        CHAR (4)      NOT NULL,
    [tr_id19]        CHAR (4)      NOT NULL,
    [tr_id20]        CHAR (40)     NOT NULL,
    [tr_id21]        CHAR (40)     NOT NULL,
    [tr_id22]        SMALLDATETIME NOT NULL,
    [tr_status2]     CHAR (1)      NOT NULL,
    [tr_status3]     CHAR (1)      NOT NULL,
    [whseloc]        CHAR (10)     NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [pjtranex0] PRIMARY KEY CLUSTERED ([fiscalno] ASC, [system_cd] ASC, [batch_id] ASC, [detail_num] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [pjtranex1]
    ON [dbo].[PJTranEX]([tr_id11] ASC) WITH (FILLFACTOR = 100);

