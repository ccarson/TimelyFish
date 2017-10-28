 /****** Object:  Stored Procedure dbo.pjsubcon_pwp    Script Date: 06/7/06 ******/
Create Procedure pjsubcon_pwp @parm1 varchar(16) as

SELECT *
  FROM PJSUBCON
 WHERE Subcontract like @parm1
 ORDER BY subcontract,project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjsubcon_pwp] TO [MSDSL]
    AS [dbo];

