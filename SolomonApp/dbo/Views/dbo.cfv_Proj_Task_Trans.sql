

/****** Object:  View dbo.cfv_Proj_Task_Trans    Script Date: 12/8/2004 8:28:22 PM ******/

/****** Object:  View dbo.cfv_Proj_Task_Trans    Script Date: 11/17/2004 11:09:52 AM ******/
/* BALANCE FORWARD IS NOT INCLUDED IN THE SUM */

CREATE View cfv_Proj_Task_Trans
as
Select project,
       pjt_entity,
       acct,
       sum(act_amount) As Amount,
       sum(act_units) As Units
  From PJPTDSUM
  Group by project, pjt_entity, acct




