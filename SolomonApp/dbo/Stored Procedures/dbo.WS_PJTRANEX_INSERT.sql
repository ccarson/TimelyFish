CREATE PROCEDURE WS_PJTRANEX_INSERT
     @batch_id char(10), @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @detail_num int, @equip_id char(10), @fiscalno char(6),
     @invtid char(30), @lotsernbr char(25), @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @orderlineref char(5), @ordnbr char(15),
     @shipperid char(15), @shipperlineref char(5), @siteid char(10), @system_cd char(2), @tr_id11 char(30), @tr_id12 char(30), @tr_id13 char(30),
     @tr_id14 char(16), @tr_id15 char(16), @tr_id16 char(16), @tr_id17 char(4), @tr_id18 char(4), @tr_id19 char(4), @tr_id20 char(40),
     @tr_id21 char(40), @tr_id22 smalldatetime, @tr_status2 char(1), @tr_status3 char(1), @whseloc char(10)
 AS
     BEGIN
      INSERT INTO [PJTRANEX]
       ([batch_id], [crtd_datetime], [crtd_prog], [crtd_user], [detail_num], [equip_id], [fiscalno],
        [invtid], [lotsernbr], [lupd_datetime], [lupd_prog], [lupd_user], [orderlineref], [ordnbr],
        [shipperid], [shipperlineref], [siteid], [system_cd], [tr_id11], [tr_id12], [tr_id13],
        [tr_id14], [tr_id15], [tr_id16], [tr_id17], [tr_id18], [tr_id19], [tr_id20],
        [tr_id21], [tr_id22], [tr_status2], [tr_status3], [whseloc])
      VALUES
       (@batch_id, @crtd_datetime, @crtd_prog, @crtd_user, @detail_num, @equip_id, @fiscalno,
        @invtid, @lotsernbr, @lupd_datetime, @lupd_prog, @lupd_user, @orderlineref, @ordnbr,
        @shipperid, @shipperlineref, @siteid, @system_cd, @tr_id11, @tr_id12, @tr_id13,
        @tr_id14, @tr_id15, @tr_id16, @tr_id17, @tr_id18, @tr_id19, @tr_id20,
        @tr_id21, @tr_id22, @tr_status2, @tr_status3, @whseloc);
    END
