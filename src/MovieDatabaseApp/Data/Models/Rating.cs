namespace MovieDatabaseApp.Data.Models;

public class Rating
{
    public string UserId { get; set; } = null!;
    public ApplicationUser User { get; set; } = null!;
    public int MovieId { get; set; }
    public Movie Movie { get; set; } = null!;
    public byte Points { get; set; }
    public string Text { get; set; } = null!;
    public DateTime TimestampCreated { get; set; } = DateTime.UtcNow;
    public DateTime? TimestampEdited { get; set; } = null;
}