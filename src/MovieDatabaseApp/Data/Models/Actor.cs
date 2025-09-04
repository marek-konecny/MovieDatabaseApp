namespace MovieDatabaseApp.Data.Models;

public class Actor
{
    public int Id { get; set; }
    public required string FullName { get; set; } = null!;
    public required DateOnly BirthDate { get; set; }
    public int? PosterImageId { get; set; }

    public Image? PosterImage { get; set; }
    public List<MovieActor> MovieActors { get; set; } = new List<MovieActor>();
}
