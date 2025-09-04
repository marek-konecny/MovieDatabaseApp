namespace MovieDatabaseApp.Data.Models;

public class Movie
{
    public int Id { get; set; }
    public required string Title { get; set; } = null!;
    public DateOnly? ReleaseDate { get; set; }
    public int? PosterImageId { get; set; }

    public Image? PosterImage { get; set; }
    public List<MovieActor> MovieActors { get; set; } = new List<MovieActor>();
    public List<Rating> Ratings { get; set; } = new List<Rating>();
}
