 CREATE Procedure IRRequirement_Single @InvtID VarChar(30), @DocumentID VarChar(30), @DocumentType VarChar(3), @DocOtherRef1 VarChar(30), @DueDate SmallDateTime, @SiteID VarChar(10), @DocOtherRef2 VarChar(30), @Revised SmallInt As
	Select * from IRRequirement where
		InvtID = @InvtID AND
		DocumentId = @DocumentID AND
		DocumentType = @DocumentType AND
		DocOtherRef1 = @DocOtherRef1 ANd
--		DueDate = @DueDate AND
-- Following cuteness was added due to the DueDate in the Table having TIME parts, and the passed in not.  So use between, add one day on, and back off a single second, that should get to MM/DD/YYYY 11:59 PM
		DueDate between @DueDate and DateAdd(Second,-1,DateAdd(Day,1,@DueDate)) AND
		SiteID = @SiteID AND
		DocOtherRef2 = @DocOtherRef2 AND
		Revised = @Revised
	order by
		InvtId,
		DocumentId,
		DocumentType,
		DocOtherRef1,
		DueDate,
		SiteID,
		DocOtherRef2,
		Revised


