--*************************************************************
--	Purpose:Ties offloads together
--	Author: Charity Anderson
--	Date: 3/1/2005
--	Usage: Flow Board
--	Parms: SrcPMID,DestPMID,User
--	      
--*************************************************************

CREATE PROC dbo.pCF100InsertOffload
	(@parm1 as int,@parm2 as int, @parm3 as varchar(10))
	
AS
Insert into cftPigOffload
(Crtd_DateTime,Crtd_Prog,Crtd_User,
DestPMId,
Lupd_DateTime,Lupd_Prog,Lupd_User,
NoteID,SrcPMId
)
Select getdate(),'CF10000',@parm3,
@parm2,
getdate(),'CF10000',@parm3,
0,@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100InsertOffload] TO [MSDSL]
    AS [dbo];

