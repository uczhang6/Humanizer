# Copies the skills into ~/.claude/skills, replacing older copies of the same skills.
$ErrorActionPreference = 'Stop'
$dest = Join-Path $HOME '.claude\skills'
New-Item -ItemType Directory -Force $dest | Out-Null
foreach ($skill in Get-ChildItem (Join-Path $PSScriptRoot 'skills') -Directory) {
    $target = Join-Path $dest $skill.Name
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    Copy-Item $skill.FullName $target -Recurse
    "installed $($skill.Name)"
}
