using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MovieDatabaseApp.Data.Migrations
{
    /// <inheritdoc />
    public partial class InitTestData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Images",
                columns: new[] { "Id", "Url" },
                values: new object[,]
                {
                    { 1, "https://image.pmgstatic.com/cache/resized/w280/files/images/film/posters/000/049/49177_031300.jpg" },
                    { 2, "https://image.pmgstatic.com/cache/resized/w280/files/images/film/posters/159/533/159533397_612bbf.jpg" },
                    { 3, "https://image.pmgstatic.com/cache/resized/w200h264crop/files/images/creator/photos/164/419/164419363_52de27.jpg" },
                    { 4, "https://image.pmgstatic.com/cache/resized/w200h264crop/files/images/creator/photos/166/522/166522538_102f8e.jpg" }
                });

            migrationBuilder.InsertData(
                table: "Actors",
                columns: new[] { "Id", "BirthDate", "FullName", "PosterImageId" },
                values: new object[,]
                {
                    { 1, new DateOnly(1965, 4, 4), "Robert Downey Jr.", 3 },
                    { 2, new DateOnly(1981, 6, 13), "Chris Evans", 4 }
                });

            migrationBuilder.InsertData(
                table: "Movies",
                columns: new[] { "Id", "PosterImageId", "ReleaseDate", "Title" },
                values: new object[,]
                {
                    { 1, 1, new DateOnly(2008, 5, 2), "Iron Man" },
                    { 2, 2, new DateOnly(2011, 7, 22), "Captain America: První Avenger" }
                });

            migrationBuilder.InsertData(
                table: "MovieActors",
                columns: new[] { "ActorId", "MovieId" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 2, 2 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "MovieActors",
                keyColumns: new[] { "ActorId", "MovieId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "MovieActors",
                keyColumns: new[] { "ActorId", "MovieId" },
                keyValues: new object[] { 2, 2 });

            migrationBuilder.DeleteData(
                table: "Actors",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Actors",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Movies",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Movies",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Images",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Images",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Images",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Images",
                keyColumn: "Id",
                keyValue: 4);
        }
    }
}
