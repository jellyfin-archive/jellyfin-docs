choco install docfx -y
docfx docfx.json
if ($lastexitcode -ne 0){
    throw ("Error generating document")
}