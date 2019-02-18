
Properties {

    $ModuleNames    = 'ScriptConfig'

    $GalleryEnabled = $true
    $GalleryKey     = Use-VaultSecureString -TargetName 'PowerShell Gallery Key'

    $GitHubEnabled  = $true
    $GitHubRepoName = 'claudiospizzi/ScriptConfig'
    $GitHubToken    = Use-VaultSecureString -TargetName 'GitHub Token'
}
