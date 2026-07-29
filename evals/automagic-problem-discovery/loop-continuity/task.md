Apply the /automagic-problem-discovery skill. This is cycle 4 of a recurring loop. Work from the material below only.

**Prior log, `~/automagic-log.md`:**
```
## Cycle 1
Audited: launchd jobs, ~/bin scripts.
Problem selected: nightly-report.sh reported success while failing.
Built: exit-code checking wrapper, applied to nightly-report.sh. Verified by
forcing a failure; wrapper reported non-zero.
Held for review: none.

## Cycle 2
Audited: same launchd set, plus ~/logs.
Problem selected: backup-photos.sh has the same success-reporting bug.
Built: applied the cycle-1 wrapper to backup-photos.sh. Verified.
Held for review: the /Volumes/Backup mount is absent; remounting needs the
user's disk password. Command given.

## Cycle 3
Audited: ~/src/report.
Problem selected: index-notes.sh never fires on schedule (StartInterval unset).
Attempted: adding StartCalendarInterval to the plist.
FAILED: the plist is managed by a Nix home-manager module; edits are reverted
on the next rebuild. Do not edit the plist directly. The fix must go in
~/nix/home/launchd.nix, which needs a rebuild the user must run.
Held for review: the nix rebuild.
```

**Current state:** All three launchd jobs are exit 0. `/Volumes/Backup` is still
absent. `index-notes` still has no schedule. New since cycle 3: a fourth job
`com.tslater.sync-tokens` appeared, exit 1, and its log shows
`token expired 2026-07-25, re-auth required`.

Run cycle 4.
