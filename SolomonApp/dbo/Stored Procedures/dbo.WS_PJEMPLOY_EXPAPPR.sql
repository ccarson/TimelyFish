 create procedure WS_PJEMPLOY_EXPAPPR @parm1 varchar (10)  as

	SELECT employee, em_id01 
	  FROM PJEMPLOY
	 WHERE employee = @parm1 
     order by employee


