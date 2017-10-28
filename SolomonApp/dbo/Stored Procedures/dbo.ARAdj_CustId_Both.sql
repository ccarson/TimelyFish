 Create Proc ARAdj_CustId_Both @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 10),
@parm4 varchar ( 2), @parm5 varchar ( 10) as

    Select * from ARAdjust where CustId = @parm1
           and AdjgDocType = @parm2
           and AdjgRefNbr = @parm3
	   and AdjdDoctype = @parm4
	   and AdjdRefnbr = @parm5
           order by CustId, AdjgDocType,AdjgRefNbr


