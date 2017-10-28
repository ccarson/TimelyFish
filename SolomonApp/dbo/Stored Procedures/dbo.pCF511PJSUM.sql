

/****** Object:  Stored Procedure dbo.pCF511PJSUM    Script Date: 10/5/2004 4:18:52 PM ******/

CREATE   Procedure pCF511PJSUM
	@parm1 varchar(16),
	@parm2 varchar(32)

as
	Select pjs.* 
	From cfv_Proj_Task_Trans pjs
	WHERE pjs.project=@parm1 AND pjs.pjt_entity=@parm2 
	Order by pjs.project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511PJSUM] TO [MSDSL]
    AS [dbo];

