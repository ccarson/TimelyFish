CREATE PROCEDURE WS_PJPTDROL_INSERT
@acct char(16),@act_amount float,@act_units float,@com_amount float,@com_units float,@crtd_datetime smalldatetime,@crtd_prog char(8),
@crtd_user char(10),@data1 char(16),@data2 float,@data3 float,@data4 float,@data5 float,@eac_amount float,@eac_units float,
@fac_amount float,@fac_units float,@lupd_datetime smalldatetime,@lupd_prog char(8),@lupd_user char(10),
@ProjCury_act_amount float, @ProjCury_com_amount float, @ProjCury_eac_amount float,
@ProjCury_fac_amount float, @ProjCury_rate float, @ProjCury_tot_bud_amt float,
@project char(16),@rate float,
@total_budget_amount float,@total_budget_units float,@user1 char(30),@user2 char(30),@user3 float,@user4 float 
AS
BEGIN
INSERT INTO [PJPTDROL]
([acct],[act_amount],[act_units],[com_amount],[com_units],[crtd_datetime],[crtd_prog],[crtd_user],[data1],[data2],[data3],[data4],
[data5],[eac_amount],[eac_units],[fac_amount],[fac_units],[lupd_datetime],[lupd_prog],[lupd_user],
[ProjCury_act_amount], [ProjCury_com_amount], [ProjCury_eac_amount],
[ProjCury_fac_amount], [ProjCury_rate], [ProjCury_tot_bud_amt],
[project],[rate],[total_budget_amount],
[total_budget_units],[user1],[user2],[user3],[user4])
VALUES
(@acct,@act_amount,@act_units,@com_amount,@com_units,@crtd_datetime,@crtd_prog,@crtd_user,@data1,@data2,@data3,@data4,@data5,@eac_amount,
@eac_units,@fac_amount,@fac_units,@lupd_datetime,@lupd_prog,@lupd_user,
@ProjCury_act_amount, @ProjCury_com_amount, @ProjCury_eac_amount,
@ProjCury_fac_amount, @ProjCury_rate, @ProjCury_tot_bud_amt,
@project,@rate,@total_budget_amount,@total_budget_units,@user1,
@user2,@user3,@user4);
End
