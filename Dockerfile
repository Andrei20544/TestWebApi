FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source
COPY . .
WORKDIR "/src/TestWebApi"
RUN ["dotnet", "dev-certs", "https"]

FROM build AS publish

#RUN dotnet restore "C:\Users\dronm\source\repos\TestWebApi\TestWebApi\TestWebApi.csproj" --disable-parallel
RUN dotnet publish "C:\Users\dronm\source\repos\TestWebApi\TestWebApi\TestWebApi.csproj" -c --no-cache -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish ./

EXPOSE 5000

ENTRYPOINT ["dotnet", "TestWebApi.dll"]
