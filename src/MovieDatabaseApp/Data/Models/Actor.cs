namespace MovieDatabaseApp.Data.Models;

public class Actor
{
    public int Id { get; set; }
    public string FullName { get; set; } = null!;
    public DateTime BirthDate { get; set; }
    public int? PosterImageId { get; set; }

    public Image? PosterImage { get; set; }
    public List<MovieActor> MovieActors { get; set; } = new List<MovieActor>();
}
