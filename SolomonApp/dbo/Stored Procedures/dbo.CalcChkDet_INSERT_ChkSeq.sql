 Create Proc CalcChkDet_INSERT_ChkSeq @EmpId varchar (10), @ChkSeq varchar(2), @EDType varchar (1), @WrkLocId varchar (6), @EarnDedId varchar (10), @Crtd_Prog varchar(8), @Crtd_User varchar(10) as
        insert CalcChkDet
            select 0,0,0,c.ChkSeq,
                   getdate(),@Crtd_Prog,@Crtd_User,0,0,0,@EarnDedId,@EDType,@EmpID,
                   getdate(),@Crtd_Prog,@Crtd_User,0,'','',0,0,0,
                   0,'','',0,0,'','','','',0,0,
                   '','','','',@WrkLocId,null
              from CalcChk c
             where c.EmpId =  @EmpId
               and ChkSeq  <> @ChkSeq
               and NOT exists (select EmpId
                                 from CalcChkDet d
                                where d.EmpId     = @EmpId
                                  and d.ChkSeq    = c.ChkSeq
                                  and d.EDType    = @EDType
                                  and d.WrkLocId  = @WrkLocId
                                  and d.EarnDedID = @EarnDedID)


