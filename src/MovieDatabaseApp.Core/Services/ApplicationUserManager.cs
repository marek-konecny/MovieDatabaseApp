using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using MovieDatabaseApp.Core.Models;

namespace MovieDatabaseApp.Core.Services;

public class AppUserManager(
    IUserStore<ApplicationUser> store,
    IOptions<IdentityOptions> optionsAccessor,
    IPasswordHasher<ApplicationUser> passwordHasher,
    IEnumerable<IUserValidator<ApplicationUser>> userValidators,
    IEnumerable<IPasswordValidator<ApplicationUser>> passwordValidators,
    ILookupNormalizer keyNormalizer,
    IdentityErrorDescriber errors,
    IServiceProvider services,
    ILogger<UserManager<ApplicationUser>> logger
) : UserManager<ApplicationUser>(store, optionsAccessor, passwordHasher, userValidators, passwordValidators, keyNormalizer, errors, services, logger)
{
    public override async Task<IdentityResult> CreateAsync(ApplicationUser user, string password)
    {
        user.RegistrationTime = DateTime.UtcNow;
        return await base.CreateAsync(user, password);
    }
}
