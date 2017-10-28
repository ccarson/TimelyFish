 create proc SoAddrSlsPer_Dflt @custid varchar(15), @shiptoid varchar(10), @progid varchar(9), @userid varchar(10)  as

insert soaddrslsper (creditpct,crtd_datetime, crtd_prog, crtd_user, custid,
lupd_datetime,lupd_prog, lupd_user, noteid,
s4future01, s4future02, s4future03, s4future04, s4future05, s4future06,
s4future07, s4future08, s4future09, s4future10, s4future11, s4future12,
shiptoid, slsperid, user1,user10, user2, user3, user4, user5, user6, user7, user8, user9)
select creditpct, getdate(), @progid,@userid, @custid, "","","",0,
"","",0,0,0,0,"","",0,0,"","",
@shiptoid,slsperid, "","","","","",0,0,"","","" from custslsper where custid =@custid
and not exists(select * from soaddrslsper s where s.CustID=@custid and s.ShipToID=@shiptoid and s.SlsPerID=custslsper.SlsPerID)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SoAddrSlsPer_Dflt] TO [MSDSL]
    AS [dbo];

