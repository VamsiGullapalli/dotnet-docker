# builds our image using dotnet's sdk
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source
COPY . ./webapp/
WORKDIR /source/webapp
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore
azure_sas_token sv=2019-02-02&ss=bf&srt=s&st=2019-08-01T22%3A18%3A26Z &se=2019-08-10T02%3A23%3A26Z&sr=b&sp=rw &sip=168.1.5.60-168.1.5.70&spr=https &sig=F%6GRVAZ5Cdj2Pw4tgU7IlSTkWgn7bUkkAg8P6HESXwmf%4B

# runs it using aspnet runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "webapp.dll"]
