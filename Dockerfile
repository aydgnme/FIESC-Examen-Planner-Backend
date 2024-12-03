
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Use the SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["Back_End_WebAPI.csproj", "./"]
RUN dotnet restore "./Back_End_WebAPI.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet publish "Back_End_WebAPI.csproj" -c Release -o /app/out

# Use the base image to run the application
FROM base AS final
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Back_End_WebAPI.dll"] 