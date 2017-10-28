


CREATE VIEW dbo.cfvWorkOrderProficiency
AS

--*************************************************************
--	Purpose:  
--	Author: Eric Lind
--	Date: 
--	Usage:  Report SDWOP.rpt
--	
--*************************************************************
SELECT
    smServCall."ServiceCallID",
    --smServDetail."TranAmt",
    amtTotal.InvSum,
    smServCall."AssignEmpID",
    
    smServCall."BranchID",
    smServCall."CompleteDate",
    smServCall."ServiceCallDate",
    smServCall."ServiceCallDateProm",
    smServCall."ServiceCallPriority",
    smCallTypes."CallTypeDesc",
    smCallTypes."CallTypeId",
    PJPROJ."project_desc"
   
FROM
    smServCall INNER JOIN  smCallTypes ON
        smServCall."CallType" = smCallTypes."CallTypeId"
     --INNER JOIN smServDetail ON
       -- smServCall."ServiceCallID" = smServDetail."ServiceCallID"
     INNER JOIN 
	(SELECT sd1.servicecallid, sum(sd1.tranamt) as invSum
           from smServDetail sd1
           GROUP BY sd1.servicecallid ) AmtTotal
     ON AmtTotal.servicecallid = smServCall.servicecallid     

     LEFT OUTER JOIN PJPROJ ON
        smServCall."ProjectID" = PJPROJ."project"
WHERE
     smCallTypes."CallTypeId" <> 'SL'    


