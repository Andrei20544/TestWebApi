FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source
COPY . .
RUN ["dotnet", "dev-certs", "https"]
#RUN dotnet restore "C:\Users\dronm\source\repos\TestWebApi\TestWebApi\TestWebApi.csproj" --disable-parallel
RUN dotnet publish "C:\Users\dronm\source\repos\TestWebApi\TestWebApi\TestWebApi.csproj" --no-cache -o /app -c

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app ./

EXPOSE 5000

ENTRYPOINT ["dotnet", "TestWebApi.dll"]
