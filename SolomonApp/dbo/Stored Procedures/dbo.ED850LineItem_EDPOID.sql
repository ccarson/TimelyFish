﻿ CREATE PROCEDURE ED850LineItem_EDPOID @EDPOID varchar(10) AS

Select * from ED850LineItem
where EDIPOID = @EDPOID


