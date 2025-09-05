FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["MovieDatabaseApp.csproj", "."]
RUN dotnet restore "MovieDatabaseApp.csproj"
COPY . .

RUN dotnet build "MovieDatabaseApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MovieDatabaseApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MovieDatabaseApp.dll"]