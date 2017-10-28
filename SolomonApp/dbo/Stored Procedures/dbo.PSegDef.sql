 /****** Object:  Stored Procedure dbo.PSegDef    Script Date: 4/17/98 12:50:25 PM ******/
Create Proc PSegDef @CLASSID varchar ( 3)             , @SEGNBR varchar ( 2)             , @SEGID varchar ( 24)               as
select * from segdef where FieldClass like @CLASSID and SegNumber like @SEGNBR and ID like @SEGID order by FieldClass, SegNumber, ID


