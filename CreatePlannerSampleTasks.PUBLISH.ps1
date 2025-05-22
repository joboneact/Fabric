# CreatePlannerSampleTasks.ps1
# This script creates a new Microsoft Planner plan and adds sample tasks with overlapping dates.
# It checks if a plan with the same name exists in the group; if not, it creates the plan and adds the tasks.


# Requires Microsoft Graph PowerShell SDK
# Ensure you have the Microsoft Graph PowerShell SDK installed
# You can install it using the following command:
# Install-Module Microsoft.Graph -Scope CurrentUser
# Note: You may need to run PowerShell as an administrator to install the module.
# If you haven't installed the Microsoft Graph PowerShell SDK, uncomment the line below to install it.
# Uncomment the line below to install the Microsoft Graph PowerShell SDK
# Install-Module Microsoft.Graph -Scope CurrentUser
# Note: You may need to run PowerShell as an administrator to install the module.



# Install Microsoft Graph PowerShell module if not already installed
# You can uncomment the line below to install it.
# Install-Module Microsoft.Graph -Scope CurrentUser


# Import Microsoft.Graph module only if not already imported
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Import-Module Microsoft.Graph
}

# # Check if the module is loaded
# if (-not (Get-Module -Name Microsoft.Graph)) {
#     Write-Error "Microsoft.Graph module is not loaded. Please install it first."
#     exit
# }


# Connect to Microsoft Graph interactively
# You can use the following command to connect interactively
# Connect-MgGraph -Scopes "Group.ReadWrite.All","Tasks.ReadWrite"
# If you have already connected, you can skip this step
# Check if already connected
if (-not (Get-MgGraphConnection)) {
    # Connect to Microsoft Graph interactively
    Connect-MgGraph -Scopes "Group.ReadWrite.All","Tasks.ReadWrite"
}

Connect-MgGraph -Scopes "Group.ReadWrite.All","Tasks.ReadWrite"

# Set variables
$groupName = "Contoso Project Team"
$planTitle = "Q3 Project Launch - Sample May 2025"

# Find the group
$group = Get-MgGroup -Filter "displayName eq '$groupName'"
if (-not $group) {
    Write-Error "Group '$groupName' not found."
    exit
}

# Check if the plan already exists
$existingPlan = Get-MgGroupPlannerPlan -GroupId $group.Id | Where-Object { $_.Title -eq $planTitle }
if ($existingPlan) {
    Write-Host "Planner plan '$planTitle' already exists in group '$groupName'. No changes made."
    exit
}

# Create the new plan
$newPlan = New-MgGroupPlannerPlan -GroupId $group.Id -Title $planTitle

# Sample users (replace with real user IDs from your tenant)
$users = @{
    "user-100" = "alice.johnson@contoso.com"
    "user-101" = "bob.smith@contoso.com"
    "user-102" = "carol.lee@contoso.com"
    "user-103" = "david.kim@contoso.com"
    "user-104" = "emma.white@contoso.com"
    "user-105" = "george.brown@contoso.com"
    "user-106" = "hannah.green@contoso.com"
    "user-107" = "ian.black@contoso.com"
    "user-108" = "julia.king@contoso.com"
    "user-109" = "kevin.scott@contoso.com"
    "user-110" = "laura.adams@contoso.com"
}

# Define five random bucket names
$buckets = @(
    "Planning & Kickoff",
    "Design & Prototyping",
    "Development",
    "Testing & QA",
    "Deployment & Support"
)

# Create buckets in the new plan and store their IDs
$bucketIds = @{}
foreach ($bucketName in $buckets) {
    $bucket = New-MgPlannerBucket -PlanId $newPlan.Id -Name $bucketName -OrderHint " !" 
    $bucketIds[$bucketName] = $bucket.Id
}

# Define nine random label names
$labels = @(
    "Urgent",
    "Client",
    "Internal",
    "Blocked",
    "In Progress",
    "Review",
    "Documentation",
    "Automation",
    "Follow Up"
)

# Helper function to randomly select labels for a task (1-3 labels per task)
function Get-RandomLabels {
    param([string[]]$labelNames)
    $count = Get-Random -Minimum 1 -Maximum 4
    $selected = Get-Random -InputObject $labelNames -Count $count
    return $selected
}

# Sample tasks with random bucket and label assignment
$tasks = @(
    @{ title="Prepare project kickoff"; assignedTo="user-100"; dueDate="2025-05-25"; bucketName=$buckets[0]; labels=Get-RandomLabels $labels },
    @{ title="Design wireframes"; assignedTo="user-101,user-102"; dueDate="2025-05-28"; bucketName=$buckets[1]; labels=Get-RandomLabels $labels },
    @{ title="Review requirements"; assignedTo="user-103"; dueDate="2025-05-30"; bucketName=$buckets[0]; labels=Get-RandomLabels $labels },
    @{ title="Develop backend API"; assignedTo="user-104"; dueDate="2025-06-02"; bucketName=$buckets[2]; labels=Get-RandomLabels $labels },
    @{ title="Frontend integration"; assignedTo="user-105"; dueDate="2025-06-05"; bucketName=$buckets[2]; labels=Get-RandomLabels $labels },
    @{ title="QA test plan"; assignedTo="user-106"; dueDate="2025-06-07"; bucketName=$buckets[3]; labels=Get-RandomLabels $labels },
    @{ title="Security review"; assignedTo="user-107"; dueDate="2025-06-04"; bucketName=$buckets[2]; labels=Get-RandomLabels $labels },
    @{ title="Performance testing"; assignedTo="user-108"; dueDate="2025-06-10"; bucketName=$buckets[3]; labels=Get-RandomLabels $labels },
    @{ title="Documentation draft"; assignedTo="user-109"; dueDate="2025-06-08"; bucketName=$buckets[4]; labels=Get-RandomLabels $labels },
    @{ title="Stakeholder review"; assignedTo="user-110"; dueDate="2025-06-12"; bucketName=$buckets[0]; labels=Get-RandomLabels $labels },
    @{ title="Bug fixing sprint"; assignedTo="user-101"; dueDate="2025-06-14"; bucketName=$buckets[2]; labels=Get-RandomLabels $labels },
    @{ title="Final QA"; assignedTo="user-106"; dueDate="2025-06-16"; bucketName=$buckets[3]; labels=Get-RandomLabels $labels },
    @{ title="Release preparation"; assignedTo="user-110"; dueDate="2025-06-18"; bucketName=$buckets[4]; labels=Get-RandomLabels $labels },
    @{ title="Go-live"; assignedTo="user-100"; dueDate="2025-06-20"; bucketName=$buckets[4]; labels=Get-RandomLabels $labels },
    @{ title="Post-launch support"; assignedTo="user-103"; dueDate="2025-06-25"; bucketName=$buckets[4]; labels=Get-RandomLabels $labels }
)

# Create tasks in the new plan
foreach ($task in $tasks) {
    $assignees = @{}
    foreach ($uid in $task.assignedTo -split ",") {
        $userEmail = $users[$uid]
        $userObj = Get-MgUser -Filter "mail eq '$userEmail'"
        if ($userObj) {
            $assignees[$userObj.Id] = @{}
        }
    }

    # Prepare label assignments (Planner supports up to 25 labels per plan, named label1-label25)
    $labelAssignments = @{}
    foreach ($label in $task.labels) {
        $labelIndex = [array]::IndexOf($labels, $label) + 1
        $labelAssignments["label$labelIndex"] = $true
    }

    New-MgPlannerTask -PlanId $newPlan.Id `
        -Title $task.title `
        -Assignments $assignees `
        -BucketId $bucketIds[$task.bucketName] `
        -DueDateTime ("{0}T17:00:00Z" -f $task.dueDate) `
        -AppliedCategories $labelAssignments
}

Write-Host "Planner plan '$planTitle' and tasks created in group '$groupName'."


<#

create new Powershell version of same sample Planner plan data. Write out to a Microsoft Planner plan but don't overwrite.

Here is a PowerShell script that creates a new Microsoft Planner plan and adds a dozen sample tasks with overlapping dates, without overwriting existing plans. This script uses the Microsoft Graph PowerShell SDK. It first checks if a plan with the same name exists in the group; if not, it creates the plan and adds the tasks.


Notes:

Replace the $groupName with your actual Microsoft 365 group name.
The $users hash table maps your sample user IDs to real user emails. Update these to match your tenant.
The script checks for an existing plan with the same title and does not overwrite if found.
You must have the necessary permissions and the Microsoft Graph PowerShell module installed.
This script creates tasks with overlapping due dates as in your sample data.



Add five random bucket names assign all tasks to one of five.
add 9 label names and randomly assign to each sample task.

perform import-module only if not done before

#>

