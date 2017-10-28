
CREATE PROCEDURE WSL_WebAppScreenMappings
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (50) -- ScreenNumber
 ,@parm2 varchar (1) -- Executable Type ('' for SL App, 'W' for Web App)
AS
SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@screenColumn nvarchar(50),
	@PFT varchar(1) = '',
	@timecardFilter nvarchar(50)

	if @sort = '' set @sort = 'WebAppScreen'

	if @parm2 = '' set @screenColumn = 'RichClientScreens'
	if @parm2 = 'W' set @screenColumn = 'WebAppScreen'

	if exists(select * from PJCONTRL where control_code = 'PFT' and control_type = 'TM')
		select @PFT = SUBSTRING(control_data,228,1) from PJCONTRL where control_code = 'PFT' and control_type = 'TM'
	else set @PFT = 'N'

	-- PFT is active. Update the parameters
	IF @PFT = 'Y' SET @timecardFilter = ' and p.action <> ''PeriodEntry'''
	IF @PFT = 'N' OR LTRIM(RTRIM(@PFT)) = '' SET @timecardFilter = ' and p.action <> ''MyAssignments'''

	if @page = 0 --Don't do paging
	BEGIN
		set @STMT = 'Select m.WebAppScreen [WAScreen], s.Name [Description], m.Controller, p.Action,
					 m.Menu, p.Param [Parameter], p.DisplayName [Display Name]
					 FROM vs_webappmappings m 
					 left outer join vs_webappparams p on m.WebAppScreen = p.WebAppScreen
					 left outer join vs_screen s on m.WebAppScreen = s.Number
					 WHERE m.' + @screenColumn + ' like ' + QUOTENAME(@parm1, '''') + @timecardFilter +
					' Order By m.' + @sort + ', p.ParmOrder'
	END
	ELSE
	BEGIN
		IF @page < 1 SET @page = 1
		IF @size < 1 SET @size = 1
		SET @lbound = (@page-1) * @size
		SET @ubound = @page * @size + 1

		SET @STMT = 
			'WITH PagingCTE AS
			(
				Select Top('  + CONVERT(varchar(9), @ubound-1) + ')
				m.WebAppScreen, s.Name,
				m.Controller, p.Action, m.Menu, p.Param, p.DisplayName, ROW_NUMBER() OVER(
					ORDER BY m.' + @sort + ', p.ParmOrder) as row from vs_webappmappings m 
					left outer join vs_webappparams p on m.WebAppScreen = p.WebAppScreen
					left outer join vs_screen s on m.WebAppScreen = s.Number
					where m.' + @screenColumn + ' like ' + QUOTENAME(@parm1, '''') + @timecardFilter + '
			)
			SELECT WebAppScreen [WAScreen], Name [Description],
			Controller, Action, Menu, Param [Parameter], DisplayName [Display Name]
			FROM PagingCTE 
			WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	END

	EXEC (@STMT)
