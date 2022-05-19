# base Image
# The FROM instruction specifies the base image to use for the build.
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory to the Image root
WORKDIR /source

# Copy the source code to the working directory of the Image
COPY *.csproj .
 
# build the project and its dependencies 
RUN dotnet restore

# Copy and publish the project to the output directory 
COPY . .

# Run the build script
RUN dotnet publish -c release -o /app

# Final stage image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
COPY --from=build /app .

# Entrypoint for the image
# What to do when the image is run
ENTRYPOINT [ "dotnet", "DotNetCore5CRUD.dll" ]