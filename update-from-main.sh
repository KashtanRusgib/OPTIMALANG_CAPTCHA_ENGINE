#!/bin/bash
# Script to fetch and pull latest changes from main branch
# Usage: ./update-from-main.sh

set -e  # Exit on error

echo "======================================"
echo "  Git Update Script"
echo "  Fetching and pulling latest changes"
echo "======================================"
echo ""

# Get current branch name
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"
echo ""

# Fetch latest changes from origin
echo "🔄 Fetching latest changes from origin..."
git fetch origin
echo "✅ Fetch complete"
echo ""

# Show current status
echo "📊 Git status:"
git status --short --branch
echo ""

# Check if main branch exists
if git show-ref --verify --quiet refs/heads/main; then
    MAIN_EXISTS=true
    echo "✅ Main branch exists locally"
elif git show-ref --verify --quiet refs/remotes/origin/main; then
    MAIN_EXISTS=false
    echo "⚠️  Main branch not checked out locally, but exists on origin"
else
    echo "❌ Error: Main branch not found"
    exit 1
fi
echo ""

# If we're on main, just pull
if [ "$CURRENT_BRANCH" = "main" ]; then
    echo "🔄 Pulling latest changes into main branch..."
    git pull origin main
    echo "✅ Main branch updated successfully"
    exit 0
fi

# Otherwise, check if we're behind main
echo "🔍 Checking if branch is behind main..."
BEHIND_COUNT=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
AHEAD_COUNT=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

echo "   - Commits behind main: $BEHIND_COUNT"
echo "   - Commits ahead of main: $AHEAD_COUNT"
echo ""

if [ "$BEHIND_COUNT" -eq 0 ]; then
    echo "✅ Your branch is up to date with main"
    exit 0
fi

# Offer to merge or rebase
echo "⚠️  Your branch is $BEHIND_COUNT commit(s) behind main"
echo ""
echo "Options:"
echo "  1) Merge main into current branch (recommended for shared branches)"
echo "  2) Rebase current branch onto main (for feature branches)"
echo "  3) Just checkout main branch"
echo "  4) Cancel"
echo ""

read -p "Choose an option [1-4]: " choice

case $choice in
    1)
        echo ""
        echo "🔄 Merging main into $CURRENT_BRANCH..."
        git merge origin/main -m "Merge main into $CURRENT_BRANCH"
        echo "✅ Merge complete"
        echo ""
        echo "💡 Remember to push your changes:"
        echo "   git push origin $CURRENT_BRANCH"
        ;;
    2)
        echo ""
        echo "🔄 Rebasing $CURRENT_BRANCH onto main..."
        git rebase origin/main
        echo "✅ Rebase complete"
        echo ""
        echo "💡 Remember to force-push your changes:"
        echo "   git push --force-with-lease origin $CURRENT_BRANCH"
        ;;
    3)
        echo ""
        echo "🔄 Checking out main branch..."
        git checkout main
        echo "🔄 Pulling latest changes..."
        git pull origin main
        echo "✅ Main branch updated and checked out"
        ;;
    4)
        echo "❌ Operation cancelled"
        exit 0
        ;;
    *)
        echo "❌ Invalid option"
        exit 1
        ;;
esac

echo ""
echo "======================================"
echo "  Update complete!"
echo "======================================"
