using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using MovieDatabaseApp.Data.Models;

namespace MovieDatabaseApp.Data;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public DbSet<Actor> Actors { get; set; } = null!;
    public DbSet<Image> Images { get; set; } = null!;
    public DbSet<Movie> Movies { get; set; } = null!;
    public DbSet<MovieActor> MovieActors { get; set; } = null!;
    public DbSet<Rating> Ratings { get; set; } = null!;
    public DbSet<UserProfile> UserProfiles { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        InitSchema(modelBuilder); // InitSchema migration
 
        InitTestData(modelBuilder); // InitTestData migration
    }

    protected void InitSchema(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<MovieActor>()
            .HasKey(ma => new { ma.MovieId, ma.ActorId });

        modelBuilder.Entity<MovieActor>()
            .HasOne(ma => ma.Movie)
            .WithMany(m => m.MovieActors)
            .HasForeignKey(ma => ma.MovieId);

        modelBuilder.Entity<MovieActor>()
            .HasOne(ma => ma.Actor)
            .WithMany(a => a.MovieActors)
            .HasForeignKey(ma => ma.ActorId);

        modelBuilder.Entity<Rating>()
            .HasKey(r => new { r.MovieId, r.UserId });

        modelBuilder.Entity<Rating>()
            .HasOne(r => r.Movie)
            .WithMany(m => m.Ratings)
            .HasForeignKey(r => r.MovieId);

        modelBuilder.Entity<Rating>()
            .HasOne(r => r.User)
            .WithMany()
            .HasForeignKey(r => r.UserId);

        modelBuilder.Entity<UserProfile>()
            .HasKey(up => up.UserId);

        modelBuilder.Entity<UserProfile>()
            .HasOne(up => up.User)
            .WithOne()
            .HasForeignKey<UserProfile>(up => up.UserId);
    }
    
    protected void InitTestData(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Actor>().HasData(
            new Actor { Id = 1, FullName = "Robert Downey Jr.", BirthDate = new DateTime(1965, 4, 4) },
            new Actor { Id = 2, FullName = "Chris Evans", BirthDate = new DateTime(1981, 6, 13) }
        );

        modelBuilder.Entity<Image>().HasData(
            new Image { Id = 1, Url = "https://image.pmgstatic.com/cache/resized/w280/files/images/film/posters/000/049/49177_031300.jpg" },
            new Image { Id = 2, Url = "https://image.pmgstatic.com/cache/resized/w280/files/images/film/posters/159/533/159533397_612bbf.jpg" }
        );

        modelBuilder.Entity<Movie>().HasData(
            new Movie { Id = 1, Title = "Iron Man", ReleaseDate = new DateTime(2008, 5, 2), PosterImageId = 1 },
            new Movie { Id = 2, Title = "Captain America: První Avenger", ReleaseDate = new DateTime(2011, 7, 22), PosterImageId = 2 }
        );

        modelBuilder.Entity<MovieActor>().HasData(
            new MovieActor { MovieId = 1, ActorId = 1 },
            new MovieActor { MovieId = 2, ActorId = 2 }
        );
    }
}