 create Procedure PJLABHDR_SPK25 @parm1 varchar (10), @parm2 varchar(100) 
   WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
	SELECT
	  PJLABHDR.docnbr,
	  PJLABHDR.employee,
	  PJEMPLOY.emp_name,
	  PJLABHDR.pe_date,
	  PJLABHDR.le_type,
	  PJLABHDR.le_status,
	  PJEMPLOY.manager1,
	  PJEMPLOY.manager2,
	  PJEMPLOY.gl_subacct,
	  PJLABHDR.le_id05,
          PJLABHDR.le_id07,
          pjlabhdr.cpnyid_home
	FROM
	  pjlabhdr,
	  pjemploy
		WHERE
	   pjlabhdr.employee =  pjemploy.employee and
	   (pjlabhdr.le_status = 'C' or pjlabhdr.le_status = 'A') and
	   pjlabhdr.cpnyid_home Like @parm1 and 
	   pjlabhdr.cpnyid_home in (select cpnyid from dbo.UserAccessCpny(@parm2))
	   
ORDER BY
	  pjlabhdr.employee ASC, pjlabhdr.pe_date DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_SPK25] TO [MSDSL]
    AS [dbo];

