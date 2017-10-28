 Create Proc DedId_Tables_Create @DedIdSrc varchar (10), @DedIdDst varchar (10), @CalYr varchar (4), @Crtd_Prog varchar(8), @Crtd_User varchar(10) as
set nocount ON
insert DeductCpny
    select @CalYr,CpnyID,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,@DedIdDst,ExpAcct,ExpSub,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,ProjBillable,ProjImpact,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,
           S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,
           S4Future12,UpdProject,User1,User2,User3,User4,User5,User6,User7,User8,WthldAcct,WthldSub,null
      from DeductCpny DedCpny2
     where DedCpny2.CalYr = @CalYr
       and DedCpny2.DedId = @DedIdSrc
       and NOT exists (select DedId
                         from DeductCpny DedCpny3
                        where DedCpny3.DedId     = @DedIdDst
                          and DedCpny3.CalYr     = @CalYr
                          and DedCpny3.CpnyId    = DedCpny2.CpnyId)

insert ExmptCredit
    select AnnMaxAmt,AnnMinAmt,Annualize,BaseDedId,BaseType,CalcMthd,
           @CalYr,CpnyID,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,
           @DedIdDst,Descr,ExmptCr,ExmptCrId,ExmptID,FxdPctRate,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,MarStat,MaxApplyFlg,NoteId,PayTblId,RedRptEarnSubjDed,
           S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,
           S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,
           User1,User2,User3,User4,User5,User6,User7,User8,null
      from ExmptCredit ExmpCr2
     where ExmpCr2.CalYr = @CalYr
       and ExmpCr2.DedId = @DedIdSrc
       and NOT exists (select ExmptCrId
                         from ExmptCredit ExmpCr3
                        where ExmpCr3.DedId     = @DedIdDst
                          and ExmpCr3.CalYr     = @CalYr
                          and ExmpCr3.MarStat   = ExmpCr2.MarStat
                          and ExmpCr3.ExmptCr   = ExmpCr2.ExmptCr
                          and ExmpCr3.ExmptCrId = ExmpCr2.ExmptCrId)

insert ValEarnDed
    select CpnyID,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,
           @DedIdDst,EarnTypeId,
           getdate(),
           @Crtd_Prog,
           @Crtd_User,NoteId,S4Future01,S4Future02,S4Future03,S4Future04,
           S4Future05,S4Future06,S4Future07,S4Future08,S4Future09,
           S4Future10,S4Future11,S4Future12,User1,User2,User3,User4,
           User5,User6,User7,User8,null
      from ValEarnDed ValEarnDed2
     where ValEarnDed2.DedId = @DedIdSrc
       and NOT exists (select DedId
                         from ValEarnDed ValEarnDed3
                        where ValEarnDed3.EarnTypeId = ValEarnDed2.EarnTypeId
                          and ValEarnDed3.EarnTypeId = @DedIdDst)
set nocount OFF


