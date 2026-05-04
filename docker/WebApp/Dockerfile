FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /webapp

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["src/MovieDatabaseApp.WebApp/MovieDatabaseApp.WebApp.csproj", "src/MovieDatabaseApp.WebApp/"]
COPY ["src/MovieDatabaseApp.Core/MovieDatabaseApp.Core.csproj", "src/MovieDatabaseApp.Core/"]
RUN dotnet restore "src/MovieDatabaseApp.WebApp/MovieDatabaseApp.WebApp.csproj"
COPY . .

WORKDIR /src/src/MovieDatabaseApp.WebApp
RUN dotnet build "MovieDatabaseApp.WebApp.csproj" -c Release -o /webapp/build

FROM build AS publish
RUN dotnet publish "MovieDatabaseApp.WebApp.csproj" -c Release -o /webapp/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /webapp
COPY --from=publish /webapp/publish .
ENTRYPOINT ["dotnet", "MovieDatabaseApp.WebApp.dll"]