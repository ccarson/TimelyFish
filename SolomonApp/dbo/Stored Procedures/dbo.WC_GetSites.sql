 /**
 * Returns a list of inventory sites visible to the specified shopper.
 */
CREATE Procedure WC_GetSites(
    @ShopperID  VARCHAR(32)
)As
    SET NOCOUNT ON

    DECLARE @UserGroupID  VARCHAR(15)
    DECLARE @CpnyID       VARCHAR(10)

    SELECT
        @UserGroupID = UserGroupID
    FROM
        WCUser (NOLOCK)
    WHERE
        ShopperID = @ShopperID


    -- If @CpnyID is null or blank then look up cpnyid from ShopperID
    SELECT
        @CpnyID = CpnyID
    FROM
        WCUserGroup ug (NOLOCK)
    WHERE
        ug.UserGroupID = @UserGroupID

    -- Create a temp table to hold the results
    CREATE TABLE #shoppersites
    (
        SiteID VARCHAR(15),
        Name   VARCHAR(30)
    )

    -- First try to get sites from WCGroupSite.
    INSERT
        #shoppersites
    SELECT
        s.SiteID,
        s.Name
    FROM
        Site s (NOLOCK)
    JOIN
        LocTable l (NOLOCK)
            ON
            l.SiteID = s.SiteID
            AND
            l.SalesValid <> 'N'
    JOIN
        WCGroupSite gs (NOLOCK)
            ON
            l.SiteID = gs.SiteID
    WHERE
        s.CpnyID = @CpnyID
        AND
        gs.UserGroupID = @UserGroupID
    GROUP BY
        s.SiteID,
        s.Name

    -- If there are no Sites then use the default setting on the site table.
    IF @@ROWCOUNT = 0
        INSERT
            #shoppersites
        SELECT
            s.SiteID,
            s.Name
        FROM
            Site s (NOLOCK)
        JOIN
            LocTable l (NOLOCK)
                ON
                s.SiteID = l.SiteID
                AND
                l.SalesValid <> 'N'
        WHERE
            s.CpnyID = @CpnyID
            AND
            s.VisibleForWC <> 0
        GROUP BY
            s.SiteID,
            s.Name

    -- Select the values from the temp table.
    SELECT
        SiteID,
        Name
    FROM
        #shoppersites
    RETURN


