CREATE PROCEDURE WS_PJACTSUM_INSERT
    @acct char(16), @amount_01 float, @amount_02 float, @amount_03 float, @amount_04 float, @amount_05 float, @amount_06 float, @amount_07 float,
    @amount_08 float, @amount_09 float, @amount_10 float, @amount_11 float, @amount_12 float, @amount_13 float, @amount_14 float, @amount_15 float,
    @amount_bf float, @crtd_datetime smalldatetime, @crtd_prog char(8),@crtd_user char(10), @data1 char(16), @fsyear_num char(4), @lupd_datetime smalldatetime, @lupd_prog char(8),
    @lupd_user char(10), @pjt_entity char(32), 
    @ProjCury_amount_01 float, @ProjCury_amount_02 float, @ProjCury_amount_03 float, @ProjCury_amount_04 float, @ProjCury_amount_05 float,
    @ProjCury_amount_06 float, @ProjCury_amount_07 float, @ProjCury_amount_08 float, @ProjCury_amount_09 float, @ProjCury_amount_10 float,
    @ProjCury_amount_11 float, @ProjCury_amount_12 float, @ProjCury_amount_13 float, @ProjCury_amount_14 float, @ProjCury_amount_15 float,
    @ProjCury_amount_bf float,     
    @project char(16), @units_01 float, @units_02 float, @units_03 float, @units_04 float, @units_05 float, 
    @units_06 float, @units_07 float, @units_08 float, @units_09 float, @units_10 float, @units_11 float, @units_12 float, @units_13 float,
    @units_14 float, @units_15 float, @units_bf float
AS
    BEGIN
     INSERT INTO [PJACTSUM]
     ([acct], [amount_01], [amount_02], [amount_03], [amount_04], [amount_05], [amount_06], [amount_07],
      [amount_08], [amount_09], [amount_10], [amount_11], [amount_12], [amount_13], [amount_14], [amount_15],
      [amount_bf],[crtd_datetime], [crtd_prog], [crtd_user], [data1], [fsyear_num], [lupd_datetime], [lupd_prog],
      [lupd_user], [pjt_entity],
      [ProjCury_amount_01], [ProjCury_amount_02], [ProjCury_amount_03], [ProjCury_amount_04], [ProjCury_amount_05],
      [ProjCury_amount_06], [ProjCury_amount_07], [ProjCury_amount_08], [ProjCury_amount_09], [ProjCury_amount_10],
      [ProjCury_amount_11], [ProjCury_amount_12], [ProjCury_amount_13], [ProjCury_amount_14], [ProjCury_amount_15],
      [ProjCury_amount_bf],
      [project], [units_01], [units_02], [units_03], [units_04], [units_05],
      [units_06], [units_07], [units_08], [units_09], [units_10], [units_11], [units_12], [units_13],
      [units_14], [units_15], [units_bf])
    VALUES
    (@acct, @amount_01, @amount_02, @amount_03, @amount_04, @amount_05, @amount_06, @amount_07,
     @amount_08, @amount_09, @amount_10, @amount_11, @amount_12, @amount_13, @amount_14, @amount_15,
     @amount_bf, @crtd_datetime, @crtd_prog, @crtd_user, @data1, @fsyear_num, @lupd_datetime, @lupd_prog,
     @lupd_user, @pjt_entity, 
     @ProjCury_amount_01, @ProjCury_amount_02, @ProjCury_amount_03, @ProjCury_amount_04, @ProjCury_amount_05,
     @ProjCury_amount_06, @ProjCury_amount_07, @ProjCury_amount_08, @ProjCury_amount_09, @ProjCury_amount_10,
     @ProjCury_amount_11, @ProjCury_amount_12, @ProjCury_amount_13, @ProjCury_amount_14, @ProjCury_amount_15,
     @ProjCury_amount_bf,
     @project, @units_01, @units_02, @units_03, @units_04, @units_05,
     @units_06, @units_07, @units_08, @units_09, @units_10, @units_11, @units_12, @units_13,
     @units_14, @units_15, @units_bf);
   END
