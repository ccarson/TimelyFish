 /****** Object:  Stored Procedure dbo.DMG_WCSI_GetShopper    Script Date: 5/10/99 5:05:32 PM ******/
CREATE Procedure WC_GetShopper(
 @ShopperID CHAR(32),
 @UserName  CHAR(60) = null,
 @Password  CHAR(40) = null
)As
    -- If User and Password are not null then lookup ShopperID
    IF @UserName IS NOT NULL AND @Password IS NOT NULL
        SELECT @ShopperID = u.ShopperID
        FROM  WCUser u
        WHERE u.UserName = @UserName
        AND   u.Password = @Password
  -- Gather user information from the various tables.
 SELECT ShopperID   = RTRIM(u.ShopperID),
        UserGroupID = RTRIM(u.UserGroupID),
        CpnyID      = RTRIM(ug.CpnyID),
        CustID      = RTRIM(ug.CustID),
        UserName    = RTRIM(u.UserName),
        ContactID   = RTRIM(u.ContactID),
       	Permission00 = CASE  WHEN u.Permission00 = 'N' THEN s.Permission00 ELSE u.Permission00 END,
        Permission01 = CASE  WHEN u.Permission01 = 'N' THEN s.Permission01 ELSE u.Permission01 END,
        Permission02 = CASE  WHEN u.Permission02 = 'N' THEN s.Permission02 ELSE u.Permission02 END,
        Permission03 = CASE  WHEN u.Permission03 = 'N' THEN s.Permission03 ELSE u.Permission03 END,
        SOTypeID     = s.S4Future12, -- Take the SOTypeID from WCSetup
        SiteRollupMeth = s.SiteRollupMeth,
        PreferredSiteID  = RTRIM(cedi.SiteID)
 FROM WCUser u
 INNER JOIN WCUserGroup ug ON u.UserGroupID = ug.UserGroupID
 INNER JOIN WCSetup s ON 1=1
 INNER JOIN Customer c ON ug.CustID = c.CustID
 INNER JOIN CustomerEDI cedi ON ug.CustID = cedi.CustID
 LEFT OUTER JOIN CustContact cc ON ug.CustID = cc.CustID AND u.ContactID = cc.ContactID
 WHERE u.ShopperID = @ShopperID AND c.STATUS IN ('A','O','R') -- Use same logic as customer_active stored proc.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WC_GetShopper] TO [MSDSL]
    AS [dbo];

