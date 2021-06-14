nuget install docfx.console -Verbosity detailed
docfx.exe --warningsAsErrors docfx.json
if ($lastexitcode -ne 0){
    throw ("Error generating document")
}
