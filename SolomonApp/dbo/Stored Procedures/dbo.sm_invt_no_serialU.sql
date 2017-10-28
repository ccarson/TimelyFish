 create PROCEDURE sm_invt_no_serialU
	@parm1	varchar(30)
AS
	SELECT
		*
	FROM
		inventory
	WHERE
		invtid LIKE @parm1
		AND
		SerAssign <> 'U'

	ORDER BY
		invtid


