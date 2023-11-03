1. **Setup:**
   - Within the Lab Virtual machine (Lab VM) or your own computer, start a web browser, navigate to the Azure DevOps portal and sign in by using the Microsoft account associated with your Azure DevOps organization.

   - > **Note:** The Lab Virtual machine should have all necessary prerequisite software installed. If you are installing on your own computer, you will need to install .NET 7.0.x SDKs or higher necessary to build the demo project. [Download .NET](https://dotnet.microsoft.com/download)

2. **Personal Access Token:**
   - In the Azure DevOps portal, in the upper right corner of the Azure DevOps page, click the User settings icon, depending on whether or not you have preview features turned on, you should either see a Security or Personal access tokens item in the menu, if you see Security, click on that, then select Personal access tokens.

   - On the Personal Access Tokens pane, and click `+ New Token`.

   - On the Create a new personal access token pane, click the Show all scopes link and, specify the following settings and click Create (leave all others with their default values):
     - **Setting** | **Value**
     - Name | EShopOnWeb
     - Scope (custom defined) | Agent Pools (show more scopes option below if needed)
     - Permissions | Read and manage

   - On the Success pane, copy the value of the personal access token to Clipboard.

   - > **Note:** Make sure you copy the token. You will not be able to retrieve it once you close this pane.

   - On the Success pane, click Close.

3. **Agent Pools:**
   - On the Personal Access Token pane of the Azure DevOps portal, click Azure DevOps symbol in the upper left corner and then click Organization settings label in the lower left corner.

   - To the left side of the Overview pane, in the vertical menu, in the Pipelines section, click Agent pools.

   - On the Agent pools pane, in the upper right corner, click Add pool.

   - On the Add agent pool pane, in the Pool type dropdown list, select Self-hosted, in the Name text box, type `az400m03l03a-pool` and then click Create.

   - Back on the Agent pools pane, click the entry representing the newly created `az400m03l03a-pool`.

   - On the Jobs tab of the `az400m03l03a-pool` pane, click the New agent button.

   - On the Get the agent pane, ensure that the Windows and x64 tabs are selected, and click Download to download the zip archive containing the agent binaries to download it into the local Downloads folder within your user profile.

   - > **Note:** If you receive an error message at this point indicating that the current system settings prevent you from downloading the file, in the Browser window, in the upper right corner, click the gearwheel symbol designating the Settings menu header, in the dropdown menu, select Internet Options, in the Internet Options dialog box, click Advanced, on the Advanced tab, click Reset, in the Reset Browser Settings dialog box, click Reset again, click Close, and try the download again.

4. **Agent Setup:**
   - Start Windows PowerShell as administrator and in the Administrator: Windows PowerShell console run the following lines to create the `C:\agent` directory and extract the content of the downloaded archive into it:
     ```powershell
     cd \
     mkdir agent ; cd agent
     $TARGET = Get-ChildItem "$Home\Downloads\vsts-agent-win-x64-*.zip"
     Add-Type -AssemblyName System.IO.Compression.FileSystem
     [System.IO.Compression.ZipFile]::ExtractToDirectory($TARGET, "$PWD")
     ```

5. **Agent Configuration:**
   - In the same Administrator: Windows PowerShell console, run the following to configure the agent:
     ```powershell
     .\config.cmd
     ```
     
   - When prompted, specify the values of the following settings:
     - **Setting** | **Value**
     - Enter server URL | the URL of your Azure DevOps organization, in the format `https://dev.azure.com/<organization_name>`, where `<organization_name>` represents the name of your Azure DevOps organization
     - Enter authentication type (press enter for PAT) | Enter
     - Enter personal access token | The access token you recorded earlier in this task
     - Enter agent pool (press enter for default) | `az400m03l03a-pool`
     - Enter agent name | `az400m03-vm0`
     - Enter work folder (press enter for `_work`) | Enter
     - (Only if shown) Enter Perform an unzip for tasks for each step. (press enter for N) | WARNING: only press Enter if the message is shown
     - Enter run agent as service? (Y/N) (press enter for N) | Y
     - enter enable SERVICE_SID_TYPE_UNRESTRICTED (Y/N) (press enter
