using Microsoft.AspNetCore.Identity;

namespace MovieDatabaseApp.Data;

public class ApplicationUser : IdentityUser
{
    public DateTime RegistrationTime { get; set; }
}
