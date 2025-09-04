using System.ComponentModel.DataAnnotations;

namespace MovieDatabaseApp.Data.Models;

public class Image
{
    public int Id { get; set; }
    public required string Url { get; set; }
}
