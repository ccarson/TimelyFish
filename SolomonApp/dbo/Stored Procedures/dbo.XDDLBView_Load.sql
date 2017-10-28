
create proc XDDLBView_Load
	@OrderString		varchar(32),
	@RecordLimit		int,
	@DocDateFrom		smalldatetime,
	@DocDateTo		smalldatetime,
	@DiscDateFrom		smalldatetime,
	@DiscDateTo		smalldatetime,
	@DueDateFrom		smalldatetime,
	@DueDateTo		smalldatetime,
	@CustName		varchar(30),
	@CustID			varchar(15),
	@CustOrdNbr		varchar(25),
	@OrdNbr			varchar(15),	
	@Terms			varchar(2),
	@DocType_IN		smallint,
	@DocType_DM		smallint,
	@DocType_FI		smallint,
	@DocType_PA		smallint,
	@DocType_CM		smallint,
	@RefNbrFrom		varchar(10),
	@RefNbrTo		varchar(10),
	@BalanceFrom		float,
	@BalanceTo		float,
	@ProjectID		varchar(16),
	@CpnyID			varchar(10),
	@CuryID			varchar(4),
	@OpenDoc		varchar(1),
	@Rlsed			varchar(1)

AS

	Declare @i		tinyint
	Declare @OrderByStr	varchar(80)
	Declare @OrderSeg	char(2)
	Declare @OrderDESC	varchar(5)
	Declare @DocTypeStr	varchar(40)
	Declare @Query 		varchar(2000)
	Declare @SelectText	varchar(400)

	-- Order string  - <Field><Asc/Desc> (eg SAWDUA.... - 32 long
	-- O - dOcument Date
	-- I - dIscount Date
	-- U - dUe Date
	-- A - customer nAme
	-- C - Customer ID
	-- N - Customer PO Nbr
	-- S - Sales Order Number
	-- T - Terms
	-- Y - Document Type
	-- F - Reference Number
	-- B - Balance
	-- J - Project
	-- K - Task
	-- M - Company ID
	-- R - Currency ID
	-- E - Open Documents
	-- L - Released

	if @RecordLimit = 0
		Set @SelectText = 'SELECT '
	else
		Set @SelectText = 'SELECT TOP ' + ltrim(cast(@RecordLimit As varchar(5))) + ' '

	SET	@SelectText = @SelectText
		+ 'A.DocDate, A.DiscDate, A.DueDate, A.PerPost, '
		+ 'C.Name, A.CustID, A.CustOrdNbr, A.OrdNbr, '
		+ 'A.Terms, A.DocType, A.RefNbr, A.CuryDocBal, '
		+ 'A.ProjectID, A.CpnyID, A.CuryID, A.OpenDoc, '
		+ 'A.Rlsed, A.BatNbr, A.BatSeq '
				
	-- Cycle thru the Order String and create
	Select @OrderByStr = ''
	Select @i = 1
	WHILE @i <= 17
		BEGIN
		Select @OrderSeg = substring(@OrderString, ((@i-1)*2)+1, 2)
		-- Determine Ascending or Descending order
		if right(@OrderSeg, 1) = 'D'
			Select @OrderDESC = ' DESC'
		else
			Select @OrderDESC = ''

		if left(@OrderSeg, 1) = 'O'
			Select @OrderByStr = @OrderByStr + 'A.DocDate' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'I'
			Select @OrderByStr = @OrderByStr + 'A.DiscDate' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'U'
			Select @OrderByStr = @OrderByStr + 'A.DueDate' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'A'
			Select @OrderByStr = @OrderByStr + 'C.Name' + @OrderDESC + ', '
--		if left(@OrderSeg, 1) = 'P'
--			Select @OrderByStr = @OrderByStr + 'A.PerPost' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'C'
			Select @OrderByStr = @OrderByStr + 'A.CustID' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'N'
			Select @OrderByStr = @OrderByStr + 'A.CustOrdNbr' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'S'
			Select @OrderByStr = @OrderByStr + 'A.OrdNbr' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'T'
			Select @OrderByStr = @OrderByStr + 'A.Terms' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'Y'
			Select @OrderByStr = @OrderByStr + 'A.DocType' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'F'
			Select @OrderByStr = @OrderByStr + 'A.RefNbr' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'B'
			Select @OrderByStr = @OrderByStr + 'A.CuryDocBal' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'J'
			Select @OrderByStr = @OrderByStr + 'A.ProjectID' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'K'
			Select @OrderByStr = @OrderByStr + 'A.TaskID' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'M'
			Select @OrderByStr = @OrderByStr + 'A.CpnyID' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'R'
			Select @OrderByStr = @OrderByStr + 'A.CuryID' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'E'
			Select @OrderByStr = @OrderByStr + 'A.OpenDoc' + @OrderDESC + ', '
		if left(@OrderSeg, 1) = 'L'
			Select @OrderByStr = @OrderByStr + 'A.Rlsed' + @OrderDESC + ', '

		Select @i = @i + 1
		END

	-- Strip off trailing comma
	Select @OrderByStr = rtrim(@OrderByStr)
	if @OrderByStr <> ''
		Select @OrderByStr = left(@OrderByStr, len(@OrderByStr)-1)

	Select @DocTypeStr = ''
	if @DocType_IN = 1
		Select @DocTypeStr = @DocTypeStr + '''IN'','
	if @DocType_DM = 1
		Select @DocTypeStr = @DocTypeStr + '''DM'','
	if @DocType_FI = 1
		Select @DocTypeStr = @DocTypeStr + '''FI'','
	if @DocType_PA = 1
		Select @DocTypeStr = @DocTypeStr + '''PA'','
	if @DocType_CM = 1
		Select @DocTypeStr = @DocTypeStr + '''CM'','

	-- Strip off trailing comma
	Select @DocTypeStr = rtrim(@DocTypeStr)
	if @DocTypeStr <> ''
		Select @DocTypeStr = left(@DocTypeStr, len(@DocTypeStr)-1)
	else
		Select @DocTypeStr = ''''''


-- No longer used
	-- Wildcards in PerPostFrom field
--	If CHARINDEX('%',@PerPostFrom) > 0 or CHARINDEX('_', @PerPostFrom) > 0
--		Set @Query = @Query +
--				' and (A.PerPost LIKE ''' + @PerPostFrom + ''')'
--	else
--		Set @Query = @Query +
--				' and (A.PerPost BETWEEN ''' + @PerPostFrom + ''' and ''' + @PerPostTo + ''')'

--	Set @Query = @Query +

	Set @Query = @SelectText + 

	'FROM			ARDoc A (nolock) LEFT OUTER JOIN Customer C (nolock)
				ON A.CustID = C.CustID
	WHERE			(A.DocDate BETWEEN ''' + Convert(varchar, @DocDateFrom, 101) + ''' and ''' + Convert(varchar, @DocDateTo, 101) + ''')
				and (A.DiscDate BETWEEN ''' + Convert(varchar, @DiscDateFrom, 101) + ''' and ''' + Convert(varchar, @DiscDateTo, 101) + ''')
				and (A.DueDate BETWEEN ''' + Convert(varchar, @DueDateFrom, 101) + ''' and ''' + Convert(varchar, @DueDateTo, 101) + ''')
				and (C.Name LIKE ''' + @CustName + ''')
				and (A.CustID LIKE ''' + @CustID + ''')
				and (A.CustOrdNbr LIKE ''' + @CustOrdNbr + ''')
				and (A.OrdNbr LIKE ''' + @OrdNbr + ''')
				and (A.Terms LIKE ''' + @Terms + ''')
				and (A.DocType IN (' + @DocTypeStr + '))'

	-- Wildcards in RefNbr field
	If CHARINDEX('%',@RefNbrFrom) > 0 or CHARINDEX('_', @RefNbrFrom) > 0
		Set @Query = @Query +
				' and (A.RefNbr LIKE ''' + @RefNbrFrom + ''')'
	else
		Set @Query = @Query +
				' and (A.RefNbr BETWEEN ''' + @RefNbrFrom + ''' and ''' + @RefNbrTo + ''')'

	Set @Query = @Query +
				' and (A.CuryDocBal BETWEEN ' + cast(@BalanceFrom As varchar(15)) + ' and ' + cast(@BalanceTo As varchar(15)) + ')
				and (A.ProjectID LIKE ''' + @ProjectID + ''')
				and (A.CpnyID LIKE ''' + @CpnyID + ''')
				and (A.CuryID LIKE ''' + @CuryID + ''')
				and (A.OpenDoc LIKE ''' + @OpenDoc + ''')
				and (A.Rlsed LIKE ''' +  @Rlsed + ''')
	ORDER BY '		+ @OrderByStr

	-- XDDLBView_Load
	execute(@Query)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLBView_Load] TO [MSDSL]
    AS [dbo];

