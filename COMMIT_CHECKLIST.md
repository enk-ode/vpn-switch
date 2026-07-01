# Commit Checklist (Definition of Done)

Use this checklist before creating commits to ensure consistency and completeness.

## Pre-Commit Checks

### 1. Code Quality
```bash
gmake check        # Syntax check all scripts
gmake lint         # Syntax + ShellCheck
gmake test-unit    # Unit tests
```

- [ ] All tests passing (`gmake test`)
- [ ] No syntax errors (`gmake check`)
- [ ] ShellCheck passes (`gmake shellcheck`)
- [ ] POSIX compliance (no bashisms)

### 2. Documentation
- [ ] CLAUDE.md reflects current status
- [ ] README.md updated if user-facing changes
- [ ] Code comments updated for modified functions

### 3. Version Control
- [ ] Git status clean (no unexpected changes)
- [ ] Changes staged intentionally
- [ ] Commit message follows format (see below)

### 4. Testing
- [ ] All existing tests pass
- [ ] New functionality has tests
- [ ] Edge cases covered

## Commit Message Format

```
<Phase/Area>: <Brief description>

<Detailed explanation of changes>

Changes:
- <Change 1>
- <Change 2>

Testing: <X>/<Y> assertions passing

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Quick Commands

```bash
# Full pre-commit check
gmake lint && gmake test

# Quick syntax check only
gmake check

# Run specific test suite
gmake test-unit
gmake test-integration
gmake test-arch
```

## Current Phase Status

### Phase 1-4 ✅ Complete
- Core architecture, WireGuard, OpenVPN
- Session management, config management
- Phase-based scripts, backend selection
- Diagnostic inspection, robust initialization

### Phase 5 (Polish & Release Prep) - In Progress
- [ ] Documentation cleanup
- [ ] GNUmakefile cross-platform support
- [ ] Code refactoring

### Phase 6 (Release Candidate)
- [ ] Final testing
- [ ] 1.0 release
