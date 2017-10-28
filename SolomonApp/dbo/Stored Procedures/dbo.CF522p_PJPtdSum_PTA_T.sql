
/****** Object:  Stored Procedure dbo.CF522p_PJPtdSum_PTA_T    Script Date: 5/19/2005 8:42:54 AM ******/

/****** Object:  Stored Procedure dbo.CF522p_PJPtdSum_PTA_T    Script Date: 2/28/2005 12:08:33 PM ******/

/****** Object:  Stored Procedure dbo.CF522p_PJPtdSum_PTA_T    Script Date: 2/28/2005 11:11:51 AM ******/

/****** Object:  Stored Procedure dbo.CF522p_PJPtdSum_PTA_T    Script Date: 2/25/2005 4:43:08 PM ******/

/****** Object:  Stored Procedure dbo.CF522p_PJPtdSum_PTA_T    Script Date: 2/21/2005 4:50:15 PM ******/

/****** Object:  Stored Procedure dbo.CF522p_PJPtdSum_PTA    Script Date: 2/21/2005 2:09:00 PM ******/
CREATE      Procedure CF522p_PJPtdSum_PTA_T 
@parm1 varchar (16), @parm2 varchar (32), @parm3 varchar (16), @parm4 datetime, @parm5 datetime 
as 
    Select *
    from pjtran 
	Where Project = @parm1 and Pjt_Entity = @parm2 and Acct = @parm3
	and amount <> 0
	and trans_date < @parm5
	and User3 <>'1'






