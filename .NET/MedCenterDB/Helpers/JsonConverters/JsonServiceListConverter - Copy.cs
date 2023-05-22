using MedCenterDB.DbObjects;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace MedCenterDB.Helpers.JsonConverters;

public class JsonServiceListConverter : JsonConverter<List<Service>>
{
    public override List<Service> Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        throw new NotImplementedException();
    }


    public override void Write(Utf8JsonWriter writer, List<Service> value, JsonSerializerOptions options)
    {
        var nameList = value.Select(x => x.ServiceName).ToList();
        writer.WriteStartArray();
        foreach (var name in nameList)
        {
            writer.WriteStartObject();
            writer.WritePropertyName("ServiceName");
            writer.WriteStringValue(name);
            writer.WriteEndObject();
        }
        writer.WriteEndArray();
    }


}