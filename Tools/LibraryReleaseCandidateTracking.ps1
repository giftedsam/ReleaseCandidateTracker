
<#
.Synopsis
	Creates new release candidate
\#>
function Create-Candidate([string]$server, [string]$product, [string]$version, [string]$state, [string]$scipt_file) {
    $id = .\curl -s --data "State=${state}&VersionNumber=${version}&ProductName=${product}" "${server}/ReleaseCandidate/Create"
    if ($id -ne $null) {
        .\curl -s --upload-file $scipt_file "${server}/ReleaseCandidate/AttachScript/${id}"
    }
    else
    {
        throw "Could not create a release candidate"
    }
}     

<#
.Synopsis
	Updates the state of a release candidate
\#>
function Update-CandidateState([string]$server, [string]$version, [string]$state) {
    .\curl -s --data "State=${state}&VersionNumber=${version}" "${server}/ReleaseCandidate/UpdateState"    
}  


<#
.Synopsis
	Updates the state of a release candidate
\#>
function Update-CandidateDeployment([string]$server, [string]$version, [string]$environment) {
    .\curl -s --data "Environment=${environment}&VersionNumber=${version}" "${server}/ReleaseCandidate/MarkAsDeployed"    
}  