 /****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 10/25/00 8:32:15 AM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 10/10/00 4:15:38 PM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 10/2/00 4:58:13 PM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 9/1/00 9:39:20 AM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 03/31/2000 12:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 2/2/00 12:18:18 PM ******/

/****** Object:  Stored Procedure dbo.RQINUnit_InvtId_UnitDesc    Script Date: 12/17/97 10:49:01 AM ******/
Create Procedure RQINUnit_InvtId_UnitDesc @Parm1 Varchar(24), @Parm2 Varchar(6) as
Select * From INUnit Where InvtId = @parm1 and
FromUnit like @parm2
order by InvtId, FromUnit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQINUnit_InvtId_UnitDesc] TO [MSDSL]
    AS [dbo];

