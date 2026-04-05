---
name: dependency-audit
description: Audit Node.js dependencies for vulnerabilities, outdated packages, deprecations, and risky version ranges using pnpm, npm, or yarn. Use this whenever users ask for dependency health checks, pre-release security review, supply chain checks, or package update planning.
metadata:
  author: aske
  version: "1.0.0"
allowed-tools: Bash Read Grep
---

# Dependency Audit (pnpm, npm, yarn)

Perform a Node dependency audit and return a prioritized, actionable report.

## Core behavior

- Detect and use the project's package manager (`pnpm`, `yarn`, or `npm`).
- Run vulnerability and outdated checks with the detected manager.
- Analyze `package.json` for risky version specifiers and maintenance risk signals.
- Report findings by severity with concrete remediation commands.
- Never apply fixes automatically. Ask for confirmation before any mutating command.

## 1) Detect package manager

Use lockfiles first (most reliable), then `package.json#packageManager`, then fallback:

1. `pnpm-lock.yaml` -> `pnpm`
2. `yarn.lock` -> `yarn`
3. `package-lock.json` or `npm-shrinkwrap.json` -> `npm`
4. `package.json` `packageManager` field (e.g. `pnpm@9`, `yarn@4`, `npm@10`)
5. fallback to `npm`

If multiple lockfiles exist, call out the ambiguity and proceed with the strongest signal in the order above.

## 2) Run audit and outdated checks

Run from repository root. Capture output even if command exits non-zero.

### pnpm

```bash
pnpm audit --json
pnpm outdated
```

### yarn

Try Berry first, then Classic fallback:

```bash
yarn npm audit --json || yarn audit --json
yarn outdated
```

### npm

```bash
npm audit --json
npm outdated --json
```

If an audit command is unavailable, report the exact install/enable command and continue with remaining checks.

## 3) Analyze package manifest

Read `package.json` and inspect `dependencies`, `devDependencies`, `optionalDependencies`, and `peerDependencies`.

Flag:

- Risky ranges: `*`, `latest`, broad unbounded ranges that can unexpectedly drift.
- Deprecated packages (from audit/outdated output).
- Direct dependencies behind major versions (from outdated output).
- Potentially abandoned dependencies if audit tools indicate maintenance concerns.

Prefer high signal findings over exhaustive noise.

## 4) Produce report

Use this structure:

```markdown
## Dependency Audit Report

- Package manager: <pnpm|yarn|npm>
- Scan date: <YYYY-MM-DD>
- Scope: package.json + lockfile + audit/outdated commands

### Critical - Fix before release
- <package> <current -> target>
  - Severity: Critical
  - Why it matters: <1 sentence>
  - Remediation: `<exact command>`

### High - Fix soon
- ...

### Medium / Low - Schedule
- ...

### Warnings
- Deprecated packages
- Risky version ranges
- Tooling gaps or partial scan notes

### Recommended action plan
1. <small, safe first step>
2. <next step>
3. <validation step: test/build>

### Confirmation
I can run these non-destructive checks next: `<commands>`.
For dependency updates/fixes, confirm and I will run the approved commands only.
```

## 5) Remediation safety rules

- Never run mutating commands without explicit user confirmation.
- Treat `audit fix` and package upgrades as mutating operations.
- Separate low-risk updates (patch/minor) from major upgrades.
- For major upgrades, include breaking-change risk note and suggest staged rollout.

## 6) Command suggestions by manager

Only suggest commands that match detected manager.

### pnpm

- Audit/fix candidates: `pnpm audit --fix`
- Targeted update: `pnpm up <pkg>@<version>`
- Refresh all allowed ranges: `pnpm up`

### yarn

- Targeted update: `yarn up <pkg>@<version>`
- Interactive upgrade planning: `yarn up -i`
- Re-run audit: `yarn npm audit --json` (or `yarn audit --json`)

### npm

- Audit/fix candidates: `npm audit fix`
- Targeted update: `npm install <pkg>@<version>`
- Refresh allowed ranges: `npm update`

Always close by asking which subset of fixes the user wants applied.
