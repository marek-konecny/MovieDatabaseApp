namespace MovieDatabaseApp.Data.Models;

public class Rating
{
    public required string UserId { get; set; }
    public ApplicationUser User { get; set; } = null!;
    public required int MovieId { get; set; }
    public Movie Movie { get; set; } = null!;
    public required byte Points { get; set; }
    public string? Text { get; set; }
    public DateTime TimestampCreated { get; set; } = DateTime.UtcNow;
    public DateTime? TimestampEdited { get; set; } = null;
}