nuget.exe install docfx.console
docfx --warningsAsErrors docfx.json
if ($lastexitcode -ne 0){
    throw ("Error generating document")
}
