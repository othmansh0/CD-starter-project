# Branch Protection Rules

## How to Configure

Go to: Repository Settings > Branches > Add branch protection rule

### For `main` branch:

| Setting | Value |
|---------|-------|
| Branch name pattern | `main` |
| Require pull request before merging | Yes |
| Required approvals | 1 |
| Dismiss stale reviews | Yes |
| Require status checks | Yes |
| Required checks | `test`, `lint` |
| Require branches up to date | Yes |
| Restrict who can push | Admins only |

### For `develop` branch:

| Setting | Value |
|---------|-------|
| Branch name pattern | `develop` |
| Require pull request before merging | Yes |
| Required approvals | 1 |
| Require status checks | Yes |
| Required checks | `test` |
| Require branches up to date | Yes |
