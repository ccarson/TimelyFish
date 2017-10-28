 Create Procedure pjactsum_spk11 @parm1 varchar (4), @parm2 varchar (16)   as
SELECT
s.fsyear_num,
s.project,
s.pjt_entity,
s.acct,
s.amount_01,s.amount_02,s.amount_03,
s.amount_04,s.amount_05,s.amount_06,
s.amount_07,s.amount_08,s.amount_09,
s.amount_10,s.amount_11,s.amount_12,
s.amount_13,s.amount_14,s.amount_15,
s.amount_bf,
s.units_01,s.units_02,s.units_03,
s.units_04,s.units_05,s.units_06,
s.units_07,s.units_08,s.units_09,
s.units_10,s.units_11,s.units_12,
s.units_13,s.units_14,s.units_15,
s.units_bf,
s.ProjCury_amount_01,s.ProjCury_amount_02,
s.ProjCury_amount_03,s.ProjCury_amount_04,
s.ProjCury_amount_05,s.ProjCury_amount_06,
s.ProjCury_amount_07,s.ProjCury_amount_08,
s.ProjCury_amount_09,s.ProjCury_amount_10,
s.ProjCury_amount_11,s.ProjCury_amount_12,
s.ProjCury_amount_13,s.ProjCury_amount_14,
s.ProjCury_amount_15,s.ProjCury_amount_bf,
p.bf_values_switch
FROM
pjactsum s, pjproj p
WHERE
s.project = p.project and
s.fsyear_num = @parm1 and
s.project like @parm2 and
p.bf_values_switch = 'Y'
ORDER BY
s.project, s.pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjactsum_spk11] TO [MSDSL]
    AS [dbo];

