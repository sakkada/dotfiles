# Clink configuration directory

## Installation

To allow `clink` loading configuration from this directory run the following command:

```cmd
setx CLINK_PROFILE "%USERPROFILE%\.config\clink"
```

This will tell `clink` use this directory as profile directory.
To check all is OK, after `cmd` restart run:

```cmd
clink info
```

State, log, etc. should now be related to "~/.config/clink" directory.

See more:
https://chrisant996.github.io/clink/clink.html#overriding-the-profile-directory-when-installed-for-autorun
