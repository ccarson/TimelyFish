CREATE PROCEDURE WSL_TMPFTInfo
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- employee
AS
  SET NOCOUNT ON

  IF EXISTS(SELECT * FROM PJPFTUSER WHERE Employee = @parm1)
  BEGIN
	SELECT u.DayRange 
		  ,u.DecPlHrs
		  ,u.Desc_Cust_Chars
		  ,u.Desc_Cust_Code
		  ,u.Desc_Oper_Chars
		  ,u.Desc_Oper_Code
		  ,u.Desc_Proj_Chars
		  ,u.Desc_Proj_Code
		  ,u.Desc_Task_Chars
		  ,u.Desc_Task_Code
		  ,u.Display_WeekEnd
		  ,u.FontSize
		  ,u.IntervalFut
		  ,u.IntervalPast
		  ,u.Prox_AmtYellowN
		  ,u.Prox_AmtYellowP
		  ,u.Prox_DateYellowN
		  ,u.Prox_DateYellowP
		  ,u.Prox_HrsYellowN
		  ,u.Prox_HrsYellowP
		  ,s.SetUpID
		  ,u.ShowCertifiedPR
		  ,u.ShowCpnyID
		  ,u.ShowGLAcct
		  ,u.ShowGLSub
		  ,u.ShowGroupCode
		  ,u.ShowHrsToCmp
		  ,u.ShowLbrClass
		  ,u.ShowMgrReview
		  ,u.ShowNonBill
		  ,u.ShowOT
		  ,u.ShowShift
		  ,u.ShowStepCmpO
		  ,u.ShowTaskCmpO
		  ,u.ShowUnionCode
		  ,u.ShowWklyDesc
		  ,u.ShowWorkerComp
		  ,u.ShowWorkType
		  ,u.ToolTipDisplay
	  FROM PJPFTUSER u CROSS JOIN PJPFTSYS s
	  WHERE u.Employee = @parm1
  END
  ELSE
  BEGIN
	SELECT DayRange 
		  ,DecPlHrs
		  ,Desc_Cust_Chars
		  ,Desc_Cust_Code
		  ,Desc_Oper_Chars
		  ,Desc_Oper_Code
		  ,Desc_Proj_Chars
		  ,Desc_Proj_Code
		  ,Desc_Task_Chars
		  ,Desc_Task_Code
		  ,Display_WeekEnd
		  ,FontSize
		  ,IntervalFut
		  ,IntervalPast
		  ,Prox_AmtYellowN
		  ,Prox_AmtYellowP
		  ,Prox_DateYellowN
		  ,Prox_DateYellowP
		  ,Prox_HrsYellowN
		  ,Prox_HrsYellowP
		  ,SetUpID
		  ,ShowCertifiedPR
		  ,ShowCpnyID
		  ,ShowGLAcct
		  ,ShowGLSub
		  ,ShowGroupCode
		  ,ShowHrsToCmp
		  ,ShowLbrClass
		  ,ShowMgrReview
		  ,ShowNonBill
		  ,ShowOT
		  ,ShowShift
		  ,ShowStepCmpO
		  ,ShowTaskCmpO
		  ,ShowUnionCode
		  ,ShowWklyDesc
		  ,ShowWorkerComp
		  ,ShowWorkType
		  ,ToolTipDisplay
	  FROM PJPFTSYS
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TMPFTInfo] TO [MSDSL]
    AS [dbo];

