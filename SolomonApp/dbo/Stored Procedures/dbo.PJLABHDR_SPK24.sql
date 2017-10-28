 Create Procedure PJLABHDR_SPK24  as
	SELECT
	  PJLABHDR.docnbr,
	  PJLABHDR.employee,
	  PJEMPLOY.emp_name,
	  PJLABHDR.pe_date,
	  PJLABHDR.le_type,
	  PJLABHDR.le_status
		FROM
	  pjlabhdr,
	  pjemploy
	WHERE
		  pjlabhdr.le_status = 'C' and
	  pjlabhdr.employee =  pjemploy.employee
ORDER BY
	  pjlabhdr.docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_SPK24] TO [MSDSL]
    AS [dbo];

