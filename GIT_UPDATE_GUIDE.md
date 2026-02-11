# Git Update Guide

This guide explains how to keep your local repository and branches synchronized with the latest changes from the main branch.

## Quick Start

### Automated Updates (GitHub Actions)

The repository includes a GitHub Actions workflow that automatically checks for updates from the main branch daily. You can also trigger it manually:

1. Go to the **Actions** tab in the GitHub repository
2. Select **"Sync with Main Branch"** workflow
3. Click **"Run workflow"** button
4. Choose your branch and click **"Run workflow"**

### Manual Updates (Script)

We provide a convenient shell script that guides you through the update process:

```bash
./update-from-main.sh
```

The script will:
- Show your current branch status
- Check if you're behind main
- Offer options to merge, rebase, or checkout main
- Guide you through the process interactively

### Manual Updates (Git Commands)

If you prefer to use git commands directly, follow these steps:

#### Step 1: Fetch Latest Changes

```bash
git fetch origin
```

This downloads the latest commits from the remote repository without modifying your local branches.

#### Step 2: Check Out Main Branch (if needed)

```bash
git checkout main
```

Switch to the main branch if you want to update it directly.

#### Step 3: Pull Latest Changes

```bash
git pull origin main
```

This merges the latest changes from the remote main branch into your current local branch.

## Common Scenarios

### Scenario 1: Update Main Branch

If you're working on the main branch:

```bash
git checkout main
git pull origin main
```

### Scenario 2: Update Feature Branch with Main

If you're on a feature branch and want to incorporate changes from main:

**Option A: Merge (recommended for shared branches)**
```bash
git fetch origin
git merge origin/main
```

**Option B: Rebase (for personal feature branches)**
```bash
git fetch origin
git rebase origin/main
```

### Scenario 3: Start a New Feature Branch from Latest Main

```bash
git fetch origin
git checkout -b my-new-feature origin/main
```

## Understanding Git Fetch vs Pull

- **`git fetch origin`**: Downloads latest changes but doesn't modify your working files
- **`git pull origin main`**: Downloads AND merges changes into your current branch
- **`git pull`** is essentially: `git fetch` + `git merge`

## Handling Merge Conflicts

If you encounter merge conflicts:

1. Git will mark the conflicting files
2. Open the files and look for conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Resolve the conflicts by editing the files
4. Stage the resolved files: `git add <filename>`
5. Complete the merge: `git commit`

## Best Practices

1. **Fetch frequently**: Run `git fetch origin` regularly to stay aware of changes
2. **Update before starting work**: Always pull the latest changes before starting new work
3. **Commit before updating**: Commit or stash your changes before pulling to avoid conflicts
4. **Keep main clean**: Don't commit directly to main; use feature branches instead
5. **Sync feature branches**: Regularly merge or rebase your feature branches with main

## Automation

### GitHub Actions Workflow

The repository includes `.github/workflows/sync-with-main.yml` which:
- Runs automatically daily at 00:00 UTC
- Can be triggered manually from the Actions tab
- Checks if branches are behind main
- Automatically merges main into the current branch if needed
- Alerts you if merge conflicts require manual intervention

### Customize Automation

To modify the sync schedule, edit `.github/workflows/sync-with-main.yml`:

```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # Change this cron expression
```

Cron format: `minute hour day month weekday`

Examples:
- `0 */6 * * *` - Every 6 hours
- `0 9 * * 1` - Every Monday at 9 AM
- `0 0 * * 0` - Every Sunday at midnight

## Troubleshooting

### "Your branch is behind 'origin/main'"

```bash
git pull origin main
```

### "You have divergent branches"

This means your branch has commits that aren't in main, and main has commits that aren't in your branch:

```bash
git fetch origin
git rebase origin/main  # or git merge origin/main
```

### "Cannot pull with rebase: You have unstaged changes"

Commit or stash your changes first:

```bash
git stash
git pull origin main
git stash pop
```

### "fatal: refusing to merge unrelated histories"

This typically happens with a new repository:

```bash
git pull origin main --allow-unrelated-histories
```

## Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Docs - Syncing a fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)

## Getting Help

If you encounter issues:
1. Check the troubleshooting section above
2. Review git status: `git status`
3. Check the git log: `git log --oneline --graph --all`
4. Ask for help in the repository discussions or issues
