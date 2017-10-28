
/****** Object:  Stored Procedure dbo.pCF511ActiveCo    Script Date: 8/2/2005 4:16:35 PM ******/


CREATE    Procedure [dbo].[pCF511ActiveCo]
		@parm1 varchar(6)
			WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as 
Select CpnyID, CpnyName from vs_Company 
Where vs_Company.Active = 1 AND
vs_Company.CpnyID Like @parm1
Order by vs_Company.CpnyID
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511ActiveCo] TO [MSDSL]
    AS [dbo];

