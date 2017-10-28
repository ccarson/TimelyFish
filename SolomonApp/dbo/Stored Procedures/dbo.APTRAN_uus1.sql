 create procedure  APTRAN_uus1
as
update APTRAN
set extrefnbr = aptran.user2,
user2 = ' ',
user3 = 0
where APTRAN.user3 = -8888.00


