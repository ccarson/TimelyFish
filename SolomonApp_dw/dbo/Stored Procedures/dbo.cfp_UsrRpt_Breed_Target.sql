


/*
Date		DBA			Purpose
20150128    sripley     Finance analyst wanted a proc to use in a refreshable spreadsheet
20150813	tthomsen	Dan Marti wanted to be able to turn sources on and off for various FarmID groups
20151016	tthomsen	Dan Marti needed formulas to be fixed
*/

CREATE PROCEDURE [dbo].[cfp_UsrRpt_Breed_Target]

AS
BEGIN

-- Single projects for FarmID C09
begin
select *
into #single_proj_farms_C09
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01' and mating_picyear_week < '14WK42') or (mating_picyear_week >= '15WK26'))
			and FarmID in ('C09')
	group by FarmID, mating_picyear_week) C09
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C10
begin
select *
into #single_proj_farms_C10
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01' and mating_picyear_week < '14WK47') or (mating_picyear_week >= '15WK26'))
			and FarmID in ('C10')
	group by FarmID, mating_picyear_week) C10
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C11
begin
select *
into #single_proj_farms_C11
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01' and mating_picyear_week < '14WK42') or (mating_picyear_week >= '15WK26'))
			and FarmID in ('C11')
	group by FarmID, mating_picyear_week) C11
order by mating_picyear_week, FarmID
end

-- Breeding projects for FarmID B37, C09, C11
begin
select *
into #breeding_proj_farms_B37_C09_C11
from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK42' and mating_picyear_week < '15WK26'
		and FarmID in ('B37','C09','C11')
	group by FarmID, mating_picyear_week) C09C11
order by mating_picyear_week, FarmID
end

-- Breeding projects update for FarmID B37
begin
update #breeding_proj_farms_B37_C09_C11
set [females bred] = [females bred] + B37.bp5
from #breeding_proj_farms_B37_C09_C11 src5
	inner join (select source, FarmID, mating_picyear_week, cast([females bred] as float)/2 as bp5
		from #breeding_proj_farms_B37_C09_C11
		where FarmID = 'B37') B37
		on B37.source = src5.source
			and B37.mating_picyear_week = src5.mating_picyear_week
			and src5.FarmID <> 'B37'
end

-- Breeding projects for FarmIDs C10 and K01
begin
select *
into #breeding_proj_farms_C10_K01
from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK47' and mating_picyear_week < '15WK26'
		and FarmID in ('C10','K01')
	group by FarmID, mating_picyear_week) C10K01
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C12 and C18
-- stop at 14w34 and start again at 14w52
begin
select *
into #single_proj_farms_C12_C18
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01'	and mating_picyear_week < '14WK34') or mating_picyear_week >= '15WK08')
		and FarmID in ('C12','C18')
	group by FarmID, mating_picyear_week) C12C18
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C13
begin
select *
into #single_proj_farms_C13
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01'	and mating_picyear_week < '14WK42') or mating_picyear_week >= '15WK08')
		and FarmID in ('C13')
	group by FarmID, mating_picyear_week) C13
order by mating_picyear_week, FarmID
end

-- Breeding projects for FarmIDs C12 and C13
begin
select *
into #breeding_proj_farms_C12_C13
from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK42' and mating_picyear_week < '15WK08'
		and FarmID in ('C12','C13')
	group by FarmID, mating_picyear_week) C12C13
order by mating_picyear_week, FarmID;
end

-- Single projects for FarmID C14
begin
select *
into #single_proj_farms_C14
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where (mating_picyear_week >= '14WK01' and mating_picyear_week < '14WK05') or (mating_picyear_week >= '14WK26' and mating_picyear_week < '14WK34') or (mating_picyear_week >= '14WK52')
			and FarmID = 'C14'
	group by FarmID, mating_picyear_week) C14
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C24
begin
select *
into #single_proj_farms_C24
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01' and mating_picyear_week < '14WK05') or (mating_picyear_week >= '14WK26' and mating_picyear_week < '14WK34') or (mating_picyear_week >= '14WK52'))
		and FarmID in ('C24')
	group by FarmID, mating_picyear_week) C24
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C15 and C20
begin
select *
into #single_proj_farms_C15_C20
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01' and mating_picyear_week < '14WK09') or mating_picyear_week > '14WK26')
		and FarmID in ('C15')
	group by FarmID, mating_picyear_week) C15C20
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C19 and B33
begin
select *
into #single_proj_farms_C19_B33
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
		from  dbo.cft_SowMart_Detail_data
		where mating_picyear_week < '14WK34' or mating_picyear_week > '15WK26'
			and FarmID in ('C19', 'B33')
	group by FarmID, mating_picyear_week) C19
order by mating_picyear_week, FarmID
end

-- Breeding projects for FarmIDs C19 and B33
begin
select *
into #breeding_proj_farms_C19_B33
from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week < '14WK36' and mating_picyear_week > '15WK26'
		and FarmID in ('C19','B33')
	group by FarmID, mating_picyear_week) C10K01
order by mating_picyear_week, FarmID
end

-- Single projects for FarmID C42, C43, and C44
begin
select *
into #single_proj_farms_C42_C43_C44
from
	(select 'Single' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where ((mating_picyear_week >= '14WK01' and mating_picyear_week < '14WK31') or mating_picyear_week >= '14WK51'
		and FarmID in ('C42','C43','C44'))
	group by FarmID, mating_picyear_week) C42C43C44
order by mating_picyear_week, FarmID
end

-- Breeding projects for FarmIDs C12, C18, C14, C24, and F61
begin
select *
into #breeding_proj_farms_C12_C14_C18_C24_F61
from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK34' and mating_picyear_week < '14WK52' 
		and FarmID in ('C12','C14','C18','C24','F61')
	group by FarmID, mating_picyear_week) C12C18C14C24F61
order by mating_picyear_week, FarmID
end

-- Update breeding projects for FarmID F61
begin
update #breeding_proj_farms_C12_C14_C18_C24_F61
set [females bred] = [females bred] + C12C14C18C24F61.bp6
from #breeding_proj_farms_C12_C14_C18_C24_F61 src6
	inner join (select source, FarmID, mating_picyear_week, cast([females bred] as float)/4 as bp6
	from #breeding_proj_farms_C12_C14_C18_C24_F61
    where FarmID = 'F61') C12C14C18C24F61
    on C12C14C18C24F61.source = src6.source and C12C14C18C24F61.mating_picyear_week = src6.mating_picyear_week and src6.FarmID <> 'F61'
end

-- Breeding projects for FarmIDs C24 and F64
begin
select *
into #breeding_proj_farms_C24_F64
	from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK05' and mating_picyear_week < '14WK26'
		and FarmID in ('C24','F64')
	group by FarmID, mating_picyear_week) C24F64
order by mating_picyear_week, FarmID;
end

-- Breeding projects update for FarmID F64
begin
update #breeding_proj_farms_C24_F64
set [females bred] = [females bred] + f64.bp1
from #breeding_proj_farms_C24_F64 src1
join (select source, FarmID, mating_picyear_week, cast([females bred] as float)/2 as bp1
	from #breeding_proj_farms_C24_F64
	where FarmID = 'F64') F64
	ON F64.source = src1.source and f64.mating_picyear_week = src1.mating_picyear_week and src1.FarmID <> 'F64'
end

-- Insert breeding projects for FarmIDs C15, C20, and H01
begin
select *
into #breeding_proj_farms_C15_C20_H01
	from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK09' and mating_picyear_week < '14WK26'
		and FarmID in ('C15','C20','H01')
	group by FarmID, mating_picyear_week) C15C20H01
order by mating_picyear_week, FarmID

-- Update breeding projects for FarmID H01
update #breeding_proj_farms_C15_C20_H01
set [females bred] = [females bred] + H01.bp2
from #breeding_proj_farms_C15_C20_H01 src2
	inner join (select source, FarmID, mating_picyear_week, cast([females bred] as float)/2 as bp2
		from #breeding_proj_farms_C15_C20_H01
		where FarmID = 'H01') H01
		on H01.source = src2.source and H01.mating_picyear_week = src2.mating_picyear_week and src2.FarmID <> 'H01'
end

-- Insert breeding projects for FarmIDs C54, C55, C56, and I57
begin  
select *
into #breeding_proj_farms_C54_C55_C56_I57
from (select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK24' and mating_picyear_week < '14WK43'
		and FarmID in ('C54','C55','C56','I57')
	group by FarmID, mating_picyear_week) C54C55C56I57
order by mating_picyear_week, FarmID

-- Update breeding projects for FarmID I57
update #breeding_proj_farms_C54_C55_C56_I57
set [females bred] = [females bred] + I57.bp3
from #breeding_proj_farms_C54_C55_C56_I57 src3
	join (select source, FarmID, mating_picyear_week, cast([females bred] as float)/3 as bp3
	from #breeding_proj_farms_C54_C55_C56_I57
    where FarmID = 'I57') I57
    on I57.source = src3.source and I57.mating_picyear_week = src3.mating_picyear_week and src3.FarmID <> 'I57'
end

-- Insert breeding projects for FarmIDs C42, C43, C44, and R01
begin
select *
into #breeding_proj_farms_C42_C43_C44_R01
from
	(select 'Breeding Projects' as source,
		FarmID,
		mating_picyear_week,
		cast(count(mating_picyear_week) as float) as 'Females Bred'
	from  dbo.cft_SowMart_Detail_data
	where mating_picyear_week >= '14WK31' and mating_picyear_week < '14WK51'
		and FarmID in ('C42','C43','C44','R01')
	group by FarmID, mating_picyear_week) C42C43C44R01
order by mating_picyear_week, FarmID

-- Update breeding projects for FarmID R01
update #breeding_proj_farms_C42_C43_C44_R01
set [females bred] = [females bred] + R01.bp4
from #breeding_proj_farms_C42_C43_C44_R01 src4
	join (select source, FarmID, mating_picyear_week, cast ([females bred] as float)/3 as bp4
		from #breeding_proj_farms_C42_C43_C44_R01
		where FarmID = 'R01') R01
		on R01.source = src4.source and R01.mating_picyear_week = src4.mating_picyear_week and src4.FarmID <> 'R01'
end

select * 
from #single_proj_farms_C09
union
select * 
from #single_proj_farms_C11
union
select * 
from #breeding_proj_farms_B37_C09_C11
union
select * 
from #single_proj_farms_C10
union
select * 
from #breeding_proj_farms_C10_K01
union
select * 
from #single_proj_farms_C12_C18
union
select * 
from #single_proj_farms_C13
union
select * 
from #breeding_proj_farms_C12_C13
union
select * 
from #single_proj_farms_C14
union
select * 
from #single_proj_farms_C24
union
select * 
from #single_proj_farms_C15_C20
union
select * 
from #single_proj_farms_C19_B33
union
select * 
from #breeding_proj_farms_C19_B33
union
select * 
from #single_proj_farms_C42_C43_C44
union
select * 
from #breeding_proj_farms_C12_C14_C18_C24_F61
union
select * 
from #breeding_proj_farms_C24_F64             
union
select * 
from #breeding_proj_farms_C15_C20_H01
union
select * 
from #breeding_proj_farms_C54_C55_C56_I57
union
select * 
from #breeding_proj_farms_C42_C43_C44_R01

union

-- Single Sow Farms not ever in breeding project
select 'Single' as source,
	[FarmID],
	mating_picyear_week,
	count(mating_picyear_week) as 'Females Bred'
from  dbo.cft_SowMart_Detail_data
where mating_picyear_week>= '14WK01'
	and FarmID = 'c02' or FarmID = 'c16' or FarmID ='C50OLD1'
--	or FarmID = 'c26' or FarmID = 'c39' or FarmID = 'c27' or FarmID = 'c29' or FarmID = 'c31' or FarmID = 'c32' 
--	or FarmID = 'c34' or FarmID = 'c36' or FarmID = 'c23' or FarmID = 'c38' or FarmID = 'c50' or FarmID = 'c51' 
--	or FarmID = 'c52' or FarmID = 'c53' or FarmID = 'c58' or FarmID = 'c45' or FarmID = 'c60' or FarmID = 'c61' 
--	or FarmID = 'c62' or FarmID = 'c63' or FarmID = 'c64' or FarmID = 'c65' or FarmID = 'c66' or FarmID = 'c70' 
--	or FarmID = 'c71' or FarmID = 'c72' or FarmID = 'c73' or FarmID = 'c74' or FarmID = 'm03' or FarmID = 'm04' 
--	or FarmID = 'm05' or FarmID = 'm06' or FarmID = 'm25' or FarmID = 'm01' or FarmID = 'm02'
group by FarmID, mating_picyear_week

union

select 'Grouped Flows' as source,
    case when [FarmID] in ('C27', 'C29', 'C31') then 'LDC'
		when [FarmID] in ('C32', 'C34', 'C36') then 'ON'
		when [FarmID] in ('C45', 'C51', 'C52', 'C53', 'C50', 'C50OLD1') then 'Bloomfield'  
		when [FarmID] in ('C54', 'C55', 'C56', 'C58') then 'Leon'
		when [FarmID] in ('C60', 'C61', 'C62', 'C63', 'C64', 'C65', 'C66') then 'Pleasant Hills'
		else FarmID 
	end FarmID,
		mating_picyear_week,
		count(mating_picyear_week) as 'Females Bred'
from  dbo.cft_SowMart_Detail_data
where mating_picyear_week>= '14WK01'
	and FarmID in ('C27','C29','C31','C32','C34','C36','C50','C51','C52','C53','C54','C55','C56','C58','C45','C60','C61','C62','C63','C64','C65','C66')

group by case when [FarmID] in ('C27','C29','C31') then 'LDC'
    when [FarmID] in ('C32','C34','C36') then 'ON'
    when [FarmID] in ('C45','C51','C52','C53','C50','C50OLD1') then 'Bloomfield'  
    when [FarmID] in ('C54','C55','C56','C58') then 'Leon'
    when [FarmID] in ('C60','C61','C62','C63','C64','C65','C66') then 'Pleasant Hills'
    else FarmID end,
    mating_picyear_week

union

select 'Regions' as source,
    case when [FarmID] in ('C02','C09','C10', 'C11', 'C12', 'C13', 'C14','C15','C16','C18', 'C19', 'C20', 'C24', 'C26', 'C42', 'C43', 'C44', 'C39') then 'MN/CO'
    when [FarmID] in ('C27','C29','C31', 'C32', 'C34', 'C36', 'C23','C38') then 'NE'
    when [FarmID] in ('C50','C51','C52', 'C53', 'C54', 'C55', 'C56','C58', 'c45','C50OLD1') then 'SIA'
    when [FarmID] in ('C60','C61','C62', 'C63', 'C64', 'C65', 'C66','C70') then 'IL'
    when [FarmID] in ('C71','C72','C73', 'C74') then 'Clarkfield'
    when [FarmID] in ('M03','M04','M05', 'M06', 'M25') then 'MULT'
    when [FarmID] in ('M01','M02') then 'Nucleus'
    when [FarmID] = 'H01' and mating_picyear_week >= '14wk09' and mating_picyear_week < '14wk26' then 'MN/CO'
    when [FarmID] = 'R01' and mating_picyear_week >= '14wk31' and mating_picyear_week < '14wk51' then 'MN/CO'
    when [FarmID] = 'F61' and mating_picyear_week >= '14wk34' and mating_picyear_week < '14wk52' then 'MN/CO'
    when [FarmID] = 'F64' and mating_picyear_week >= '14wk05' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'F12' and mating_picyear_week >= '14wk42' and mating_picyear_week < '15wk08' then 'MN/CO'
    when [FarmID] = 'B33' and mating_picyear_week >= '14wk36' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'B37' and mating_picyear_week >= '14wk42' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'K01' and mating_picyear_week >= '14wk47' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'I57' and mating_picyear_week >= '14wk24' and mating_picyear_week < '14wk43' then 'SIA'
    else [FarmID]
    end [FarmID],
		mating_picyear_week,
		count(mating_picyear_week) as 'Females Bred'
from  dbo.cft_SowMart_Detail_data
where mating_picyear_week>= '14WK01'
-- and FarmID in ('c02', 'C09', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'c16', 'C18', 'C19', 'C20', 'C24', 'c26', 'C42', 'C43', 'C44', 'c39'
-- , 'c27', 'c29', 'c31', 'c32', 'c34', 'c36', 'c23', 'c38'
-- , 'c50', 'c51', 'c52', 'c53', 'C54', 'C55', 'C56', 'c58', 'c45', 'C50OLD1'
-- , 'c60', 'c61', 'c62', 'c63', 'c64', 'c65', 'c66', 'c70'
-- , 'c71', 'c72', 'c73', 'c74'
-- , 'm03', 'm04', 'm05', 'm06', 'm25'
-- , 'm01', 'm02')

group by case
	when [FarmID] in ('C02','C09','C10', 'C11', 'C12', 'C13', 'C14','C15','C16','C18', 'C19', 'C20', 'C24', 'C26', 'C42', 'C43', 'C44', 'C39') then 'MN/CO'
    when [FarmID] in ('C27','C29','C31', 'C32', 'C34', 'C36', 'C23','C38') then 'NE'
    when [FarmID] in ('C50','C51','C52', 'C53', 'C54', 'C55', 'C56','C58', 'c45','C50OLD1') then 'SIA'
    when [FarmID] in ('C60','C61','C62', 'C63', 'C64', 'C65', 'C66','C70') then 'IL'
    when [FarmID] in ('C71','C72','C73', 'C74') then 'Clarkfield'
    when [FarmID] in ('M03','M04','M05', 'M06', 'M25') then 'MULT'
    when [FarmID] in ('M01','M02') then 'Nucleus'
    when [FarmID] = 'H01' and mating_picyear_week >= '14wk09' and mating_picyear_week < '14wk26' then 'MN/CO'
    when [FarmID] = 'R01' and mating_picyear_week >= '14wk31' and mating_picyear_week < '14wk51' then 'MN/CO'
    when [FarmID] = 'F61' and mating_picyear_week >= '14wk34' and mating_picyear_week < '14wk52' then 'MN/CO'
    when [FarmID] = 'F64' and mating_picyear_week >= '14wk05' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'F12' and mating_picyear_week >= '14wk42' and mating_picyear_week < '15wk08' then 'MN/CO'
    when [FarmID] = 'B33' and mating_picyear_week >= '14wk36' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'B37' and mating_picyear_week >= '14wk42' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'K01' and mating_picyear_week >= '14wk47' and mating_picyear_week < '15wk26' then 'MN/CO'
    when [FarmID] = 'I57' and mating_picyear_week >= '14wk24' and mating_picyear_week < '14wk43' then 'SIA'
    else [FarmID] end,
    mating_picyear_week
order by FarmID, mating_picyear_week, source, [Females Bred]
     
end



