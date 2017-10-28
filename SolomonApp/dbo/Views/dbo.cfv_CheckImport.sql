
/****** Object:  View dbo.cfv_CheckImport    Script Date: 12/8/2004 8:24:47 PM ******/


/****** Object:  View dbo.cfv_CheckImport    Script Date: 11/19/2004 11:15:37 AM ******/


CREATE    View cfv_CheckImport
as
Select project,
       pjt_entity,
       acct,
       amount,
       units
  From PJCHARGD
  Where Crtd_Prog='IMPORT'







