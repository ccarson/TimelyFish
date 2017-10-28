/****** Object:  Stored Procedure dbo.CF522p_Site    Script Date: 5/10/2005 2:49:13 PM ******/

/****** Object:  Stored Procedure dbo.CF522p_Site    Script Date: 5/10/2005 1:42:30 PM ******/

/****** Object:  Stored Procedure dbo.CF522p_Site    Script Date: 5/3/2005 3:08:18 PM ******/


CREATE       Procedure dbo.CF522p_Site
		@parm1 varchar (10)

AS 
Select st.ContactID, ct.ContactName, ft.Description
From cftSite st
JOIN cftContact ct ON st.ContactID=ct.ContactID
JOIN cftFacilityType ft ON st.FacilityTypeID=ft.FacilityTypeID
JOIN cftPigGroup pg ON st.ContactID=pg.SiteContactID
Where st.ContactID Like @parm1 AND pg.CostFlag='1' AND pg.PGStatusID='I'
Group by st.ContactID, ct.ContactName, ft.Description



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_Site] TO [MSDSL]
    AS [dbo];

