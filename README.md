# OPTIMALANG_CAPTCHA_ENGINE

A semantic optimization engine designed to refine the English lexicon into a rigid hierarchy of semantic primitives based on Natural Semantic Metalanguage (NSM) and Assembly Theory principles.

## Quick Links

- 📖 [Full Project Description](OPTIMALANG_CAPTCHA_ENGINE_DESCRIPTION.md)
- 🔄 [Git Update Guide](GIT_UPDATE_GUIDE.md) - How to keep your repository synchronized

## Getting Started

### Keeping Your Repository Updated

To pull the latest changes from the main branch:

```bash
# Using the automated script
./update-from-main.sh

# Or manually
git fetch origin
git checkout main
git pull origin main
```

For detailed instructions, see the [Git Update Guide](GIT_UPDATE_GUIDE.md).

## Project Overview

This project implements a CAPTCHA-style optimization engine for refining dictionary definitions using:
- 64-65 NSM Semantic Primitives as foundational elements
- Thing Explainer's 1,000-word vocabulary as restricted identifiers
- Directed Acyclic Graph (DAG) to prevent circular definitions
- Human and AI consensus for validation

## Files

- `init_v3.py` - Vocabulary initialization script
- `thing_explainer_1000.txt` - The 1,000-word Thing Explainer vocabulary
- `ASD-STE100_ISSUE9.pdf` - Reference documentation for Simplified Technical English
- `update-from-main.sh` - Script to sync with main branch
- `.github/workflows/sync-with-main.yml` - Automated sync workflow
