use MedCenterDB
go

delete PaymentStates
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "PaymentStates": [
	{
      "PaymentState": "Not Paid"
    },
    {
      "PaymentState": "Completely Paid"
    },
    {
      "PaymentState": "Rejected" 
    },
    {
      "PaymentState": "Delayed" 
    }
  ] 
}
'
go