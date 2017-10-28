 CREATE PROCEDURE smServCall_lookup
		@Custid varchar(10),
        @ShipToId varchar(10),
        @ProjectID varchar(16),
        @CallType varchar(10),
        @CallStatus varchar (10),
        @AssignEmpID varchar (10),
        @InvoiceNumber varchar (10),
        @ServiceCallStatus varchar (1),
        @CpnyID varchar(10),
        @PromisedFlag varchar(5),
        @BeginPromDate varchar(10),      --Date needs to be converted to a string and passed in (Call IntlStrToDate).
        @EndPromDate varchar(10),        --Date needs to be converted to a string and passed in (Call IntlStrToDate).
        @CompletedFlag varchar(5),      
        @BeginCompleteDate varchar(10),  --Date needs to be converted to a string and passed in (Call IntlStrToDate).
        @EndCompleteDate varchar(10)    --Date needs to be converted to a string and passed in (Call IntlStrToDate).
AS

DECLARE @szSelect	varchar(300)
DECLARE @szFrom		varchar(250)
DECLARE @szWhere	varchar(1000)

DECLARE @szWhereCustID		  varchar(50)
DECLARE @szWhereShipToID	  varchar(50)
DECLARE @szWhereProjectID	  varchar(50)
DECLARE @szWhereCallType	  varchar(50)
DECLARE @szWhereCallStatus	  varchar(50)
DECLARE @szWhereAssignEmpID   varchar(50)
DECLARE @szWhereInvoiceNumber varchar(50)
DECLARE @szWhereServiceCallSt varchar(50)
DECLARE @szWhereCpnyID        varchar(50)
DECLARE @szWherePromised      varchar(100)
DECLARE @szWhereCompleted     varchar(100)

--Customer Parameter
IF @Custid = '*' or Len(@Custid) = 0
BEGIN
    Select @szWhereCustID = ' s.CustomerID LIKE ''%'' '
END
ELSE
BEGIN
    Select @szWhereCustID = ' s.CustomerID = ''' + @Custid + ''' '
END

--Ship to ID Parameter
IF @ShipToId = '*' or Len(@ShipToId) = 0
BEGIN
    Select @szWhereShipToID = ' AND s.ShipToId LIKE ''%'' '
END
ELSE
BEGIN
    Select @szWhereShipToID = ' AND s.ShipToId = ''' + @ShipToId + ''' '
END
--Project ID Parameter
IF @ProjectID = '*' or Len(@ProjectID) = 0
BEGIN
    Select @szWhereProjectID = ' AND s.ProjectID LIKE ''%'' '
END
ELSE
BEGIN
    Select @szWhereProjectID = ' AND s.ProjectID = ''' + @ProjectId + ''' '
END
--CallType Parameter
IF @CallType = '*' or Len(@CallType) = 0
BEGIN
    Select @szWhereCallType = ' AND s.CallType LIKE ''%'' '
END
ELSE
BEGIN
    Select @szWhereCallType = ' AND s.CallType = ''' + @CallType + ''' '
END
--CallStatus Parameter
IF @CallStatus = '*' or Len(@CallStatus) = 0
BEGIN
    Select @szWhereCallStatus = ' AND s.CallStatus LIKE ''%'' '
END
ELSE
BEGIN
    Select @szWhereCallStatus = ' AND s.CallStatus = ''' + @CallStatus + ''' '
END
--AssignEmpID Parameter
IF @AssignEmpID = '*' or Len(@AssignEmpID) = 0
BEGIN
    Select @szWhereAssignEmpID = ' AND s.AssignEmpID LIKE ''%'' '
END
ELSE
BEGIN
    Select @szWhereAssignEmpID = ' AND s.AssignEmpID = ''' + @AssignEmpID + ''' '
END
--InvoiceNumber Parameter
IF @InvoiceNumber = '*' or Len(@InvoiceNumber) = 0
BEGIN
    Select @szWhereInvoiceNumber = ' AND s.InvoiceNumber LIKE ''%'' '
END
ELSE
BEGIN
    Select @szWhereInvoiceNumber = ' AND s.InvoiceNumber = ''' + @InvoiceNumber + ''' '
END
--CallStatus Parameter
IF @ServiceCallStatus = 'B' or Len(@ServiceCallStatus) = 0
BEGIN
    Select @szWhereServiceCallSt = ' AND s.ServiceCallStatus LIKE ''%'' '
END
ELSE
BEGIN
	IF @ServiceCallStatus = 'C'
	BEGIN
		Select @szWhereServiceCallSt = ' AND s.ServiceCallStatus = ''' + @ServiceCallStatus + ''' '
	END
	ELSE
	BEGIN
		Select @szWhereServiceCallSt = ' AND s.ServiceCallStatus <> ''C'' '
	END
END
--Company ID Parameter
SELECT @szWhereCpnyID = ' AND s.CpnyID = ''' + @CpnyID + ''' '
--Promised Date Parameter
SELECT @szWherePromised = CASE WHEN @PromisedFlag = 'NONE'  
                                THEN ' '
                               WHEN @PromisedFlag = 'BEGIN' 
                                THEN ' AND s.ServiceCallDateProm >= ''' + @BeginPromDate + ''' ' 
                               WHEN @PromisedFlag = 'END' 
                                THEN ' AND s.ServiceCallDateProm <= ''' + @EndPromDate + ''' ' +
									' AND s.ServiceCallDateProm <> ''01/01/1900 00:00:00'''
                               WHEN @PromisedFlag = 'BOTH' 
                                THEN ' AND s.ServiceCallDateProm >= ''' + @BeginPromDate + ''' ' +
                                     ' AND s.ServiceCallDateProm <= ''' + @EndPromDate + ''' '
                              END
--Completed Date Parameter
SELECT @szWhereCompleted = CASE WHEN @CompletedFlag = 'NONE'  
                                THEN ' '
                               WHEN @CompletedFlag = 'BEGIN' 
                                THEN ' AND s.CompleteDate >= ''' + @BeginCompleteDate + ''' '
                               WHEN @CompletedFlag = 'END' 
                                THEN ' AND s.CompleteDate <= ''' + @EndCompleteDate + ''' ' +
									' AND s.CompleteDate <> ''01/01/1900 00:00:00'''
                               WHEN @CompletedFlag = 'BOTH' 
                                THEN ' AND s.CompleteDate >= ''' + @BeginCompleteDate + ''' ' + 
                                     ' AND s.CompleteDate <= ''' + @EndCompleteDate + ''' '
                              END

--Dynamically generating the SQL Statement.
SELECT @szSelect = 'SELECT s.ServiceCallID, s.CpnyID, s.CustomerID, s.ServiceCallStatus, s.ProjectID, s.CallType, 
       s.CallStatus, s.ServiceCallDateProm, s. PromTimeFrom, s. PromiseTimeTOAMPM, 
       s.AssignEmpID, s.CallerName, s.InvoiceNumber, s.InvoiceAmount, c.Name, a.Phone' 
SELECT @szFrom = '  FROM SMServCall s INNER JOIN Customer c ON s.CustomerID = c.CustId 
      INNER JOIN SOAddress a ON s.CustomerID = a.CustId 
		AND s.ShipToId = a.ShipToID ' 
SELECT @szWhere = 'WHERE ' + @szWhereCustID + @szWhereShipToID + @szWhereProjectID + @szWhereCallType + @szWhereCallStatus + 
                  @szWhereAssignEmpID + @szWhereInvoiceNumber + @szWhereServiceCallSt + @szWhereCpnyID +
                  @szWherePromised + @szWhereCompleted

EXEC (@szSelect + @szFrom + @szWhere)

