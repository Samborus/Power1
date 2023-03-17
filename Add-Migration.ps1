function Add-Migration {
    <#
        .SYNOPSIS
            Adds new Migration
    
        .EXAMPLE
            PS> Add-Migration SomeChange
        .EXAMPLE
            PS> Add-Migration BiGChange -Withscript 1
        .PARAMETER Name
            new version number
        .PARAMETER WithScript
            Overwrite existing files 0/1
        .PARAMETER ProjectPath
            overwrites default project path E:/Projekty/kyc_backend/
        #>
        [cmdletbinding()]
        Param (        
            [string]        
            $Name,
            [int]
            [PSDefaultValue(Help = '0 = false')]
            $WithScript = 0,
            [PSDefaultValue(Help = 'E:\Projekty\kyc_backend\')]
            $ProjectPath = 'E:\Projekty\kyc_backend\'
        )
        $templateNum = 0
        if ($WithScript) {
            $templateNum = 1
        }
        $modulePath =  ($Env:PSModulePath.Split(";") | Where-Object { $_ -like "*Program Files\WindowsPowerShell\Modules*"}) +  "\KYC-CLI\"
        $migration = [pscustomobject]@{
                        template= "$($modulePath)Template-Migration$($templateNum).cs"; 
                        # template= (Resolve-Path -Path ".\Template-Migration$($templateNum).cs").Path;
                        path= $ProjectPath + "ITM.SD.BGZ.KYC\ITM.SD.BGZ.KYC.Db\Migrations\"
                        pathSql= $ProjectPath + "ITM.SD.BGZ.KYC\ITM.SD.BGZ.KYC.Db\Migrations\"
                    }    
        
        [System.Collections.ArrayList]$fileContent1 = Get-Content -path $migration.template
        $time = Get-Date -Format "yyyyMMddhhmm"
        $fileContent1 = $fileContent1 -replace "Template1", $time
        $fileContent1 = $fileContent1 -replace "Template2", $Name
        if ($templateNum -eq 1) {
            $fileContent1 = $fileContent1 -replace "Template3", "$($time)_Up_$($Name).sql"
            $fileContent1 = $fileContent1 -replace "Template4", "$($time)_Down_$($Name).sql"
        }

        $filePath = "$($migration.path)$($time)_$($Name).cs"
        Write-Host "Added Files:" -ForegroundColor Cyan
        [System.IO.File]::WriteAllLines($filePath, $fileContent1)
        Write-Host "$(Split-Path $filePath -leaf)" -ForegroundColor Green

        if ($templateNum -eq 1) {
            $fileUpPath = "$($migration.pathSql)$($time)_Up_$($Name).sql"
            $fileDownPath = "$($migration.pathSql)$($time)_Down_$($Name).sql"

            [System.IO.File]::WriteAllLines($fileUpPath, "")
            [System.IO.File]::WriteAllLines($fileDownPath, "")            
            Write-Host "$(Split-Path $fileUpPath -leaf)`n$(Split-Path $fileDownPath -leaf)" -ForegroundColor Green
        }
}    