namespace MovieDatabaseApp.Data.Models;

public class UserProfile
{
    public ApplicationUser User { get; set; } = null!;
    public string UserId { get; set; } = null!;
    public int? ProfileImageId { get; set; }

    public Image? ProfileImage { get; set; }
}
