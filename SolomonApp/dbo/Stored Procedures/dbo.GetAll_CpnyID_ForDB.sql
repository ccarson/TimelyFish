 create proc GetAll_CpnyID_ForDB
	@DatabaseName	varchar(30)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	Select CpnyID
	from vs_Company
	where DatabaseName = @DatabaseName

