--*************************************************************
--	Purpose:Insert a record into cftPigProdEff 
--	Author: Jim Maher
--	Date: 10/13/06
--	Usage: PigProdPodMaint\Form1\General\cPodID_Chk
--	Parms: @parm1 (ADG) 		@parm2 (CF01)
--	       @parm3 (CF02)		@parm4 (CF03)
--             @parm5 (CF04)		@parm6 (CF05)
--             @parm7 (Crtd_DateTime)	@parm8 (Crtd_Prog)
--             @parm9 (Crtd_User)	@parm10 (FeedEfficiency)
--             @parm11 (GenderTypeID)	@parm12 (LUpd_DateTime)
--             @parm13 (LUpd_Prog)	@parm14 (LUpd_User)
--             @parm15 (NoteID)		@parm16 (PodID)
--             
--
--	Used When creating a new pod, will create 3 new lines.
--	      
--*************************************************************

CREATE PROCEDURE dbo.pXP1100PigProdEffIns
	(@parm1 as float,
	@parm2 as varchar(30),
	@parm3 as varchar(10),
	@parm4 as smalldatetime,
	@parm5 as smallint,
	@parm6 as float,
	@parm7 as smalldatetime,
	@parm8 as varchar(8),
	@parm9 as varchar(10),
	@parm10 as float,
	@parm11 as varchar(1),
	@parm12 as smalldatetime,
	@parm13 as varchar(8),
	@parm14 as varchar(10),
	@parm15 as int,
	@parm16 as varchar(3)
	--,@parm17 as timestamp
	)

AS
Insert INTO cftPigProdEff (ADG,CF01,CF02,CF03,CF04,CF05,Crtd_DateTime,Crtd_Prog,Crtd_User,FeedEfficiency,GenderTypeID,LUpd_DateTime,Lupd_Prog,LUpd_User,NoteID,PodID)
VALUES (@parm1,@parm2,@parm3,@parm4,@parm5,@parm6,@parm7,@parm8,@parm9,@parm10,@parm11,@parm12,@parm13,@parm14,@parm15,@parm16)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP1100PigProdEffIns] TO [MSDSL]
    AS [dbo];

