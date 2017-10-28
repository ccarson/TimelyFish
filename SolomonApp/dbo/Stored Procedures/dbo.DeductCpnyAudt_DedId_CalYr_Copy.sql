
Create Proc [dbo].[DeductCpnyAudt_DedId_CalYr_Copy] @newyr varchar ( 4),@AudtDate varchar(25), @AudtDateSort varchar(25),  
 @Crtd_Prog varchar(8), @Crtd_User varchar(10), @DedId varchar ( 10) as

insert into DeductCpnyAudt(
AudtDate, AudtDateSort, calyr,CpnyID,
           Crtd_DateTime,
           Crtd_Prog,
           Crtd_User,DedId,ExpAcct,ExpSub,
           LUpd_DateTime,
           LUpd_Prog,
           LUpd_User,ProjBillable,ProjImpact,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,
           S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,
           S4Future12,UpdProject,User1,User2,User3,User4,User5,User6,User7,User8,WthldAcct,WthldSub)
    select @AudtDate, @AudtDateSort, @newyr,CpnyID,
           Crtd_DateTime,
           @Crtd_Prog,
           @Crtd_User,DedId,ExpAcct,ExpSub,
           Crtd_DateTime,
           @Crtd_Prog,
           @Crtd_User,ProjBillable,ProjImpact,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,
           S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,
           S4Future12,UpdProject,User1,User2,User3,User4,User5,User6,User7,User8,WthldAcct,WthldSub
      from DeductCpny DedCpny2
     where DedCpny2.DedId = @DedId
       and DedCpny2.CalYr = @newyr

