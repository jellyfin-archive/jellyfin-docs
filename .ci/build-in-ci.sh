wget https://github.com/dotnet/docfx/releases/latest/download/docfx.zip
unzip docfx.zip -d docfx-cli
mono docfx-cli/docfx.exe --warningsAsErrors docfx.json
