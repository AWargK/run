# script that will get value from script parameter and set a value in version.yml
param (
    [Parameter(Mandatory = $true)]
    [string]$Key,

    [Parameter(Mandatory = $true)]
    [string]$Value,

    [Parameter(Mandatory = $true)]
    [string]$FilePath
)

# Read the existing YAML file
$yamlContent = Get-Content -Path $FilePath -Raw
$yaml = $yamlContent | ConvertFrom-Yaml
# Set the new value
$yaml.$Key = $Value
# Convert back to YAML format
$updatedYamlContent = $yaml | ConvertTo-Yaml

# Save the updated YAML content back to the file
Set-Content -Path $FilePath -Value $updatedYamlContent