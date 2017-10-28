 Create Proc DeductCpny_DedId_CalYr_Copy @DedId varchar ( 10), @oldyr varchar ( 4), @newyr varchar ( 4), @Crtd_Prog varchar(8), @Crtd_User varchar(10) as

insert DeductCpny
    select @newyr,CpnyID,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,DedId,ExpAcct,ExpSub,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,ProjBillable,ProjImpact,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,
           S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,
           S4Future12,UpdProject,User1,User2,User3,User4,User5,User6,User7,User8,WthldAcct,WthldSub,null
      from DeductCpny DedCpny2
     where DedCpny2.DedId = @DedId
       and DedCpny2.CalYr = @oldyr
       and NOT exists (select DedId
                         from DeductCpny DedCpny3
                        where DedCpny3.DedId     = DedCpny2.DedId
                          and DedCpny3.CalYr     = @newyr
                          and DedCpny3.CpnyId    = DedCpny2.CpnyId)


