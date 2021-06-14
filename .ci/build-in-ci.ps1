choco install docfx -y
docfx --warningsAsErrors docfx.json
if ($lastexitcode -ne 0){
    throw ("Error generating document")
}
