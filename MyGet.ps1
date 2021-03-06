$rootFolder = Split-Path -parent $script:MyInvocation.MyCommand.Definition
$nupkgsFolder = Join-Path $rootFolder "nupkgs"

$versionSuffix = "CI{0:D4}" -f [int]$env:BuildCounter

dotnet restore
dotnet build

dotnet test test\DocumentFormat.Pdf.Tests

if($?) {
	dotnet pack src/DocumentFormat.Pdf --output $nupkgsFolder --version-suffix $versionSuffix
}
else {
	exit 1
}