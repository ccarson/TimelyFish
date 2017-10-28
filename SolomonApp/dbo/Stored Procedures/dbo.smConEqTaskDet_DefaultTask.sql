 CREATE PROCEDURE
	smConEqTaskDet_DefaultTask
		@parm1	varchar(10),		-- Contract ID
		@parm2	varchar(10),		-- Equipment ID
		@parm3	varchar(10)		-- PMCode
AS

DECLARE @MaxLineNbr INTEGER

DELETE FROM smConEqTaskDet
WHERE 	ContractID = @parm1 AND
	EquipID = @parm2 AND
	PMCode = @parm3

-- insert data from smPMDetail to smConEqTaskDet
INSERT INTO smConEqTaskDet
(	ContractID ,
	Crtd_DateTime ,
	Crtd_Prog ,
	Crtd_User ,
	DetailType ,
	EquipID ,
	Invtid ,
	LineNbr ,
	Lupd_DateTime ,
	Lupd_Prog ,
	Lupd_User ,
	PMCode ,
	Quantity ,
	Season ,
	UnitCost ,
	UnitPrice ,
	User1 ,
	User2 ,
	User3 ,
	User4 ,
	User5 ,
	User6 ,
	User7 ,
	User8 ,
	WorkArea ,
	WorkDesc
)    SELECT
	@parm1 ,
	Crtd_DateTime ,
	Crtd_Prog ,
	Crtd_User ,
	DetailType ,
	@parm2 ,
	Invtid ,
	LineNbr ,
	Lupd_DateTime ,
	Lupd_Prog ,
	Lupd_User ,
	PMType ,
	Quantity ,
	Season,
	UnitCost,
	UnitPrice,
	User1 ,
	User2 ,
	User3 ,
	User4 ,
	User5 ,
	User6 ,
	User7 ,
	User8 ,
	WorkArea ,
	WorkDesc
    FROM smPMDetail
    WHERE PMType = @parm3
    ORDER BY LineNbr

SELECT @MaxLineNbr = MAX(LineNbr) FROM smConEqTaskDet
WHERE 	ContractID = @parm1 AND
	EquipID = @parm2 AND
	PMCode = @parm3
IF @MaxLineNbr IS NULL SELECT @MaxLineNbr = -1 ELSE SELECT @MaxLineNbr = @MaxLineNbr + 32768

-- insert data from smPMDetail to smConEqTaskDet
INSERT INTO smConEqTaskDet
(	ContractID ,
	Crtd_DateTime ,
	Crtd_Prog ,
	Crtd_User ,
	DetailType ,
	EquipID ,
	Invtid ,
	LineNbr ,
	Lupd_DateTime ,
	Lupd_Prog ,
	Lupd_User ,
	PMCode ,
	Quantity ,
	Season ,
	UnitCost ,
	UnitPrice ,
	User1 ,
	User2 ,
	User3 ,
	User4 ,
	User5 ,
	User6 ,
	User7 ,
	User8 ,
	WorkArea ,
	WorkDesc
)    SELECT
	@parm1 ,
	m.Crtd_DateTime ,
	m.Crtd_Prog ,
	m.Crtd_User ,
	m.DetailType ,
	@parm2 ,
	m.Invtid ,
	CONVERT(INT,m.LineNbr) + @MaxLineNbr + 1 ,
	m.Lupd_DateTime ,
	m.Lupd_Prog ,
	m.Lupd_User ,
	m.PMType ,
	m.Quantity ,
	'',
	0,
	0,
	m.User1 ,
	m.User2 ,
	m.User3 ,
	m.User4 ,
	m.User5 ,
	m.User6 ,
	m.User7 ,
	m.User8 ,
	'' ,
	m.Descr
    FROM smPMModel m INNER JOIN smSvcEquipment e
         ON e.ManufId = m.ManufId AND e.ModelId = m.ModelId AND e.EquipId = @parm2 AND e.ModelId <> ''
    WHERE m.PMType = @parm3 AND CONVERT(INT,m.LineNbr) + @MaxLineNbr + 1 BETWEEN -32768 AND 32767
    ORDER BY LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConEqTaskDet_DefaultTask] TO [MSDSL]
    AS [dbo];

