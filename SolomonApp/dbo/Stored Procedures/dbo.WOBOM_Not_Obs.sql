 create proc WOBOM_Not_Obs
	@KitID         char (30)

as

   SELECT         *
   FROM           Kit
   WHERE          KitId like @KitID and
                  Status <> 'O'
   ORDER BY       KitId, SiteID, Status


