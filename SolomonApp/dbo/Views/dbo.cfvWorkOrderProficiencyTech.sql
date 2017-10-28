

CREATE   VIEW dbo.cfvWorkOrderProficiencyTech
AS
SELECT     dbo.smServCall.ServiceCallID, AmtTotal.invSum, AmtTotal.Hrs,
		   EmpID= case when AmtTotal.EmpID='' then dbo.smServCall.AssignEmpID else AmtTotal.EmpID end, dbo.smServCall.BranchID, dbo.smServCall.CompleteDate, 
                      dbo.smServCall.ServiceCallDate, dbo.smServCall.ServiceCallDateProm, dbo.smServCall.ServiceCallPriority, dbo.smCallTypes.CallTypeDesc, 
                      dbo.smCallTypes.CallTypeId, dbo.PJPROJ.project_desc
FROM         dbo.smServCall INNER JOIN
                      dbo.smCallTypes ON dbo.smServCall.CallType = dbo.smCallTypes.CallTypeId INNER JOIN
                          (SELECT     sd1.servicecallid, sd1.EmpID, SUM(sd1.tranamt) AS invSum, sum(sd1.WOrkHr) as Hrs
                            FROM          smServDetail sd1
                            GROUP BY sd1.servicecallid, sd1.EmpID) AmtTotal ON AmtTotal.servicecallid = dbo.smServCall.ServiceCallID LEFT OUTER JOIN
                      dbo.PJPROJ ON dbo.smServCall.ProjectID = dbo.PJPROJ.project

WHERE     (dbo.smCallTypes.CallTypeId <> 'SL')


