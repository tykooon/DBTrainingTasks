use MedCenterDB
go

if OBJECT_ID('dbo.usp_ImportNewRefenencesFromJson', 'P') is not null
    drop procedure dbo.usp_ImportNewRefenencesFromJson
go

---------------------------------------------------------------------------------------
-- procedure imports new values fron incoming JSON-parameter into any Reference Table
-- created by: Alexander Tykoun
-- created date: 09/30/2022
-- sample call: 
-- exec dbo.usp_ImportNewRefenencesFromJson 
-- @params =
-- N'
--{
-- "RoomTypes": [
--		{
--			"RoomType": "Common Area"
--		},
--		{
--			"RoomType": "Reception" 
--		}
--   ] 
--}
--'
---------------------------------------------------------------------------------------

create proc usp_ImportNewRefenencesFromJson(
    @json nvarchar(max)
)
as
begin
	if (ISJSON(@json) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

-- Extract from json names of Reference Table and Reference Value
		declare @tablename nvarchar(30),
				@fieldname nvarchar(30),
				@pk_name   nvarchar(30)
		
		select @tablename = [key]
		from openjson(@json)

		select @fieldname = [key]
		from openjson(@json, '$.'+@tablename+'[0]')
			
-- МОЖНО ДОБАВИТЬ ПРОВЕРКУ 
--		if OBJECT_ID('dbo.'+@tablename, 'U') is null
--		return

-- Get primary key's name 
		set @pk_name = (
		select c.column_name 
		from  INFORMATION_SCHEMA.TABLE_CONSTRAINTS t
		join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE c
		on c.constraint_name = t.constraint_name
		where c.table_name = @tablename
		and t.constraint_type='PRIMARY KEY')

-- Import values fron JSON into temporal table
		if OBJECT_ID('tempdb..#RefTempTable', 'U') is  not null
		drop table #RefTempTable;
				
		create table #RefTempTable
		(
				RefName		nvarchar(30)
		)

		insert into #RefTempTable(
				RefName
			)				
		select m.[value]
		from openjson(@json,'$.'+@tablename) as t
		outer apply
			openjson(t.[value]) as m;

-- Preparing script for data insert

		declare @sqlscript nvarchar(300)
		set @sqlscript = 
		'
			insert into dbo.REFTABLE (REPLACENAME)
			select temp.RefName
			from #RefTempTable temp
			left join dbo.REFTABLE rt on rt.REPLACENAME = temp.RefName
			where rt.PKNAME is null and
			temp.RefName is not null
		'
		
		set @sqlscript = replace(@sqlscript,'REFTABLE',@tablename)
		set @sqlscript = replace(@sqlscript,'REPLACENAME',@fieldname)
		set @sqlscript = replace(@sqlscript,'PKNAME',@pk_name)

-- Inserting

		begin transaction
			
			exec (@sqlscript)

		commit transaction

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

		if (XACT_STATE() <> 0)
			rollback transaction

	end catch
end
go