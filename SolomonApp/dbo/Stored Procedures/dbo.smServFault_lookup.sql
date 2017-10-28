 CREATE PROCEDURE smServFault_lookup
		@ServiceCallID varchar(15),
        @TaskStatus varchar(10)
AS

DECLARE @szSelect	varchar(300)
DECLARE @szFrom		varchar(200)
DECLARE @szWhere	varchar(1000)

DECLARE @szWhereServiceCallID varchar(50)
DECLARE @szWhereTaskStatus	  varchar(50)

--Service Call ID Parameter
SELECT @szWhereServiceCallID = ' s.ServiceCallID = ''' + @ServiceCallID + ''' '

--Task Status Parameter
SELECT @szWhereTaskStatus = CASE WHEN @TaskStatus = 'B'  
                                THEN ' AND s.TaskStatus LIKE ''%'' ' 
                               WHEN @TaskStatus = 'C' 
                                THEN ' AND s.TaskStatus = ''C'' ' 
                               WHEN @TaskStatus = 'O' 
                                THEN ' AND s.TaskStatus <> ''C'' '
                              END

--Dynamically generating the SQL Statement.
SELECT @szSelect = 'SELECT s.ServiceCallID, s.FaultCodeID, isnull(c.FaultDesc, ''''), s.EmpID, s.TaskStatus, s.StartDate, 
       s.StartTime, s. CauseID, s. ResolutionID' 
SELECT @szFrom = '  FROM SMServFault s LEFT JOIN SMCode c ON s.FaultCodeId = c.Fault_Id '
SELECT @szWhere = 'WHERE ' + @szWhereServiceCallID + @szWhereTaskStatus 

EXEC (@szSelect + @szFrom + @szWhere)

