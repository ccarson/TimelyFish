 /****** Object:  Stored Procedure dbo.LocTable_Reset    Script Date: 4/17/98 10:58:18 AM ******/
Create Proc LocTable_Reset
	@PIID		varchar(10)

as

	Update 	LocTable set Selected = 0
	From    LocTable Join PIDetail (NoLock)
			On LocTable.Whseloc = PIDetail.Whseloc
			And LocTable.SiteID = PIDetail.SiteID
	where 	LocTable.selected = 1
	  And	LocTable.CountStatus = 'P'
	  And	PIDetail.PIID = @PIID

	Update	LocTable Set CountStatus = 'A', Selected = 0
	Where	CountStatus = 'P' and Selected = 1

