 create proc ut_dhcreate @tabname varchar(50),
                      @path    varchar(20),
                      @dhname       varchar(36)
as
/********************************************************************************
*             Copyright TLB, Inc. 1991, 1994 All Rights Reserved
** Proc Name     : ut_dhcreate
** Narrative     : Creates a dh file based on the current definition of a table.
** Inputs        : tabname     ie. APDoc
*                 path        This is the destination of the dh file. This is
*                             relative to the sqlserver box, not the client.
*                             For example,  C:\temp\    will put in on the
*                             database servers C drive.
*                 dhname      name of "dh" file to create, usually same as table
*                                 name with ".dh" suffix. (ie. APDoc.dh)
*********************************************************************************
* #  Init  Date     Change
********************************************************************************
*001  CLS   06/29/98  Initial Creation
*********************************************************************************
*/

declare @command varchar(255),          @temp_colname varchar(32),
        @col_name  char(32),
        @col_type  varchar(65),
        @col_length char(15)

/*** Build Header stuff ***/
/***                    ***/
set @tabname = ltrim(rtrim(@tabname))

select @command='echo Option Explicit> '+@path+@dhname
exec master.dbo.xp_cmdshell @command

select @command='echo. >> '+@path+@dhname
exec master.dbo.xp_cmdshell @command

select @command='echo Attribute VB_Name = "' + @tabname + 'DH">> '+@path+@dhname
exec master.dbo.xp_cmdshell @command

select @command='echo Type ' + @tabname + '>> '+@path+@dhname
exec master.dbo.xp_cmdshell @command

declare col_cursor scroll cursor for
select  sc.name ,
        case
          /* Convert db types to vb types.                    */
          /* All converts are straightforward except date/time         */
          /* which converts as follows.                                */
          /*     If a field name ends in "datetime" ===> sdate         */
          /*     If a field name ends in "time"                        */
          /*                  other than "datetime" ===> stime         */
          when (t.name = 'char')	   then 'As String * '
          when (t.name = 'smallint')       then 'As Integer'
          when (t.name = 'float')          then 'As Double'
          when (t.name = 'Decimal')          then 'As Decimal'
          when (t.name = 'smalldatetime'
            and (sc.name like '%time%'
                   and sc.name not like '%datetime%'))
                                          then 'As Stime'
          when (t.name = 'smalldatetime'
            and (sc.name not like '%time%'
                   or sc.name like '%datetime%'))
                                          then 'As Sdate'
          when (t.name = 'int')		   then 'As Long'
          when (t.name = 'image')          then 'As String * 1900'
          when (t.name = 'text')           then 'As String * 1900'
          else 'Unknown type ' + t.name
        end type,
        case t.name
          when 'char' then substring(ltrim(str(sc.length)),1,datalength(convert(varchar,sc.length)))
          else ''
        end length
        from syscolumns sc,
             systypes   t
       where sc.id=object_id(@tabname)
         and t.usertype = sc.usertype
         and t.name <> 'timestamp'
    order by sc.colid

open col_cursor

fetch col_cursor into
      @col_name,
      @col_type,
      @col_length

while (@@fetch_status = 0)
  begin
    /*** Check for arrays ***/
   /*** Arrays will be identified for now as         ***/
   /*** columns ending with a two position number    ***/
   /*** with a column name other than S4Future       ***/

  if (@col_name not like 'S4Future%' and
     substring(@col_name,datalength(rtrim(@col_name))-1,2) = '00' )
  begin
     select @temp_colname = substring(@col_name,1,datalength(rtrim(@col_name))-2)
     while (@@fetch_status = 0 and
            substring(@col_name,1,datalength(rtrim(@col_name))-2) = @temp_colname)
     begin
        fetch col_cursor into
          @col_name,
          @col_type,
          @col_length
     end
     fetch prior from col_cursor into
          @col_name,
          @col_type,
          @col_length
     select @col_name = substring(@col_name,1,datalength(rtrim(@col_name))-2) + '(0 To '+
             substring(substring(@col_name,datalength(rtrim(@col_name))-1,2),
                       patindex('%0%',substring(@col_name,datalength(rtrim(@col_name))-1,1))+1,
                     2 - patindex('%0%',substring(@col_name,datalength(rtrim(@col_name))-1,1))) +
            ')' +Space(30)

  end

  select @command='echo     ' + rtrim(@col_name + @col_type + '' + @col_length)+ ' >> ' + @path+@dhname

exec master.dbo.xp_cmdshell @command
  fetch next from col_cursor into
      @col_name,
      @col_type,
      @col_length
end
close col_cursor
deallocate col_cursor

/*** print footer stuff ***/

select @command='echo End Type>> '+@path+@dhname
exec master.dbo.xp_cmdshell @command

select @command='echo. >> '+@path+@dhname
exec master.dbo.xp_cmdshell @command

select @command='echo Public b' + @tabname + ' As ' + @tabname + ', n' + @tabname + ' As ' + @tabname + '>> '+@path+@dhname
exec master.dbo.xp_cmdshell @command



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_dhcreate] TO [MSDSL]
    AS [dbo];

