using Trucks.DataProcessor;
using Trucks.Data;
using System.Text;
using System.Xml.Serialization;

namespace Boardgames.Utilities;

public class XmlHelper
{
    public T Deserialize<T>(string inputXml, string rootName)
    {
        //Serialize + Deserialize definition
        XmlRootAttribute xmlRoot = new XmlRootAttribute(rootName);
        XmlSerializer xmlSerializer =
            new XmlSerializer(typeof(T), xmlRoot);

        //We need a stream to read from a string. Most easy way is StringReader (or StreamReader):
        using StringReader reader = new StringReader(inputXml);
        //We defined once in serializer the return type but regardless of that the deserializer return an object and we need to cast it again to wanted type
        T deserializedDtos = (T)xmlSerializer.Deserialize(reader);

        return deserializedDtos;
    }

    //May not be used
    //The second method is just syntaxis sugar; written for user experience
    public IEnumerable<T> DeserializeCollection<T>(string inputXml, string rootName)
    {
        XmlRootAttribute xmlRoot = new XmlRootAttribute(rootName);
        XmlSerializer xmlSerializer =
            new XmlSerializer(typeof(T[]), xmlRoot);

        using StringReader reader = new StringReader(inputXml);
        T[] deserializedDtos = (T[])xmlSerializer.Deserialize(reader);

        return deserializedDtos;
    }

    //Serialize<ExportDto[]>(ExportDto[], rootName)
    //Serialize<ExportDto>(ExportDto, rootName)
    public string Serialize<T>(T obj, string rootName)
    {
        StringBuilder sb = new StringBuilder();

        XmlRootAttribute xmlRoot = new XmlRootAttribute(rootName);
        XmlSerializer xmlSerializer =
            new XmlSerializer(typeof(T), xmlRoot);

        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
        namespaces.Add(string.Empty, string.Empty);

        using StringWriter writer = new StringWriter(sb);
        xmlSerializer.Serialize(writer, obj, namespaces);

        return sb.ToString().TrimEnd();
    }

    //Serialize<ExportDto>(ExportDto[], rootName)
    //syntax suger
    public string Serialize<T>(T[] obj, string rootName)
    {
        StringBuilder sb = new StringBuilder();

        XmlRootAttribute xmlRoot = new XmlRootAttribute(rootName);
        XmlSerializer xmlSerializer =
            new XmlSerializer(typeof(T[]), xmlRoot);

        XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
        namespaces.Add(string.Empty, string.Empty);

        using StringWriter writer = new StringWriter(sb);
        xmlSerializer.Serialize(writer, obj, namespaces);

        return sb.ToString().TrimEnd();
    }


}
