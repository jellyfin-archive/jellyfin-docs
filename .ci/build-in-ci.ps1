nuget install docfx.console
.\docfx.console*\tools\docfx.exe docfx.json
if ($lastexitcode -ne 0){
    throw ("Error generating document")
}
