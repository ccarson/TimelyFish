
/****** Object:  Stored Procedure dbo.ItemXRef_Auto_Insert    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.ItemXRef_Auto_Insert    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemXRef_Auto_Insert @parm1 varchar ( 30), @parm2 varchar ( 1), 
				 @parm3 smalldatetime, @parm4 varchar (8),@parm5 varchar (10), 
				 @parm6 varchar(60)  , @parm7 varchar(10),@parm8 varchar (30) as

	Insert ItemXRef 
	(AlternateID, AltIDType, Crtd_DateTime, Crtd_Prog,      
	Crtd_User, Descr, EntityID, InvtID, LUpd_DateTime, LUpd_Prog, 
	LUpd_User, NoteID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
        S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,Sequence, Unit, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8)  
	
	values( @parm1, @parm2, @parm3, @parm4,      
	@parm5, @parm6, @parm7, @parm8, @parm3, @parm4, 
	@parm5, 0,' ', ' ', 0, 0, 0, 0, ' ', ' ', 0, 0, ' ', ' ',0, ' ', 0, ' ', ' ', 0, 0, ' ', ' ', ' ', ' ')



