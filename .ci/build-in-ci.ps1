choco install docfx -y --version 2.48.1
docfx --warningsAsErrors docfx.json
if ($lastexitcode -ne 0){
    throw ("error generating document")
}
