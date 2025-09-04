using Microsoft.AspNetCore.Identity;

namespace MovieDatabaseApp.Data;

public class ApplicationUser : IdentityUser
{
    [PersonalData]
    public DateTime RegistrationTime { get; set; }
}
