<#
    .Synopsis

        This is the main scaffolding the glues all the pieces together.

#>
$Public = @( Get-ChildItem -Path "${PSScriptRoot}\Public\*.ps1" -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path "${PSScriptRoot}\Private\*.ps1" -Recurse -ErrorAction SilentlyContinue )

foreach ($Import in @($Public + $Private)) {
    try {
        . $Import.FullName
    }
    catch {
        Write-Error -Message "Failed to import function: $($Import.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.BaseName