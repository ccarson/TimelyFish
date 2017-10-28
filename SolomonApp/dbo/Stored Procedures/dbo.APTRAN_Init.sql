 create procedure APTRAN_Init
as
select * from APTRAN
where batnbr = 'Z'
and refnbr = 'Z'
and linenbr = 0


