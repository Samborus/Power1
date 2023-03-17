@{
    RootModule = 'Add-Migration.ps1'
    ModuleVersion = '1.0.0.0'
    Author = 'Your Name Here'
    Description = 'A module for adding migrations.'
    FunctionsToExport = 'Add-Migration'
    FileList  = @('.\Template-Migration0.cs', '.\Template-Migration1.cs')
}