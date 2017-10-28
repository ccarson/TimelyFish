 create procedure ProjInv_FetchPJPROJFlexInfo @ProjectID varchar (16)  as

  SELECT billcuryid, customer, project, slsperid, status_15, status_16
    FROM PJPROJ WITH(NOLOCK)
   WHERE project = @ProjectID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_FetchPJPROJFlexInfo] TO [MSDSL]
    AS [dbo];

