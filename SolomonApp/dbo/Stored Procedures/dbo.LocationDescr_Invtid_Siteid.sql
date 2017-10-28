 CREATE PROCEDURE LocationDescr_Invtid_Siteid
	@parm1 varchar ( 30),
	@parm2 varchar ( 10) AS
SELECT *
	FROM location
		left outer join LocTable
			on Location.SiteID = Loctable.SiteID
			and Location.WhseLoc = Loctable.WhseLoc
	WHERE Location.Invtid = @parm1 AND
		Location.siteid like @parm2
	ORDER BY
         Location.invtid,  Location.siteid,  Location.whseloc


