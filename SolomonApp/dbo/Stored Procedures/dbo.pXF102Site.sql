
/****** Object:  Stored Procedure dbo.pXF102Site    Script Date: 6/24/2005 8:09:17 AM ******/

/****** Object:  Stored Procedure dbo.pXF102Site    Script Date: 6/23/2005 11:38:19 AM ******/

/****** Object:  Stored Procedure dbo.pXF102Site    Script Date: 6/22/2005 2:30:49 PM ******/

/****** Object:  Stored Procedure dbo.pXF102Site    Script Date: 5/9/2005 2:53:13 PM ******/

/****** Object:  Stored Procedure dbo.pXF102Site    Script Date: 5/9/2005 2:51:00 PM ******/



CREATE  Proc pXF102Site
       @parm1 varchar(47)
as
select ct.ContactName, pm.SiteContactID
	FROM cftContact ct 
	JOIN cftUserSitePerm pm ON ct.ContactID=pm.SiteContactID
	Where ct.ContactTypeID='04' AND ct.StatusTypeID='1' AND pm.UserID=@parm1
        Order by ct.ContactName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF102Site] TO [MSDSL]
    AS [dbo];

