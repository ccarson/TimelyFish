
/****** Object:  Stored Procedure dbo.CF522p_PJProj_PigGroup    Script Date: 10/3/2005 1:33:43 PM ******/


CREATE          Procedure dbo.CF522p_PJProj_PigGroup 
	@parm1 varchar(6), @parm2 varchar(10), @parm3 varchar(3), @parm4 varchar(32)
AS 
Select * 
From cftPigGroup 
Where CostFlag=1 
AND PGStatusID='I'
AND SiteContactID=@parm1 
AND CF03=@parm2
AND PigProdPhaseID = @parm3
AND TaskID Like @parm4






GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_PJProj_PigGroup] TO [MSDSL]
    AS [dbo];

