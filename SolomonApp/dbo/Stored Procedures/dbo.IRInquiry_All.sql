 CREATE Procedure IRInquiry_All @ComputerName VarChar(21), @DateStartFrom SmallDateTime, @DateStartTo SmallDateTime, @DateEndFrom smalldatetime, @DateEndTo SmallDateTime, @Revised SmallInt as
Select * from IRInquiry where ComputerName like @ComputerName and DateStart between @DateStartFrom and @DateStartTo and DateEnd between @DateEndFrom and @DateEndTo and Revised = @Revised
	Order by ComputerName, DateStart, DateEnd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRInquiry_All] TO [MSDSL]
    AS [dbo];

