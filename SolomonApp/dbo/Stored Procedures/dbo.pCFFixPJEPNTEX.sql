
/****** Object:  Stored Procedure dbo.pCF511ProjPigGroupEx    Script Date: 10/27/2004 6:58:22 PM ******/

CREATE    Procedure pCFFixPJEPNTEX

As

Select * from pjpent p
Where p.pjt_entity NOT IN (Select pjt_entity From PJPENTEX)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCFFixPJEPNTEX] TO [MSDSL]
    AS [dbo];

