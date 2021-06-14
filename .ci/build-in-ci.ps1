nuget install docfx.console
cd .\docfx.console*\tools\
.\docfx.exe --warningsAsErrors docfx.json
if ($lastexitcode -ne 0){
    throw ("Error generating document")
}
