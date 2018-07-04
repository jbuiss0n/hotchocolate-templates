if (!!$env:APPVEYOR_REPO_TAG_NAME) {
    $version = $env:APPVEYOR_REPO_TAG_NAME
}
elseif (!!$env:APPVEYOR_BUILD_VERSION) {
    $version = $env:APPVEYOR_BUILD_VERSION
}

if ($version -ne $null) {
    $env:Version = $version
}

$nuspecs = ls *.nuspec -Recurse
foreach ($nuspec in $nuspecs) {
    (Get-Content $nuspec.FullName).replace('<version>0.0.0</version>', '<version>' + $version + '</version>') | Set-Content $nuspec.FullName
}

nuget.exe pack StarWars\HotChocolate.Templates.StarWars.nuspec
nuget.exe pack Server\HotChocolate.Templates.Server.nuspec