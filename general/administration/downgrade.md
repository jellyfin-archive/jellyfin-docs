---
uid: admin-downgrade
title: Downgrade
---

# Downgrade from 10.6.0 to 10.5.0

This procedure is written for docker, but can be translated to other platforms by following the same general principles.

1. Stop your jellyfin container

2. Go to your data folder of jellyfin
 
3. Rename all .db files to .nightly
    ```
    authentication.db       >>>   authentication.nightly
    displaypreferences.db   >>>   displaypreferences.nightly
    jellyfin.db             >>>   jellyfin.nightly
    kodisyncqueue.db        >>>   kodisyncqueue.nightly
    library.db              >>>   library.nightly
    ```

4. Rename all .old or .back1 files to normal files

    ```
    activitylog.db.old     >>>    activitylog.db
    users.db.old           >>>    users.db
    library.db.bak1        >>>    library.db
    ```

5. Start your jellyfin container
