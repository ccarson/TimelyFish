 Create Procedure pjcomrol_spk1 @parm1 varchar (4)   as
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
	p.bf_values_switch
FROM
		pjcomrol r, pjproj p
WHERE
	r.project = p.project and
	r.fsyear_num = @parm1 and
	p.bf_values_switch = 'Y'
ORDER BY
	r.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjcomrol_spk1] TO [MSDSL]
    AS [dbo];

