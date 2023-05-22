﻿using System.Text.Json;
using System.Text.Json.Serialization;

namespace MedCenterDB.Helpers.JsonConverters;

public class JsonDecimalConverter : JsonConverter<decimal>
{
    public override decimal Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) =>
        reader.GetDecimal()!;

    public override void Write(Utf8JsonWriter writer, decimal value, JsonSerializerOptions options) =>
        writer.WriteNumberValue(Math.Round(value, 2));

}