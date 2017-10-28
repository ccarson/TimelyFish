CREATE VIEW vInactiveSubTran
	AS 
	SELECT BatNbr, CpnyId, Module, NewSub = convert(char(24),''), Selected = convert(smallint, 0), 
	Sub, tstamp = min(tstamp)
  	FROM GLTran g
	WHERE Posted = 'U'
	AND Sub Not In (Select Sub FROM SubAcct WHERE Active = 1)
	AND RLSED = 1
	GROUP BY BatNbr, CpnyId, Module, Sub
