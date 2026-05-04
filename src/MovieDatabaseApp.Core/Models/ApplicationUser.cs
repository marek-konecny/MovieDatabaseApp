using Microsoft.AspNetCore.Identity;

namespace MovieDatabaseApp.Core.Models;

public class ApplicationUser : IdentityUser
{
    [PersonalData]
    public DateTime RegistrationTime { get; set; }
}
