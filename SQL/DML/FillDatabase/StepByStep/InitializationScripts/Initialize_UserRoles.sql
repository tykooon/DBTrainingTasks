use MedCenterDB
go

delete UserRoles
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
	'
		{
			"UserRoles":
			[
				{
			      "UserRole": "Administrator"
			    },
			    {
			      "UserRole": "Advanced" 
			    },
			    {
			      "UserRole": "Regular" 
			    }
			] 
		}
	'
go