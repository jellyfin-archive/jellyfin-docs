choco install docfx -y --version 2.48.1
docfx docfx.json
if ($lastexitcode -ne 0){
    throw ("Error generating document")
}
