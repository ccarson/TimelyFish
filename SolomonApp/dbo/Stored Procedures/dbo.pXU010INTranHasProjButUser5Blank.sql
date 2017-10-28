CREATE PROCEDURE pXU010INTranHasProjButUser5Blank 
	-- CREATED BY: TJones
	-- CREATED ON: 5/20/05
	-- UPDATED ON: 8/19/05 -- changed filter per MTravous to be = only (not <=)
	-- This procedure is used by the program that generates intercompany
	-- entries - specifically for inventory issues and returns entered in INTran
	-- It includes only records that have ProjectID filled in with a non-zero value
	-- It filters for the specific company the user is logged into in Solomon and the
	-- peroid they have chosen.
	@CpnyId varchar (10),
	@PerPost varchar(6) 
	AS 
	SELECT i.*  
	FROM INTran i
	WHERE i.CpnyId = @CpnyId 
	AND ProjectID Not In('','0')
	AND i.TranType in ('II','RI') 
	AND i.Rlsed = 1 
	AND i.User5 = '' 
	AND i.PerPost = @PerPost
	ORDER BY ProjectID, TaskID, Acct, COGSAcct, Sub, PerPost, TranType
