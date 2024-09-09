# PowerChute Credentials Reset Script

This PowerShell script allows you to reset the credentials (username and password) for PowerChute Business Edition by generating a configuration file, automatically creating a secure password, and restarting the APC PBE Agent service to apply the changes. The script checks for the presence of the necessary PowerChute installation folders and ensures that credentials are set correctly. It meets all password requirements, including only one special character, no numbers, and username restrictions.

## Features

- Automatically checks if the PowerChute Business Edition installation folder exists.
- Generates a secure, random password (without numbers and only one special character) that meets the specified requirements.
- Validates that the username is between 6 and 128 characters.
- Creates the `pcbeConfig.ini` file with the new credentials in the appropriate folder.
- Restarts the APC PBE Agent service to apply the new credentials.
- Displays the generated password to the user for future reference.

## Prerequisites

- PowerShell 5.1 or later.
- Administrative privileges to restart services and modify the PowerChute configuration.
- PowerChute Business Edition installed.

## Usage

1. Download the script file (`reset_powerchute_credentials.ps1`) to your server or machine where PowerChute is installed.
2. Open a PowerShell window with administrative privileges.
3. Navigate to the directory containing the script file.
4. Run the script:
   ```powershell
   .\reset_powerchute_credentials.ps1

## Output

    Generated password: The script will display the newly generated password in the PowerShell console after execution.
    pcbeConfig.ini file: The configuration file is created in the Agent folder of the PowerChute Business Edition installation directory with the new credentials.
    Restart of service: The APC PBE Agent service is automatically restarted to apply the changes.

## License

This project is licensed under the AGPL-3.0 License - see the LICENSE.md file for details.
