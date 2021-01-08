# limit-helpd
Script to limit and control rogue "helpd" processes in macOS Big Sur (11.1)

TIP #1: It could also be used for any other process, by simply parametrizing the process name.

TIP #2: Although this script is tested to run on macOS 11.1, it should also work in some other UNIX-like OSes, like Linux or BSD.

## Explanation
There seems to be a bug in macOS Big Sur that makes the "helpd" process go nuts and consume a whole CPU core all the time, until killed. Until Apple figures how to fix it, I came with a simple solution (well, sort of...) that checks for any running helpd process and eventually kills if it that has consumed more CPU time than it is allowed by this script.

I have also included a launchd agent definition for launching and maintaining this script always running in the background.

For more information about this issue in Big Sur, see:
https://forums.macrumors.com/threads/helpd-process-problem.2276211

## Usage
Just copy the "limit_helpd.sh" script to "/usr/local/bin" on your Mac and ensure it has the executable bit set.

Afterwards, copy the "plist" file to "~/Library/LaunchAgents" and then execute:

`launchctl load ~/Library/LaunchAgents/local.limit-helpd.plist`

You can check in the log file (/tmp/limit_helpd.log) if it's working.

## Notes
The script is extremely simple in what it does. It does not even check the input arguments (to do :-)
