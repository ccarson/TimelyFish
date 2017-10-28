 Create Proc CheckSeq_Insert_Default as
    If Not Exists (Select * From CheckSeq Where ChkSeq='01')
        Insert CheckSeq
               (ChkSeq, Crtd_DateTime, Crtd_Prog, Crtd_User, Descr, LUpd_DateTime, LUpd_Prog, LUpd_User, PrtDDFlag,
                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
                S4Future10, S4Future11, S4Future12, User1, User2, User3, User4, User5, User6, User7, User8)
        Values ('01',getdate(),'TSQL',left(suser_sname(),10),'Pre-defined Check Seq',getdate(),'TSQL',left(suser_sname(),10),'N',
                '','',0,0,0,0,'','',0,0,'','','','',0,0,'','','','')


