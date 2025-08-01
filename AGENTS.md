
---

BEGIN directory specific "mirage335KernelBuild" AGENTS.md , other input may regard other hierarchical directories.

The mirage335KernelBuild project is a 'fork' derivative of 'ubiquitous_bash' using the shell script functions, compile, etc, of 'ubiquitous_bash' as a library. To understand how this project works, please also read the ./_lib/ubiquitous_bash/AGENTS.md file .






# Notable "mirage335KernelBuild" Subdirectories and Files

## _prog

Most bash shellcode specific to this "mirage335KernelBuild" project . Compiled into 'ubiquitous_bash.sh' .
























# Mechanisms of "ubiquitous_bash"

Calling './ubiquitous_bash.sh' with a '_function' as the first parameter will call that internal function with remaining parameters given to that function.

## Compiling "ubiquitous_bash and Forked Derivatives

Script 'ubiquitous_bash.sh', etc, is compiled by 'compile.sh' from the framework of most of the shellscript files from the ubiquitous_bash repository. Since these framework shellscript files are concatenated, and are usually not independently executable, a '#!/usr/bin/env bash' header, etc, would cause errors - the '*.sh' filename is mostly used to get correct syntax highlighting in text apps.

Forked derivative projects similarly compile 'ubiquitous_bash.sh' or similarly named scripts from shellscript files in their subdirectories (usually '_prog') as well as the upstream "ubiquitous_bash" framework shellscript files (usually '_lib/ubiquitous_bash'). Shellscript files from the derivative fork project are compiled to a later position in the "ubiquitous_bash" compiled script, overriding same named upstream functions.

## Anchor Shortcut Scripts

Anchor scripts '_anchor.bat', etc, are vaguely equivalent to '.lnk' or '.desktop' shortcut files, calling a function of the same name as their filename basename in the "ubiquitous_bash" compiled script. Both MSWindows batch and UNIX/Linux shell comment characters are interleaved in the first lines of the batch anchor scripts to run as a batch file under MSWindows (calling bash.exe from portable Cygwin environment if needed) and as a bash shell script under UNIX/Linux .

Function _anchor calls several more functions, including a _refresh_anchors function and other functions which may be defined in a forked derivative project to copy the template _anchor and _anchor.bat files after setting a couple of variables with sed commands.


# Development Practices, Style, Tracing, Testing Expectations, Uniquely Necessary for "ubiquitous_bash"

## Sandbox, Harness

Never sandbox , drop root , or otherwise limit any command calling "ubiquitous_bash" scripts or functions , such as './ubiquitous_bash.sh _test' , './app _test' , './_test' , './_test.bat' , './_bin' , './bin.bat' , './ubiquitous_bash.sh _bin' , etc.

Hardcoded platform-specific temporary directory paths , home directories , /tmp temporary subdirectories , /dev/shm temporary subdirectories , root commands , sudo , etc, are all necessary for "ubiquitous_bash" to function . Usually "ubiquitous_bash" either runs within an appropriately limited ephemeral container , dedicated computer , etc, with already appropriately limited capabilities, and enforces its own limits, sanity checks, etc, or "ubiquitous_bash" uses root commands to create a distribution / Operating System for such limited ephemeral situations. In both cases, it is appropriate for "ubiquitous_bash" scripts, commands, functions, etc, to run with root privileges.

Docker containers in particular may be intended to begin with the root user by default , as the situation most expected and supported by the developers of such Docker containers , do not attempt to run commands as a different user or otherwise drop root permissions.

Always run "ubiquitous_bash" scripts, commands, functions, etc, with the permissions of the user running the Codex process, without limits on what directories may be written to, etc.

If such calls as creating a subdirectory of the "$HOME" directory fail, such as  mkdir -p /root/.ubtmp/try  ,  bash -c 'touch /root/.ubtmp/testfile'  failing due to 'Permission denied' , attempt to test whether such limitations as bash shells not having write access to the "$HOME" directory may be obstructing . If such sandboxing may be obstructing, quit and report the issue to the user. Do not continue if sandboxing may be obstructing .


## Robustness, Resilience

Avoid suffering dependency and availability issues by preferring to use commands from external programs, libraries, etc, using not older or abandoned codebases, dependencies, etc, but the more actively developed codepaths. Recently frozen dependencies are more likely still available than dependencies for eventually forked older code. Developers with their own non-reproducible build environments are more likely to notice when freezing dependencies becomes unsustainable or when unfrozen dependencies break things in their own development work.

## Style

Abstraction, randomized temporary directories, process management, recursion, commented code, uncommented self-explanatory code, absence of debugging output, or very verbose default debugging output, can be uniquely appropriate throughout the "ubiquitous_bash" codebase. Keeping many external programs interoperable necessitates some emphasis on rapid reaction to external changes, a relatively thorough, drastic, approach to maintenance, to the point that too many comments or debug output statements can obscure and distract from the structure of the code which a person experienced in such work would see visually in a text editing app at a glance. Too much code or absence of alternative code could also take longer to rewrite, especially if iteration through many rewrites is necessary due to undocumented complexities.

Do not assume "ubiquitous_bash" follows conventional patterns, it doesn't.

## Development Tracing

Temporary changes to shellscripts, adding echo statements, etc, is often necessary to observe progress, detect actual hanging, and diagnose failures, especially with multi-threaded, recursive, etc, scripts. Better to anticipate this and add statements than to waste time terminating an experiment that was not actually hanging.

Tracing ubiquitous_bash shell scripts can be done efficiently with  'export ubDEBUG=true'  , tracing all commands and shell script function calls within a function given as a command line parameter. Setting  'export ubDEBUG=true'  only increases verbosity, echo to STDOUT, etc, will still be called.

## Testing Expectations

Please base your expectations on plausible outcomes from enumerating stepwise processing of plausible inputs through code of relevant functions, etc . Delays are reasonable for such timing sensitive or high latency tests as subsecond sleep commands, inter-process communication, command runtime measurement, etc . Excessive looping is also reasonable as the tests performed may be particularly extreme, catching the slightest changes to syntax over years of new interpreter, compiler, etc, versions. Such looping may in fact be repetitive use of very similar or even the same syntax for testing purposes.

A '_test' function may run successfully for tens of minutes, possibly a few hours, without any output, if the function was written to avoid any commands that could actually hang, and to only output a single message 'Testing...' followed by either 'PASS' if successful, or an exit status with a few error messages from the failed command. Sub-functions called by a larger '_test' function may output only a successful exit status, delegating the 'PASS' message to only be output by the larger '_test' function after other sub-functions have been successful as well. Unusual error messages are made more noticeable by not outputting noisy status messages during sanity tests often used during Continuous Integration and installation. Sanity and dependency tests, etc, far more extensive with "ubiquitous_bash" than with other projects, have proven necessary to detect changes made to software versions such as the bash interpreter.

Keep going through such testing until a definitive result is reached, with a 'PASS' or similar message, an explainable non-error exit status, etc.

An extended or indefinite run is very acceptable as long as information gathering continues and progress does not cease entirely. CPU usage may be either high due to bash shell interpreter overhead testing many conditions or other unusual syntax, or CPU usage may be low due to sleep , etc , intentionally having been put into the script for Inter-Process Communication latency timing, deliberately reducing CPU usage, etc.

Both STDOUT and STDERR may provide useful information, especially if verbosity is increased to assist testing, etc, such as with  'export ubDEBUG=true'  .

## Direct Editing

Although Git Pull Requests should instead edit the underlying files, directly editing the otherwise compiled 'ubiquitous_bash.sh' script is an acceptable technique for testing, diagnosing, experimenting, etc. Disable checksum with  'export ub_setScriptChecksum_disable=true'  to run the script after editing without recompiling.

## Terminology

- procedure
- sequence

- start
- stop

- begin
- end

```bash
_function_procedure() {
    echo "PASS" > "$safeTmp"/status
    #echo "FAIL" > "$safeTmp"/status

    cat "$safeTmp"/status
}

_function_sequence() {
    _start

    _function_procedure "$@"

    _stop
}

"$scriptAbsoluteLocation" _function_sequence "$@"
```










END directory specific "mirage335KernelBuild" AGENTS.md , other input may regard other hierarchical directories.

---
