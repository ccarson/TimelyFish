 Create Procedure pjactrol_spk11 @parm1 varchar (4), @parm2 varchar (16)   as
SELECT
        r.fsyear_num,
        r.project,
        r.acct,
        r.amount_01,r.amount_02,r.amount_03,
        r.amount_04,r.amount_05,r.amount_06,
        r.amount_07,r.amount_08,r.amount_09,
        r.amount_10,r.amount_11,r.amount_12,
        r.amount_13,r.amount_14,r.amount_15,
        r.amount_bf,
        r.units_01,r.units_02,r.units_03,
        r.units_04,r.units_05,r.units_06,
        r.units_07,r.units_08,r.units_09,
        r.units_10,r.units_11,r.units_12,
        r.units_13,r.units_14,r.units_15,
        r.units_bf,
        r.ProjCury_amount_01,r.ProjCury_amount_02,
		r.ProjCury_amount_03,r.ProjCury_amount_04,
		r.ProjCury_amount_05,r.ProjCury_amount_06,
		r.ProjCury_amount_07,r.ProjCury_amount_08,
		r.ProjCury_amount_09,r.ProjCury_amount_10,
		r.ProjCury_amount_11,r.ProjCury_amount_12,
		r.ProjCury_amount_13,r.ProjCury_amount_14,
		r.ProjCury_amount_15,r.ProjCury_amount_bf,
        p.bf_values_switch
FROM
        pjactrol r, pjproj p
WHERE
        r.project = p.project and
        r.fsyear_num = @parm1 and
        r.project like @parm2 and
        p.bf_values_switch = 'Y'
ORDER BY
        r.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjactrol_spk11] TO [MSDSL]
    AS [dbo];

