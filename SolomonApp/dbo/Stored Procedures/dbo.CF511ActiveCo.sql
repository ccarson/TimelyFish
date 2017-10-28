
CREATE Procedure [dbo].[CF511ActiveCo] @parm1 varchar (10) 

	-- Added Execute As to handle SL Integrated Security method -- TJones 3/13/2012
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'

	As 
    Select * from SolomonSystem.dbo.Company As a
	Where a.Active = 1
	AND a.CpnyID Like @parm1 
	Order by a.Active, a.CpnyID

