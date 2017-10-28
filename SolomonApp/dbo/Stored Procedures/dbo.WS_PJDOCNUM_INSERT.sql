CREATE PROCEDURE WS_PJDOCNUM_INSERT
     @AutoNum_labhdr smallint, @LastUsed_labhdr char(10), @AutoNum_chargh smallint, @LastUsed_chargh char(10), @AutoNum_alloc smallint, @LastUsed_alloc char(10), @AutoNum_tran smallint,
     @LastUsed_tran char(10), @AutoNum_foreign smallint, @LastUsed_foreign char(10), @AutoNum_revenue smallint, @LastUsed_revenue char(10), @AutoNum_1 smallint, @LastUsed_1 char(10),
     @AutoNum_2 smallint, @LastUsed_2 char(10), @AutoNum_3 smallint, @LastUsed_3 char(10), @AutoNum_4 smallint, @LastUsed_4 char(10), @AutoNum_5 smallint,
     @LastUsed_5 char(10), @AutoNum_6 smallint, @LastUsed_6 char(10), @AutoNum_7 smallint, @LastUsed_7 char(10), @AutoNum_8 smallint, @LastUsed_8 char(10),
     @AutoNum_9 smallint, @LastUsed_9 char(10), @AutoNum_10 smallint, @LastUsed_10 char(10), @AutoNum_11 smallint, @LastUsed_11 char(10), @AutoNum_12 smallint,
     @LastUsed_12 char(10), @Id char(10), @Crtd_DateTime smalldatetime, @Crtd_Prog char(8), @Crtd_User char(10), @LUpd_DateTime smalldatetime, @LUpd_Prog char(8),
     @LUpd_User char(10)
 AS
     BEGIN
      INSERT INTO [PJDOCNUM]
       ([AutoNum_labhdr], [LastUsed_labhdr], [AutoNum_chargh], [LastUsed_chargh], [AutoNum_alloc], [LastUsed_alloc], [AutoNum_tran],
        [LastUsed_tran], [AutoNum_foreign], [LastUsed_foreign], [AutoNum_revenue], [LastUsed_revenue], [AutoNum_1], [LastUsed_1],
        [AutoNum_2], [LastUsed_2], [AutoNum_3], [LastUsed_3], [AutoNum_4], [LastUsed_4], [AutoNum_5],
        [LastUsed_5], [AutoNum_6], [LastUsed_6], [AutoNum_7], [LastUsed_7], [AutoNum_8], [LastUsed_8],
        [AutoNum_9], [LastUsed_9], [AutoNum_10], [LastUsed_10], [AutoNum_11], [LastUsed_11], [AutoNum_12],
        [LastUsed_12], [Id], [Crtd_DateTime], [Crtd_Prog], [Crtd_User], [LUpd_DateTime], [LUpd_Prog],
        [LUpd_User])
      VALUES
       (@AutoNum_labhdr, @LastUsed_labhdr, @AutoNum_chargh, @LastUsed_chargh, @AutoNum_alloc, @LastUsed_alloc, @AutoNum_tran,
        @LastUsed_tran, @AutoNum_foreign, @LastUsed_foreign, @AutoNum_revenue, @LastUsed_revenue, @AutoNum_1, @LastUsed_1,
        @AutoNum_2, @LastUsed_2, @AutoNum_3, @LastUsed_3, @AutoNum_4, @LastUsed_4, @AutoNum_5,
        @LastUsed_5, @AutoNum_6, @LastUsed_6, @AutoNum_7, @LastUsed_7, @AutoNum_8, @LastUsed_8,
        @AutoNum_9, @LastUsed_9, @AutoNum_10, @LastUsed_10, @AutoNum_11, @LastUsed_11, @AutoNum_12,
        @LastUsed_12, @Id, @Crtd_DateTime, @Crtd_Prog, @Crtd_User, @LUpd_DateTime, @LUpd_Prog,
        @LUpd_User);
     END

