 CREATE Proc pp_030x_Delete_BatchDocTran @BatNbr varchar(10), @Sol_User varchar(10),
			@editscrnnbr varchar(5)
AS

Declare   @PerNbr CHAR(6)

select @PerNbr = CurrPerNbr
  from Apsetup (nolock)


delete  apd
  from apdoc apd
 where apd.batnbr = @BatNbr and @editscrnNbr = '03030'
IF @@ERROR <> 0 GOTO ABORT

---Delete temporary check trans for manual checks created in 03010
delete  apd
  from apdoc apd
 where apd.batnbr = @BatNbr and apd.docclass = 'C' and apd.doctype = "VC" and @editscrnNbr = '03010'
IF @@ERROR <> 0 GOTO ABORT

 Update apd
   set LUpd_DateTime = GETDATE(),
	 LUpd_Prog = @editscrnnbr,
	 LUpd_User = @Sol_User,
	 status = 'V',
	 doctype = 'VT',
	 batnbr = ''
  from apdoc apd
 where apd.batnbr = @BatNbr and @editscrnNbr in ('03010','03020','03025')
IF @@ERROR <> 0 GOTO ABORT

Delete apt
  from APTran apt
 where apt.batnbr = @BatNbr
IF @@ERROR <> 0 GOTO ABORT

---update prtrans linked to this voucher (created in PR)
update pr
	set APBatch = "", APRefnbr = "", APLineID = 0
	from prtran pr, batch b
	where 	b.batnbr = @BatNbr and
		b.jrnltype = "PR" and
		b.module = "AP" and
		pr.APBatch = @BatNbr and
		@editscrnNbr = '03010'
 Update b
   Set AutoRev=0,AutoRevCopy=0,battype="",CrTot=0,CtrlTot=0,Cycle=0,
      Descr="",DrTot=0,EditScrnNbr="",GlPostOpt="",JrnlType="",LUpd_DateTime=GETDATE(),LUpd_Prog=@editscrnnbr,LUpd_User=@Sol_User,Module="AP",
      NbrCycle=0,PerEnt="",Rlsed=1,Status ='V',perpost = @PerNbr
  from batch b
 where b.batnbr= @BatNbr and b.module = 'AP'

ABORT:


