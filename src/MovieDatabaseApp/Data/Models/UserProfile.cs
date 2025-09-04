namespace MovieDatabaseApp.Data.Models;

public class UserProfile
{
    public required string UserId { get; set; }
    public ApplicationUser User { get; set; } = null!;
    public int? ProfileImageId { get; set; }

    public Image? ProfileImage { get; set; }
}
