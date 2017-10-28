 CREATE PROCEDURE
	SD200_Search_SOAddress
		@parm1	varchar(100),		-- fieldname
		@parm2	varchar(100)		-- search values
AS
	DECLARE @szSQL			varchar(3000)
	DECLARE @szSelect		varchar(500)
	DECLARE @szWhere		varchar(500)
	DECLARE @szOrderBy		varchar(100)

	-- initialize
	SELECT @szSelect = ''

	SELECT @szWhere = ''
	SELECT @szOrderBy = ''

	-- SOAddress

	SELECT @szSelect =
		case @parm1
			when 'addr1' then 'SELECT SOAddress.*, smSOAddress.* FROM SOAddress WITH(INDEX(sm_soaddress_4),NOLOCK)
					left outer join smSOAddress (NOLOCK)
						on SOAddress.CustID = smSOAddress.CustID
						and SOAddress.ShiptoID = smSOAddress.ShiptoID'
			when 'phone' then 'SELECT SOAddress.*, smSOAddress.* FROM SOAddress WITH(INDEX(sm_soaddress_11),NOLOCK)
					left outer join smSOAddress (NOLOCK)
						on SOAddress.CustID = smSOAddress.CustID
						and SOAddress.ShiptoID = smSOAddress.ShiptoID'
			when 'name' then 'SELECT SOAddress.*, smSOAddress.* FROM SOAddress WITH(INDEX(sm_soaddress_5),NOLOCK)
					left outer join smSOAddress (NOLOCK)
						on SOAddress.CustID = smSOAddress.CustID
						and SOAddress.ShiptoID = smSOAddress.ShiptoID'
		else
			'SELECT SOAddress.*, smSOAddress.* FROM SOAddress (NOLOCK)
				left outer join smSOAddress (NOLOCK)
					on SOAddress.CustID = smSOAddress.CustID
					and SOAddress.ShiptoID = smSOAddress.ShiptoID'
		end
	SELECT @szSelect = @szSelect + ' inner join Customer (NOLOCK)
					 on SOAddress.CustID = Customer.CustID' 

 	SELECT @szWhere = ' WHERE ' + @parm1 + ' LIKE ' + QUOTENAME(@parm2, '''') +
			  ' And Customer.Status in (''A'', ''O'')' 

	SELECT @szOrderBy = ' ORDER BY SOAddress.CustID, SOAddress.ShiptoID'

	SELECT @szSQL = @szSelect + @szWhere + @szOrderBy

--PRINT (@szSQL)

	-- execute statement
	exec (@szSQL)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SD200_Search_SOAddress] TO [MSDSL]
    AS [dbo];

