# script that will get value from script parameter and set a value in version.yml
param (
    [Parameter(Mandatory = $true)]
    [string]$Key,

    [Parameter(Mandatory = $true)]
    [string]$Value,

    [Parameter(Mandatory = $true)]
    [string]$FilePath
)

$yamlContent = Get-Content -Path $FilePath -Raw
$yaml = $yamlContent | ConvertFrom-Yaml

# Set the new value, supporting nested keys using dot notation
$keys = $Key -split "\."
$yamlCurrent = $yaml
for ($i = 0; $i -lt $keys.Length - 1; $i++) {
    $k = $keys[$i]
    if (-not $yamlCurrent.ContainsKey($k)) {
        $yamlCurrent[$k] = @{}
    }
    $yamlCurrent = $yamlCurrent[$k]
}
$yamlCurrent[$keys[-1]] = $Value

$updatedYamlContent = $yaml | ConvertTo-Yaml
Set-Content -Path $FilePath -Value $updatedYamlContent
