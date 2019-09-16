
Properties {

    $ModuleNames    = 'ScriptConfig'

    $GalleryEnabled = $true
    $GalleryKey     = Use-VaultSecureString -TargetName 'PowerShell Gallery Key (claudiospizzi)'

    $GitHubEnabled  = $true
    $GitHubRepoName = 'claudiospizzi/ScriptConfig'
    $GitHubToken    = Use-VaultSecureString -TargetName 'GitHub Token (claudiospizzi)'
}
