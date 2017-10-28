 Create	Proc SCM_10990_Site_Blank_CpnyID
As
/*
	This procedure will return a record set containing invalid data found in the Site
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/
	Set	NoCount On

/*	Site records cannot have a blank CpnyID. */
	Select	* From	Site
		Where	RTrim(CpnyID) = ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10990_Site_Blank_CpnyID] TO [MSDSL]
    AS [dbo];

