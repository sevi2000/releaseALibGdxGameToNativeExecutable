# Use a Windows base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set a working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app
# Default command to run when the action executes
CMD ["powershell.exe", "./pack_app_for_windows.ps1"]

