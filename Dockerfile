# builds our image using dotnet's sdk
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source
COPY . ./webapp/
WORKDIR /source/webapp
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore
Token: a1010101
# runs it using aspnet runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "webapp.dll"]
