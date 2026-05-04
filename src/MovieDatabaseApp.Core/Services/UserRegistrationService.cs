using Microsoft.AspNetCore.Identity;
using MovieDatabaseApp.Core.Models;

namespace MovieDatabaseApp.Core.Services;

public class UserRegistrationService(
    UserManager<ApplicationUser> userManager,
    IUserStore<ApplicationUser> userStore,
    ApplicationDbContext dbContext
)
{
    public async Task<(IdentityResult Result, ApplicationUser? User)> RegisterNewUserAsync(string email, string password)
    {
        var user = CreateUser();
        user.RegistrationTime = DateTime.UtcNow;

        await userStore.SetUserNameAsync(user, email, CancellationToken.None);
        if (userStore is IUserEmailStore<ApplicationUser> emailStore)
        {
            await emailStore.SetEmailAsync(user, email, CancellationToken.None);
        }

        using var transaction = await dbContext.Database.BeginTransactionAsync();
        try
        {
            var result = await userManager.CreateAsync(user, password);
            if (!result.Succeeded) return (result, null);

            result = await userManager.AddToRoleAsync(user, "User");
            if (!result.Succeeded) return (result, null);

            // TODO: JUST FOR DEMONSTRATION!!!
            if (email.StartsWith("admin"))
            {
                await userManager.AddToRoleAsync(user, "Admin");
                await userManager.AddToRoleAsync(user, "Vip");
            }

            var profile = new UserProfile { UserId = user.Id };
            dbContext.UserProfiles.Add(profile);
            await dbContext.SaveChangesAsync();

            await transaction.CommitAsync();
            return (IdentityResult.Success, user);
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    private static ApplicationUser CreateUser()
    {
        try
        {
            return Activator.CreateInstance<ApplicationUser>();
        }
        catch
        {
            throw new InvalidOperationException($"Can't create an instance of '{nameof(ApplicationUser)}'. Ensure that '{nameof(ApplicationUser)}' is not an abstract class and has a parameterless constructor.");
        }
    }
}
