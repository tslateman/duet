Apply the /automagic-problem-discovery skill to this workspace snapshot. Work from the snapshot only, do not read my actual disk. End with the tool you would build.

**`launchctl list | grep tslater`**
```
-   1   com.tslater.nightly-report
-   0   com.tslater.log-rotate
-   1   com.tslater.backup-photos
78  0   com.tslater.index-notes
```

**Last 30 shell history lines (deduplicated, with counts):**
```
14  bash ~/bin/nightly-report.sh          # run by hand
11  tail -100 ~/logs/nightly-report.log
 9  launchctl kickstart -k gui/501/com.tslater.nightly-report
 6  bash ~/bin/backup-photos.sh
 4  open ~/logs/
 3  git -C ~/notes pull && bash ~/bin/index-notes.sh
 2  brew services restart postgresql@16
```

**`~/bin/nightly-report.sh` (excerpt):**
```bash
#!/bin/bash
python3 ~/src/report/main.py > ~/logs/nightly-report.log 2>&1
echo "report done" >> ~/logs/nightly-report.log
```

**`~/bin/backup-photos.sh` (excerpt):**
```bash
#!/bin/bash
rsync -a ~/Pictures/ /Volumes/Backup/Pictures/ > ~/logs/backup.log 2>&1
echo "backup ok" >> ~/logs/backup.log
```

**`~/logs/nightly-report.log` (tail):**
```
Traceback (most recent call last):
  File "/Users/tslater/src/report/main.py", line 88, in <module>
    conn = psycopg.connect(DSN)
psycopg.OperationalError: connection refused
report done
```

**`~/logs/backup.log` (tail):**
```
rsync: [sender] change_dir "/Volumes/Backup/Pictures" failed: No such file or directory (2)
backup ok
```
