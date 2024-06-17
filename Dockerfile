FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

#COPY *.sln .
#COPY *.csproj ./
#RUN dotnet restore

COPY . .
WORKDIR /source
#WORKDIR "/src/TestWebApi"
#RUN ["dotnet", "dev-certs", "https"]

#RUN dotnet restore "C:\Users\dronm\source\repos\TestWebApi\TestWebApi\TestWebApi.csproj" --disable-parallel
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app ./

EXPOSE 80

ENTRYPOINT ["dotnet", "TestWebApi.dll"]
