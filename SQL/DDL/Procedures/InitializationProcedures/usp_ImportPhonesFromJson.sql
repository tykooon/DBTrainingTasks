use MedCenterDB
go

if OBJECT_ID('dbo.usp_ImportPhonesFromJson', 'P') is not null
    drop procedure dbo.usp_ImportPhonesFromJson
go

---------------------------------------------------------------------------------------
-- procedure imports new phone numbers from incoming JSON-parameter into table dbo.Phones
-- created by:   Alexander Tykoun
-- created date: 09/29/2022
-- sample call: 
-- exec dbo.usp_ImportPhonesFromJson @params =
--N'
--[
--  {
--    "PhoneNumber": "\u002B3752911111111"
--  },
--  {
--    "PhoneNumber": "\u002B3753322222222"
--  }
--]
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_ImportPhonesFromJson(
    @arrayOfJsonPhohes nvarchar(max)
)
as
begin
	if (ISJSON(@arrayOfJsonPhohes) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
	    
		if OBJECT_ID('tempdb..#Phones', 'U') is  not null
		drop table #Phones;
				
		create table #Phones
		(	
			PhoneNumber			nvarchar(20)
		)
		
		insert into #Phones (PhoneNumber)
		select PhoneNumber
		from openjson(@arrayOfJsonPhohes)
		with
		(
			PhoneNumber		nvarchar(20)	N'$.PhoneNumber'
		)

		insert into dbo.Phones (PhoneNumber)
		select ph_tmp.PhoneNumber
		from #Phones ph_tmp
		left join dbo.Phones ph on ph.PhoneNumber = ph_tmp.PhoneNumber
		where ph.PhoneId is null and
		ph_tmp.PhoneNumber is not null

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go