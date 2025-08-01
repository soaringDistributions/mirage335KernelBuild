#!/usr/bin/env bash

if [[ "$ubDEBUG" == "true" ]] ; then set +x ; set +E ; set +o functrace ; set +o errtrace ; export -n SHELLOPTS 2>/dev/null || true ; trap '' RETURN ; trap - RETURN ; fi

[[ "$PATH" != *"/usr/local/bin"* ]] && [[ -e "/usr/local/bin" ]] && export PATH=/usr/local/bin:"$PATH"
[[ "$PATH" != *"/usr/bin"* ]] && [[ -e "/usr/bin" ]] && export PATH=/usr/bin:"$PATH"
[[ "$PATH" != *"/bin:"* ]] && [[ -e "/bin" ]] && export PATH=/bin:"$PATH"

if [[ "$ub_setScriptChecksum" != "" ]]
then
	export ub_setScriptChecksum=
fi

_ub_cksum_special_derivativeScripts_header() {
	local currentFile_cksum
	if [[ "$1" == "" ]]
	then
		currentFile_cksum="$0"
	else
		currentFile_cksum="$1"
	fi
	
	head -n 30 "$currentFile_cksum" | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9'
}
_ub_cksum_special_derivativeScripts_contents() {
	local currentFile_cksum
	if [[ "$1" == "" ]]
	then
		currentFile_cksum="$0"
	else
		currentFile_cksum="$1"
	fi
	
	tail -n +45 "$currentFile_cksum" | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9'
}
##### CHECKSUM BOUNDARY - 30 lines

[[ "$ubDEBUG" == "true" ]] && export ub_setScriptChecksum_disable='true'
#export ub_setScriptChecksum_disable='true'
( [[ -e "$0".nck ]] || [[ "${BASH_SOURCE[0]}" != "${0}" ]] || [[ "$1" == '--profile' ]] || [[ "$1" == '--script' ]] || [[ "$1" == '--call' ]] || [[ "$1" == '--return' ]] || [[ "$1" == '--devenv' ]] || [[ "$1" == '--shell' ]] || [[ "$1" == '--bypass' ]] || [[ "$1" == '--parent' ]] || [[ "$1" == '--embed' ]] || [[ "$1" == '--compressed' ]] || [[ "$0" == "/bin/bash" ]] || [[ "$0" == "-bash" ]] || [[ "$0" == "/usr/bin/bash" ]] || [[ "$0" == "bash" ]] ) && export ub_setScriptChecksum_disable='true'
export ub_setScriptChecksum_header='3620520443'
export ub_setScriptChecksum_contents='3891783678'

# CAUTION: Symlinks may cause problems. Disable this test for such cases if necessary.
# WARNING: Performance may be crucial here.
#[[ -e "$0" ]] && ! [[ -h "$0" ]] && [[ "$ub_setScriptChecksum" != "" ]]
if [[ -e "$0" ]] && [[ "$ub_setScriptChecksum_header" != "" ]] && [[ "$ub_setScriptChecksum_contents" != "" ]] && [[ "$ub_setScriptChecksum_disable" != 'true' ]] #&& ! ( [[ -e "$0".nck ]] || [[ "${BASH_SOURCE[0]}" != "${0}" ]] || [[ "$1" == '--profile' ]] || [[ "$1" == '--script' ]] || [[ "$1" == '--call' ]] || [[ "$1" == '--return' ]] || [[ "$1" == '--devenv' ]] || [[ "$1" == '--shell' ]] || [[ "$1" == '--bypass' ]] || [[ "$1" == '--parent' ]] || [[ "$1" == '--embed' ]] || [[ "$1" == '--compressed' ]] || [[ "$0" == "/bin/bash" ]] || [[ "$0" == "-bash" ]] || [[ "$0" == "/usr/bin/bash" ]] || [[ "$0" == "bash" ]] )
then
	[[ $(_ub_cksum_special_derivativeScripts_header) != "$ub_setScriptChecksum_header" ]] && exit 1
	[[ $(_ub_cksum_special_derivativeScripts_contents) != "$ub_setScriptChecksum_contents" ]] && exit 1
fi
##### CHECKSUM BOUNDARY - 45 lines

_ub_cksum_special_derivativeScripts_write() {
	local current_ub_setScriptChecksum_header
	local current_ub_setScriptChecksum_contents

	current_ub_setScriptChecksum_header=$(_ub_cksum_special_derivativeScripts_header "$1")
	current_ub_setScriptChecksum_contents=$(_ub_cksum_special_derivativeScripts_contents "$1")

	sed -i 's/'#'#'###uk4uPhB663kVcygT0q-UbiquitousBash-ScriptSelfModify-SetScriptChecksumHeader-UbiquitousBash-uk4uPhB663kVcygT0q#####'/'"$current_ub_setScriptChecksum_header"'/' "$1"
	sed -i 's/'#'#'###uk4uPhB663kVcygT0q-UbiquitousBash-ScriptSelfModify-SetScriptChecksumContents-UbiquitousBash-uk4uPhB663kVcygT0q#####'/'"$current_ub_setScriptChecksum_contents"'/' "$1"
}


#Universal debugging filesystem.
_user_log-ub() {
	# DANGER Do NOT create automatically, or reference any existing directory!
	! [[ -d "$HOME"/.ubcore/userlog ]] && cat - > /dev/null 2>&1 && return 0
	
	#Terminal session may be used - the sessionid may be set through .bashrc/.ubcorerc .
	if [[ "$sessionid" != "" ]]
	then
		cat - >> "$HOME"/.ubcore/userlog/u-"$sessionid".log
		return 0
	fi
	cat - >> "$HOME"/.ubcore/userlog/u-undef.log
	
	return 0
}

#Cyan. Harmless status messages.
_messagePlain_nominal() {
	echo -e -n '\E[0;36m '
	echo -n "$@"
	echo -e -n ' \E[0m'
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
_messagePlain_probe() {
	echo -e -n '\E[0;34m '
	echo -n "$@"
	echo -e -n ' \E[0m'
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
_messagePlain_probe_expr() {
	echo -e -n '\E[0;34m '
	echo -e -n "$@"
	echo -e -n ' \E[0m'
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
_messagePlain_probe_var() {
	echo -e -n '\E[0;34m '
	
	echo -n "$1"'= '
	
	eval echo -e -n \$"$1"
	
	echo -e -n ' \E[0m'
	echo
	return 0
}
_messageVar() {
	_messagePlain_probe_var "$@"
}

#Green. Working as expected.
_messagePlain_good() {
	echo -e -n '\E[0;32m '
	echo -n "$@"
	echo -e -n ' \E[0m'
	echo
	return 0
}

#Yellow. May or may not be a problem.
_messagePlain_warn() {
	echo -e -n '\E[1;33m '
	echo -n "$@"
	echo -e -n ' \E[0m'
	echo
	return 0
}

#Red. Will result in missing functionality, reduced performance, etc, but not necessarily program failure overall.
_messagePlain_bad() {
	echo -e -n '\E[0;31m '
	echo -n "$@"
	echo -e -n ' \E[0m'
	echo
	return 0
}



##Parameters
#"--shell", ""
#"--profile"
#"--parent", "--embed", "--return", "--devenv"
#"--call", "--script" "--bypass"
#if [[ "$ub_import" != "" ]]
#then
	#[[ "$ub_import" != "" ]] && export ub_import="" && unset ub_import
	
	#[[ "$importScriptLocation" != "" ]] && export importScriptLocation= && unset importScriptLocation
	#[[ "$importScriptFolder" != "" ]] && export importScriptFolder= && unset importScriptFolder
#fi
#[[ "$ub_import" != "" ]] && export ub_import="" && unset ub_import
#[[ "$ub_import_param" != "" ]] && export ub_import_param="" && unset ub_import_param
#[[ "$ub_import_script" != "" ]] && export ub_import_script="" && unset ub_import_script
#[[ "$ub_loginshell" != "" ]] && export ub_loginshell="" && unset ub_loginshell
ub_import=
ub_import_param=
ub_import_script=
ub_loginshell=


# ATTENTION: Apparently (Portable) Cygwin Bash interprets correctly.
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && ub_import="true"

( [[ "$1" == '--profile' ]] || [[ "$1" == '--script' ]] || [[ "$1" == '--call' ]] || [[ "$1" == '--return' ]] || [[ "$1" == '--devenv' ]] || [[ "$1" == '--shell' ]] || [[ "$1" == '--bypass' ]] || [[ "$1" == '--parent' ]] || [[ "$1" == '--embed' ]] || [[ "$1" == '--compressed' ]] ) && ub_import_param="$1" && shift
( [[ "$0" == "/bin/bash" ]] || [[ "$0" == "-bash" ]] || [[ "$0" == "/usr/bin/bash" ]] || [[ "$0" == "bash" ]] ) && ub_loginshell="true"	#Importing ubiquitous bash into a login shell with "~/.bashrc" is the only known cause for "_getScriptAbsoluteLocation" to return a result such as "/bin/bash".
[[ "$ub_import" == "true" ]] && ! [[ "$ub_loginshell" == "true" ]] && ub_import_script="true"

_messagePlain_probe_expr '$0= '"$0"'\n ''$1= '"$1"'\n ''ub_import= '"$ub_import"'\n ''ub_import_param= '"$ub_import_param"'\n ''ub_import_script= '"$ub_import_script"'\n ''ub_loginshell= '"$ub_loginshell" | _user_log-ub

# DANGER Prohibited import from login shell. Use _setupUbiquitous, call from another script, or manually set importScriptLocation.
# WARNING Import from shell can be detected. Import from script cannot. Asserting that script has been imported is possible. Asserting that script has not been imported is not possible. Users may be protected from interactive mistakes. Script developers are NOT protected.
if [[ "$ub_import_param" == "--profile" ]]
then
	if ( [[ "$profileScriptLocation" == "" ]] ||  [[ "$profileScriptFolder" == "" ]] ) && _messagePlain_bad 'import: profile: missing: profileScriptLocation, missing: profileScriptFolder' | _user_log-ub
	then
		return 1 >/dev/null 2>&1
		exit 1
	fi
elif ( [[ "$ub_import_param" == "--parent" ]] || [[ "$ub_import_param" == "--embed" ]] || [[ "$ub_import_param" == "--return" ]] || [[ "$ub_import_param" == "--devenv" ]] )
then
	if ( [[ "$scriptAbsoluteLocation" == "" ]] || [[ "$scriptAbsoluteFolder" == "" ]] || [[ "$sessionid" == "" ]] ) && _messagePlain_bad 'import: parent: missing: scriptAbsoluteLocation, missing: scriptAbsoluteFolder, missing: sessionid' | _user_log-ub
	then
		return 1 >/dev/null 2>&1
		exit 1
	fi
elif [[ "$ub_import_param" == "--call" ]] || [[ "$ub_import_param" == "--script" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--shell" ]] || [[ "$ub_import_param" == "--compressed" ]] || ( [[ "$ub_import" == "true" ]] && [[ "$ub_import_param" == "" ]] )
then
	if ( [[ "$importScriptLocation" == "" ]] || [[ "$importScriptFolder" == "" ]] ) && _messagePlain_bad 'import: call: missing: importScriptLocation, missing: importScriptFolder' | _user_log-ub
	then
		return 1 >/dev/null 2>&1
		exit 1
	fi
elif [[ "$ub_import" != "true" ]]	#"--shell", ""
then
	_messagePlain_warn 'import: undetected: cannot determine if imported' | _user_log-ub
	true #no problem
else	#FAIL, implies [[ "$ub_import" == "true" ]]
	_messagePlain_bad 'import: fall: fail' | _user_log-ub
	return 1 >/dev/null 2>&1
	exit 1
fi

#Override.
# DANGER: Recursion hazard. Do not create override alias/function without checking that alternate exists.


# Seems Ubuntu 20 used an 'alias' for 'python', which may not be usable by shell scripts.
if ! type python > /dev/null 2>&1 && type python3 > /dev/null 2>&1
then
	python() {
		python3 "$@"
	}
fi



# ATTENTION: NOTICE: https://nixos.wiki/wiki/Locales

# WARNING: May conflict with 'export LANG=C' or similar.
# Workaround for very minor OS misconfiguration. Setting this variable at all may be undesirable however. Consider enabling and generating all locales with 'sudo dpkg-reconfigure locales' or similar .
#[[ "$LC_ALL" == '' ]] && export LC_ALL="en_US.UTF-8"

# WARNING: Do NOT use 'ubKeep_LANG' unless necessary!
# nix-shell --run "locale -a" -p bash
#  C   C.utf8   POSIX
[[ "$ubKeep_LANG" != "true" ]] && [[ "$LANG" != "C" ]] && export LANG="C"


# WARNING: Only partially compatible.
if ! type md5sum > /dev/null 2>&1 && type md5 > /dev/null 2>&1
then
	md5sum() {
		md5 "$@"
	}
fi

# DANGER: No production use. Testing only.
# WARNING: Only partially compatible.
#if ! type md5 > /dev/null 2>&1 && type md5sum > /dev/null 2>&1
#then
#	md5() {
#		md5sum "$@"
#	}
#fi


# WARNING: DANGER: Compatibility may not be guaranteed!
if ! type unionfs-fuse > /dev/null 2>&1 && type unionfs > /dev/null 2>&1 && man unionfs | grep 'unionfs-fuse - A userspace unionfs implementation' > /dev/null 2>&1
then
	unionfs-fuse() {
		unionfs "$@"
	}
fi

if ! type qemu-arm-static > /dev/null 2>&1 && type qemu-arm > /dev/null 2>&1
then
	qemu-arm-static() {
		qemu-arm "$@"
	}
fi

if ! type qemu-armeb-static > /dev/null 2>&1 && type qemu-armeb > /dev/null 2>&1
then
	qemu-armeb-static() {
		qemu-armeb "$@"
	}
fi


# ATTENTION: Highly irregular. Workaround due to gsch2pcb installed by nix package manager not searching for installed footprints.
#if [[ "$NIX_PROFILES" != "" ]]
#then
	if [[ -e "$HOME"/.nix-profile/bin/gsch2pcb ]] && [[ -e /usr/local/share/pcb/newlib ]] && [[ -e /usr/local/lib/pcb_lib ]]
	then
		gsch2pcb() {
			"$HOME"/.nix-profile/bin/gsch2pcb --elements-dir /usr/local/share/pcb/newlib --elements-dir /usr/local/lib/pcb_lib "$@"
		}
	elif [[ -e /usr/share/pcb/pcblib-newlib ]]
	then
		gsch2pcb() {
			"$HOME"/.nix-profile/bin/gsch2pcb --elements-dir /usr/share/pcb/pcblib-newlib "$@"
		}
	fi
#fi


# Only production use is Inter-Process Communication (IPC) loops which may be theoretically impossible to make fully deterministic under Operating Systems which do not have hard-real-time kernels and/or may serve an unlimited number of processes.
_here_header_bash_or_dash() {
	if [[ -e /bin/dash ]]
		then
		
cat << 'CZXWXcRMTo8EmM8i4d'
#!/bin/dash

CZXWXcRMTo8EmM8i4d
	
	else
	
cat << 'CZXWXcRMTo8EmM8i4d'
#!/usr/bin/env bash

CZXWXcRMTo8EmM8i4d

	fi
}



# Delay to attempt to avoid InterProcess-Communication (IPC) problems caused by typical UNIX/MSW Operating System kernel latency and/or large numbers of processes/threads.
# Widely deployed Linux compatible hardware and software is able to run with various 'preemption' 'configured'/'patched' kernels. Detecting such kernels may allow reduction of this arbitrary delay.
# CAUTION: Merely attempts to avoid a problem which may be inherently unavoidably unpredictable.
_sleep_spinlock() {
	# CAUTION: Spinlocks on the order of 8s are commonly observed with 'desktop' operating systems. Do NOT reduce this delay without thorough consideration! Theoretically, it may not be possible to determine whether the parent of a process is still running in less than spinlock time, only the existence of the parent process guarantees against PID rollover, and multiple spinlocks may occur between the necessary IPC events to determine any of the above.
	# ATTENTION: Consider setting this to the worst-case acceptable latency for a system still considered 'responsive' (ie. a number of seconds greater than that which would cause a user or other 'watchdog' to forcibly reboot the system).
	local currentWaitSpinlock
	let currentWaitSpinlock="$RANDOM"%4
	#let currentWaitSpinlock="$currentWaitSpinlock"+12
	let currentWaitSpinlock="$currentWaitSpinlock"+10
	sleep "$currentWaitSpinlock"
}


_____special_live_hibernate_rmmod_remainder-vbox_procedure() {
	local currentLine
	sudo -n lsmod | grep '^vbox.*$' | cut -f1 -d\  | while read currentLine
	do
		#echo "$currentLine"
		sudo -n rmmod "$currentLine"
	done
}

_____special_live_hibernate_rmmod_remainder-vbox() {
	local currentIterations
	currentIterations=0
	while [[ "$currentIterations" -lt 2 ]]
	do
		let currentIterations="$currentIterations + 1"
		_____special_live_hibernate_rmmod_remainder-vbox_procedure "$@" > /dev/null 2>&1
	done
	
	_____special_live_hibernate_rmmod_remainder-vbox_procedure "$@"
}

# CAUTION: Do not alow similarity of this function name to other commonly used function names . Unintended tab completion could significantly and substantially impede user , particularly if 'disk' hibernation is not properly available .
_____special_live_hibernate() {
	! _mustGetSudo && exit 1
	
	_messageNormal 'init: _____special_live_hibernate'
	
	local currentIterations
	
	_messagePlain_nominal 'attempt: swapon'
	sudo -n swapon /dev/disk/by-uuid/469457fc-293f-46ec-92da-27b5d0c36b17
	free -m
	
	_messagePlain_nominal 'detect: vboxguest'
	sudo -n lsmod | grep vboxguest > /dev/null 2>&1 && export ub_current_special_live_consider_vbox='true'
	[[ "$ub_current_special_live_consider_vbox" == 'true' ]] && _messagePlain_good 'good: detected: vboxguest'
	
	if [[ "$ub_current_special_live_consider_vbox" == 'true' ]]
	then
		_messagePlain_nominal 'attempt: terminate: VBoxService , VBoxClient'
		sudo -n pkill VBoxService
		sudo -n pkill VBoxClient
		
		pgrep ^VBox && sleep 0.1 && pgrep ^VBox && sleep 0.3 && pgrep ^VBox && sleep 1
		sudo -n pkill -KILL VBoxService
		sudo -n pkill -KILL VBoxClient
		
		
		pgrep ^VBox && sleep 0.3
		_messagePlain_nominal 'attempt: rmmod (vbox)'
		sleep 0.05
		sudo -n rmmod vboxsf
		sudo -n rmmod vboxvideo
		sudo -n rmmod vboxguest
		_____special_live_hibernate_rmmod_remainder-vbox
		
		sleep 0.02
		sudo -n rmmod vboxsf
		sudo -n rmmod vboxvideo
		sudo -n rmmod vboxguest
		_____special_live_hibernate_rmmod_remainder-vbox
	fi
	
	_messagePlain_nominal 'attempt: HIBERNATE'
	sudo -n journalctl --rotate
	sudo -n journalctl --vacuum-time=1s
	sudo -n systemctl hibernate
	
	
	# ~1.0s
	sleep 1.1
	currentIterations=0
	while [[ "$currentIterations" -lt 3 ]]
	do
		sudo -n systemctl status hibernate.target | tail -n2 | head -n1 | grep ' Reached ' > /dev/null 2>&1 && _messagePlain_probe 'Reached'
		sudo -n systemctl status hibernate.target | tail -n1 | grep ' Stopped ' > /dev/null 2>&1 && _messagePlain_probe 'Stopped'
		sudo -n systemctl status hibernate.target | grep 'inactive (dead)' > /dev/null 2>&1 && _messagePlain_probe 'inactive'
		
		
		sudo -n systemctl status hibernate.target | tail -n2 | head -n1 | grep ' Reached ' > /dev/null 2>&1 &&
		sudo -n systemctl status hibernate.target | tail -n1 | grep ' Stopped ' > /dev/null 2>&1 &&
		sudo -n systemctl status hibernate.target | grep 'inactive (dead)' > /dev/null 2>&1 &&
		break
		
		_messagePlain_good 'delay: resume'
		
		let currentIterations="$currentIterations + 1"
		sleep 0.3
	done
	
	_messagePlain_nominal 'delay: spinlock (optimistic)'
	# Expected to result in longer delay if system is not idle.
	# ~2s
	currentIterations=0
	while [[ "$currentIterations" -lt 6 ]]
	do
		let currentIterations="$currentIterations + 1"
		sleep 0.3
	done
	# 0.5s
	currentIterations=0
	while [[ "$currentIterations" -lt 5 ]]
	do
		let currentIterations="$currentIterations + 1"
		sleep 0.1
	done
	# 0.15s
	currentIterations=0
	while [[ "$currentIterations" -lt 15 ]]
	do
		let currentIterations="$currentIterations + 1"
		sleep 0.01
	done
	
	#_messagePlain_nominal 'delay: spinlock (arbitrary)'
	#sleep 1
	
	#_messagePlain_nominal 'delay: spinlock (pessimistic)'
	#_sleep_spinlock
	
	
	if [[ "$ub_current_special_live_consider_vbox" == 'true' ]]
	then
		_messagePlain_nominal 'attempt: modprobe (vbox)'
		sudo -n modprobe vboxsf
		sudo -n modprobe vboxvideo
		sudo -n modprobe vboxguest
		
		
		sleep 0.1
		_messagePlain_nominal 'attempt: VBoxService'
		sudo -n VBoxService --pidfile /var/run/vboxadd-service.sh
		
		# 0.3s
		currentIterations=0
		while [[ "$currentIterations" -lt 3 ]]
		do
			let currentIterations="$currentIterations + 1"
			sleep 0.1
		done
		_messagePlain_nominal 'attempt: VBoxClient'
		#sudo -n VBoxClient --vmsvga
		#sudo -n VBoxClient --seamless
		#sudo -n VBoxClient --draganddrop
		#sudo -n VBoxClient --clipboard
		sudo -n VBoxClient-all
	fi
	
	disown -a -h -r
	disown -a -r
	
	_messageNormal 'done: _____special_live_hibernate'
	return 0
}

_____special_live_bulk_rw() {
	! _mustGetSudo && exit 1
	_messageNormal 'init: _____special_live_bulk_rw'
	
	sudo -n mkdir -p /mnt/bulk
	_messagePlain_nominal 'detect: mount: bulk'
	if ! mountpoint /mnt/bulk
	then
		_messagePlain_nominal 'mount: rw: bulk'
		sudo -n mount -o rw /dev/disk/by-uuid/f1edb7fb-13b1-4c97-91d2-baf50e6d65d8 /mnt/bulk
	fi
	
	! mountpoint /mnt/bulk && _messagePlain_bad 'fail: detect: mount: bulk' && exit 1
	
	_messagePlain_nominal 'remount: rw: bulk'
	sudo -n mount -o remount,rw /mnt/bulk
	
	_messageNormal 'done: _____special_live_bulk_rw'
	return 0
}

# No production use. Not expected to be desirable. Any readonly files could be added, compressed, to the 'live' 'root' .
_____special_live_bulk_ro() {
	! _mustGetSudo && exit 1
	_messageNormal 'init: _____special_live_bulk_ro'
	
	sudo -n mkdir -p /mnt/bulk
	_messagePlain_nominal 'detect: mount: bulk'
	if ! mountpoint /mnt/bulk
	then
		_messagePlain_nominal 'mount: ro: bulk'
		sudo -n mount -o ro /dev/disk/by-uuid/f1edb7fb-13b1-4c97-91d2-baf50e6d65d8 /mnt/bulk
	fi
	
	! mountpoint /mnt/bulk && _messagePlain_bad 'fail: detect: mount: bulk' && exit 1
	
	_messagePlain_nominal 'remount: ro: bulk'
	sudo -n mount -o remount,ro /mnt/bulk
	
	_messageNormal 'done: _____special_live_bulk_ro'
	return 0
}


# DANGER: Simultaneous use of any 'rw' mounted filesystem with any 'restored' hibernation file/partition is expected to result in extreme filesystem corruption! Take extra precautions to avoid this mistake!
# CAUTION: Do not alow similarity of this function name to other commonly used function names . Unintended tab completion could significantly and substantially impede user.
_____special_live_dent_backup() {
	! _mustGetSudo && exit 1
	_messageNormal 'init: _____special_live_dent_backup'
	
	_messagePlain_nominal 'attempt: mount: dent'
	sudo -n mkdir -p /mnt/dent
	! mountpoint /mnt/dent && sudo -n mount -o ro /dev/disk/by-uuid/d82e3d89-3156-4484-bde2-ccc534ca440b /mnt/dent
	! mountpoint /mnt/dent && exit 1
	
	sudo -n mount -o remount,rw /mnt/dent
	
	_messagePlain_nominal 'attempt: copy: hint'
	if type -p 'pigz' > /dev/null 2>&1
	then
		sudo -n dd if=/dev/disk/by-uuid/469457fc-293f-46ec-92da-27b5d0c36b17 bs=1M | pigz --fast | sudo -n tee /mnt/dent/hint_bak.gz > /dev/null
	elif type -p 'gzip' > /dev/null 2>&1
	then
		sudo -n dd if=/dev/disk/by-uuid/469457fc-293f-46ec-92da-27b5d0c36b17 bs=1M | gzip --fast | sudo -n tee /mnt/dent/hint_bak.gz > /dev/null
	else
		sudo -n dd if=/dev/disk/by-uuid/469457fc-293f-46ec-92da-27b5d0c36b17 bs=1M | sudo -n tee /mnt/dent/hint_bak > /dev/null
	fi
	sync
	
	_messagePlain_nominal 'attempt: mount: ro: bulk'
	sudo -n mkdir -p /mnt/bulk
	! mountpoint /mnt/bulk && sudo -n mount -o ro /dev/disk/by-uuid/f1edb7fb-13b1-4c97-91d2-baf50e6d65d8 /mnt/bulk
	! mountpoint /mnt/bulk && exit 1
	
	
	_messagePlain_nominal 'attempt: copy: bulk'
	sudo -n mkdir -p /mnt/dent/bulk_bak
	[[ ! -e /mnt/dent/bulk_bak ]] && exit 1
	[[ ! -d /mnt/dent/bulk_bak ]] && exit 1
	
	sudo -n rsync -ax --delete /mnt/bulk/. /mnt/dent/bulk_bak/.
	
	
	
	_messagePlain_nominal 'attempt: umount: dent'
	sudo -n mount -o remount,ro /mnt/dent
	sync
	
	sudo -n umount /mnt/dent
	sync
	
	_messageNormal 'done: _____special_live_dent_backup'
	return 0
}


# DANGER: Simultaneous use of any 'rw' mounted filesystem with any 'restored' hibernation file/partition is expected to result in extreme filesystem corruption! Take extra precautions to avoid this mistake!
# CAUTION: Do not alow similarity of this function name to other commonly used function names . Unintended tab completion could significantly and substantially impede user.
# WARNING: By default does not restore contents of '/mnt/bulk' assuming simultaneous use of persistent storage and hibernation backup is sufficiently unlikely and risky that a request to the user is preferable.
_____special_live_dent_restore() {
	! _mustGetSudo && exit 1
	_messageNormal 'init: _____special_live_dent_restore'
	
	_messagePlain_nominal 'attempt: mount: dent'
	sudo -n mkdir -p /mnt/dent
	! mountpoint /mnt/dent && sudo -n mount -o ro /dev/disk/by-uuid/d82e3d89-3156-4484-bde2-ccc534ca440b /mnt/dent
	! mountpoint /mnt/dent && exit 1
	#sudo -n mount -o remount,ro /mnt/dent
	
	
	_messagePlain_nominal 'attempt: copy: hint'
	#sudo -n dd if=/dev/zero of=/dev/disk/by-uuid/469457fc-293f-46ec-92da-27b5d0c36b17 bs=1M
	if type -p 'pigz' > /dev/null 2>&1 || type -p 'gzip' > /dev/null 2>&1
	then
		sudo -n gzip -d -c /mnt/dent/hint_bak.gz | sudo -n dd of=/dev/disk/by-uuid/469457fc-293f-46ec-92da-27b5d0c36b17 bs=1M
	else
		sudo cat /mnt/dent/hint_bak | sudo -n dd of=/dev/disk/by-uuid/469457fc-293f-46ec-92da-27b5d0c36b17 bs=1M
	fi
	sync
	
	
	
	
	#_messagePlain_nominal 'attempt: mount: rw: bulk'
	#sudo -n mkdir -p /mnt/bulk
	#! mountpoint /mnt/bulk && sudo -n mount -o ro /dev/disk/by-uuid/f1edb7fb-13b1-4c97-91d2-baf50e6d65d8 /mnt/bulk
	#! mountpoint /mnt/bulk && exit 1
	#sudo -n mount -o remount,rw /mnt/bulk
	
	#_messagePlain_nominal 'attempt: copy: bulk'
	#sudo -n mkdir -p /mnt/dent/bulk_bak
	#[[ ! -e /mnt/dent/bulk_bak ]] && exit 1
	#[[ ! -d /mnt/dent/bulk_bak ]] && exit 1
	
	#sudo -n rsync -ax --delete /mnt/dent/bulk_bak/. /mnt/bulk/.
	
	
	
	_messagePlain_nominal 'attempt: umount: dent'
	sudo -n mount -o remount,ro /mnt/dent
	sync
	sudo -n umount /mnt/dent
	sync
	
	_messagePlain_request 'request: consider restoring /mnt/bulk (not overwritten by default)'
	
	_messageNormal 'done: _____special_live_dent_restore'
	return 0
}








#Override (Program).

#Override, cygwin.

# WARNING: Multiple reasons to instead consider direct detection by other commands -  ' uname -a | grep -i cygwin > /dev/null 2>&1 ' , ' [[ -e '/cygdrive' ]] ' , etc .
_if_cygwin() {
	if uname -a 2>/dev/null | grep -i cygwin > /dev/null 2>&1
	then
		return 0
	fi
	return 1
}


# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
#/usr/local/bin:/usr/bin:/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:/usr/bin:/usr/lib/lapack:/cygdrive/x:/cygdrive/x/_bin:/cygdrive/x/_bundle:/opt/ansible/bin:/opt/nodejs/current:/opt/testssl:/home/root/bin
#/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:/usr/bin:/usr/lib/lapack:/cygdrive/x:/cygdrive/x/_bin:/cygdrive/x/_bundle:/opt/ansible/bin:/opt/nodejs/current:/opt/testssl:/home/root/bin
if [[ "$PATH" == "/cygdrive"* ]] || ( [[ "$PATH" == *"/cygdrive"* ]] && [[ "$PATH" != *"/usr/local/bin"* ]] )
then
	if [[ "$PATH" == "/cygdrive"* ]]
	then
		export PATH=/usr/local/bin:/usr/bin:/bin:"$PATH"
	fi
	
	[[ "$PATH" != *"/usr/local/bin"* ]] && export PATH=/usr/local/bin:"$PATH"
	[[ "$PATH" != *"/usr/bin"* ]] && export PATH=/usr/bin:"$PATH"
	[[ "$PATH" != *"/bin:"* ]] && export PATH=/bin:"$PATH"
fi


# ATTENTION: Workaround - Cygwin Portable - append MSW PATH if reasonable.
# NOTICE: Also see '_test-shell-cygwin' .
# MSWEXTPATH lengths up to 33, 38, are known reasonable values.
# As of 2025-05-20 , a development system, VSCode PowerShell terminal, has been known to impose 45 such lines on MSWEXTPATH , other PowerShell terminal imposed 41 such lines. Limit of 44 lines at the time was exceeded.
if [[ "$MSWEXTPATH" != "" ]] && ( [[ "$PATH" == *"/cygdrive"* ]] || [[ "$PATH" == "/cygdrive"* ]] ) && [[ "$convertedMSWEXTPATH" == "" ]] && _if_cygwin
then
        if [[ $(echo "$MSWEXTPATH" | grep -o ';' | wc -l | tr -dc '0-9') -le 99 ]] && [[ $(echo "$PATH" | grep -o ':' | wc -l | tr -dc '0-9') -le 99 ]]
        then
                export convertedMSWEXTPATH=$(cygpath -p "$MSWEXTPATH")
                export PATH=/usr/bin:"$convertedMSWEXTPATH":"$PATH"
        fi
fi



# ATTENTION: Workaround - Cygwin Portable - change directory to current directory as detected by 'ubcp.cmd' .
if [[ "$CWD" != "" ]] && [[ "$cygwin_CWD_onceOnly_done" != 'true' ]] && uname -a | grep -i cygwin > /dev/null 2>&1
then
	! cd "$CWD" && exit 1
	export cygwin_CWD_onceOnly_done='true'
fi



# ATTENTION: Workaround - Cygwin Portable - symlink home directory if nonexistent .
# https://stackoverflow.com/questions/39551802/how-to-fix-cygwin-using-wrong-ssh-directory-no-matter-what-i-do
#  'OpenSSH never honors $HOME.'
# https://sourceware.org/legacy-ml/cygwin/2016-06/msg00404.html
#  'OpenSSH never honors $HOME.'
# https://cygwin.com/cygwin-ug-net/ntsec.html
if [[ "$HOME" == "/home/root" ]] && [[ ! -e /home/"$USER" ]] && _if_cygwin
then
	ln -s --no-target-directory "/home/root" /home/"$USER" > /dev/null 2>&1
fi



# Forces Cygwin symlinks to best compatibility. Should be set by default elsewhere. Use sparingly only if necessary (eg. _setup_ubcp) .
_force_cygwin_symlinks() {
	! _if_cygwin && return 0
	[[ "$CYGWIN" != *"winsymlinks:lnk"* ]] && export CYGWIN="winsymlinks:lnk ""$CYGWIN"
}


# ATTENTION: User must launch "tmux" (no parameters) in a graphical Cygwin terminal.
# Launches graphical application through "tmux new-window" if available.
# https://superuser.com/questions/531787/starting-windows-gui-program-in-windows-through-cygwin-sshd-from-ssh-client
_workaround_cygwin_tmux() {
	if pgrep -u "$USER" ^tmux$ > /dev/null 2>&1
	then
		tmux new-window "$@"
		return "$?"
	fi
	
	"$@"
	return "$?"
}


# DANGER: Severely differing functionality. Intended only to stand in for "ip addr show" and similar.
if ! type ip > /dev/null 2>&1 && type 'ipconfig' > /dev/null 2>&1 && uname -a | grep -i cygwin > /dev/null 2>&1
then
	ip() {
		if [[ "$1" == "addr" ]] && [[ "$2" == "show" ]]
		then
			ipconfig
			return $?
		fi
		
		return 1
	}
fi



if _if_cygwin
then
	# ATTRIBUTION-AI: ChatGPT 4.5-preview  2025-04-11  with knowledge ubiquitous_bash, etc
	# Prioritizes native git binaries if available. Mostly a disadvantage over the Cygwin/MSW git binaries, but adds more usable git-lfs , and works surprisingly well, apparently still defaulting to: Cygwin HOME '.gitconfig' , Cygwin '/usr/bin/ssh' , correctly understanding the overrides of '_gitBest' , etc.
	#  Alternatives:
	#   git-lfs compiled for Cygwin/MSW - requires installing 'go' compiler for Cygwin/MSW
	#   git fetch commands - manual effort
	#   wrapper script to detect git lfs error and retry with subsequent separate fetch - technically possible
	#   avoid git-lfs - usually sufficient
	_override_msw_git() {
		local git_path="/cygdrive/c/Program Files/Git/cmd"
		
		# Optionally iterate through additional drive letters:
		# for drive in c ; do
		# for drive in c d e f g h i j k l m n o p q r s t u v w D E F G H I J K L M N O P Q R S T U V W ; do
		#   local git_path="/cygdrive/${drive}/Program Files/Git/cmd"
		#   if [ -d "${git_path}" ]; then
		#     break
		#   fi
		# done
		
		[ -d "$git_path" ] || return 0  # Return quietly if the git_path is not a directory

		# ATTENTION: To use with 'ops.sh' or similar if necessary, appropriate, and safe.
		export PATH_pre_override_git="$PATH"
		
		local path_entry entry IFS=':'
		local new_path=""
		
		for entry in $PATH ; do
			# Skip adding if this entry matches git_path exactly
			[ "$entry" = "$git_path" ] && continue
			
			# Append current entry to the new_path
			if [ -z "$new_path" ]; then
				new_path="$entry"
			else
				new_path="${new_path}:${entry}"
			fi
		done

		# Finally, explicitly prepend the git path
		export PATH="${git_path}:${new_path}"

		#( _messagePlain_probe_var PATH >&2 ) > /dev/null
		#( _messagePlain_probe_var PATH_pre_override_git >&2 ) > /dev/null

		# CAUTION: DANGER: MSW native git binaries can perceive 'parent directories' outside the 'root' directory provided by Cygwin, equivalent to calling git binaries through remote (eg. SSH, etc) commands to a filesystem encapsulating a ChRoot !
		#  This function limits that behavior, especially for 'ubiquitous_bash' projects with MSW installers shipping standalone 'ubcp' environments.
		_override_msw_git_CEILING() {
			# On the unusual occasion "$scriptLocal" is defined as something other than "$scriptAbsoluteFolder"/_local, the 'ubcp' directory is not expected to have been included as a standard subdirectory under any other definition of "$scriptLocal" . Since this information is only used to add redundant configuration (ie. directories are not created, etc), no issues should be possible.
			#current_script_ubcp_msw=$(cygpath -w "$scriptLocal")
			current_script_ubcp_msw=$(cygpath -w "$scriptAbsoluteFolder"/_local)
			current_script_ubcp_msw_escaped="${current_script_ubcp_msw//\\/\\\\}"
			current_script_ubcp_msw_slash="${current_script_ubcp_msw//\\/\/}"

			# ONLY for the MSW git binaries override case (if "$git_path" is not valid, this function will already return before this)
			export GIT_CEILING_DIRECTORIES="/home/root/.ubcore/ubiquitous_bash;/home/root/.ubcore;/home/root;/cygdrive;/cygdrive/d/a/ubiquitous_bash/ubiquitous_bash;/cygdrive/c/a/ubiquitous_bash/ubiquitous_bash;C:\core\infrastructure\ubcp\cygwin;C:\q\p\zCore\infrastructure\ubiquitous_bash\_local\ubcp\cygwin;C:\core\infrastructure\extendedInterface\_local\ubcp;C:\core\infrastructure\ubDistBuild\_local\ubcp"
			
			[[ "$scriptAbsoluteFolder" != "" ]] && export GIT_CEILING_DIRECTORIES="$GIT_CEILING_DIRECTORIES"';'"$current_script_ubcp_msw"
		}
		#export -f _override_msw_git_CEILING
		_override_msw_git_CEILING
	}
	# CAUTION: Early in the script for a reason! Changing the PATH drastically later has been known to cause WSL 'bash' to override Cygwin 'bash' with very obviously unpredictable results.
	#  ATTENTION: There would be a '_test' function in 'ubiquitous_bash' for this, but the state of 'wsl' which may not be installed with 'ubdist', etc, is not necessarily predictable enough for a simple PASS/FAIL .
	#if [[ "$1" != "_setupUbiquitous" ]] && [[ "$ub_under_setupUbiquitous" != "true" ]]
	#then
		_override_msw_git
		#_override_msw_git_CEILING
	#fi

	# ATTRIBUTION-AI: ChatGPT 4.5-preview  2025-04-11  with knowledge ubiquitous_bash, etc  (partially)
	# ATTRIBUTION-AI: ChatGPT 4o  2025-04-12  web search  (partially)
	# ATTRIBUTION-AI: ChatGPT o3-mini-high  2025-04-12
	_write_configure_git_safe_directory_if_admin_owned_sequence() {
		local functionEntryPWD="$PWD"

		# DUBIOUS
		local functionEntry_GIT_DIR="$GIT_DIR"
		local functionEntry_GIT_WORK_TREE="$GIT_WORK_TREE"
		local functionEntry_GIT_INDEX_FILE="$GIT_INDEX_FILE"
		local functionEntry_GIT_OBJECT_DIRECTORY="$GIT_OBJECT_DIRECTORY"
		#local functionEntry_GIT_ALTERNATE_OBJECT_DIRECTORIES="$GIT_ALTERNATE_OBJECT_DIRECTORIES"
		local functionEntry_GIT_CONFIG="$GIT_CONFIG"
		local functionEntry_GIT_CONFIG_GLOBAL="$GIT_CONFIG_GLOBAL"
		local functionEntry_GIT_CONFIG_SYSTEM="$GIT_CONFIG_SYSTEM"
		local functionEntry_GIT_CONFIG_NOSYSTEM="$GIT_CONFIG_NOSYSTEM"
		#local functionEntry_GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME"
		#local functionEntry_GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL"
		#local functionEntry_GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE"
		#local functionEntry_GIT_COMMITTER_NAME="$GIT_COMMITTER_NAME"
		#local functionEntry_GIT_COMMITTER_EMAIL="$GIT_COMMITTER_EMAIL"
		#local functionEntry_GIT_COMMITTER_DATE="$GIT_COMMITTER_DATE"
		#local functionEntry_GIT_EDITOR="$GIT_EDITOR"
		#local functionEntry_GIT_PAGER="$GIT_PAGER"
		local functionEntry_GIT_NAMESPACE="$GIT_NAMESPACE"
		local functionEntry_GIT_CEILING_DIRECTORIES="$GIT_CEILING_DIRECTORIES"
		local functionEntry_GIT_DISCOVERY_ACROSS_FILESYSTEM="$GIT_DISCOVERY_ACROSS_FILESYSTEM"
		#local functionEntry_GIT_SSL_NO_VERIFY="$GIT_SSL_NO_VERIFY"
		#local functionEntry_GIT_SSH="$GIT_SSH"
		#local functionEntry_GIT_SSH_COMMAND="$GIT_SSH_COMMAND"

		git config --global --add safe.directory "$1"
		#if [[ $(type -p git) != '/usr/bin/git' ]]
		#then
			##git config --global --add safe.directory "$2"
			git config --global --add safe.directory "$3"
			git config --global --add safe.directory "$4"
		#fi

		cd "$functionEntryPWD"

		# DUBIOUS
		GIT_DIR="$functionEntry_GIT_DIR"
		GIT_WORK_TREE="$functionEntry_GIT_WORK_TREE"
		GIT_INDEX_FILE="$functionEntry_GIT_INDEX_FILE"
		GIT_OBJECT_DIRECTORY="$functionEntry_GIT_OBJECT_DIRECTORY"
		#GIT_ALTERNATE_OBJECT_DIRECTORIES="$functionEntry_GIT_ALTERNATE_OBJECT_DIRECTORIES"
		GIT_CONFIG="$functionEntry_GIT_CONFIG"
		GIT_CONFIG_GLOBAL="$functionEntry_GIT_CONFIG_GLOBAL"
		GIT_CONFIG_SYSTEM="$functionEntry_GIT_CONFIG_SYSTEM"
		GIT_CONFIG_NOSYSTEM="$functionEntry_GIT_CONFIG_NOSYSTEM"
		#GIT_AUTHOR_NAME="$functionEntry_GIT_AUTHOR_NAME"
		#GIT_AUTHOR_EMAIL="$functionEntry_GIT_AUTHOR_EMAIL"
		#GIT_AUTHOR_DATE="$functionEntry_GIT_AUTHOR_DATE"
		#GIT_COMMITTER_NAME="$functionEntry_GIT_COMMITTER_NAME"
		#GIT_COMMITTER_EMAIL="$functionEntry_GIT_COMMITTER_EMAIL"
		#GIT_COMMITTER_DATE="$functionEntry_GIT_COMMITTER_DATE"
		#GIT_EDITOR="$functionEntry_GIT_EDITOR"
		#GIT_PAGER="$functionEntry_GIT_PAGER"
		GIT_NAMESPACE="$functionEntry_GIT_NAMESPACE"
		GIT_CEILING_DIRECTORIES="$functionEntry_GIT_CEILING_DIRECTORIES"
		GIT_DISCOVERY_ACROSS_FILESYSTEM="$functionEntry_GIT_DISCOVERY_ACROSS_FILESYSTEM"
		#GIT_SSL_NO_VERIFY="$functionEntry_GIT_SSL_NO_VERIFY"
		#GIT_SSH="$functionEntry_GIT_SSH"
		#GIT_SSH_COMMAND="$functionEntry_GIT_SSH_COMMAND"

		return 0
	}

	# ATTRIBUTION-AI: ChatGPT 4.5-preview  2025-04-11  with knowledge ubiquitous_bash, etc  (partially)
	# CAUTION: NOT sufficient to call this function only during installation (as Administrator, which is what normally causes this issue). If the user subsequently installs native 'git for Windows', additional '.gitconfig' entries are needed, with the different MSWindows native style path format.
	# Historically this was apparently at least mostly not necessary until prioritizing native git binaries (if available) instead of relying on Cygwin/MSW git binaries.
	_write_configure_git_safe_directory_if_admin_owned() {
		local current_path="$1"
		local win_path win_path_escaped win_path_slash cygwin_path
		win_path="$(cygpath -w "$current_path")"
		#cygwin_path="$(cygpath -u "$current_path")"  # explicit Cygwin POSIX path
		win_path_escaped="${win_path//\\/\\\\}"
		win_path_slash="${win_path//\\/\/}"

		# Single call to verify Administrators ownership explicitly (fast Windows API call)
		local owner_line
		owner_line="$(icacls "$win_path" 2>/dev/null)"
		if [[ "$owner_line" != *"BUILTIN\\Administrators"* ]]; then
			# Not Administrators-owned, no further action needed, immediate return
			return 0
		fi
		# Read "$HOME"/.gitconfig just once (efficient builtin file reading)
		local gitconfig_content
		if [[ -e "$HOME"/.gitconfig ]]; then
			gitconfig_content="$(< "$HOME"/.gitconfig)"

			## Check 1: Exact Windows path (C:\...)
			#if [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path"* ]]; then
				#return 0
			#fi

			## Check 2: Double-backslash-escaped Windows path (C:\\...)
			#win_path_escaped="${win_path//\\/\\\\}"
			#if [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path_escaped"* ]]; then
				#return 0
			#fi

			## Check 3: Normal-slash Windows path (C:/...)
			#win_path_slash="${win_path//\\/\/}"
			#if [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path_slash"* ]]; then
				#return 0
			#fi

			## Check 4: Original Cygwin POSIX path (/cygdrive/c/...)
			#if [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $cygwin_path"* ]]; then
				#return 0
			#fi

			#( [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path"* ]] || [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path_escaped"* ]] || [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path_slash"* ]] ) && ( [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $cygwin_path"* ]] ) && return 0

			# Slightly more performance efficient. No expected scenario in which a MSW path has been added but a UNIX path has not.
			( [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path"* ]] || [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path_escaped"* ]] || [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $win_path_slash"* ]] ) && return 0
			cygwin_path="$(cygpath -u "$current_path")"  # explicit Cygwin POSIX path
			( [[ "$gitconfig_content" == *"[safe]"* && "$gitconfig_content" == *"directory = $cygwin_path"* ]] ) && return 0
		fi

		# Explicit message clearly communicating safe-configuration action for transparency
		#echo "Administrators ownership detected; configuring git safe.directory entry."

		# perform safe git configuration exactly once after all efficient checks
		# CAUTION: Tested to create functionally identical log entries through both '/usr/bin/git' and native git binaries. Ensure that remains the case if making any changes.
		#"$scriptAbsoluteLocation" _write_configure_git_safe_directory_if_admin_owned_sequence "$cygwin_path" "$win_path_escaped" "$win_path_slash" "$win_path"
		( _write_configure_git_safe_directory_if_admin_owned_sequence "$cygwin_path" "$win_path_escaped" "$win_path_slash" "$win_path" )
	}
	# Must be later, after set global variable "$scriptAbsoluteFolder" .
	#_write_configure_git_safe_directory_if_admin_owned "$scriptAbsoluteFolder"
	
	# NOTICE: Recent versions of Cygwin seem to have replaced or omitted '/usr/bin/gpg.exe', possibly in favor of a symlink to '/usr/bin/gpg2.exe' .
	# CAUTION: This override is specifically to ensure availability of 'gpg' binary through a function, but that could have the effect of presenting an incorrect gpg2 CLI interface to software expecting a gpg1 CLI interface.
	 # In practice, Debian Linux seem to impose gpg v2 as the CLI interface for gpg - 'gpg --version' responds v2 .
	# WARNING: All of which is a good reason to always automatically prefer a specified major version binary of gpg (ie. gpg2) in other software.
	if ! type -p gpg > /dev/null && type -p gpg2 > /dev/null
	then
		gpg() {
			gpg2 "$@"
		}
	fi
	
	
	# WARNING: Since MSW/Cygwin is hardly suitable for mounting UNIX/tmpfs/ramfs/etc filesystems, 'mountpoint' 'safety checks' are merely disabled.
	mountpoint() {
		true
	}
	losetup() {
		false
	}
	
	tc() {
		false
	}
	wondershaper() {
		false
	}
	
	ionice() {
		false
	}

	# ATTENTION: Sets the priority for '_wsl' as well as 'u' shortcuts. Override with '_bashrc' or similar as desired (eg. replace 'ubdist_embedded' with some specialized 3D printer firwmare/klipper dist/OS, etc).
	_wsl() {
		local currentBin_wsl
		#currentBin_wsl=$(type -p wsl)

		currentBin_wsl="wsl"

		if ( [[ "$1" != "-"* ]] || [[ "$1" == "-u" ]] || [[ "$1" == "-e" ]] || [[ "$1" == "--exec" ]] ) && ( [[ "$1" != "-d" ]] || [[ "$2" != "-d" ]] || [[ "$3" != "-d" ]] || [[ "$4" != "-d" ]] || [[ "$5" != "-d" ]] || [[ "$6" != "-d" ]] )
		then
			if "$currentBin_wsl" --list | tr -dc 'a-zA-Z0-9\n' | grep '^ubdist' > /dev/null 2>&1
			then
				#"$currentBin_wsl" -u root -d ubdist "$@"
				"$currentBin_wsl" -d ubdist "$@"
				return
			elif "$currentBin_wsl" --list | tr -dc 'a-zA-Z0-9\n' | grep '^ubDistBuild' > /dev/null 2>&1
			then
				#"$currentBin_wsl" -u root -d ubDistBuild "$@"
				"$currentBin_wsl" -d ubDistBuild "$@"
				return
			elif "$currentBin_wsl" --list | tr -dc 'a-zA-Z0-9\n' | grep '^ubdist_embedded' > /dev/null 2>&1
			then
				#"$currentBin_wsl" -u root -d ubdist_embedded "$@"
				"$currentBin_wsl" -d ubdist_embedded "$@"
				return
			elif "$currentBin_wsl" --list | tr -dc 'a-zA-Z0-9\n' | grep '^Debian' > /dev/null 2>&1
			then
				#"$currentBin_wsl" -u root -d Debian "$@"
				"$currentBin_wsl" -d Debian "$@"
				return
			fi
			"$currentBin_wsl" "$@"
			return
		fi
		"$currentBin_wsl" "$@"
		return
	}
	#l() {
		#_wsl "$@"
	#}
	#alias l='_wsl'
	alias u='_wsl'
	
	# MSWindows native 'PowerSession' apparently does not support 'asciinema cat'.
	#alias asciinema='PowerSession'

	# Optional. Other than recording, and some issues with 'asciinema cat', pip installed 'asciinema' seems usable .
	# Use _asciinema_record to record .
	alias asciinema='wsl -d ubdist asciinema'

	#alias codex='wsl -d ubdist codex'
	alias codex='wsl -d ubdist "~/.ubcore/ubiquitous_bash/ubcore.sh" _codexBin-usr_bin_node'

	alias codexNative=$(type -P codex 2>/dev/null)
fi
	
_sudo_cygwin-if_parameter-skip2() {
	[[ "$1" == "-u" ]] && return 0
	return 1
}
_sudo_cygwin-if_parameter-skip1() {
	[[ "$1" == "-n" ]] && return 0
	[[ "$1" == "--preserve-env"* ]] && return 0
	return 1
}

# CAUTION: Fragile, at best.
# DANGER: MSW apparently does not necessarily allow 'Administrator' access to all network 'drives'. Workaround copying of obvious files is limited.
# WARNING: Most likely, after significant delay, will 'prompt' the user with a very much obstructive, and not securing very much, dialog box.
# https://stackoverflow.com/questions/4090301/root-user-sudo-equivalent-in-cygwin
# https://superuser.com/questions/812018/run-a-command-in-another-cygwin-window-and-not-exit
_sudo_cygwin_sequence() {
	_start
	
	# 'If already admin, just run the command in-line.'
	# 'This works on my Win10 machine; dunno about others.'
	if id -G | grep -q ' 544 '
	then
		"$@"
		_stop "$?"
	fi
	
	# 'cygstart/runas doesn't handle arguments with spaces correctly so create'
	# 'a script that will do so properly.'
	echo "#!/bin/bash" >> "$safeTmp"/cygwin_sudo_temp.sh

	echo "cd \"$PWD"\" >> "$safeTmp"/cygwin_sudo_temp.sh

	echo "export PATH=\"$PATH\"" >> "$safeTmp"/cygwin_sudo_temp.sh

	# No production use.
	echo "export GH_TOKEN=\"$GH_TOKEN\"" >> "$safeTmp"/cygwin_sudo_temp.sh
	echo "export INPUT_GITHUB_TOKEN=\"$INPUT_GITHUB_TOKEN\"" >> "$safeTmp"/cygwin_sudo_temp.sh
	echo "export TOKEN=\"$TOKEN\"" >> "$safeTmp"/cygwin_sudo_temp.sh

	# No production use.
	echo "export nonet=\"$nonet\"" >> "$safeTmp"/cygwin_sudo_temp.sh
	echo "export devfast=\"$devfast\"" >> "$safeTmp"/cygwin_sudo_temp.sh
	echo "export skimfast=\"$skimfast\"" >> "$safeTmp"/cygwin_sudo_temp.sh

	local currentParam1
	while _sudo_cygwin-if_parameter-skip2 "$@" || _sudo_cygwin-if_parameter-skip1 "$@"
	do
		currentParam1="$1"

		if _sudo_cygwin-if_parameter-skip2 "$currentParam1"
		then
			! shift && _messageFAIL
			! shift && _messageFAIL
			currentParam1=""
		fi

		if _sudo_cygwin-if_parameter-skip1 "$currentParam1"
		then
			! shift && _messageFAIL
			currentParam1=""
		fi
	done

	#echo 'local currentExitStatus' >> "$safeTmp"/cygwin_sudo_temp.sh
	_safeEcho_newline "$safeTmp"/_bin.bat "$@" >> "$safeTmp"/cygwin_sudo_temp.sh
	echo 'currentExitStatus=$?' >> "$safeTmp"/cygwin_sudo_temp.sh
	echo 'echo > "'"$safeTmp"'"/sequenceDone_'"$ubiquitousBashID" >> "$safeTmp"/cygwin_sudo_temp.sh
	echo 'sleep 3' >> "$safeTmp"/cygwin_sudo_temp.sh
	echo 'exit $currentExitStatus' >> "$safeTmp"/cygwin_sudo_temp.sh
	chmod u+x "$safeTmp"/cygwin_sudo_temp.sh
	
	
		
	cp "$scriptAbsoluteLocation" "$safeTmp"/
	local currentScriptBasename
	currentScriptBasename=$(basename "$scriptAbsoluteLocation")
	chmod u+x "$safeTmp"/"$currentScriptBasename"
	
	cp "$scriptLib"/ubiquitous_bash/_bin.bat "$safeTmp"/_bin.bat 2>/dev/null
	#cp /home/root/.ubcore/ubiquitous_bash/_bin.bat "$safeTmp"/_bin.bat 2>/dev/null
	cp -f "$scriptAbsoluteFolder"/_bin.bat "$safeTmp"/_bin.bat 2>/dev/null
	chmod u+x "$safeTmp"/_bin.bat

	[[ ! -e "$safeTmp"/_bin.bat ]] && _messagePlain_bad 'bad: missing: _bin.bat' && _messageFAIL && _stop 1

	if type _anchor_configure > /dev/null 2>&1
	then
		"$safeTmp"/"$currentScriptBasename" _anchor_configure "$safeTmp"/_bin.bat
	else
		_messagePlain_bad 'bad: missing: _anchor_configure'
		_messageFAIL && _stop 1
		_stop 1
	fi
	

	# 'Do it as Administrator.'
	#cygstart --action=runas "$scriptAbsoluteFolder"/_bin.bat bash
	
	if [[ "$scriptAbsoluteFolder" == "/cygdrive/c"* ]]
	then
		# WARNING: May be untested, or (especially under interactive shell) may call obsolete code.
		#cygstart --action=runas "$scriptAbsoluteFolder"/_bin.bat "$safeTmp"/cygwin_sudo_temp.sh

		cygstart --action=runas "$safeTmp"/_bin.bat "$safeTmp"/cygwin_sudo_temp.sh
	else
		cygstart --action=runas "$safeTmp"/_bin.bat "$safeTmp"/cygwin_sudo_temp.sh
	fi
	
	
	while ! [[ -e "$safeTmp"/sequenceDone_"$ubiquitousBashID" ]]
	do
		sleep 3
	done
	
	_stop "$?"
}
_sudo_cygwin() {
	"$scriptAbsoluteLocation" _sudo_cygwin_sequence "$@"
}

# CAUTION: BROKEN !
# (at least historically this did not work reliably though it may or may not be reliable now)
if _if_cygwin && type cygstart > /dev/null 2>&1
then
	sudo_cygwin() {
		#[[ "$1" == "-n" ]] && shift
		if type cygstart > /dev/null 2>&1
		then
			_sudo_cygwin "$@"
			#cygstart --action=runas "$@"
			#"$@"
			return
		fi
		
		"$@"
		return
		
		return 1
	}
	sudoc() {
		#[[ "$1" == "-n" ]] && return 1
		sudo_cygwin "$@"
	}
	alias sudo=sudoc
fi




# Calls MSW native programs from Cygwin/MSW with file parameter translation.
#_userMSW kate /etc/fstab
_userMSW() {
	if ! _if_cygwin || ! type cygpath > /dev/null 2>&1
	then
		"$@"
		return
	fi
	
	
	local currentArg
	local currentResult
	processedArgs=()
	for currentArg in "$@"
	do
		if [[ -e "$currentArg" ]] || [[ "$currentArg" == "/cygdrive/"* ]] || [[ "$currentArg" == "/home/"* ]] || [[ "$currentArg" == "/root/"* ]]
		then
			currentResult=$(cygpath -w "$currentArg")
		else
			currentResult="$currentArg"
		fi
		
		processedArgs+=("$currentResult")
	done
	
	
	"${processedArgs[@]}"
}

_discover_powershell() {
	local currentPowershellBinary
    currentPowershellBinary=$(find /cygdrive/c/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)
    [[ "$currentPowershellBinary" == "" ]] && currentPowershellBinary=$(find /cygdrive/d/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)
    [[ "$currentPowershellBinary" == "" ]] && currentPowershellBinary=$(find /cygdrive/e/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)
    [[ "$currentPowershellBinary" == "" ]] && currentPowershellBinary=$(find /cygdrive/f/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)
	
    [[ "$currentPowershellBinary" == "" ]] && currentPowershellBinary=$(find /mnt/c/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)
    [[ "$currentPowershellBinary" == "" ]] && currentPowershellBinary=$(find /mnt/d/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)
    [[ "$currentPowershellBinary" == "" ]] && currentPowershellBinary=$(find /mnt/e/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)
    [[ "$currentPowershellBinary" == "" ]] && currentPowershellBinary=$(find /mnt/f/Windows/System32/WindowsPowerShell/ -name powershell.exe 2>/dev/null | head -n 1)

	_safeEcho "$currentPowershellBinary"
	[[ "$currentPowershellBinary" != "" ]] && return 0
	return 1
}

_powershell() {
    local currentPowershellBinary
    currentPowershellBinary=$(_discover_powershell)

	#_userMSW "$currentPowershellBinary" "$@"
    "$currentPowershellBinary" "$@"
}



_discoverResource-cygwinNative-ProgramFiles-declaration-ProgramFiles() {
	local currentBinary
	currentBinary="$1"
	
	local currentBinary_functionName
	currentBinary_functionName=$(echo "$1" | tr -dc 'a-zA-Z0-9\-_')
	
	local currentExpectedSubdir
	currentExpectedSubdir="$2"
	
	local forceNativeBinary
	forceNativeBinary='false'
	
	[[ "$3" != "true" ]] && type "$currentBinary_functionName" > /dev/null 2>&1 && return 0
	
	local forceWorkaroundPrefix
	forceWorkaroundPrefix="$4"
	
	if ! type "$currentBinary_functionName" > /dev/null 2>&1 && type '/cygdrive/'"$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q"'/Program Files/'"$currentExpectedSubdir"'/'"$currentBinary".exe > /dev/null 2>&1
	then
		eval $currentBinary_functionName'() { '"$forceWorkaroundPrefix"'/cygdrive/"'"$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q"'"/"'"Program Files"'"/"'"$currentExpectedSubdir"'"/"'"$currentBinary"'".exe "$@" ; }'
		false
	fi
	
	if ! type "$currentBinary_functionName" > /dev/null 2>&1 && type '/cygdrive/'"$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q"'/Program Files (x86)/'"$currentExpectedSubdir"'/'"$currentBinary".exe > /dev/null 2>&1
	then
		eval $currentBinary_functionName'() { '"$forceWorkaroundPrefix"'/cygdrive/"'"$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q"'"/"'"Program Files (x86)"'"/"'"$currentExpectedSubdir"'"/"'"$currentBinary"'".exe "$@" ; }'
	fi
	type "$currentBinary_functionName" > /dev/null 2>&1 && export -f "$currentBinary" > /dev/null 2>&1 && return 0
	return 1
}

_discoverResource-cygwinNative-ProgramFiles-declaration-core() {
	local currentBinary
	currentBinary="$1"
	
	local currentBinary_functionName
	currentBinary_functionName=$(echo "$1" | tr -dc 'a-zA-Z0-9\-_')
	
	local currentExpectedSubdir
	currentExpectedSubdir="$2"
	
	local forceNativeBinary
	forceNativeBinary='false'
	
	[[ "$3" != "true" ]] && type "$currentBinary_functionName" > /dev/null 2>&1 && return 0
	
	local forceWorkaroundPrefix
	forceWorkaroundPrefix="$4"
	
	local currentCygdriveC_equivalent
	currentCygdriveC_equivalent=$(cygpath -S | sed 's/\/Windows\/System32//g' | sed 's/^\/cygdrive\///')
	
	if ! type "$currentBinary_functionName" > /dev/null 2>&1 && type '/cygdrive/'"$currentCygdriveC_equivalent"'/core/installations/'"$currentExpectedSubdir"'/'"$currentBinary".exe > /dev/null 2>&1
	then
		eval $currentBinary_functionName'() { '"$forceWorkaroundPrefix"'/cygdrive/"'"$currentCygdriveC_equivalent"'"/"'"core/installations"'"/"'"$currentExpectedSubdir"'"/"'"$currentBinary"'".exe "$@" ; }'
	fi
	type "$currentBinary_functionName" > /dev/null 2>&1 && return 0
	
	if ! type "$currentBinary_functionName" > /dev/null 2>&1 && type '/cygdrive/'"$currentCygdriveC_equivalent"'/core/installations/'"$currentExpectedSubdir"'/'"$currentBinary".exe > /dev/null 2>&1
	then
		eval $currentBinary_functionName'() { '"$forceWorkaroundPrefix"'/cygdrive/"'"$currentCygdriveC_equivalent"'"/"'"core/installations"'"/"'"$currentExpectedSubdir"'"/"'"$currentBinary"'".exe "$@" ; }'
	fi
	type "$currentBinary_functionName" > /dev/null 2>&1 && export -f "$currentBinary" > /dev/null 2>&1 && return 0
	return 1
}

_discoverResource-cygwinNative-ProgramFiles() {
	local currentBinary
	currentBinary="$1"
	local currentBinary_functionName
	currentBinary_functionName=$(echo "$1" | tr -dc 'a-zA-Z0-9\-_')
	[[ "$3" != "true" ]] && type "$currentBinary_functionName" > /dev/null 2>&1 && return 0
	
	local currentCygdriveC_equivalent
	currentCygdriveC_equivalent=$(cygpath -S | sed 's/\/Windows\/System32//g' | sed 's/^\/cygdrive\///')
	unset currentDriveLetter_cygwin_uk4uPhB663kVcygT0q
	export currentDriveLetter_cygwin_uk4uPhB663kVcygT0q="$currentCygdriveC_equivalent"
	_discoverResource-cygwinNative-ProgramFiles-declaration-ProgramFiles "$@"
	[[ "$3" != "true" ]] && type "$currentBinary_functionName" > /dev/null 2>&1 && return 0
	
	# ATTENTION: Configure: 'c..w' (aka. 'w..c') .
	# WARNING: Program Files at drive letters other than 'c' may not be supported now or ever. Especially other than 'c,d,e'.
	unset currentDriveLetter_cygwin_uk4uPhB663kVcygT0q
	#for currentDriveLetter_cygwin_uk4uPhB663kVcygT0q in {c..w}
	for currentDriveLetter_cygwin_uk4uPhB663kVcygT0q in {c..f}
	do
		_discoverResource-cygwinNative-ProgramFiles-declaration-ProgramFiles "$@"
		[[ "$3" != "true" ]] && type "$currentBinary_functionName" > /dev/null 2>&1 && return 0
	done
	
	_discoverResource-cygwinNative-ProgramFiles-declaration-core "$@"
	
	type "$currentBinary_functionName" > /dev/null 2>&1 && export -f "$currentBinary_functionName" > /dev/null 2>&1 && return 0
	return 1
}


_set_at_userMSW_discoverResource-cygwinNative-ProgramFiles() {
	export functionEntry_USERPROFILE="$USERPROFILE"
	export functionEntry_HOMEDRIVE="$HOMEDRIVE"
	export functionEntry_HOMEPATH="$HOMEPATH"
	
	# https://docs.oracle.com/en/virtualization/virtualbox/6.0/admin/vboxconfigdata.html
	#  'Windows: $HOME/.VirtualBox.'
	# https://en.wikipedia.org/wiki/Home_directory
	# %USERPROFILE%
	# %HOMEDRIVE%%HOMEPATH%
	# echo $USERPROFILE
	# export USERPROFILE="$USERPROFILE"'\Downloads'
	# cmd
	# echo %USERPROFILE%
	
	if [[ "$HOME" != "/root" ]] && [[ "$HOME" != "/home/root" ]] && [[ "$HOME" != "/home/""$USER" ]]
	then
		export USERPROFILE=$(cygpath -w "$HOME")
		export HOMEDRIVE=$(echo "$USERPROFILE" | head -c 2)
		export HOMEPATH=$(echo "$USERPROFILE" | tail -c +3)
	fi
	
	# WARNING: Cygwin/MSW HOME directory redirection may be disabled for future versions of 'ubiquitous bash'.
	if [[ "$USERPROFILE" == "$functionEntry_USERPROFILE" ]] && [[ "$VBOX_USER_HOME_short" != "" ]]
	then
		export USERPROFILE=$(cygpath -w "$VBOX_USER_HOME_short")
		export HOMEDRIVE=$(echo "$VBOX_USER_HOME_short" | head -c 2)
		export HOMEPATH=$(echo "$VBOX_USER_HOME_short" | tail -c +3)
	fi
	
	export functionEntry_VBOXID="$VBOXID"
	export functionEntry_vBox_vdi="$vBox_vdi"
	export functionEntry_vBoxInstanceDir="$vBoxInstanceDir"
	export functionEntry_VBOX_ID_FILE="$VBOX_ID_FILE"
	export functionEntry_VBOX_USER_HOME="$VBOX_USER_HOME"
	export functionEntry_VBOX_USER_HOME_local="$VBOX_USER_HOME_local"
	export functionEntry_VBOX_USER_HOME_short="$VBOX_USER_HOME_short"
	export functionEntry_VBOX_IPC_SOCKETID="$VBOX_IPC_SOCKETID"
	export functionEntry_VBoxXPCOMIPCD_PIDfile="$VBoxXPCOMIPCD_PIDfile"
	
	[[ -e "$VBOXID" ]] && export VBOXID=$(cygpath -w "$VBOXID")
	[[ -e "$vBox_vdi" ]] && export vBox_vdi=$(cygpath -w "$vBox_vdi")
	[[ -e "$vBoxInstanceDir" ]] && export vBoxInstanceDir=$(cygpath -w "$vBoxInstanceDir")
	[[ -e "$VBOX_ID_FILE" ]] && export VBOX_ID_FILE=$(cygpath -w "$VBOX_ID_FILE")
	[[ -e "$VBOX_USER_HOME" ]] && export VBOX_USER_HOME=$(cygpath -w "$VBOX_USER_HOME")
	[[ -e "$VBOX_USER_HOME_local" ]] && export VBOX_USER_HOME_local=$(cygpath -w "$VBOX_USER_HOME_local")
	[[ -e "$VBOX_USER_HOME_short" ]] && export VBOX_USER_HOME_short=$(cygpath -w "$VBOX_USER_HOME_short")
	[[ -e "$VBOX_IPC_SOCKETID" ]] && export VBOX_IPC_SOCKETID=$(cygpath -w "$VBOX_IPC_SOCKETID")
	[[ -e "$VBoxXPCOMIPCD_PIDfile" ]] && export VBoxXPCOMIPCD_PIDfile=$(cygpath -w "$VBoxXPCOMIPCD_PIDfile")
}

_setFunctionEntry_at_userMSW_discoverResource-cygwinNative-ProgramFiles() {
	export USERPROFILE="$functionEntry_USERPROFILE"
	export HOMEDRIVE="$functionEntry_HOMEDRIVE"
	export HOMEPATH="$functionEntry_HOMEPATH"
	
	export VBOXID="$functionEntry_VBOXID"
	export vBox_vdi="$functionEntry_vBox_vdi"
	export vBoxInstanceDir="$functionEntry_vBoxInstanceDir"
	export VBOX_ID_FILE="$functionEntry_VBOX_ID_FILE"
	export VBOX_USER_HOME="$functionEntry_VBOX_USER_HOME"
	export VBOX_USER_HOME_local="$functionEntry_VBOX_USER_HOME_local"
	export VBOX_USER_HOME_short="$functionEntry_VBOX_USER_HOME_short"
	export VBOX_IPC_SOCKETID="$functionEntry_VBOX_IPC_SOCKETID"
	export VBoxXPCOMIPCD_PIDfile="$functionEntry_VBoxXPCOMIPCD_PIDfile"
}

_prepare_at_userMSW_discoverResource-cygwinNative-ProgramFiles() {
	mkdir -p "$HOME"
	
	_set_at_userMSW_discoverResource-cygwinNative-ProgramFiles "$@"
}


#_at_userMSW_discoverResource-cygwinNative-ProgramFiles VBoxManage Oracle/VirtualBox false
_at_userMSW_discoverResource-cygwinNative-ProgramFiles() {
	_at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles "$@"
}

# WARNING: Output of 'probe' messages may interfere if program (eg. VBoxManage) output is expected not to include such messages.
#_at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles 'kate' 'Kate/bin' false
#_at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles VBoxManage Oracle/VirtualBox false
_at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles() {
	if declare -f orig_"$1" > /dev/null 2>&1
	then
		_messagePlain_probe 'exists: override: '"$1"
		return 0
	fi
	
	unset "$1"
	_discoverResource-cygwinNative-ProgramFiles "$1" "$2" "$3"
	
	! type "$1" > /dev/null 2>&1 && return 1
	
	
	# https://stackoverflow.com/questions/1203583/how-do-i-rename-a-bash-function
	eval orig_"$(declare -f ""$1"")"
	
	unset "$1"
	eval "$1"'() { _prepare_at_userMSW_discoverResource-cygwinNative-ProgramFiles ; _userMSW _messagePlain_probe_cmd orig_'"$1"' "$@" ; _setFunctionEntry_at_userMSW_discoverResource-cygwinNative-ProgramFiles ; }'
}


_ops_cygwinOverride_allDisks() {
	# DANGER: Calling a script from every connected Cygwin/MSW drive arguably causes obvious problems, although any device or network directly connected to any MSW machine inevitably entails such risks.
	# WARNING: Looping through {w..c} completely may impose delays sufficient to break "_test_selfTime", "_test_broadcastPipe_page", etc, if extremely slow storage is attached.
	# ATTENTION: Configure: 'w..c' (aka. 'c..w') .
	unset currentDriveLetter_cygwin_uk4uPhB663kVcygT0q
	for currentDriveLetter_cygwin_uk4uPhB663kVcygT0q in {w..c}
	do
		# WARNING: May require export of functions!
		[[ -e /cygdrive/$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q ]] && [[ -e /cygdrive/$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q/ops-cygwin.sh ]] && . /cygdrive/$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q/ops-cygwin.sh
	done
	unset currentDriveLetter_cygwin_uk4uPhB663kVcygT0q
}

# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
[[ "$profileScriptLocation_new" == 'true' ]] && echo -n '.'

if [[ -e /cygdrive ]] && _if_cygwin
then
	# WARNING: Reduces incidents of extremely slow storage attachment from breaking "_test_selfTime", "_test_broadcastPipe_page", etc, at risks of not recognizing newly installed 'native' programs for up to 20minutes .
	export cygwinOverride_measureDateB=$(date +%s%N | cut -b1-13)
	[[ "$cygwinOverride_measureDateA" == "" ]] && export cygwinOverride_measureDateA=$(bc <<< "$cygwinOverride_measureDateB - 900000000" | tr -dc '0-9')
	
	# WARNING: Experiment without checking checksum to ensure functions are exported correctly!
	if [[ $(bc <<< "$cygwinOverride_measureDateB - $cygwinOverride_measureDateA" | tr -dc '0-9') -gt 1200000 ]] || [[ "$ub_setScriptChecksum_contents_cygwinOverride" != "$ub_setScriptChecksum_contents" ]]
	then
		export cygwinOverride_measureDateA=$(date +%s%N | cut -b1-13)
		export ub_setScriptChecksum_contents_cygwinOverride="$ub_setScriptChecksum_contents"
		
		
		_discoverResource-cygwinNative-ProgramFiles 'ykman' 'Yubico/YubiKey Manager' false

		# For efficiency, do not search locations other than ' C:\ ' (aka. '/cygdrive/c' ).
		[[ -e '/cygdrive/c/Program Files/Yubico/Yubico PIV Tool/bin/yubico-piv-tool.exe' ]] && _discoverResource-cygwinNative-ProgramFiles 'yubico-piv-tool' 'Yubico/Yubico PIV Tool/bin' false
		
		
		# WARNING: Prefer to avoid 'nmap' for Cygwin/MSW .
		#_discoverResource-cygwinNative-ProgramFiles 'nmap' 'Nmap' false
		
		_discoverResource-cygwinNative-ProgramFiles 'qalc' 'Qalculate' false
		
		
		# WARNING: CAUTION: DANGER: UNIX EOL *MANDATORY* !
		[[ -e "$scriptAbsoluteFolder"/ops-cygwin.sh ]] && . "$scriptAbsoluteFolder"/ops-cygwin.sh
		
		# export ubiquitousBashID=uk4uPhB663kVcygT0q
		unset currentDriveLetter_cygwin_uk4uPhB663kVcygT0q
		export currentDriveLetter_cygwin_uk4uPhB663kVcygT0q=$(cygpath -S | sed 's/\/Windows\/System32//g' | sed 's/^\/cygdrive\///')
		[[ -e /cygdrive/$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q ]] && [[ -e /cygdrive/$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q/ops-cygwin.sh ]] && . /cygdrive/$currentDriveLetter_cygwin_uk4uPhB663kVcygT0q/ops-cygwin.sh
		
		#_ops_cygwinOverride_allDisks "$@"
		
		unset currentDriveLetter_cygwin_uk4uPhB663kVcygT0q
		
		
		
		# CAUTION: Performance - such '_discoverResource' functions are time consuming . If reasonable, instead call only from functions as necessary (eg. as part of '_userVBox') .
		# ATTENTION: Expect 0.500s for any program which is not found at 'C:\Program Files' or similar, and 0.200s for any program which is found quickly.
		# Other inefficiencies of Cygwin are usually more substantial if only a few entries are here.
		
		
		# WARNING: Native 'vncviewer.exe' is a GUI app, and cannot be launched directly from Cygwin SSH server.
		_discoverResource-cygwinNative-ProgramFiles 'vncviewer' 'TigerVNC' false '_workaround_cygwin_tmux '
		
		#_discoverResource-cygwinNative-ProgramFiles 'kate' 'Kate/bin' false
		
		
		
		
		
		_at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles 'kate' 'Kate/bin' false > /dev/null 2>&1
	fi
	
	export override_cygwin_vncviewer="true"

	kwrite() {
		kate -n "$@"
	}

	code() {
		local current_workdir
		#current_workdir=$(_getAbsoluteFolder "$1")
		current_workdir=$(_searchBaseDir "$@")
		current_workdir=$(cygpath -w "$current_workdir")


		local currentArg
		local currentResult
		processedArgs=()
		for currentArg in "$@"
		do
			if [[ -e "$currentArg" ]] || [[ "$currentArg" == "/cygdrive/"* ]] || [[ "$currentArg" == "/home/"* ]] || [[ "$currentArg" == "/root/"* ]]
			then
				currentResult=$(cygpath -w "$currentArg")
			else
				currentResult="$currentArg"
			fi
			
			processedArgs+=("$currentResult")
		done

		"$(type -P code)" --new-window "${processedArgs[@]}" --new-window "$current_workdir"
	}

	_aria2c_cygwin_overide() {
		if _safeEcho_newline "$@" | grep '\--async-dns' > /dev/null
		then
			aria2c "$@"
			return
		else
			aria2c --async-dns=false "$@"
			return
		fi
	}
	alias aria2c=_aria2c_cygwin_overide

	##! type -p wslg
	#[[ -e '/cygdrive/c/WINDOWS/system32/wslg.exe' ]] && wsl() { '/cygdrive/c/WINDOWS/system32/wslg.exe' "$@" ; }
	[[ -e '/cygdrive/c/Program Files/WSL/wslg.exe' ]] && wslg() { '/cygdrive/c/Program Files/WSL/wslg.exe' "$@" ; } && wslg.exe() { wslg "$@" ; }
	##! type -p wsl
	#[[ -e '/cygdrive/c/WINDOWS/system32/wsl.exe' ]] && wsl() { '/cygdrive/c/WINDOWS/system32/wsl.exe' "$@" ; }
	[[ -e '/cygdrive/c/Program Files/WSL/wsl.exe' ]] && wsl() { '/cygdrive/c/Program Files/WSL/wsl.exe' "$@" ; } && wsl.exe() { wsl "$@" ; }
fi

# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
[[ "$profileScriptLocation_new" == 'true' ]] && echo -n '.'







_discoverResource-cygwinNative-nmap() {
	type nmap > /dev/null 2>&1 && return 0
	# WARNING: Prefer to avoid 'nmap' for Cygwin/MSW .
	_if_cygwin && _discoverResource-cygwinNative-ProgramFiles 'nmap' 'Nmap' false
}





_setup_ubiquitousBash_cygwin_procedure_root() {
	local cygwinMSWdesktopDir
	local cygwinMSWmenuDir
	
	cygwinMSWdesktopDir=$(cygpath -u -a -A -D)
	cygwinMSWmenuDir=$(cygpath -u -a -A -P)
	
	mkdir -p "$cygwinMSWdesktopDir"
	mkdir -p "$cygwinMSWmenuDir"/ubiquitous_bash
	
	cp "$scriptAbsoluteFolder"/_bash.bat "$cygwinMSWdesktopDir"/
	cp "$scriptAbsoluteFolder"/_bash.bat "$cygwinMSWmenuDir"/ubiquitous_bash/
	
	
	cygwinMSWdesktopDir=$(cygpath -u -a -D)
	cygwinMSWmenuDir=$(cygpath -u -a -P)
	
	chown -R "$USER":"$USER" "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash > /dev/null 2>&1
	chown -R "$USER":None "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash
	
	chown "$USER":"$USER" "$cygwinMSWdesktopDir"/_bash.bat > /dev/null 2>&1
	chown "$USER":None "$cygwinMSWdesktopDir"/_bash.bat
	chown -R "$USER":"$USER" "$cygwinMSWmenuDir"/ubiquitous_bash/ > /dev/null 2>&1
	chown -R "$USER":None "$cygwinMSWmenuDir"/ubiquitous_bash/
}

_setup_ubiquitousBash_cygwin_procedure() {
	#/cygdrive/c/q/p/zCore/infrastructure/ubiquitous_bash/ubiquitous_bash.sh _setupUbiquitous
	[[ "$scriptAbsoluteFolder" != '/cygdrive'* ]] && _stop 1
	
	_messagePlain_nominal 'init: _setup_ubiquitousBash_cygwin'
	
	local currentCygdriveC_equivalent
	currentCygdriveC_equivalent="$1"
	[[ "$currentCygdriveC_equivalent" == "" ]] && currentCygdriveC_equivalent=$(cygpath -S | sed 's/\/Windows\/System32//g')
	[[ "$1" == "/" ]] && currentCygdriveC_equivalent=$(echo "$PWD" | sed 's/\(\/cygdrive\/[a-zA-Z]*\).*/\1/')
	
	mkdir -p "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash
	cd "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash
	
	cp "$scriptAbsoluteFolder"/ubiquitous_bash.sh "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/lean.sh "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/ubcore.sh "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	cp "$scriptAbsoluteFolder"/lean.py "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	#cp "$scriptAbsoluteFolder"/_bash "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_bash.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	#cp "$scriptAbsoluteFolder"/_bin "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_bin.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	cp "$scriptAbsoluteFolder"/_test "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_test.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	cp "$scriptAbsoluteFolder"/_true "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_true.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	cp "$scriptAbsoluteFolder"/_false "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_false.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	cp "$scriptAbsoluteFolder"/_anchor "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_anchor.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_setup_ubcp.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	cp "$scriptAbsoluteFolder"/_setupUbiquitous.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	cp "$scriptAbsoluteFolder"/_setupUbiquitous_nonet.bat "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	cp "$scriptAbsoluteFolder"/fork "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/
	
	
	cp "$scriptAbsoluteFolder"/package.tar.xz "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/ > /dev/null 2>&1
	
	
	
	mkdir -p "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp
	
	cp -a "$scriptLocal"/ubcp/_upstream "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	cp -a "$scriptLocal"/ubcp/overlay "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	cp "$scriptLocal"/ubcp/.gitignore "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	cp "$scriptLocal"/ubcp/agpl-3.0.txt "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	cp "$scriptLocal"/ubcp/cygwin-portable.cmd "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	cp "$scriptLocal"/ubcp/cygwin-portable-updater.cmd "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	cp "$scriptLocal"/ubcp/gpl-2.0.txt "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	cp "$scriptLocal"/ubcp/gpl-3.0.txt "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	cp "$scriptLocal"/ubcp/license.txt "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	cp "$scriptLocal"/ubcp/README.md "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	cp "$scriptLocal"/ubcp/ubcp.cmd "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	cp "$scriptLocal"/ubcp/ubcp_rename-to-enable.cmd "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	cp "$scriptLocal"/ubcp/cygwin-portable-installer-config.cmd  "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	cp "$scriptLocal"/ubcp/ubcp-cygwin-portable-installer.cmd "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/_local/ubcp/
	
	
	
	
	cygwinMSWdesktopDir=$(cygpath -u -a -A -D)
	cygwinMSWmenuDir=$(cygpath -u -a -A -P)
	
	mkdir -p "$cygwinMSWdesktopDir"
	mkdir -p "$cygwinMSWmenuDir"/ubiquitous_bash
	
	cp "$scriptAbsoluteFolder"/_bash.bat "$cygwinMSWdesktopDir"/
	cp "$scriptAbsoluteFolder"/_bash.bat "$cygwinMSWmenuDir"/ubiquitous_bash/
	
	
	
	local cygwinMSWdesktopDir
	local cygwinMSWmenuDir
	cygwinMSWdesktopDir=$(cygpath -u -a -D)
	cygwinMSWmenuDir=$(cygpath -u -a -P)
	
	mkdir -p "$cygwinMSWdesktopDir"
	mkdir -p "$cygwinMSWmenuDir"/ubiquitous_bash
	
	cp "$scriptAbsoluteFolder"/_bash.bat "$cygwinMSWdesktopDir"/
	cp "$scriptAbsoluteFolder"/_bash.bat "$cygwinMSWmenuDir"/ubiquitous_bash/
	
	
	
	chown -R "$USER":"$USER" "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash > /dev/null 2>&1
	chown -R "$USER":None "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash
	
	chown "$USER":"$USER" "$cygwinMSWdesktopDir"/_bash.bat > /dev/null 2>&1
	chown "$USER":None "$cygwinMSWdesktopDir"/_bash.bat
	chown -R "$USER":"$USER" "$cygwinMSWmenuDir"/ubiquitous_bash/ > /dev/null 2>&1
	chown -R "$USER":None "$cygwinMSWmenuDir"/ubiquitous_bash/
	
	
	#sudo -n "$scriptAbsoluteLocation" _setup_ubiquitousBash_cygwin_procedure_root "$@"
	
	
	# ATTENTION: NOTICE: Any installer for developers which relies on unpacking directories to '/core/infrastructure' must also add this to '/' .
	# Having '_bash.bat' at '/' normally allows developers to get a bash prompt from both 'CMD' and 'PowerShell' terminal windows by '/_bash' command.
	cp "$scriptAbsoluteFolder"/_bash.bat "$currentCygdriveC_equivalent"/


	# ATTENTION: Bad idea. UNIX style line endings have been tested compatible with: cmd/MSWindows, Cygwin/MSW (bash), ubdist/WSL2. Presumably also compatible with UNIX/Linux .
	#unix2dos "$currentCygdriveC_equivalent"/core/infrastructure/ubiquitous_bash/*.bat
	#unix2dos "$currentCygdriveC_equivalent"/_bash.bat

	#unix2dos "$cygwinMSWmenuDir"/ubiquitous_bash/_bash.bat
	#unix2dos "$cygwinMSWdesktopDir"/_bash.bat
	
	
	_messagePlain_good 'done: _setup_ubiquitousBash_cygwin: lean'
	sleep 1
}


_setup_ubiquitousBash_cygwin() {
	"$scriptAbsoluteLocation" _setup_ubiquitousBash_cygwin_procedure "$@"
}


_report_setup_ubcp() {
	local currentCygdriveC_equivalent
	currentCygdriveC_equivalent="$1"
	[[ "$currentCygdriveC_equivalent" == "" ]] && currentCygdriveC_equivalent=$(cygpath -S | sed 's/\/Windows\/System32//g')
	[[ "$1" == "/" ]] && currentCygdriveC_equivalent=$(echo "$PWD" | sed 's/\(\/cygdrive\/[a-zA-Z]*\).*/\1/')


	mkdir -p "$currentCygdriveC_equivalent"/core/infrastructure/
	#cd "$currentCygdriveC_equivalent"/core/infrastructure/


	find /bin/ /usr/bin/ /sbin/ /usr/sbin/ | tee "$currentCygdriveC_equivalent"/core/infrastructure/ubcp-binReport > /dev/null
	find /home/root/ | tee "$currentCygdriveC_equivalent"/core/infrastructure/ubcp-homeReport > /dev/null


	apt-cyg show | cut -f1 -d\ | tail -n +2 | tee "$currentCygdriveC_equivalent"/core/infrastructure/ubcp-packageReport > /dev/null
}


_setup_ubcp_procedure() {
	_messagePlain_nominal 'init: _setup_ubcp_procedure'
	! uname -a | grep -i cygwin > /dev/null 2>&1 && _stop 1
	
	tskill ssh-pageant > /dev/null 2>&1
	
	local currentCygdriveC_equivalent
	currentCygdriveC_equivalent="$1"
	[[ "$currentCygdriveC_equivalent" == "" ]] && currentCygdriveC_equivalent=$(cygpath -S | sed 's/\/Windows\/System32//g')
	[[ "$1" == "/" ]] && currentCygdriveC_equivalent=$(echo "$PWD" | sed 's/\(\/cygdrive\/[a-zA-Z]*\).*/\1/')
	
	export safeToDeleteGit="true"
	if [[ -e "$currentCygdriveC_equivalent"/core/infrastructure/ubcp ]]
	then
		# DANGER: Not only does this use 'rm -rf' without sanity checking, the behavior is undefined if this ubcp installation has been used to start this script!
		#[[ -e "$currentCygdriveC_equivalent"/core/infrastructure/ubcp ]] && rm -rf "$currentCygdriveC_equivalent"/core/infrastructure/ubcp
		
		_messageError 'FAIL: ubcp already installed locally and must be deleted prior to script!'
		sleep 10
		_stop 1
		exit 1
		return 1
	fi
	
	
	
	
	
	#cd "$scriptLocal"/
	
	mkdir -p "$currentCygdriveC_equivalent"/core/infrastructure/
	cd "$currentCygdriveC_equivalent"/core/infrastructure/
	
	#tar -xvf "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.gz
	#tar -xvf "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.xz

	if [[ "$skimfast" != "true" ]]
	then
		cat "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.flx | lz4 -d -c | tar -xvf -
	else
		cat "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.flx | lz4 -d -c | tar -xf -
		#tar -xf "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.flx
	fi
	
	_messagePlain_good 'done: _setup_ubcp_procedure: ubcp'
	sleep 10
	
	cd "$outerPWD"
}



# CAUTION: Do NOT hook to '_setup' .
# WARNING: ATTENTION: NOTICE: No production use. Developer feature.
# Highly irregular accommodation for usage of 'ubiquitous_bash' through 'ubcp' (cygwin portable) compatibility layer through MSW network drive (especially '_userVBox' MSW guest network drive) .
# WARNING: May require 'administrator' privileges under MSW. However, it may be better for this directory to be 'owned' by the 'primary' 'user' account. Particularly considering the VR/gaming/CAD software that remains 'exclusive' to MSW is 'legacy' software which for both licensing and technical reasons may be inherently incompatible with 'multi-user' access.
# WARNING: MSW 'administrator' 'privileges' may break 'ubcp' .
_setup_ubcp() {
	_force_cygwin_symlinks
	
	# WARNING: May break if 'mitigation' has not been applied!
	#! [[ -e "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.gz ]] && 
	#! [[ -e "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.xz ]] && 
	if ! [[ -e "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.flx ]] && [[ -e "$scriptLocal"/ubcp/cygwin ]]
	then
		export ubPackage_enable_ubcp='true'
		"$scriptAbsoluteLocation" _package_procedure-cygwinOnly
	fi
	
	"$scriptAbsoluteLocation" _setup_ubcp_procedure "$1"
	"$scriptAbsoluteLocation" _setup_ubiquitousBash_cygwin_procedure "$1"

	"$scriptAbsoluteLocation" _report_setup_ubcp "$1"
}






_mitigate-ubcp_rewrite_procedure() {
	[[ "$skimfast" != "true" ]] && _messagePlain_nominal 'init: _mitigate-ubcp_rewrite_procedure'
	[[ "$currentPWD" != "" ]] && cd "$currentPWD"
	local currentRoot=$(_getAbsoluteLocation "$PWD")
	
	local currentLink="$1"
	local currentLinkFile=$(basename "$1" )
	local currentLinkFolder=$(dirname "$1")
	currentLinkFolder=$(_getAbsoluteLocation "$currentLinkFolder")
	
	local currentLinkDirective=$(readlink "$1")
	
	
	[[ "$skimfast" != "true" ]] && _messagePlain_probe_var currentRoot
	[[ "$skimfast" != "true" ]] && _messagePlain_probe_var currentLink
	[[ "$skimfast" != "true" ]] && _messagePlain_probe_var currentLinkFile
	[[ "$skimfast" != "true" ]] && _messagePlain_probe_var currentLinkFolder
	[[ "$skimfast" != "true" ]] && _messagePlain_probe_var currentLinkDirective
	
	[[ "$currentLinkDirective" == '/proc/'* ]] && return 0
	[[ "$currentLinkDirective" == '/dev/'* ]] && return 0
	
	
	
	local currentRelativeRoot
	local currentLinkFolder_eval
	
	local currentDots='..'
	
	local currentMatch=false
	local currentIterations=0
	
	if [[ "$currentLinkFolder" == "$currentRoot" ]]
	then
		currentRelativeRoot='.'
		currentMatch='true'
	else
		while [[ "$currentMatch" == 'false' ]] && [[ "$currentIterations" -lt 14 ]]
		do
			[[ "$skimfast" != "true" ]] && _messagePlain_probe "$currentLinkFolder"/"$currentDots"
			currentLinkFolder_eval=$(_getAbsoluteLocation "$currentLinkFolder"/"$currentDots")
			[[ "$currentLinkFolder_eval" == "$currentRoot" ]] && currentMatch='true'
			
			if [[ "$currentMatch" == 'true' ]]
			then
				currentRelativeRoot="$currentDots"
			elif [[ "$currentMatch" == 'false' ]]
			then
				currentDots='../'"$currentDots"
				let currentIterations="$currentIterations"+1
			fi
		done
	fi
	
	
	
	
	[[ "$skimfast" != "true" ]] && _messagePlain_probe_var currentRelativeRoot
	
	
	local processedLinkDirective
	
	if [[ "$currentLinkDirective" == '/'* ]]
	then
		processedLinkDirective="$currentRelativeRoot""$currentLinkDirective"
		
	fi
	
	[[ "$skimfast" != "true" ]] && _messagePlain_probe_var processedLinkDirective
	
	
	
	if [[ "$currentLinkDirective" == '/'* ]]
	then
		cd "$currentLinkFolder"
		
		[[ "$skimfast" != "true" ]] && ls -l "$processedLinkDirective"
		
		
		# ATTENTION: Forces scenario '2'!
		# CAUTION: Three possible scenarios to consider.
		# 2) Symlinks rewritten to '/bin'. Links now pointing to '/bin' should return files when retrieved through network drive, without this link.
		# In any case, Cygwin will not be managing this directory .
		if [[ "$mitigate_ubcp_modifySymlink" == 'true' ]]
		then
			if [[ "$currentLinkDirective" == '/usr/bin/'* ]]
			then
				processedLinkDirective="${processedLinkDirective/'/usr/bin/'/'/bin/'}"
			fi
		fi
		
		[[ -e "$processedLinkDirective" ]] && rm -f "$currentLinkFolder"/"$currentLinkFile"
		
		ln -sf "$processedLinkDirective" "$currentLinkFolder"/"$currentLinkFile"
		
		[[ "$skimfast" != "true" ]] && ls -ld "$currentLinkFolder"/"$currentLinkFile"
		[[ "$skimfast" != "true" ]] && [[ -d "$currentLinkFolder"/"$currentLinkFile" ]] && ls -l "$currentLinkFolder"/"$currentLinkFile"
		
		#rm -f "$currentLink"
		##currentLink=$(_getAbsoluteLocation "$currentLink)
		##cd "$currentLinkFolder"
		#ln -sf "$currentLinkDirective" "$currentLink"
		# ... replace symlink with file if not also a symlink
		
		cd "$outerPWD"
	fi
	
	# ATTENTION: Forces scenario '3'!
	# CAUTION: Three possible scenarios to consider.
	# 3) Symlinks replaced. No links, files only.
	if [[ "$mitigate_ubcp_replaceSymlink" == 'true' ]]
	then
		cd "$currentLinkFolder"
		
		[[ "$skimfast" != "true" ]] && ls -ld "$currentLinkFolder"/"$currentLinkFile"
		
		
		
		[[ "$skimfast" != "true" ]] && _messagePlain_nominal 'directive: replace: true'
		cp -L -R --preserve=all "$currentLinkFolder"/"$currentLinkFile" "$currentLinkFolder"/"$currentLinkFile".replace
		rm -f "$currentLinkFolder"/"$currentLinkFile"
		mv "$currentLinkFolder"/"$currentLinkFile".replace "$currentLinkFolder"/"$currentLinkFile"
		
		[[ "$skimfast" != "true" ]] && ls -ld "$currentLinkFolder"/"$currentLinkFile"
		[[ "$skimfast" != "true" ]] && [[ -d "$currentLinkFolder"/"$currentLinkFile" ]] && ls -l "$currentLinkFolder"/"$currentLinkFile"
		
		cd "$outerPWD"
	fi
	
	
	
	return 0
}

# WARNING: May be untested.
_mitigate-ubcp_rewrite_parallel() {
	local currentArg
	for currentArg in "$@"
	do
		true
		
		_mitigate-ubcp_rewrite_procedure "$currentArg"
		
		# WARNING: May be untested.
		#_mitigate-ubcp_rewrite_procedure "$currentArg" &
		
		#/bin/echo "$currentArg" > /dev/tty
	done
}

_mitigate-ubcp_rewrite_sequence() {
	export safeToDeleteGit="true"
	! _safePath "$1" && _stop 1
	cd "$1"
	
	
	# WARNING: May be slow (multiple hours).
	unset currentPWD
	#find "$2" -type l -exec "$scriptAbsoluteLocation" _mitigate-ubcp_rewrite_procedure '{}' \;
	
	
	# WARNING: May be untested.
	# https://stackoverflow.com/questions/4321456/find-exec-a-shell-function-in-linux
	# Since only the shell knows how to run shell functions, you have to run a shell to run a function.
	# export -f dosomething
	# find . -exec bash -c 'dosomething "$0"' {} \;
	unset currentPWD
	export currentPWD="$PWD"
	#export currentPWD="$1"
	unset currentFile
	export -f "_mitigate-ubcp_rewrite_procedure"
	export -f "_messagePlain_nominal"
	export -f "_color_begin_nominal"
	export -f "_color_end"
	export -f "_getAbsoluteLocation"
	export -f "_realpath_L_s"
	export -f "_realpath_L"
	export -f "_compat_realpath_run"
	export -f "_compat_realpath"
	export -f "_messagePlain_probe_var"
	export -f "_color_begin_probe"
	export -f "_messagePlain_probe"
	#find "$2" -print0 | while IFS= read -r -d '' currentFile; do _mitigate-ubcp_rewrite_procedure "$currentFile"; done
	
	
	
	# WARNING: May be untested.
	##find "$2" -type l -exec bash -c '_mitigate-ubcp_rewrite_procedure "$1"' _ {} \;
	
	
	#_experimentInteractive ()
	#{
		#echo begin: "$@";
		#sleep 1;
		#echo end
	#}
	#export -f _experimentInteractive
	#seq 1 500 | xargs -x -s 4096 -L 6 -P 4 bash -c 'echo begin: "$@" ; sleep 1 ; echo end' _
	#seq 1 500 | xargs -x -s 4096 -L 6 -P 4 bash -c '_experimentInteractive "$@"' _

	
	# WARNING: Diagnostic output will be corrupted by parallelism.
	# ATTENTION: Expect as much as 4x as many CPU threads may be saturated due to MSW (MSW, NOT Cygwin) inefficiencies.
	# Or only 2x if CPU has leading single-thread (ie. per-thread) performance and MSW inefficiencies have been reduced.
	# Expect done in as little as 15 minutes.
	# https://serverfault.com/questions/193319/a-better-unix-find-with-parallel-processing
	# https://stackoverflow.com/questions/11003418/calling-shell-functions-with-xargs
	export -f "_mitigate-ubcp_rewrite_parallel"
	find "$2" -type l -print0 | xargs -0 -x -s 3072 -L 6 -P $(nproc) bash -c '_mitigate-ubcp_rewrite_parallel "$@"' _
	#find "$2" -type l -print0 | xargs -0 -n 1 -P 4 -I {} bash -c '_mitigate-ubcp_rewrite_parallel "$@"' _ {}
	#find "$2" -type l -print0 | xargs -0 -n 1 -P 4 -I {} bash -c '_mitigate-ubcp_rewrite_procedure "$@"' _ {}
	
	return 0
}

_mitigate-ubcp_rewrite() {
	"$scriptAbsoluteLocation" _mitigate-ubcp_rewrite_sequence "$@"

	# CAUTION: This may not catch mitigate failure . The actual issue with 'getconf' was removal of the 'ARG_MAX' value , which was not caused by mitigate failure .
	if [[ ! -e /usr/bin/getconf ]]
	then
		_messagePlain_bad 'missing: bad: /usr/bin/getconf'
		echo 'Usually, this is a symlink, if missing, indicative of failed symlink mitigation due to xargs parameter length or parallelism failure.'
		_messageFAIL
		_stop 1
		return 1
	fi
	return 0
}




_mitigate-ubcp_procedure() {
	export safeToDeleteGit="true"
	! _safePath "$1" && _stop 1
	
	# DANGER: REQUIRED for symbolic links to be valid as necessary during rewrite/replace algorithm.
	ln -s "$1"/bin "$1"/usr/bin
	
	_mitigate-ubcp_rewrite "$1" "$1"/etc/alternatives
	
	_mitigate-ubcp_rewrite "$1" "$1"/bin
	_mitigate-ubcp_rewrite "$1" "$1"/usr/share
	_mitigate-ubcp_rewrite "$1" "$1"/usr/libexec
	_mitigate-ubcp_rewrite "$1" "$1"/lib
	_mitigate-ubcp_rewrite "$1" "$1"/etc/pki
	_mitigate-ubcp_rewrite "$1" "$1"/etc/ssl
	_mitigate-ubcp_rewrite "$1" "$1"/etc/crypto-policies
	_mitigate-ubcp_rewrite "$1" "$1"/etc/mc
	
	_mitigate-ubcp_rewrite "$1" "$1"/opt
	
	
	
	
	
	# CAUTION: Three possible scenarios to consider.
	# 1) Symlinks rewritten as is to '/usr/bin'. Links pointing to '/usr/bin' directory will not work through network drive unless this link remains.
		# PREVENT - ' rm -f "$1"/usr/bin ' .
		# Tested - known working ( _userVBox , _userQemu ) .
	# 2) Symlinks rewritten to '/bin'. Links now pointing to '/bin' should return files when retrieved through network drive, without this link.
		# ALLOW - ' rm -f "$1"/usr/bin ' .
		# Tested - known working ( _userVBox , _userQemu ) .
	# 3) Symlinks replaced. No links, files only.
		# ALLOW - ' rm -f "$1"/usr/bin ' 
		# Tested - known working ( _userVBox , _userQemu ) .
	# In any case, Cygwin will not be managing this directory .
	( [[ "$mitigate_ubcp_replaceSymlink" == 'true' ]] || [[ "$mitigate_ubcp_modifySymlink" == 'true' ]] ) && rm -f "$1"/usr/bin
}




_mitigate-ubcp_directory() {
	mkdir -p "$safeTmp"/package/_local
	
	if [[ -e "$scriptLocal"/ubcp/cygwin ]]
	then
		_mitigate-ubcp_procedure "$scriptLocal"/ubcp/cygwin
		return 0
	fi
# 	if [[ -e "$scriptLib"/ubcp/cygwin ]]
# 	then
# 		_mitigate-ubcp_procedure "$scriptLib"/ubcp/cygwin
# 		return 0
# 	fi
# 	if [[ -e "$scriptAbsoluteFolder"/ubcp/cygwin ]]
# 	then
# 		_mitigate-ubcp_procedure "$scriptAbsoluteFolder"/ubcp/cygwin
# 		return 0
# 	fi
	
	
	export mitigate_ubcp_replaceSymlink='false'
	cd "$outerPWD"
	_stop 1
}

# ATTENTION: Override with 'ops' or similar.
_mitigate-ubcp() {
	export mitigate_ubcp_modifySymlink='true'
	export mitigate_ubcp_replaceSymlink='false'
	"$scriptAbsoluteLocation" _mitigate-ubcp_directory "$@"
	
	export mitigate_ubcp_replaceSymlink='true'
	"$scriptAbsoluteLocation" _mitigate-ubcp_directory "$@"
}



_package_procedure-cygwinOnly() {
	_start
	mkdir -p "$safeTmp"/package
	
	# WARNING: Largely due to presence of '.gitignore' files in 'ubcp' .
	export safeToDeleteGit="true"
	
	rm -f "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.gz > /dev/null 2>&1
	rm -f "$scriptLocal"/package_ubcp-cygwinOnly.tar.gz > /dev/null 2>&1
	rm -f "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.gz > /dev/null 2>&1
	
	rm -f "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.xz > /dev/null 2>&1
	rm -f "$scriptLocal"/package_ubcp-cygwinOnly.tar.xz > /dev/null 2>&1
	rm -f "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.xz > /dev/null 2>&1
	
	rm -f "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar > /dev/null 2>&1
	rm -f "$scriptLocal"/package_ubcp-cygwinOnly.tar > /dev/null 2>&1
	rm -f "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar > /dev/null 2>&1
	
	rm -f "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.flx > /dev/null 2>&1
	rm -f "$scriptLocal"/package_ubcp-cygwinOnly.tar.flx > /dev/null 2>&1
	rm -f "$scriptLocal"/ubcp/package_ubcp-cygwinOnly.tar.flx > /dev/null 2>&1
	
	if [[ "$ubPackage_enable_ubcp" == 'true' ]]
	then
		_package_ubcp_copy "$@"
	fi
	
	cd "$safeTmp"/package/
	_package_subdir
	
	# ATTENTION: Unusual. Expected to result in a package containing only 'ubcp' directory in the root.
	# WARNING: Having these subdirectories opened in MSW 'explorer' (file manager) may cause this directory to not exist.
	! cd "$safeTmp"/package/"$objectName"/_local && _stop 1
	
	#tar -czvf "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.gz .
	#env XZ_OPT="-5 -T0" tar -cJvf "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.xz .
	#env XZ_OPT="-0 -T0" tar -cJvf "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.xz .
	#tar -cvf "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar .

	if [[ "$skimfast" != "true" ]]
	then
		tar -cvf - . | lz4 -z --fast=1 - "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.flx
	else
		tar -cf - . | lz4 -z --fast=1 - "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.flx
		#tar -cf "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.flx .
	fi
	
	mkdir -p "$scriptLocal"/ubcp/
	mv "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.gz "$scriptLocal"/ubcp/ > /dev/null 2>&1
	mv "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.xz "$scriptLocal"/ubcp/ > /dev/null 2>&1
	mv "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar "$scriptLocal"/ubcp/ > /dev/null 2>&1
	mv "$scriptAbsoluteFolder"/package_ubcp-cygwinOnly.tar.flx "$scriptLocal"/ubcp/
	
	_messagePlain_request 'request: review contents of _local/ubcp/cygwin/home and similar directories'
	sleep 20
	
	cd "$outerPWD"
	_stop
}




_package-cygwinOnly() {
	export ubPackage_enable_ubcp='true'
	"$scriptAbsoluteLocation" _package_procedure-cygwinOnly "$@"
}
_package-cygwin() {
	_package-cygwinOnly "$@"
}














# Discouraged. Few file paths, some setup, etc, may be different. Otherwise, WSL should not be treated differently.
_if_wsl() {
    uname -a | grep -i 'microsoft' > /dev/null 2>&1 || uname -a | grep -i 'WSL2' > /dev/null 2>&1
}

if [[ "$WSL_DISTRO_NAME" != "" ]] && _if_wsl
then
    
    # WARNING: CAUTION: Adding some native MSWindows programs from MSWindows path (eg. python) may cause conflicts with native WSL/Linux equivalent programs, etc.
    
    # NOTICE: Native ubdist/OS, WSL/Linux, etc, equivalent, is 'xdg-open', etc .
    #! type explorer > /dev/null 2>&1 && [[ -e /mnt/c/Windows/System32/explorer.exe ]] && explorer() { /mnt/c/Windows/System32/explorer.exe "$@"; }
    ! type explorer > /dev/null 2>&1 && [[ -e /mnt/c/Windows/explorer.exe ]] && explorer() { /mnt/c/Windows/explorer.exe "$@"; }
    #! type explorer > /dev/null 2>&1 && [[ -e /mnt/d/Windows/System32/explorer.exe ]] && explorer() { /mnt/d/Windows/System32/explorer.exe "$@"; }
    ! type explorer > /dev/null 2>&1 && [[ -e /mnt/d/Windows/explorer.exe ]] && explorer() { /mnt/d/Windows/explorer.exe "$@"; }
fi



# Ingredients. Debian pacakges mirror, docker images, pre-built dist/OS images, etc.
_set_ingredients() {
    export ub_INGREDIENTS=""

    local currentDriveLetter

    if ! _if_cygwin
    then
        [[ -e /mnt/ingredients/ingredients ]] && mountpoint /mnt/ingredients && export ub_INGREDIENTS=/mnt/ingredients/ingredients && return 0

        # STRONGLY PREFERRED.
        [[ -e /mnt/ingredients ]] && mountpoint /mnt/ingredients && export ub_INGREDIENTS=/mnt/ingredients && return 0

        # STRONGLY DISCOURAGED.
        # Do NOT create "$HOME"/core/ingredients unless for some very unexpected reason it is necessary for a non-root user to use ingredients.
        [[ -e "$HOME"/core/ingredients ]] && export ub_INGREDIENTS="$HOME"/core/ingredients && return 0

        # WSL(2) specific.
        #_if_wsl
        #uname -a | grep -i 'microsoft' > /dev/null 2>&1 || uname -a | grep -i 'WSL2' > /dev/null 2>&1
        if type _if_wsl > /dev/null 2>&1 && _if_wsl
        then
            [[ -e /mnt/host/z/mnt/ingredients ]] && export ub_INGREDIENTS=/mnt/host/z/mnt/ingredients && return 0
            [[ -e /mnt/z/mnt/ingredients ]] && export ub_INGREDIENTS=/mnt/z/mnt/ingredients && return 0
            [[ -e /mnt/c/core/ingredients ]] && export ub_INGREDIENTS=/mnt/c/core/ingredients && return 0
            [[ -e /mnt/host/c/core/ingredients ]] && export ub_INGREDIENTS=/mnt/host/c/core/ingredients && return 0
            #
            for currentDriveLetter in d e f g h i j k l m n o p q r s t u v w D E F G H I J K L M N O P Q R S T U V W
            do
                [[ -e /mnt/"$currentDriveLetter"/ingredients ]] && export ub_INGREDIENTS=/mnt/"$currentDriveLetter"/ingredients && return 0
            done
            if [[ -e /mnt/host ]]
            then
                for currentDriveLetter in d e f g h i j k l m n o p q r s t u v w D E F G H I J K L M N O P Q R S T U V W
                do
                    [[ -e /mnt/host/"$currentDriveLetter"/ingredients ]] && export ub_INGREDIENTS=/mnt/host/"$currentDriveLetter"/ingredients && return 0
                done
            fi
        fi
    fi

    if _if_cygwin
    then
        [[ -e /cygdrive/z/mnt/ingredients ]] && export ub_INGREDIENTS=/cygdrive/z/mnt/ingredients && return 0
        [[ -e /cygdrive/c/core/ingredients ]] && export ub_INGREDIENTS=/cygdrive/c/core/ingredients && return 0
        #
        for currentDriveLetter in d e f g h i j k l m n o p q r s t u v w D E F G H I J K L M N O P Q R S T U V W
        do
            [[ -e /cygdrive/"$currentDriveLetter"/ingredients ]] && export ub_INGREDIENTS=/cygdrive/"$currentDriveLetter"/ingredients && return 0
        done
    fi




    [[ "$ub_INGREDIENTS" == "" ]] && return 1
    return 0
}



#####Utilities

_test_getAbsoluteLocation_sequence() {
	_start scriptLocal_mkdir_disable
	
	local testScriptLocation_actual
	local testScriptLocation
	local testScriptFolder
	
	local testLocation_actual
	local testLocation
	local testFolder
	
	#script location/folder work directories
	mkdir -p "$safeTmp"/sAL_dir
	cp "$scriptAbsoluteLocation" "$safeTmp"/sAL_dir/script
	ln -s "$safeTmp"/sAL_dir/script "$safeTmp"/sAL_dir/lnk
	[[ ! -e "$safeTmp"/sAL_dir/script ]] && _stop 1
	[[ ! -e "$safeTmp"/sAL_dir/lnk ]] && _stop 1
	
	ln -s "$safeTmp"/sAL_dir "$safeTmp"/sAL_lnk
	[[ ! -e "$safeTmp"/sAL_lnk/script ]] && _stop 1
	[[ ! -e "$safeTmp"/sAL_lnk/lnk ]] && _stop 1
	
	#_getScriptAbsoluteLocation
	testScriptLocation_actual=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteLocation)
	[[ "$safeTmp"/sAL_dir/script != "$testScriptLocation_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir/script != "$testScriptLocation_actual"' && _stop 1
	
	testScriptLocation=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/script' && _stop 1
	testScriptLocation=$("$safeTmp"/sAL_dir/lnk _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testScriptLocation=$("$safeTmp"/sAL_lnk/script _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/script' && _stop 1
	testScriptLocation=$("$safeTmp"/sAL_lnk/lnk _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	#_getScriptAbsoluteFolder
	testScriptFolder_actual=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteFolder)
	[[ "$safeTmp"/sAL_dir != "$testScriptFolder_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir != "$testScriptFolder_actual"' && _stop 1
	
	testScriptFolder=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/script' && _stop 1
	testScriptFolder=$("$safeTmp"/sAL_dir/lnk _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testScriptFolder=$("$safeTmp"/sAL_lnk/script _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/script' && _stop 1
	testScriptFolder=$("$safeTmp"/sAL_lnk/lnk _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	
	#_getAbsoluteLocation
	testLocation_actual=$("$safeTmp"/sAL_dir/script _getAbsoluteLocation "$safeTmp"/sAL_dir/script)
	[[ "$safeTmp"/sAL_dir/script != "$testLocation_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir/script != "$testLocation_actual"' && _stop 1
	
	testLocation=$("$safeTmp"/sAL_dir/script _getAbsoluteLocation "$safeTmp"/sAL_dir/script)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/script' && _stop 1
	testLocation=$("$safeTmp"/sAL_dir/lnk _getAbsoluteLocation "$safeTmp"/sAL_dir/lnk)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testLocation=$("$safeTmp"/sAL_lnk/script _getAbsoluteLocation "$safeTmp"/sAL_lnk/script)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/script' && _stop 1
	testLocation=$("$safeTmp"/sAL_lnk/lnk _getAbsoluteLocation "$safeTmp"/sAL_lnk/lnk)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	#_getAbsoluteFolder
	testFolder_actual=$("$safeTmp"/sAL_dir/script _getAbsoluteFolder "$safeTmp"/sAL_dir/script)
	[[ "$safeTmp"/sAL_dir != "$testFolder_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir != "$testFolder_actual"' && _stop 1
	
	testFolder=$("$safeTmp"/sAL_dir/script _getAbsoluteFolder "$safeTmp"/sAL_dir/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/script' && _stop 1
	testFolder=$("$safeTmp"/sAL_dir/lnk _getAbsoluteFolder "$safeTmp"/sAL_dir/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testFolder=$("$safeTmp"/sAL_lnk/script _getAbsoluteFolder "$safeTmp"/sAL_lnk/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/script' && _stop 1
	testFolder=$("$safeTmp"/sAL_lnk/lnk _getAbsoluteFolder "$safeTmp"/sAL_lnk/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	_stop
}

_test_getAbsoluteLocation() {
	"$scriptAbsoluteLocation" _test_getAbsoluteLocation_sequence "$@"
	[[ "$?" != "0" ]] && _stop 1
	return 0
}

#https://unix.stackexchange.com/questions/293892/realpath-l-vs-p
_test_realpath_L_s_sequence() {
	_start scriptLocal_mkdir_disable
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	
	local testPath_actual
	local testPath
	
	mkdir -p "$safeTmp"/src
	mkdir -p "$safeTmp"/sub
	ln -s  "$safeTmp"/src "$safeTmp"/sub/lnk
	
	echo > "$safeTmp"/sub/point
	
	ln -s "$safeTmp"/sub/point "$safeTmp"/sub/lnk/ref
	
	#correct
	#"$safeTmp"/sub/ref
	#realpath -L "$safeTmp"/sub/lnk/../ref
	
	#default, wrong
	#"$safeTmp"/ref
	#realpath -P "$safeTmp"/sub/lnk/../ref
	#echo -n '>'
	#readlink -f "$safeTmp"/sub/lnk/../ref
	
	testPath_actual="$safeTmp"/sub/ref
	
	cd "$functionEntryPWD"
	testPath=$(_realpath_L "$safeTmp"/sub/lnk/../ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L' && _stop 1
	
	cd "$safeTmp"
	testPath=$(_realpath_L ./sub/lnk/../ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L' && _stop 1
	
	#correct
	#"$safeTmp"/sub/lnk/ref
	#realpath -L -s "$safeTmp"/sub/lnk/ref
	
	#default, wrong for some use cases
	#"$safeTmp"/sub/point
	#realpath -L "$safeTmp"/sub/lnk/ref
	#echo -n '>'
	#readlink -f "$safeTmp"/sub/lnk/ref
	
	testPath_actual="$safeTmp"/sub/lnk/ref
	
	cd "$functionEntryPWD"
	testPath=$(_realpath_L_s "$safeTmp"/sub/lnk/ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L_s' && _stop 1
	
	cd "$safeTmp"
	testPath=$(_realpath_L_s ./sub/lnk/ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L_s' && _stop 1
	
	
	cd "$functionEntryPWD"
	_stop
}

_test_realpath_L_s() {
	#Optional safety check. Nonconformant realpath solution should be caught by synthetic test cases.
	#_compat_realpath
	#  ! [[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && echo 'crit: missing: realpath' && _stop 1
	
	"$scriptAbsoluteLocation" _test_realpath_L_s_sequence "$@"
	[[ "$?" != "0" ]] && _stop 1
	return 0
}

_test_realpath_L() {
	_test_realpath_L_s "$@"
}

_test_realpath() {
	_test_realpath_L_s "$@"
}

_test_readlink_f_sequence() {
	_start scriptLocal_mkdir_disable
	
	echo > "$safeTmp"/realFile
	ln -s "$safeTmp"/realFile "$safeTmp"/linkA
	ln -s "$safeTmp"/linkA "$safeTmp"/linkB
	
	local currentReadlinkResult
	currentReadlinkResult=$(readlink -f "$safeTmp"/linkB)
	
	local currentReadlinkResultBasename
	currentReadlinkResultBasename=$(basename "$currentReadlinkResult")
	
	if [[ "$currentReadlinkResultBasename" != "realFile" ]]
	then
		#echo 'fail: readlink -f'
		_stop 1
	fi
	
	_stop 0
}

_test_readlink_f() {
	if ! "$scriptAbsoluteLocation" _test_readlink_f_sequence
	then
		# May fail through MSW network drive provided by '_userVBox' .
		uname -a | grep -i cygwin > /dev/null 2>&1 && echo 'warn: broken (cygwin): readlink -f' && return 1
		echo 'fail: readlink -f'
		_stop 1
	fi
	
	return 0
}

_compat_realpath() {
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	#Workaround, Mac. See https://github.com/mirage335/ubiquitous_bash/issues/1 .
	export compat_realpath_bin=/opt/local/libexec/gnubin/realpath
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	export compat_realpath_bin=$(type -p realpath)
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	export compat_realpath_bin=/bin/realpath
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	export compat_realpath_bin=/usr/bin/realpath
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	# ATTENTION
	# Command "readlink -f" or text processing can be used as fallbacks to obtain absolute path
	# https://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx
	
	export compat_realpath_bin=""
	return 1
}

_compat_realpath_run() {
	! _compat_realpath && return 1
	
	"$compat_realpath_bin" "$@"
}

_realpath_L() {
	if ! _compat_realpath_run -L . > /dev/null 2>&1
	then
		readlink -f "$@"
		return
	fi
	
	realpath -L "$@"
}

_realpath_L_s() {
	if ! _compat_realpath_run -L . > /dev/null 2>&1
	then
		readlink -f "$@"
		return
	fi
	
	realpath -L -s "$@"
}


_cygwin_translation_rootFileParameter() {
	if ! uname -a | grep -i cygwin > /dev/null 2>&1
	then
		echo "$0"
		return 0
	fi
	
	
	local currentScriptLocation
	currentScriptLocation="$0"
	
	# CAUTION: Lookup table is used to avoid pulling in any additional dependencies. Additionally, Cygwin apparently may ignore letter case of path .
	
	[[ "$currentScriptLocation" == 'A:'* ]] && currentScriptLocation=${currentScriptLocation/A\://cygdrive/a} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'B:'* ]] && currentScriptLocation=${currentScriptLocation/B\://cygdrive/b} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'C:'* ]] && currentScriptLocation=${currentScriptLocation/C\://cygdrive/c} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'D:'* ]] && currentScriptLocation=${currentScriptLocation/D\://cygdrive/d} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'E:'* ]] && currentScriptLocation=${currentScriptLocation/E\://cygdrive/e} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'F:'* ]] && currentScriptLocation=${currentScriptLocation/F\://cygdrive/f} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'G:'* ]] && currentScriptLocation=${currentScriptLocation/G\://cygdrive/g} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'H:'* ]] && currentScriptLocation=${currentScriptLocation/H\://cygdrive/h} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'I:'* ]] && currentScriptLocation=${currentScriptLocation/I\://cygdrive/i} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'J:'* ]] && currentScriptLocation=${currentScriptLocation/J\://cygdrive/j} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'K:'* ]] && currentScriptLocation=${currentScriptLocation/K\://cygdrive/k} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'L:'* ]] && currentScriptLocation=${currentScriptLocation/L\://cygdrive/l} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'M:'* ]] && currentScriptLocation=${currentScriptLocation/M\://cygdrive/m} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'N:'* ]] && currentScriptLocation=${currentScriptLocation/N\://cygdrive/n} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'O:'* ]] && currentScriptLocation=${currentScriptLocation/O\://cygdrive/o} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'P:'* ]] && currentScriptLocation=${currentScriptLocation/P\://cygdrive/p} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'Q:'* ]] && currentScriptLocation=${currentScriptLocation/Q\://cygdrive/q} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'R:'* ]] && currentScriptLocation=${currentScriptLocation/R\://cygdrive/r} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'S:'* ]] && currentScriptLocation=${currentScriptLocation/S\://cygdrive/s} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'T:'* ]] && currentScriptLocation=${currentScriptLocation/T\://cygdrive/t} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'U:'* ]] && currentScriptLocation=${currentScriptLocation/U\://cygdrive/u} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'V:'* ]] && currentScriptLocation=${currentScriptLocation/V\://cygdrive/v} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'W:'* ]] && currentScriptLocation=${currentScriptLocation/W\://cygdrive/w} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'X:'* ]] && currentScriptLocation=${currentScriptLocation/X\://cygdrive/x} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'Y:'* ]] && currentScriptLocation=${currentScriptLocation/Y\://cygdrive/y} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'Z:'* ]] && currentScriptLocation=${currentScriptLocation/Z\://cygdrive/z} && echo "$currentScriptLocation" && return 0
	
	[[ "$currentScriptLocation" == 'a:'* ]] && currentScriptLocation=${currentScriptLocation/a\://cygdrive/a} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'b:'* ]] && currentScriptLocation=${currentScriptLocation/b\://cygdrive/b} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'c:'* ]] && currentScriptLocation=${currentScriptLocation/c\://cygdrive/c} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'd:'* ]] && currentScriptLocation=${currentScriptLocation/d\://cygdrive/d} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'e:'* ]] && currentScriptLocation=${currentScriptLocation/e\://cygdrive/e} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'f:'* ]] && currentScriptLocation=${currentScriptLocation/f\://cygdrive/f} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'g:'* ]] && currentScriptLocation=${currentScriptLocation/g\://cygdrive/g} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'h:'* ]] && currentScriptLocation=${currentScriptLocation/h\://cygdrive/h} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'i:'* ]] && currentScriptLocation=${currentScriptLocation/i\://cygdrive/i} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'j:'* ]] && currentScriptLocation=${currentScriptLocation/j\://cygdrive/j} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'k:'* ]] && currentScriptLocation=${currentScriptLocation/k\://cygdrive/k} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'l:'* ]] && currentScriptLocation=${currentScriptLocation/l\://cygdrive/l} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'm:'* ]] && currentScriptLocation=${currentScriptLocation/m\://cygdrive/m} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'n:'* ]] && currentScriptLocation=${currentScriptLocation/n\://cygdrive/n} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'o:'* ]] && currentScriptLocation=${currentScriptLocation/o\://cygdrive/o} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'p:'* ]] && currentScriptLocation=${currentScriptLocation/p\://cygdrive/p} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'q:'* ]] && currentScriptLocation=${currentScriptLocation/q\://cygdrive/q} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'r:'* ]] && currentScriptLocation=${currentScriptLocation/r\://cygdrive/r} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 's:'* ]] && currentScriptLocation=${currentScriptLocation/s\://cygdrive/s} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 't:'* ]] && currentScriptLocation=${currentScriptLocation/t\://cygdrive/t} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'u:'* ]] && currentScriptLocation=${currentScriptLocation/u\://cygdrive/u} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'v:'* ]] && currentScriptLocation=${currentScriptLocation/v\://cygdrive/v} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'w:'* ]] && currentScriptLocation=${currentScriptLocation/w\://cygdrive/w} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'x:'* ]] && currentScriptLocation=${currentScriptLocation/x\://cygdrive/x} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'y:'* ]] && currentScriptLocation=${currentScriptLocation/y\://cygdrive/y} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'z:'* ]] && currentScriptLocation=${currentScriptLocation/z\://cygdrive/z} && echo "$currentScriptLocation" && return 0
	
	
	echo "$currentScriptLocation" && return 0
}


#Critical prerequsites.
_getAbsolute_criticalDep() {
	#  ! type realpath > /dev/null 2>&1 && exit 1
	! type readlink > /dev/null 2>&1 && exit 1
	! type dirname > /dev/null 2>&1 && exit 1
	! type basename > /dev/null 2>&1 && exit 1
	
	#Known to succeed under BusyBox (OpenWRT), NetBSD, and common Linux variants. No known failure modes. Extra precaution.
	! readlink -f . > /dev/null 2>&1 && exit 1
	
	! echo 'qwerty123.git' | grep '\.git$' > /dev/null 2>&1 && exit 1
	echo 'qwerty1234git' | grep '\.git$' > /dev/null 2>&1 && exit 1
	
	return 0
}
#! _getAbsolute_criticalDep && exit 1
_getAbsolute_criticalDep

#Retrieves absolute path of current script, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#However, will dereference symlinks IF the script location itself is a symlink. This is to allow symlinking to scripts to function normally.
#Suitable for allowing scripts to find other scripts they depend on. May look like an ugly hack, but it has proven reliable over the years.
_getScriptAbsoluteLocation() {
	if [[ "$0" == "-"* ]]
	then
		return 1
	fi
	
	local currentScriptLocation
	currentScriptLocation="$0"
	uname -a | grep -i cygwin > /dev/null 2>&1 && type _cygwin_translation_rootFileParameter > /dev/null 2>&1 && currentScriptLocation=$(_cygwin_translation_rootFileParameter)
	
	
	local absoluteLocation
	if [[ (-e $PWD\/$currentScriptLocation) && ($currentScriptLocation != "") ]] && [[ "$currentScriptLocation" != "/"* ]]
	then
		absoluteLocation="$PWD"\/"$currentScriptLocation"
		absoluteLocation=$(_realpath_L_s "$absoluteLocation")
	else
		absoluteLocation=$(_realpath_L "$currentScriptLocation")
	fi
	
	if [[ -h "$absoluteLocation" ]]
	then
		absoluteLocation=$(readlink -f "$absoluteLocation")
		absoluteLocation=$(_realpath_L "$absoluteLocation")
	fi
	echo $absoluteLocation
}
alias getScriptAbsoluteLocation=_getScriptAbsoluteLocation

#Retrieves absolute path of current script, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#Suitable for allowing scripts to find other scripts they depend on.
_getScriptAbsoluteFolder() {
	if [[ "$0" == "-"* ]]
	then
		return 1
	fi
	
	dirname "$(_getScriptAbsoluteLocation)"
}
alias getScriptAbsoluteFolder=_getScriptAbsoluteFolder

#Retrieves absolute path of parameter, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#Suitable for finding absolute paths, when it is desirable not to interfere with symlink specified folder structure.
_getAbsoluteLocation() {
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	if [[ "$1" == "" ]]
	then
		echo
		return
	fi
	
	local absoluteLocation
	if [[ (-e $PWD\/$1) && ($1 != "") ]] && [[ "$1" != "/"* ]]
	then
		absoluteLocation="$PWD"\/"$1"
		absoluteLocation=$(_realpath_L_s "$absoluteLocation")
	else
		absoluteLocation=$(_realpath_L "$1")
	fi
	echo "$absoluteLocation"
}
alias getAbsoluteLocation=_getAbsoluteLocation

#Retrieves absolute path of parameter, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#Suitable for finding absolute paths, when it is desirable not to interfere with symlink specified folder structure.
_getAbsoluteFolder() {
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	local absoluteLocation=$(_getAbsoluteLocation "$1")
	dirname "$absoluteLocation"
}
alias getAbsoluteLocation=_getAbsoluteLocation

_getScriptLinkName() {
	! [[ -e "$0" ]] && return 1
	! [[ -L "$0" ]] && return 1
	
	! type basename > /dev/null 2>&1 && return 1
	
	local scriptLinkName
	scriptLinkName=$(basename "$0")
	
	[[ "$scriptLinkName" == "" ]] && return 1
	echo "$scriptLinkName"
}

#https://unix.stackexchange.com/questions/27021/how-to-name-a-file-in-the-deepest-level-of-a-directory-tree?answertab=active#tab-top
_filter_lowestPath() {
	awk -F'/' 'NF > depth {
depth = NF;
deepest = $0;
}
END {
print deepest;
}'
}

#https://stackoverflow.com/questions/1086907/can-find-or-any-other-tool-search-for-files-breadth-first
_filter_highestPath() {
	awk -F'/' '{print "", NF, $F}' | sort -n | awk '{print $2}' | head -n 1
}

_recursion_guard() {
	! [[ -e "$1" ]] && return 1
	
	! type "$1" >/dev/null 2>&1 && return 1
	
	local launchGuardScriptAbsoluteLocation
	launchGuardScriptAbsoluteLocation=$(_getScriptAbsoluteLocation)
	local launchGuardTestAbsoluteLocation
	launchGuardTestAbsoluteLocation=$(_getAbsoluteLocation "$1")
	[[ "$launchGuardScriptAbsoluteLocation" == "$launchGuardTestAbsoluteLocation" ]] && return 1
	
	return 0
}

#Checks whether command or function is available.
# DANGER Needed by safeRMR .
_checkDep() {
	if ! type "$1" >/dev/null 2>&1
	then
		echo "$1" missing
		_stop 1
	fi
}

_tryExec() {
	type "$1" >/dev/null 2>&1 && "$1"
}

_tryExecFull() {
	type "$1" >/dev/null 2>&1 && "$@"
}

#Fails if critical global variables point to nonexistant locations. Code may be duplicated elsewhere for extra safety.
_failExec() {
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	return 0
}

#Portable sanity checked "rm -r" command.
# DANGER Last line of defense against catastrophic errors where "rm -r" or similar would be used!
# WARNING Not foolproof. Use to guard against systematic errors, not carelessness.
# WARNING Do NOT rely upon outside of internal programmatic usage inside script!
# WARNING Consider using this function even if program control flow can be proven safe. Redundant checks just might catch catastrophic memory errors.
#"$1" == directory to remove
_safeRMR() {
	! type _getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _getAbsolute_criticalDep && return 1
	
	#Fail sooner, avoiding irrelevant error messages. Especially important to cases where an upstream process has already removed the "$safeTmp" directory of a downstream process which reaches "_stop" later.
	! [[ -e "$1" ]] && return 1
	
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	_failExec || return 1
	
	#if [[ ! -e "$0" ]]
	#then
	#	return 1
	#fi
	
	if [[ "$1" == "" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "/" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	#Denylist.
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	#Allowlist.
	local safeToRM=false
	
	local safeScriptAbsoluteFolder
	#safeScriptAbsoluteFolder="$(_getScriptAbsoluteFolder)"
	safeScriptAbsoluteFolder="$scriptAbsoluteFolder"
	
	[[ "$1" == "./"* ]] && [[ "$PWD" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	[[ "$1" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	#[[ "$1" == "/home/$USER"* ]] && safeToRM="true"
	[[ "$1" == "/tmp/"* ]] && safeToRM="true"
	
	# WARNING: Allows removal of temporary folders created by current ubiquitous bash session only.
	[[ "$sessionid" != "" ]] && [[ "$1" == *"$sessionid"* ]] && safeToRM="true"
	[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$sessionid" != "" ]] && [[ "$1" == *$(echo "$sessionid" | head -c 16)* ]] && safeToRM="true"
	#[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$1" == "$tmpSelf"* ]] && safeToRM="true"
	
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	# ATTENTION: Search for verbatim warning to find related workarounds!
	if [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]]
	then
		if [[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$tmpSelf" != "" ]] && [[ "$tmpSelf" == "/cygdrive/"* ]] && [[ "$tmpSelf" == "$tmpMSW"* ]]
		then
			safeToRM="true"
		fi
	fi

	if [[ -e "$HOME"/.ubtmp ]] && uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1
	then
		[[ "$1" == "$HOME"/.ubtmp/* ]] && safeToRM="true"
		[[ "$1" == "./"* ]] && [[ "$PWD" == "$HOME"/.ubtmp* ]] && safeToRM="true"
	fi
	
	
	[[ "$safeToRM" == "false" ]] && return 1
	
	#Safeguards/
	[[ "$safeToDeleteGit" != "true" ]] && [[ -d "$1" ]] && [[ -e "$1" ]] && find "$1" 2>/dev/null | grep -i '\.git$' >/dev/null 2>&1 && return 1
	
	#Validate necessary tools were available for path building and checks.
	#  ! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	if [[ -e "$1" ]]
	then
		#sleep 0
		#echo "$1"
		# WARNING Recommend against adding any non-portable flags.
		rm -rf "$1" > /dev/null 2>&1
	fi
}

#Portable sanity checking for less, but, dangerous, commands.
# WARNING Not foolproof. Use to guard against systematic errors, not carelessness.
# WARNING Do NOT rely upon outside of internal programmatic usage inside script!
#"$1" == file/directory path to sanity check
_safePath() {
	! type _getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _getAbsolute_criticalDep && return 1
	
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	_failExec || return 1
	
	#if [[ ! -e "$0" ]]
	#then
	#	return 1
	#fi
	
	if [[ "$1" == "" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "/" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	#Denylist.
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	#Allowlist.
	local safeToRM=false
	
	local safeScriptAbsoluteFolder
	#safeScriptAbsoluteFolder="$(_getScriptAbsoluteFolder)"
	safeScriptAbsoluteFolder="$scriptAbsoluteFolder"
	
	[[ "$1" == "./"* ]] && [[ "$PWD" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	[[ "$1" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	#[[ "$1" == "/home/$USER"* ]] && safeToRM="true"
	[[ "$1" == "/tmp/"* ]] && safeToRM="true"
	
	# WARNING: Allows removal of temporary folders created by current ubiquitous bash session only.
	[[ "$sessionid" != "" ]] && [[ "$1" == *"$sessionid"* ]] && safeToRM="true"
	[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$sessionid" != "" ]] && [[ "$1" == *$(echo "$sessionid" | head -c 16)* ]] && safeToRM="true"
	#[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$1" == "$tmpSelf"* ]] && safeToRM="true"
	
	
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	# ATTENTION: Search for verbatim warning to find related workarounds!
	if [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]]
	then
		if [[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$tmpSelf" != "" ]] && [[ "$tmpSelf" == "/cygdrive/"* ]] && [[ "$tmpSelf" == "$tmpMSW"* ]]
		then
			safeToRM="true"
		fi
	fi

	if [[ -e "$HOME"/.ubtmp ]] && uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1
	then
		[[ "$1" == "$HOME"/.ubtmp/* ]] && safeToRM="true"
		[[ "$1" == "./"* ]] && [[ "$PWD" == "$HOME"/.ubtmp* ]] && safeToRM="true"
	fi
	
	
	[[ "$safeToRM" == "false" ]] && return 1
	
	#Safeguards/
	[[ "$safeToDeleteGit" != "true" ]] && [[ -d "$1" ]] && [[ -e "$1" ]] && find "$1" 2>/dev/null | grep -i '\.git$' >/dev/null 2>&1 && return 1
	
	#Validate necessary tools were available for path building and checks.
	#  ! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	if [[ -e "$1" ]]
	then
		#sleep 0
		#echo "$1"
		# WARNING Recommend against adding any non-portable flags.
		return 0
	fi
}

# DANGER Last line of defense against catastrophic errors when using "delete" flag with rsync or similar!
_safeBackup() {
	! type _getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _getAbsolute_criticalDep && return 1
	
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	
	#Fail sooner, avoiding irrelevant error messages. Especially important to cases where an upstream process has already removed the "$safeTmp" directory of a downstream process which reaches "_stop" later.
	! [[ -e "$1" ]] && return 1
	
	[[ "$1" == "" ]] && return 1
	[[ "$1" == "/" ]] && return 1
	[[ "$1" == "-"* ]] && return 1
	
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/root" ]] && return 1
	[[ "$1" == "/root/" ]] && return 1
	[[ "$1" == "/root/$USER" ]] && return 1
	[[ "$1" == "/root/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	return 0
}

# DANGER Last line of defense against catastrophic errors when using "delete" flag with rsync or similar!
# WARNING Intended for direct copy/paste inclusion into independent launch wrapper scripts. Kept here for redundancy as well as example and maintenance.
_command_safeBackup() {
	! type _command_getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _command_getAbsolute_criticalDep && return 1
	
	[[ ! -e "$commandScriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$commandScriptAbsoluteFolder" ]] && return 1
	
	#Fail sooner, avoiding irrelevant error messages. Especially important to cases where an upstream process has already removed the "$safeTmp" directory of a downstream process which reaches "_stop" later.
	! [[ -e "$1" ]] && return 1
	
	[[ "$1" == "" ]] && return 1
	[[ "$1" == "/" ]] && return 1
	[[ "$1" == "-"* ]] && return 1
	
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/root" ]] && return 1
	[[ "$1" == "/root/" ]] && return 1
	[[ "$1" == "/root/$USER" ]] && return 1
	[[ "$1" == "/root/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	#  ! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	return 0
}




# Suggested for files used as Inter-Process Communication (IPC) or similar indicators (eg. temporary download files recently in progress).
# Works around files that may not be deleted by 'rm -f' when expected (ie. due to Cygwin/MSW file locking).
# ATTRIBUTION-AI: OpRt_.deepseek/deepseek-r1-distill-llama-70b  2025-03-27  (partial)
_destroy_lock() {
    [[ "$1" == "" ]] && return 0

    # Fraction of   2GB part file  divided by  1MB/s optical-disc write speed   .
    local currentLockWait="1250"

    local current_anyFilesExists
    local currentFile
    
    
    local currentIteration=0
    for ((currentIteration=0; currentIteration<"$currentLockWait"; currentIteration++))
    do
        rm -f "$@" > /dev/null 2>&1

        current_anyFilesExists="false"
        for currentFile in "$@"
        do
            [[ -e "$currentFile" ]] && current_anyFilesExists="true"
        done

        if [[ "$current_anyFilesExists" == "false" ]]
        then
            return 0
            break
        fi

        # DANGER: Does NOT use _safeEcho . Do NOT use with external input!
        ( echo "STACK_FAIL STACK_FAIL STACK_FAIL: software: wait: rm: exists: file: ""$@" >&2 ) > /dev/null
        sleep 1
    done

    [[ "$currentIteration" != "0" ]] && sleep 7
    return 1
}




# Equivalent to 'mv -n' with an error exit status if file cannot be overwritten.
# https://unix.stackexchange.com/questions/248544/mv-move-file-only-if-destination-does-not-exist
_moveconfirm() {
	local currentExitStatusText
	currentExitStatusText=$(mv -vn "$1" "$2" 2>/dev/null)
	[[ "$currentExitStatusText" == "" ]] && return 1
	return 0
}


_test_moveconfirm_procedure() {
	echo > "$safeTmp"/mv_src
	echo > "$safeTmp"/mv_dst
	
	_moveconfirm "$safeTmp"/mv_src "$safeTmp"/mv_dst && return 1
	
	rm -f "$safeTmp"/mv_dst
	! _moveconfirm "$safeTmp"/mv_src "$safeTmp"/mv_dst && return 1
	
	rm -f "$safeTmp"/mv_dst
	
	return 0
}

_test_moveconfirm_sequence() {
	_start
	
	if ! _test_moveconfirm_procedure "$@"
	then
		_stop 1
	fi
	
	_stop
}

_test_moveconfirm() {
	"$scriptAbsoluteLocation" _test_moveconfirm_sequence "$@"
}


_all_exist() {
	local currentArg
	for currentArg in "$@"
	do
		! [[ -e "$currentArg" ]] && return 1
	done
	
	return 0
}

_wait_not_all_exist() {
	while ! _all_exist "$@"
	do
		sleep 0.1
	done
}

#http://stackoverflow.com/questions/687948/timeout-a-command-in-bash-without-unnecessary-delay
_timeout() { ( set +b; sleep "$1" & "${@:2}" & wait -n; r=$?; kill -9 `jobs -p`; exit $r; ) } 

_terminate() {
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	local currentPID
	
	cat "$safeTmp"/.pid >> "$processListFile" 2> /dev/null
	
	while read -r currentPID
	do
		pkill -P "$currentPID"
		kill "$currentPID"
	done < "$processListFile"
	
	rm "$processListFile"
}

_terminateMetaHostAll() {
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	local currentPID
	
	cat ./.m_*/.pid >> "$processListFile" 2> /dev/null
	
	while read -r currentPID
	do
		pkill -P "$currentPID"
		kill "$currentPID"
	done < "$processListFile"
	
	rm "$processListFile"
	
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	sleep 0.3
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	sleep 1
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	sleep 3
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	sleep 10
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	sleep 20
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	sleep 20
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	sleep 20
	! ls -d -1 ./.m_*/.pid > /dev/null 2>&1 && return 0
	
	return 1
}

_terminateAll() {
	"$scriptAbsoluteLocation" _terminateAll_sequence "$@"
}
_terminateAll_sequence() {
	_start
	_terminateAll_procedure "$@"
	_stop "$?"
}
_terminateAll_procedure() {
	_terminateMetaHostAll
	
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	local currentPID
	
	
	cat ./.s_*/.pid >> "$processListFile" 2> /dev/null
	
	cat ./.e_*/.pid >> "$processListFile" 2> /dev/null
	cat ./.m_*/.pid >> "$processListFile" 2> /dev/null
	
	cat ./w_*/.pid >> "$processListFile" 2> /dev/null
	
	while read -r currentPID
	do
		pkill -P "$currentPID"
		! _if_cygwin && sudo -n pkill -P "$currentPID"
		kill "$currentPID"
		! _if_cygwin && sudo -n kill "$currentPID"
	done < "$processListFile"
	
	if [[ "$ub_kill" == "true" ]]
	then
		sleep 9
		while read -r currentPID
		do
			pkill -KILL -P "$currentPID"
			! _if_cygwin && sudo -n pkill -KILL -P "$currentPID"
			kill -KILL "$currentPID"
			! _if_cygwin && sudo -n kill -KILL "$currentPID"
		done < "$processListFile"
	fi
	
	rm "$processListFile"
}

_killAll() {
	export ub_kill="true"
	_terminateAll
	export ub_kill=
}

_condition_lines_zero() {
	local currentLineCount
	currentLineCount=$(wc -l)
	
	[[ "$currentLineCount" == 0 ]] && return 0
	return 1
}


_safe_declare_uid() {
	unset _uid
	_uid() {
		local currentLengthUID
		currentLengthUID="$1"
		[[ "$currentLengthUID" == "" ]] && currentLengthUID=18
		cat /dev/random 2> /dev/null | base64 2> /dev/null | tr -dc 'a-zA-Z0-9' 2> /dev/null | tr -d 'acdefhilmnopqrsuvACDEFHILMNOPQRSU14580' | head -c "$currentLengthUID" 2> /dev/null
		return
	}
	export -f _uid
}

#Generates semi-random alphanumeric characters, default length 18.
_uid() {
	local curentLengthUID
	local currentIteration
	currentIteration=0
	
	currentLengthUID="18"
	! [[ -z "$uidLengthPrefix" ]] && ! [[ "$uidLengthPrefix" -lt "18" ]] && currentLengthUID="$uidLengthPrefix"
	! [[ -z "$1" ]] && currentLengthUID="$1"
	
	if [[ -z "$uidLengthPrefix" ]] && [[ -z "$1" ]]
	then
		# https://stackoverflow.com/questions/32484504/using-random-to-generate-a-random-string-in-bash
		# https://www.cyberciti.biz/faq/unix-linux-iterate-over-a-variable-range-of-numbers-in-bash/
		#chars=abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
		chars=bgjktwxyz23679BGJKTVWXYZ
		#for currentIteration in {1..$currentLengthUID} ; do
		for (( currentIteration=1; currentIteration<="$currentLengthUID"; currentIteration++ )) ; do
		echo -n "${chars:RANDOM%${#chars}:1}"
		done
		echo
	else
		cat /dev/urandom 2> /dev/null | base64 2> /dev/null | tr -dc 'a-zA-Z0-9' 2> /dev/null | tr -d 'acdefhilmnopqrsuvACDEFHILMNOPQRSU14580' | head -c "$currentLengthUID" 2> /dev/null
	fi
	return 0
}

# WARNING: Reduces uniqueness, irreversible. Multiple input characters result in same output character.
_filter_random() {
	tr 'a-z' 'bgjktwxyz''bgjktwxyz''bgjktwxyz' | tr 'A-Z' 'BGJKTVWXYZ''BGJKTVWXYZ''BGJKTVWXYZ' | tr '0-9' '23679''23679''23679' | tr -dc 'bgjktwxyz23679BGJKTVWXYZ'
}

# WARNING: Reduces uniqueness, irreversible. Multiple input characters result in same output character.
# WARNING: Not recommended for short strings (ie. not recommended for '8.3' compatibility ).
_filter_hex() {
	tr 'a-z' 'bcdf''bcdf''bcdf''bcdf''bcdf''bcdf''bcdf''bcdf' | tr 'A-Z' 'BCDF''BCDF''BCDF''BCDF''BCDF''BCDF''BCDF''BCDF' | tr '0-9' '23679''23679''23679' | tr -dc 'bcdf23679BCDF'
}

_compat_stat_c_run() {
	local functionOutput
	
	functionOutput=$(stat -c "$@" 2> /dev/null)
	[[ "$?" == "0" ]] && echo "$functionOutput" && return 0
	
	#BSD
	if stat --help 2>&1 | grep '\-f ' > /dev/null 2>&1
	then
		functionOutput=$(stat -f "$@" 2> /dev/null)
		[[ "$?" == "0" ]] && echo "$functionOutput" && return 0
	fi
	
	return 1
}

_permissions_directory_checkForPath() {
	local parameterAbsoluteLocation
	parameterAbsoluteLocation=$(_getAbsoluteLocation "$1")
	
	local checkScriptAbsoluteFolder="$(_getScriptAbsoluteFolder)"
	
	[[ "$parameterAbsoluteLocation" == "$PWD" ]] && ! [[ "$parameterAbsoluteLocation" == "$checkScriptAbsoluteFolder" ]] && return 1
	
	
	
	local currentParameter
	currentParameter="$1"
	
	[[ "$scriptAbsoluteFolder" == /media/"$USER"* ]] && [[ -e /media/"$USER" ]] && currentParameter=/media/"$USER"
	[[ "$scriptAbsoluteFolder" == /mnt/"$USER"* ]] && [[ -e /mnt/"$USER" ]] && currentParameter=/mnt/"$USER"
	[[ "$scriptAbsoluteFolder" == /var/run/media/"$USER"* ]] && [[ -e /var/run/media/"$USER" ]] && currentParameter=/var/run/media/"$USER"
	[[ "$scriptAbsoluteFolder" == /run/"$USER"* ]] && [[ -e /run/"$USER" ]] && currentParameter=/run/"$USER"
	
	local permissions_readout=$(_compat_stat_c_run "%a" "$currentParameter")
	
	local permissions_user
	local permissions_group
	local permissions_other
	
	permissions_user=$(echo "$permissions_readout" | cut -c 1)
	permissions_group=$(echo "$permissions_readout" | cut -c 2)
	permissions_other=$(echo "$permissions_readout" | cut -c 3)
	
	[[ "$permissions_user" -gt "7" ]] && return 1
	[[ "$permissions_group" -gt "7" ]] && return 1
	[[ "$permissions_other" -gt "5" ]] && return 1
	
	#Above checks considered sufficient in typical cases, remainder for sake of example. Return true (safe).
	return 0
	
	local permissions_uid
	local permissions_gid
	
	permissions_uid=$(_compat_stat_c_run "%u" "$currentParameter")
	permissions_gid=$(_compat_stat_c_run "%g" "$currentParameter")
	
	#Normally these variables are available through ubiqutious bash, but this permissions check may be needed earlier in that global variables setting process.
	local permissions_host_uid
	local permissions_host_gid
	
	permissions_host_uid=$(id -u)
	permissions_host_gid=$(id -g)
	
	[[ "$permissions_uid" != "$permissions_host_uid" ]] && return 1
	[[ "$permissions_uid" != "$permissions_host_gid" ]] && return 1
	
	return 0
}

#Checks whether the repository has unsafe permissions for adding binary files to path. Used as an extra safety check by "_setupUbiquitous" before adding a hook to the user's default shell environment.
_permissions_ubiquitous_repo() {
	local parameterAbsoluteLocation
	parameterAbsoluteLocation=$(_getAbsoluteLocation "$1")
	
	[[ ! -e "$parameterAbsoluteLocation" ]] && return 0
	
	! _permissions_directory_checkForPath "$parameterAbsoluteLocation" && return 1
	
	[[ -e "$parameterAbsoluteLocation"/_bin ]] && ! _permissions_directory_checkForPath "$parameterAbsoluteLocation"/_bin && return 1
	[[ -e "$parameterAbsoluteLocation"/_bundle ]] && ! _permissions_directory_checkForPath "$parameterAbsoluteLocation"/_bundle && return 1
	
	return 0
}

_test_permissions_ubiquitous-exception() {
	_if_cygwin && echo 'warn: accepted: cygwin: permissions' && return 0

	# Possible shared filesystem mount without correct permissions from the host .
	[[ -e /.dockerenv ]] && echo 'warn: accepted: docker: permissions' && return 0


	! _if_cygwin && _stop 1
	#  ! _if_cygwin && _stop "$1"
}

#Checks whether currently set "$scriptBin" and similar locations are actually safe.
# WARNING Keep in mind this is necessarily run only after PATH would already have been modified, and does not guard against threats already present on the local machine.
_test_permissions_ubiquitous() {
	[[ ! -e "$scriptAbsoluteFolder" ]] && _stop 1
	
	! _permissions_directory_checkForPath "$scriptAbsoluteFolder" && _test_permissions_ubiquitous-exception 1
	
	[[ -e "$scriptBin" ]] && ! _permissions_directory_checkForPath "$scriptBin" && _test_permissions_ubiquitous-exception 1
	[[ -e "$scriptBundle" ]] && ! _permissions_directory_checkForPath "$scriptBundle" && _test_permissions_ubiquitous-exception 1
	
	return 0
}



#Takes "$@". Places in global array variable "globalArgs".
# WARNING Adding this globalvariable to the "structure/globalvars.sh" declaration or similar to be overridden at script launch is not recommended.
#"${globalArgs[@]}"
_gather_params() {
	export globalArgs=("${@}")
}

_self_critial() {
	_priority_critical_pid "$$"
}

_self_interactive() {
	_priority_interactive_pid "$$"
}

_self_background() {
	_priority_background_pid "$$"
}

_self_idle() {
	_priority_idle_pid "$$"
}

_self_app() {
	_priority_app_pid "$$"
}

_self_zero() {
	_priority_zero_pid "$$"
}


#Example.
_priority_critical() {
	_priority_dispatch "_priority_critical_pid"
}

_priority_critical_pid_root() {
	! _wantSudo && return 1
	
	sudo -n ionice -c 2 -n 2 -p "$1"
	! sudo -n renice -15 -p "$1" && return 1
	
	return 0
}

_priority_critical_pid() {
	[[ "$1" == "" ]] && return 1
	
	_priority_critical_pid_root "$1" && return 0
	
	ionice -c 2 -n 4 -p "$1"
	! renice 0 -p "$1" && return 1
	
	return 1
}

_priority_interactive_pid_root() {
	! _wantSudo && return 1
	
	sudo -n ionice -c 2 -n 2 -p "$1"
	! sudo -n renice -10 -p "$1" && return 1
	
	return 0
}

_priority_interactive_pid() {
	[[ "$1" == "" ]] && return 1
	
	_priority_interactive_pid_root "$1" && return 0
	
	ionice -c 2 -n 4 -p "$1"
	! renice 0 -p "$1" && return 1
	
	return 1
}

_priority_app_pid_root() {
	! _wantSudo && return 1
	
	sudo -n ionice -c 2 -n 3 -p "$1"
	! sudo -n renice -5 -p "$1" && return 1
	
	return 0
}

_priority_app_pid() {
	[[ "$1" == "" ]] && return 1
	
	_priority_app_pid_root "$1" && return 0
	
	ionice -c 2 -n 4 -p "$1"
	! renice 0 -p "$1" && return 1
	
	return 1
}

_priority_background_pid_root() {
	! _wantSudo && return 1
	
	sudo -n ionice -c 2 -n 5 -p "$1"
	! sudo -n renice +5 -p "$1" && return 1
	
	return 0
}

_priority_background_pid() {
	[[ "$1" == "" ]] && return 1
	
	if ! type ionice > /dev/null 2>&1 || ! groups | grep -E 'wheel|sudo' > /dev/null 2>&1
	then
		renice +5 -p "$1"
		return 0
	fi
	
	_priority_background_pid_root "$1" && return 0
	
	ionice -c 2 -n 5 -p "$1"
	
	renice +5 -p "$1"
}



_priority_idle_pid_root() {
	! _wantSudo && return 1
	
	sudo -n ionice -c 3 -p "$1"
	! sudo -n renice +15 -p "$1" && return 1
	
	return 0
}

_priority_idle_pid() {
	[[ "$1" == "" ]] && return 1
	
	if ! type ionice > /dev/null 2>&1 || ! groups | grep -E 'wheel|sudo' > /dev/null 2>&1
	then
		renice +15 -p "$1"
		return 0
	fi
	
	_priority_idle_pid_root "$1" && return 0
	
	#https://linux.die.net/man/1/ionice
	ionice -c 3 -p "$1"
	
	renice +15 -p "$1"
}

_priority_zero_pid_root() {
	! _wantSudo && return 1
	
	sudo -n ionice -c 2 -n 4 -p "$1"
	! sudo -n renice 0 -p "$1" && return 1
	
	return 0
}

_priority_zero_pid() {
	[[ "$1" == "" ]] && return 1
	
	_priority_zero_pid_root "$1" && return 0
	
	#https://linux.die.net/man/1/ionice
	ionice -c 2 -n 4 -p "$1"
	
	renice 0 -p "$1"
}

# WARNING: Untested.
_priority_dispatch() {
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	echo "$1" >> "$processListFile"
	pgrep -P "$1" 2>/dev/null >> "$processListFile"
	
	local currentPID
	
	while read -r currentPID
	do
		"$@" "$currentPID"
	done < "$processListFile"
	
	rm "$processListFile"
}

# WARNING: Untested.
_priority_enumerate_pid() {
	[[ "$1" == "" ]] && return 1
	
	echo "$1"
	pgrep -P "$1" 2>/dev/null
}

_priority_enumerate_pattern() {
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	echo -n >> "$processListFile"
	
	pgrep "$1" >> "$processListFile"
	
	
	local parentListFile
	parentListFile="$tmpSelf"/.pidlist_$(_uid)
	
	echo -n >> "$parentListFile"
	
	local currentPID
	
	while read -r currentPID
	do
		pgrep -P "$currentPID" 2>/dev/null > "$parentListFile"
	done < "$processListFile"
	
	cat "$processListFile"
	cat "$parentListFile"
	
	
	rm "$processListFile"
	rm "$parentListFile"
}

# DANGER: Best practice is to call as with trailing slashes and source trailing dot .
# _instance_internal /root/source/. /root/destination/
# _instance_internal "$1"/. "$actualFakeHome"/"$2"/
# DANGER: Do not silence output unless specifically required (eg. links, possibly to directories, intended not to overwrite copies).
# _instance_internal "$globalFakeHome"/. "$actualFakeHome"/ > /dev/null 2>&1
_instance_internal() {
	! [[ -e "$1" ]] && return 1
	! [[ -d "$1" ]] && return 1
	! [[ -e "$2" ]] && return 1
	! [[ -d "$2" ]] && return 1
	rsync -q -ax --exclude "/.cache" --exclude "/.git" --exclude ".git" "$@"
}

#echo -n
_safeEcho() {
	printf '%s' "$1"
	shift
	
	[[ "$@" == "" ]] && return 0
	
	local currentArg
	for currentArg in "$@"
	do
		printf '%s' " "
		printf '%s' "$currentArg"
	done
	return 0
}

#echo
_safeEcho_newline() {
	_safeEcho "$@"
	printf '\n'
}

_safeEcho_quoteAddSingle() {
	# https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_07.html
	while (( "$#" )); do
		_safeEcho ' '"'""$1""'"
		shift
	done
}
_safeEcho_quoteAddSingle_newline() {
	_safeEcho_quoteAddSingle "$@"
	printf '\n'
}

_safeEcho_quoteAddDouble() {
	#https://stackoverflow.com/questions/1668649/how-to-keep-quotes-in-bash-arguments
	
	local currentCommandStringPunctuated
	local currentCommandStringParameter
	for currentCommandStringParameter in "$@"; do
		currentCommandStringParameter="${currentCommandStringParameter//\\/\\\\}"
		currentCommandStringPunctuated="$currentCommandStringPunctuated \"${currentCommandStringParameter//\"/\\\"}\""
	done
	
	_safeEcho "$currentCommandStringPunctuated"
}
_safeEcho_quoteAddDouble_newline() {
	_safeEcho_quoteAddDouble "$@"
	printf '\n'
}


#Universal debugging filesystem.
#End user function.
_user_log() {
	# DANGER Do NOT create automatically, or reference any existing directory!
	! [[ -d "$HOME"/.ubcore/userlog ]] && cat - > /dev/null 2>&1 && return 0
	
	cat - >> "$HOME"/.ubcore/userlog/user.log
	
	return 0
}

_monitor_user_log() {
	! [[ -d "$HOME"/.ubcore/userlog ]] && return 1
	
	tail -f "$HOME"/.ubcore/userlog/*
}

#Universal debugging filesystem.
#"generic/ubiquitousheader.sh"
_user_log-ub() {
	# DANGER Do NOT create automatically, or reference any existing directory!
	! [[ -d "$HOME"/.ubcore/userlog ]] && cat - > /dev/null 2>&1 && return 0
	
	#Terminal session may be used - the sessionid may be set through .bashrc/.ubcorerc .
	if [[ "$sessionid" != "" ]]
	then
		cat - >> "$HOME"/.ubcore/userlog/u-"$sessionid".log
		return 0
	fi
	cat - >> "$HOME"/.ubcore/userlog/u-undef.log
	
	return 0
}

_monitor_user_log-ub() {
	! [[ -d "$HOME"/.ubcore/userlog ]] && return 1
	
	tail -f "$HOME"/.ubcore/userlog/u-*
}

#Universal debugging filesystem.
_user_log_anchor() {
	# DANGER Do NOT create automatically, or reference any existing directory!
	! [[ -d "$HOME"/.ubcore/userlog ]] && cat - > /dev/null 2>&1 && return 0
	
	#Terminal session may be used - the sessionid may be set through .bashrc/.ubcorerc .
	if [[ "$sessionid" != "" ]]
	then
		cat - >> "$HOME"/.ubcore/userlog/a-"$sessionid".log
		return 0
	fi
	cat - >> "$HOME"/.ubcore/userlog/a-undef.log
	
	return 0
}

_monitor_user_log_anchor() {
	! [[ -d "$HOME"/.ubcore/userlog ]] && return 1
	
	tail -f "$HOME"/.ubcore/userlog/a-*
}

#Universal debugging filesystem.
_user_log_template() {
	# DANGER Do NOT create automatically, or reference any existing directory!
	! [[ -d "$HOME"/.ubcore/userlog ]] && cat - > /dev/null 2>&1 && return 0
	
	#Terminal session may be used - the sessionid may be set through .bashrc/.ubcorerc .
	if [[ "$sessionid" != "" ]]
	then
		cat - >> "$HOME"/.ubcore/userlog/t-"$sessionid".log
		return 0
	fi
	cat - >> "$HOME"/.ubcore/userlog/t-undef.log
	
	return 0
}

# https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
_messageColors-common() {
	echo -e '\E[1;37m ' \''\\E[1;37m'\' white \''\\E[0m'\' ' \E[0m'
	echo -e '\E[0;30m ' \''\\E[0;30m'\' black \''\\E[0m'\' ' \E[0m'
	
	echo -e '\E[0;34m ' \''\\E[0;34m'\' blue \''\\E[0m'\' ' \E[0m'
	echo -e '\E[1;34m ' \''\\E[1;34m'\' blue_light \''\\E[0m'\' ' \E[0m'
	echo -e '\E[0;32m ' \''\\E[0;32m'\' green \''\\E[0m'\' ' \E[0m'
	echo -e '\E[1;32m ' \''\\E[1;32m'\' green_light \''\\E[0m'\' ' \E[0m'
	echo -e '\E[0;36m ' \''\\E[0;36m'\' cyan \''\\E[0m'\' ' \E[0m'
	echo -e '\E[1;36m ' \''\\E[1;36m'\' cyan_light \''\\E[0m'\' ' \E[0m'
	echo -e '\E[0;31m ' \''\\E[0;31m'\' red \''\\E[0m'\' ' \E[0m'
	echo -e '\E[1;31m ' \''\\E[1;31m'\' red_light \''\\E[0m'\' ' \E[0m'
	echo -e '\E[0;35m ' \''\\E[0;35m'\' purple \''\\E[0m'\' ' \E[0m'
	echo -e '\E[1;35m ' \''\\E[1;35m'\' purple_light \''\\E[0m'\' ' \E[0m'
	echo -e '\E[0;33m ' \''\\E[0;33m'\' brown \''\\E[0m'\' ' \E[0m'
	echo -e '\E[1;33m ' \''\\E[1;33m'\' yellow \''\\E[0m'\' ' \E[0m'
	
	echo -e '\E[0;30m ' \''\\E[0;30m'\' gray \''\\E[0m'\' ' \E[0m'
	echo -e '\E[1;37m ' \''\\E[1;37m'\' gray_light \''\\E[0m'\' ' \E[0m'
	return 0
}

# https://dev.to/ifenna__/adding-colors-to-bash-scripts-48g4
# Color		Foreground Code		Background Code
# Black			30	40
# Red			31	41
# Green			32	42
# Yellow		33	43
# Blue			34	44
# Magenta		35	45
# Cyan			36	46
# Light Gray		37	47
# Gray			90	100
# Light Red		91	101
# Light Green		92	102
# Light Yellow		93	103
# Light Blue		94	104
# Light Magenta		95	105
# Light Cyan		96	106
# White			97	107
_messageColors-extra() {
	local currentIterationA
	local currentIterationB
	
	for (( currentIterationA=30; currentIterationA<="37"; currentIterationA++ )) ; do
		echo -e '\033[0;'"$currentIterationA"'m ''\\033[0;'"$currentIterationA"'m 'message' \\033[0m'' \033[0m'
		echo -e '\033[1;'"$currentIterationA"'m ''\\033[1;'"$currentIterationA"'m 'message' \\033[0m'' \033[0m'
	done
	
	for (( currentIterationA=90; currentIterationA<="97"; currentIterationA++ )) ; do
		echo -e '\033[0;'"$currentIterationA"'m ''\\033[0;'"$currentIterationA"'m 'message' \\033[0m'' \033[0m'
		echo -e '\033[1;'"$currentIterationA"'m ''\\033[1;'"$currentIterationA"'m 'message' \\033[0m'' \033[0m'
	done
	
	
	
	currentIterationB=37
	for (( currentIterationA=40; currentIterationA<="46"; currentIterationA++ )) ; do
		echo -e '\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' '\\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' message ' \\033[0m' ' \033[0m'
	done
	currentIterationA=47
	currentIterationB=30
	echo -e '\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' '\\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' message ' \\033[0m' ' \033[0m'
	
	currentIterationB=37
	for (( currentIterationA=100; currentIterationA<="107"; currentIterationA++ )) ; do
		echo -e '\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' '\\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' message ' \\033[0m' ' \033[0m'
	done
}

_messageColors-all() {
	local currentIterationA
	local currentIterationB
	
	for (( currentIterationB=30; currentIterationB<="37"; currentIterationB++ )) ; do
		for (( currentIterationA=40; currentIterationA<="47"; currentIterationA++ )) ; do
			echo -e '\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' '\\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' message ' \\033[0m' ' \033[0m'
			echo -e '\033[1;'"$currentIterationB"';'"$currentIterationA"'m ' '\\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' message ' \\033[0m' ' \033[0m'
		done
	done
	
	for (( currentIterationB=90; currentIterationB<="97"; currentIterationB++ )) ; do
		for (( currentIterationA=100; currentIterationA<="107"; currentIterationA++ )) ; do
			echo -e '\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' '\\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' message ' \\033[0m' ' \033[0m'
			echo -e '\033[1;'"$currentIterationB"';'"$currentIterationA"'m ' '\\033[0;'"$currentIterationB"';'"$currentIterationA"'m ' message ' \\033[0m' ' \033[0m'
		done
	done
}

_messageColors() {
	clear
	_messageColors-common "$@"
	echo
	echo '##########'
	echo
	_messageColors-extra "$@"
	echo
	echo '##########'
	echo
	_messageColors-all "$@"
}


_color_demo() {
	_messagePlain_request _color_demo
	_messagePlain_nominal _color_demo
	_messagePlain_probe _color_demo
	_messagePlain_probe_expr _color_demo
	_messagePlain_probe_var ubiquitousBashIDshort
	_messagePlain_good _color_demo
	_messagePlain_warn _color_demo
	_messagePlain_bad _color_demo
	_messagePlain_probe_cmd echo _color_demo
	_messagePlain_probe_quoteAddDouble echo _color_demo
	_messagePlain_probe_quoteAddSingle echo _color_demo
	_messageNormal _color_demo
	_messageError _color_demo
	_messageDELAYipc _color_demo
	_messageProcess _color_demo
}
_color_end() {
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '</span>'
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n ' \E[0m'
}

_color_begin_request() {
	#b218b2
	#848484
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#b218b2;background-color:#848484;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[0;35m '
}
_color_begin_nominal() {
	#18b2b2
	#848484
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#18b2b2;background-color:#848484;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[0;36m '
}
_color_begin_probe() {
	#1818b2
	#848484
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#1818b2;background-color:#848484;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[0;34m '
}
_color_begin_probe_noindent() {
	#1818b2
	#848484
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#1818b2;background-color:#848484;">'
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[0;34m'
}
_color_begin_good() {
	#17ae17
	#848484
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#17ae17;background-color:#848484;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[0;32m '
}
_color_begin_warn() {
	#ffff54
	#848484
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#ffff54;background-color:#848484;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[1;33m '
}
_color_begin_bad() {
	#b21818
	#848484
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#b21818;background-color:#848484;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[0;31m '
}
_color_begin_Normal() {
	#54ff54
	#18b2b2
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#54ff54;background-color:#18b2b2;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[1;32;46m '
}
_color_begin_Error() {
	#ffff54
	#b21818
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#ffff54;background-color:#b21818;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[1;33;41m '
}
_color_begin_DELAYipc() {
	#ffff54
	#b2b2b2
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '<span style="color:#ffff54;background-color:#b2b2b2;"> '
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n '\E[1;33;47m '
}



#Purple. User must do something manually to proceed. NOT to be used for dependency installation requests - use probe, bad, and fail statements for that.
_messagePlain_request() {
	_color_begin_request
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Cyan. Harmless status messages.
#"generic/ubiquitousheader.sh"
_messagePlain_nominal() {
	_color_begin_nominal
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
#"generic/ubiquitousheader.sh"
_messagePlain_probe() {
	_color_begin_probe
	#_color_begin_probe_noindent
	echo -n "$@"
	_color_end
	echo
	return 0
}
_messagePlain_probe_noindent() {
	#_color_begin_probe
	_color_begin_probe_noindent
	echo -n "$@"
	_color_end
	echo
	return 0
}
# WARNING: Less track record with very unusual text. May or may not output correctly in some (unknown, unexpected) situations.
# DANGER: MUST use this function instead of _messagePlain_probe when text is from external origins!
_messagePlain_probe_safe() {
	_color_begin_probe
	#_color_begin_probe_noindent
	#echo -n "$@"
	_safeEcho "$@"
	_color_end
	echo
	return
}

#Blue. Diagnostic instrumentation.
#"generic/ubiquitousheader.sh"
_messagePlain_probe_expr() {
	_color_begin_probe
	echo -e -n "$@"
	_color_end
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
#"generic/ubiquitousheader.sh"
_messagePlain_probe_var() {
	_color_begin_probe
	
	echo -n "$1"'= '
	
	eval echo -e -n \$"$1"
	
	_color_end
	echo
	return 0
}
_messageVar() {
	_messagePlain_probe_var "$@"
}

#Green. Working as expected.
#"generic/ubiquitousheader.sh"
_messagePlain_good() {
	_color_begin_good
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Yellow. May or may not be a problem.
#"generic/ubiquitousheader.sh"
_messagePlain_warn() {
	_color_begin_warn
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Red. Will result in missing functionality, reduced performance, etc, but not necessarily program failure overall.
_messagePlain_bad() {
	_color_begin_bad
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
#Prints "$@" and runs "$@".
# WARNING: Use with care.
_messagePlain_probe_cmd() {
	_color_begin_probe
	
	_safeEcho "$@"
	
	_color_end
	echo
	
	"$@"
	
	return
}
_messageCMD() {
	_messagePlain_probe_cmd "$@"
}

#Blue. Diagnostic instrumentation.
#Prints "$@" with quotes around every parameter.
_messagePlain_probe_quoteAddDouble() {
	_color_begin_probe
	
	_safeEcho_quoteAddDouble "$@"
	
	_color_end
	echo
	
	return
}
_messagePlain_probe_quoteAdd() {
	_messagePlain_probe_quoteAddDouble "$@"
}

#Blue. Diagnostic instrumentation.
#Prints "$@" with single quotes around every parameter.
_messagePlain_probe_quoteAddSingle() {
	_color_begin_probe
	
	_safeEcho_quoteAddSingle "$@"
	
	_color_end
	echo
	
	return
}

#Blue. Diagnostic instrumentation.
#Prints "$@" and runs "$@".
# WARNING: Use with care.
_messagePlain_probe_cmd_quoteAdd() {
	
	_messagePlain_probe_quoteAdd "$@"
	
	"$@"
	
	return
}
_messageCMD_quoteAdd() {
	_messagePlain_probe_cmd_quoteAdd "$@"
}

#Demarcate major steps.
_messageNormal() {
	_color_begin_Normal
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Demarcate major failures.
_messageError() {
	_color_begin_Error
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Demarcate need to fetch/generate dependency automatically - not a failure condition.
_messageNEED() {
	_messageNormal "NEED"
	#echo " NEED "
}

#Demarcate have dependency already, no need to fetch/generate.
_messageHAVE() {
	_messageNormal "HAVE"
	#echo " HAVE "
}

_messageWANT() {
	_messageNormal "WANT"
	#echo " WANT "
}

#Demarcate where PASS/FAIL status cannot be absolutely proven. Rarely appropriate - usual best practice is to simply progress to the next major step.
_messageDONE() {
	_messageNormal "DONE"
	#echo " DONE "
}

_messagePASS() {
	_messageNormal "PASS"
	#echo " PASS "
}

#Major failure. Program stopped.
_messageFAIL() {
	_messageError "FAIL"
	#echo " FAIL "
	_stop 1
	exit 1
	return 0
}

_messageWARN() {
	echo
	echo "$@"
	return 0
}

# Demarcate *any* delay performed to allow 'InterProcess-Communication' connections (perhaps including at least some network or serial port servers).
_messageDELAYipc() {
	_color_begin_DELAYipc
	echo -e -n 'delay: InterProcess-Communication'
	_color_end
	echo
}


_messageProcess() {
	local processString
	processString="$1""..."
	
	local processStringLength
	processStringLength=${#processString}
	
	local currentIteration
	currentIteration=0
	
	local padLength
	let padLength=40-"$processStringLength"
	
	[[ "$processStringLength" -gt "38" ]] && _messageNormal "$processString" && return 0
	
	_color_begin_Normal
	
	echo -n "$processString"
	
	_color_end
	
	while [[ "$currentIteration" -lt "$padLength" ]]
	do
		echo -e -n ' '
		let currentIteration="$currentIteration"+1
	done
	
	return 0
}


_sep() {
	echo '________________________________________'
}

_mustcarry() {
	grep "$1" "$2" > /dev/null 2>&1 && return 0
	
	echo "$1" >> "$2"
	return
}

#Determines if user is root. If yes, then continue. If not, exits after printing error message.
_mustBeRoot() {
if [[ $(id -u) != 0 ]]; then 
	echo "This must be run as root!"
	exit
fi
}
alias mustBeRoot=_mustBeRoot

#Determines if sudo is usable by scripts.
_mustGetSudo() {
	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	_if_cygwin && return 0
	
	local rootAvailable
	rootAvailable=false
	
	rootAvailable=$(sudo -n echo true)
	
	#[[ $(id -u) == 0 ]] && rootAvailable=true
	
	! [[ "$rootAvailable" == "true" ]] && exit 1
	
	return 0
}

#Determines if sudo is usable by scripts. Will not exit on failure.
_wantSudo() {
	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	_if_cygwin && return 0
	
	local rootAvailable
	rootAvailable=false
	
	rootAvailable=$(sudo -n echo true 2> /dev/null)
	
	#[[ $(id -u) == 0 ]] && rootAvailable=true
	
	! [[ "$rootAvailable" == "true" ]] && return 1
	
	return 0
}

#Returns a UUID in the form of xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
_getUUID() {
	if [[ -e /proc/sys/kernel/random/uuid ]]
	then
		cat /proc/sys/kernel/random/uuid
		return 0
	fi
	
	
	if type -p uuidgen > /dev/null 2>&1
	then
		uuidgen
		return 0
	fi
	
	# Failure. Intentionally adds extra characters to cause any tests of uuid output to fail.
	_uid 40
	return 1
}
alias getUUID=_getUUID

#Gets filename extension, specifically any last three characters in given string.
#"$1" == filename
_getExt() {
	echo "$1" | tr -dc 'a-zA-Z0-9.' | tr '[:upper:]' '[:lower:]' | tail -c 4
}

#Reports either the directory provided, or the directory of the file provided.
_findDir() {
	local dirIn=$(_getAbsoluteLocation "$1")
	dirInLogical=$(_realpath_L_s "$dirIn")
	
	if [[ -d "$dirInLogical" ]]
	then
		echo "$dirInLogical"
		return
	fi
	
	echo $(_getAbsoluteFolder "$dirInLogical")
	return
	
}

_discoverResource() {
	
	[[ "$scriptAbsoluteFolder" == "" ]] && return 1
	
	local testDir
	testDir="$scriptAbsoluteFolder" ; [[ -e "$testDir"/"$1" ]] && echo "$testDir"/"$1" && return 0
	testDir="$scriptAbsoluteFolder"/.. ; [[ -e "$testDir"/"$1" ]] && echo "$testDir"/"$1" && return 0
	testDir="$scriptAbsoluteFolder"/../.. ; [[ -e "$testDir"/"$1" ]] && echo "$testDir"/"$1" && return 0
	testDir="$scriptAbsoluteFolder"/../../.. ; [[ -e "$testDir"/"$1" ]] && echo "$testDir"/"$1" && return 0
	
	return 1
}

_rmlink() {
	[[ "$1" == "/dev/null" ]] && return 1
	
	#[[ -h "$1" ]] && rm -f "$1" && return 0
	[[ -h "$1" ]] && rm -f "$1" > /dev/null 2>&1
	
	! [[ -e "$1" ]] && return 0
	
	return 1
}

#Like "ln -sf", but will not proceed if target is not link and exists (ie. will not erase files).
_relink_procedure() {
	#Do not update correct symlink.
	local existingLinkTarget
	existingLinkTarget=$(readlink "$2")
	[[ "$existingLinkTarget" == "$1" ]] && return 0
	
	! [[ "$relinkRelativeUb" == "true" ]] && _rmlink "$2" && ln -s "$1" "$2" && return 0
	
	if [[ "$relinkRelativeUb" == "true" ]]
	then
		_rmlink "$2" && ln -s --relative "$1" "$2" && return 0
	fi
	
	return 1
}

_relink() {
	[[ "$2" == "/dev/null" ]] && return 1
	[[ "$relinkRelativeUb" == "true" ]] && export relinkRelativeUb=""
	_relink_procedure "$@"
}

_relink_relative() {
	export relinkRelativeUb=""
	
	[[ "$relinkRelativeUb" != "true" ]] && ln --help 2>/dev/null | grep '\-\-relative' > /dev/null 2>&1 && export relinkRelativeUb="true"
	[[ "$relinkRelativeUb" != "true" ]] && ln 2>&1 | grep '\-\-relative' > /dev/null 2>&1 && export relinkRelativeUb="true"
	[[ "$relinkRelativeUb" != "true" ]] && man ln 2>/dev/null | grep '\-\-relative' > /dev/null 2>&1 && export relinkRelativeUb="true"
	
	_relink_procedure "$@"
	export relinkRelativeUb=""
	unset relinkRelativeUb
}

#Copies files only if source/destination do match. Keeps files in a completely written state as often as possible.
_cpDiff() {
	! diff "$1" "$2" > /dev/null 2>&1 && cp "$1" "$2"
}

#Waits for the process PID specified by first parameter to end. Useful in conjunction with $! to provide process control and/or PID files. Unlike wait command, does not require PID to be a child of the current shell.
_pauseForProcess() {
	while ps --no-headers -p $1 &> /dev/null
	do
		sleep 0.3
	done
}
alias _waitForProcess=_pauseForProcess
alias waitForProcess=_pauseForProcess

_test_daemon() {
	_getDep pkill
}

#To ensure the lowest descendents are terminated first, the file must be created in reverse order. Additionally, PID files created before a prior reboot must be discarded and ignored.
_prependDaemonPID() {
	
	#Reset locks from before prior reboot.
	_readLocked "$daemonPidFile"lk
	_readLocked "$daemonPidFile"op
	_readLocked "$daemonPidFile"cl
	
	while true
	do
		_createLocked "$daemonPidFile"op && break
		sleep 0.1
	done
	
	#Removes old PID file if not locked during current UNIX session (ie. since latest reboot).  Prevents termination of non-daemon PIDs.
	if ! _readLocked "$daemonPidFile"lk
	then
		rm -f "$daemonPidFile"
		rm -f "$daemonPidFile"t
	fi
	_createLocked "$daemonPidFile"lk
	
	[[ ! -e "$daemonPidFile" ]] && echo >> "$daemonPidFile"
	cat - "$daemonPidFile" >> "$daemonPidFile"t
	mv "$daemonPidFile"t "$daemonPidFile"
	
	rm -f "$daemonPidFile"op
}

#By default, process descendents will be terminated first. Doing so is essential to reaching sub-proesses of sub-scripts, without manual user input.
#https://stackoverflow.com/questions/34438189/bash-sleep-process-not-getting-killed
_daemonSendTERM() {
	#Terminate descendents if parent has not been able to quit.
	pkill -P "$1"
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.1
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.3
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 2
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 6
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 9
	
	#Kill descendents if parent has not been able to quit.
	pkill -KILL -P "$1"
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.1
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.3
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 2
	
	#Terminate parent if parent has not been able to quit.
	kill -TERM "$1"
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.1
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.3
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 2
	
	#Kill parent if parent has not been able to quit.
	kill KILL "$1"
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.1
	! ps -p "$1" >/dev/null 2>&1 && return 0
	sleep 0.3
	
	#Failure to immediately kill parent is an extremely rare, serious error.
	ps -p "$1" >/dev/null 2>&1 && return 1
	return 0
}

#No production use.
_daemonSendKILL() {
	pkill -KILL -P "$1"
	kill -KILL "$1"
}

#True if any daemon registered process is running.
_daemonAction() {
	[[ ! -e "$daemonPidFile" ]] && return 1
	
	local currentLine
	local processedLine
	local daemonStatus
	
	while IFS='' read -r currentLine || [[ -n "$currentLine" ]]; do
		processedLine=$(echo "$currentLine" | tr -dc '0-9')
		if [[ "$processedLine" != "" ]] && ps -p "$processedLine" >/dev/null 2>&1
		then
			daemonStatus="up"
			[[ "$1" == "status" ]] && return 0
			[[ "$1" == "terminate" ]] && _daemonSendTERM "$processedLine"
			[[ "$1" == "kill" ]] && _daemonSendKILL "$processedLine"
		fi
	done < "$daemonPidFile"
	
	[[ "$daemonStatus" == "up" ]] && return 0
	return 1
}

_daemonStatus() {
	_daemonAction "status"
}

#No production use.
_waitForTermination() {
	_daemonStatus && sleep 0.1
	_daemonStatus && sleep 0.3
	_daemonStatus && sleep 1
	_daemonStatus && sleep 2
}
alias _waitForDaemon=_waitForTermination

#Kills background process using PID file.
_killDaemon() {
	#Do NOT proceed if PID values may be invalid.
	! _readLocked "$daemonPidFile"lk && return 1
	
	#Do NOT proceed if daemon is starting (opening).
	_readLocked "$daemonPidFile"op && return 1
	
	! _createLocked "$daemonPidFile"cl && return 1
	
	#Do NOT proceed if daemon is starting (opening).
	_readLocked "$daemonPidFile"op && return 1
	
	_daemonAction "terminate"
	
	#Do NOT proceed to detele lock/PID files unless daemon can be confirmed down.
	_daemonStatus && return 1
	
	rm -f "$daemonPidFile" >/dev/null 2>&1
	rm -f "$daemonPidFile"lk
	rm -f "$daemonPidFile"cl
	
	return 0
}

_cmdDaemon_sequence() {
	export isDaemon=true
	
	"$@" &
	
	local currentPID="$!"
	
	#Any PID which may be part of a daemon may be appended to this file.
	echo "$currentPID" | _prependDaemonPID
	
	wait "$currentPID"
}

_cmdDaemon() {
	"$scriptAbsoluteLocation" _cmdDaemon_sequence "$@" &
	disown -a -h -r
	disown -a -r
}

#Executes self in background (ie. as daemon).
_execDaemon() {
	#_daemonStatus && return 1
	
	_cmdDaemon "$scriptAbsoluteLocation"
}

_launchDaemon() {
	_start
	
	_killDaemon
	
	
	_execDaemon
	while _daemonStatus
	do
		sleep 5
	done
	
	
	
	
	
	_stop
}

#Remote TERM signal wrapper. Verifies script is actually running at the specified PID before passing along signal to trigger an emergency stop.
#"$1" == pidFile
#"$2" == sessionid (optional for cleaning up stale systemd files)
_remoteSigTERM() {
	[[ ! -e "$1" ]] && [[ "$2" != "" ]] && _unhook_systemd_shutdown "$2"
	
	[[ ! -e "$1" ]] && return 0
	
	pidToTERM=$(cat "$1")
	
	kill -TERM "$pidToTERM"
	
	_pauseForProcess "$pidToTERM"
}

_embed_here() {
	cat << CZXWXcRMTo8EmM8i4d
#!/usr/bin/env bash

export scriptAbsoluteLocation="$scriptAbsoluteLocation"
export scriptAbsoluteFolder="$scriptAbsoluteFolder"
export sessionid="$sessionid"
. "$scriptAbsoluteLocation" --embed "\$@"
CZXWXcRMTo8EmM8i4d
}

_embed() {
	export sessionid="$1"
	"$scriptAbsoluteLocation" --embed "$@"
}

#"$@" == URL
_fetch() {
	if type axel > /dev/null 2>&1
	then
		axel "$@"
		return 0
	fi
	
	wget "$@"
	
	return 0
}

_validatePort() {
	[[ "$1" -lt "1024" ]] && return 1
	[[ "$1" -gt "65535" ]] && return 1
	
	return 0
}

_testFindPort() {
	! _wantGetDep ss
	! _wantGetDep sockstat
	
	# WARNING: Not yet relying exclusively on 'netstat' - recommend continuing to install 'nmap' for Cygwin port range detection (and also for _waitPort) .
	if uname -a | grep -i cygwin > /dev/null 2>&1
	then
		# ATTENTION: Use of nmap on Cygwin/MSW is apparently unnecessary. Beginning to disable for this use case.
		#! type nmap > /dev/null 2>&1 && echo "missing socket detection: nmap" && _stop 1
		! type netstat | grep cygdrive > /dev/null 2>&1 && echo "missing socket detection: netstat" && _stop 1
		return 0
	fi
	
	! type ss > /dev/null 2>&1 && ! type sockstat > /dev/null 2>&1 && echo "missing socket detection" && _stop 1
	
	local machineLowerPort=$(cat /proc/sys/net/ipv4/ip_local_port_range 2> /dev/null | cut -f1)
	local machineUpperPort=$(cat /proc/sys/net/ipv4/ip_local_port_range 2> /dev/null | cut -f2)
	
	[[ "$machineLowerPort" == "" ]] && echo "warn: autodetect: lower_port"
	[[ "$machineUpperPort" == "" ]] && echo "warn: autodetect: upper_port"
	[[ "$machineLowerPort" == "" ]] || [[ "$machineUpperPort" == "" ]] && return 0
	
	[[ "$machineLowerPort" -lt "1024" ]] && echo "invalid lower_port" && _stop 1
	[[ "$machineLowerPort" -lt "32768" ]] && echo "warn: low lower_port"
	[[ "$machineLowerPort" -gt "32768" ]] && echo "warn: high lower_port"
	
	[[ "$machineUpperPort" -gt "65535" ]] && echo "invalid upper_port" && _stop 1
	[[ "$machineUpperPort" -gt "60999" ]] && echo "warn: high upper_port"
	[[ "$machineUpperPort" -lt "60999" ]] && echo "warn: low upper_port"
	
	local testFoundPort
	testFoundPort=$(_findPort)
	! _validatePort "$testFoundPort" && echo "invalid port discovery" && _stop 1
}

#True if port open (in use).
_checkPort_local() {
	[[ "$1" == "" ]] && return 1
	
	if type ss > /dev/null 2>&1
	then
		ss -lpn | grep ':'"$1"' ' > /dev/null 2>&1
		return $?
	fi
	
	if type sockstat > /dev/null 2>&1
	then
		sockstat -46ln | grep '\.'"$1"' ' > /dev/null 2>&1
		return $?
	fi
	
	if uname -a | grep -i cygwin > /dev/null 2>&1 && type netstat > /dev/null 2>&1 && type netstat | grep cygdrive > /dev/null 2>&1
	then
		#nmap --host-timeout 0.1 -Pn localhost -p "$1" 2> /dev/null | grep open > /dev/null 2>&1
		
		# https://www.maketecheasier.com/check-ports-in-use-windows10/
		#netstat -a | grep 'TCP\|UDP' | cut -f 1-7 -d\
		netstat -a -n -q | grep 'TCP\|UDP' | cut -f 1-8 -d\  | grep ':'"$1" > /dev/null 2>&1
		return $?
	fi
	
	if type nmap > /dev/null 2>&1 && ! uname -a | grep -i cygwin > /dev/null
	then
		nmap --host-timeout 0.1 -Pn localhost -p "$1" 2> /dev/null | grep open > /dev/null 2>&1
		return $?
	fi
	
	return 1
}

#Waits a reasonable time interval for port to be open (in use).
#"$1" == port
_waitPort_local() {
	local checksDone
	checksDone=0
	while ! _checkPort_local "$1" && [[ "$checksDone" -lt 72 ]]
	do
		let checksDone+=1
		sleep 0.1
	done
	
	local checksDone
	checksDone=0
	while ! _checkPort_local "$1" && [[ "$checksDone" -lt 72 ]]
	do
		let checksDone+=1
		sleep 0.3
	done
	
	local checksDone
	checksDone=0
	while ! _checkPort_local "$1" && [[ "$checksDone" -lt 72 ]]
	do
		let checksDone+=1
		sleep 1
	done
	
	return 0
}


#http://unix.stackexchange.com/questions/55913/whats-the-easiest-way-to-find-an-unused-local-port
_findPort() {
	local lower_port
	local upper_port
	
	lower_port="$1"
	upper_port="$2"
	
	#Non public ports are between 49152-65535 (2^15 + 2^14 to 2^16 - 1).
	#Convention is to assign ports 55000-65499 and 50025-53999 to specialized servers.
	#read lower_port upper_port < /proc/sys/net/ipv4/ip_local_port_range
	[[ "$lower_port" == "" ]] && lower_port=54000
	[[ "$upper_port" == "" ]] && upper_port=54999
	
	local range_port
	local rand_max
	let range_port="upper_port - lower_port"
	let rand_max="range_port / 2"
	
	local portRangeOffset
	portRangeOffset=$RANDOM
	#let "portRangeOffset %= 150"
	let "portRangeOffset %= rand_max"
	
	[[ "$opsautoGenerationMode" == "true" ]] && [[ "$lowestUsedPort" == "" ]] && export lowestUsedPort="$lower_port"
	[[ "$opsautoGenerationMode" == "true" ]] && lower_port="$lowestUsedPort"
	
	! [[ "$opsautoGenerationMode" == "true" ]] && let "lower_port += portRangeOffset"
	
	while true
	do
		for (( currentPort = lower_port ; currentPort <= upper_port ; currentPort++ )); do
			if ! _checkPort_local "$currentPort"
			then
				sleep 0.1
				if ! _checkPort_local "$currentPort"
				then
					break 2
				fi
			fi
		done
	done
	
	if [[ "$opsautoGenerationMode" == "true" ]]
	then
		local nextUsablePort
		
		let "nextUsablePort = currentPort + 1"
		export lowestUsedPort="$nextUsablePort"
		
	fi
	
	echo "$currentPort"
	
	_validatePort "$currentPort"
}

_test_waitport() {
	_discoverResource-cygwinNative-nmap
	
	if _if_cygwin && ! type nmap > /dev/null 2>&1
	then
		echo 'warn: missing: nmap'
	else
	_getDep nmap
	fi
}

_showPort_ipv6() {
	_discoverResource-cygwinNative-nmap

	nmap -6 --host-timeout "$netTimeout" -Pn "$1" -p "$2" 2> /dev/null
}

_showPort_ipv4() {
	_discoverResource-cygwinNative-nmap
	
	nmap --host-timeout "$netTimeout" -Pn "$1" -p "$2" 2> /dev/null
}

_checkPort_ipv6() {
	if _showPort_ipv6 "$@" | grep open > /dev/null 2>&1
	then
		return 0
	fi
	return 1
}

#Checks hostname for open port.
#"$1" == hostname
#"$2" == port
_checkPort_ipv4() {
	if _showPort_ipv4 "$@" | grep open > /dev/null 2>&1
	then
		return 0
	fi
	return 1
}

_checkPort_sequence() {
	_start scriptLocal_mkdir_disable
	
	local currentEchoStatus
	currentEchoStatus=$(stty --file=/dev/tty -g 2>/dev/null)
	
	local currentExitStatus
	
	if ( [[ "$1" == 'localhost' ]] || [[ "$1" == '::1' ]] || [[ "$1" == '127.0.0.1' ]] )
	then
		_checkPort_ipv4 "localhost" "$2"
		return "$?"
	fi
	
	#Lack of coproc support implies old system, which implies IPv4 only.
	#if ! type coproc >/dev/null 2>&1
	#then
	#	_checkPort_ipv4 "$1" "$2"
	#	return "$?"
	#fi
	
	( ( _showPort_ipv4 "$1" "$2" ) 2> /dev/null > "$safeTmp"/_showPort_ipv4 & )
	
	( ( _showPort_ipv6 "$1" "$2" ) 2> /dev/null > "$safeTmp"/_showPort_ipv6 & )
	
	
	local currentTimer
	currentTimer=1
	while [[ "$currentTimer" -le "$netTimeout" ]]
	do
		grep -m1 'open' "$safeTmp"/_showPort_ipv4 > /dev/null 2>&1 && _stop
		grep -m1 'open' "$safeTmp"/_showPort_ipv6 > /dev/null 2>&1 && _stop
		
		! [[ $(jobs | wc -c) -gt '0' ]] && ! grep -m1 'open' "$safeTmp"/_showPort_ipv4 && grep -m1 'open' "$safeTmp"/_showPort_ipv6 > /dev/null 2>&1 && _stop 1
		
		let currentTimer="$currentTimer"+1
		sleep 1
	done
	
	
	_stop 1
}

# DANGER: Unstable, abandoned. Reference only.
# WARNING: Limited support for older systems.
#https://unix.stackexchange.com/questions/86270/how-do-you-use-the-command-coproc-in-various-shells
#http://wiki.bash-hackers.org/syntax/keywords/coproc
#http://mywiki.wooledge.org/BashFAQ/024
#[[ $COPROC_PID ]] && kill $COPROC_PID
#coproc { bash -c '(sleep 9 ; echo test) &' ; bash -c 'echo test' ;  } ; grep -m1 test <&${COPROC[0]}
#coproc { echo test ; echo x ; } ; sleep 1 ; grep -m1 test <&${COPROC[0]}
_checkPort_sequence_coproc() {
	local currentEchoStatus
	currentEchoStatus=$(stty --file=/dev/tty -g 2>/dev/null)
	
	local currentExitStatus
	
	if ( [[ "$1" == 'localhost' ]] || [[ "$1" == '::1' ]] || [[ "$1" == '127.0.0.1' ]] )
	then
		_checkPort_ipv4 "localhost" "$2"
		return "$?"
	fi
	
	#Lack of coproc support implies old system, which implies IPv4 only.
	if ! type coproc >/dev/null 2>&1
	then
		_checkPort_ipv4 "$1" "$2"
		return "$?"
	fi
	
	#coproc { sleep 30 ; echo foo ; sleep 30 ; echo bar; } ; grep -m1 foo <&${COPROC[0]}
	#[[ $COPROC_PID ]] && kill $COPROC_PID ; coproc { ((sleep 1 ; echo test) &) ; echo x ; sleep 3 ; } ; sleep 0.1 ; grep -m1 test <&${COPROC[0]}
	
	[[ "$COPROC_PID" ]] && kill "$COPROC_PID" > /dev/null 2>&1
	coproc {
		( ( _showPort_ipv4 "$1" "$2" ) & )
		
		#[sleep] Lessens unlikely occurrence of interleaved text within "open" keyword.
		#IPv6 delayed instead of IPv4 due to likelihood of additional delay by IPv6 tunneling.
		#sleep 0.1
		
		# TODO: Better characterize problems with sleep.
		# Workaround - sleep may disable 'stty echo', which may be irreversable within SSH proxy command.
		#_timeout 0.1 cat < /dev/zero > /dev/null
		if ! ping -c 2 -i 0.1 localhost > /dev/null 2>&1
		then
			ping -c 2 -i 1 localhost > /dev/null 2>&1
		fi
		
		#[sleep] Lessens unlikely occurrence of interleaved text within "open" keyword.
		#IPv6 delayed instead of IPv4 due to likelihood of additional delay by IPv6 tunneling.
		( ( _showPort_ipv6 "$1" "$2" ) & )

		#sleep 2
		ping -c 2 -i 2 localhost > /dev/null 2>&1
	}
	grep -m1 open <&"${COPROC[0]}" > /dev/null 2>&1
	currentExitStatus="$?"
	
	stty --file=/dev/tty "$currentEchoStatus" 2> /dev/null
	
	return "$currentExitStatus"
}

#Checks hostname for open port.
#"$1" == hostname
#"$2" == port
_checkPort() {
	#local currentEchoStatus
	#currentEchoStatus=$(stty --file=/dev/tty -g 2>/dev/null)
	
	#if bash -c \""$scriptAbsoluteLocation"\"\ _checkPort_sequence\ \""$1"\"\ \""$2"\" > /dev/null 2>&1
	if "$scriptAbsoluteLocation" _checkPort_sequence "$1" "$2" > /dev/null 2>&1
	then
		#stty --file=/dev/tty "$currentEchoStatus" 2> /dev/null
		return 0
	fi
	#stty --file=/dev/tty "$currentEchoStatus" 2> /dev/null
	return 1
}


#Waits a reasonable time interval for port to be open.
#"$1" == hostname
#"$2" == port
_waitPort() {
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.1
	_checkPort "$1" "$2" && return 0
	sleep 0.3
	_checkPort "$1" "$2" && return 0
	sleep 0.3
	_checkPort "$1" "$2" && return 0
	sleep 0.6
	
	local checksDone
	checksDone=0
	while ! _checkPort "$1" "$2" && [[ "$checksDone" -lt 72 ]]
	do
		let checksDone+=1
		sleep 1
	done
	
	return 0
}

#Run command and output to terminal with colorful formatting. Controlled variant of "bash -v".
_showCommand() {
	echo -e '\E[1;32;46m $ '"$1"' \E[0m'
	"$@"
}

#Validates non-empty request.
_validateRequest() {
	echo -e -n '\E[1;32;46m Validating request '"$1"'...	\E[0m'
	[[ "$1" == "" ]] && echo -e '\E[1;33;41m BLANK \E[0m' && return 1
	echo "PASS"
	return
}

#http://www.commandlinefu.com/commands/view/3584/remove-color-codes-special-characters-with-sed
_nocolor() {
	sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

_noFireJail() {
	if ( [[ -L /usr/local/bin/"$1" ]] && ls -l /usr/local/bin/"$1" | grep firejail > /dev/null 2>&1 ) || ( [[ -L /usr/bin/"$1" ]] && ls -l /usr/bin/"$1" | grep firejail > /dev/null 2>&1 )
	then
		 _messagePlain_bad 'conflict: firejail: '"$1"
		 return 1
	fi
	
	return 0
}

#Copy log files to "$permaLog" or current directory (default) for analysis.
_preserveLog() {
	if [[ ! -d "$permaLog" ]]
	then
		permaLog="$PWD"
	fi
	
	cp "$logTmp"/* "$permaLog"/ > /dev/null 2>&1
}

_typeShare() {
	_typeDep "$1" && return 0
	
	[[ -e /usr/share/"$1" ]] && ! [[ -d /usr/share/"$1" ]] && return 0
	[[ -e /usr/local/share/"$1" ]] && ! [[ -d /usr/local/share/"$1" ]] && return 0
	
	[[ -d /usr/share/"$1" ]] && return 2
	[[ -d /usr/local/share/"$1" ]] && return 2
	
	[[ "$1" == '/'* ]] && [[ -e "$1"* ]] && return 3
	ls /usr/share/"$1"* > /dev/null 2>&1 && return 3
	ls /usr/local/share/"$1"* > /dev/null 2>&1 && return 3
	
	return 1
}

_typeShare_dir_wildcard() {
	local currentFunctionReturn
	_typeShare "$@"
	currentFunctionReturn="$?"
	
	[[ "$currentFunctionReturn" == '0' ]] && return 0
	[[ "$currentFunctionReturn" == '2' ]] && return 0
	[[ "$currentFunctionReturn" == '3' ]] && return 0
	return 1
}

_typeShare_dir() {
	local currentFunctionReturn
	_typeShare "$@"
	currentFunctionReturn="$?"
	
	[[ "$currentFunctionReturn" == '0' ]] && return 0
	[[ "$currentFunctionReturn" == '2' ]] && return 0
	return 1
}

_typeDep() {
	
	# WARNING: Allows specification of entire path from root. *Strongly* prefer use of subpath matching, for increased portability.
	[[ "$1" == '/'* ]] && [[ -e "$1" ]] && return 0
	
	[[ -e /lib/"$1" ]] && ! [[ -d /lib/"$1" ]] && return 0
	[[ -e /lib/x86_64-linux-gnu/"$1" ]] && ! [[ -d /lib/x86_64-linux-gnu/"$1" ]] && return 0
	[[ -e /lib64/"$1" ]] && ! [[ -d /lib64/"$1" ]] && return 0
	[[ -e /lib64/x86_64-linux-gnu/"$1" ]] && ! [[ -d /lib64/x86_64-linux-gnu/"$1" ]] && return 0
	[[ -e /usr/lib/"$1" ]] && ! [[ -d /usr/lib/"$1" ]] && return 0
	[[ -e /usr/lib/x86_64-linux-gnu/"$1" ]] && ! [[ -d /usr/lib/x86_64-linux-gnu/"$1" ]] && return 0
	[[ -e /usr/local/lib/"$1" ]] && ! [[ -d  /usr/local/lib/"$1" ]] && return 0
	[[ -e /usr/local/lib/x86_64-linux-gnu/"$1" ]] && ! [[ -d /usr/local/lib/x86_64-linux-gnu/"$1" ]] && return 0
	[[ -e /usr/include/"$1" ]] && ! [[ -d /usr/include/"$1" ]] && return 0
	[[ -e /usr/include/x86_64-linux-gnu/"$1" ]] && ! [[ -d /usr/include/x86_64-linux-gnu/"$1" ]] && return 0
	[[ -e /usr/local/include/"$1" ]] && ! [[ -d /usr/local/include/"$1" ]] && return 0
	[[ -e /usr/local/include/x86_64-linux-gnu/"$1" ]] && ! [[ -d /usr/local/include/x86_64-linux-gnu/"$1" ]] && return 0
	
	if ! type "$1" >/dev/null 2>&1
	then
		return 1
	fi
	
	return 0
}

_wantDep() {
	_typeDep "$1" && return 0
	
	# Expect already root if 'MSW/Cygwin' and obstructive popup dialog if 'sudo' is called through 'MSW/Cygwin' .
	_if_cygwin && return 1
	
	_wantSudo && sudo -n "$scriptAbsoluteLocation" _typeDep "$1" && return 0
	
	return 1
}

_mustGetDep() {
	_typeDep "$1" && return 0
	
	# Expect already root if 'MSW/Cygwin' and obstructive popup dialog if 'sudo' is called through 'MSW/Cygwin' .
	_if_cygwin && return 1
	
	_wantSudo && sudo -n "$scriptAbsoluteLocation" _typeDep "$1" && return 0
	
	echo "$1" missing
	_stop 1
}

_fetchDep_distro() {
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Debian\|Raspbian' > /dev/null 2>&1
	then
		_tryExecFull _fetchDep_debian "$@"
		return
	fi
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' > /dev/null 2>&1
	then
		_tryExecFull _fetchDep_ubuntu "$@"
		return
	fi
	return 1
}

_wantGetDep() {
	_wantDep "$@" && return 0
	
	_fetchDep_distro "$@"
	
	_wantDep "$@" && return 0
	return 1
}

_getDep() {
	_wantDep "$@" && return 0
	
	_fetchDep_distro "$@"
	
	_mustGetDep "$@"
}

_apt-file_sequence() {
	_start
	
	_mustGetSudo
	#_mustGetDep su
	
	! _wantDep apt-file && sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y apt-file
	_checkDep apt-file
	
	sudo -n apt-file "$@" > "$safeTmp"/pkgsOut 2> "$safeTmp"/pkgsErr
	sudo -n apt-file search bash > "$safeTmp"/checkOut 2> "$safeTmp"/checkErr
	
	while ! [[ -s "$safeTmp"/checkOut ]] || cat "$safeTmp"/pkgsErr | grep 'cache is empty' > /dev/null 2>&1
	do
		sudo -n apt-file update > "$safeTmp"/updateOut 2> "$safeTmp"/updateErr
		sudo -n apt-file "$@" > "$safeTmp"/pkgsOut 2> "$safeTmp"/pkgsErr
		sudo -n apt-file search bash > "$safeTmp"/checkOut 2> "$safeTmp"/checkErr
	done
	
	cat "$safeTmp"/pkgsOut
	#cat "$safeTmp"/pkgsErr >&2
	_stop
}

_apt-file() {
	_timeout 750 "$scriptAbsoluteLocation" _apt-file_sequence "$@"
}












_fetchDep_debianBookworm_special() {
	sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
	
# 	if [[ "$1" == *"java"* ]]
# 	then
# 		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y default-jdk default-jre
# 		return 0
# 	fi
	
	if [[ "$1" == *"wine"* ]] && ! dpkg --print-foreign-architectures | grep i386 > /dev/null 2>&1
	then
		sudo -n dpkg --add-architecture i386
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y wine wine32 wine64 libwine libwine:i386 fonts-wine
		return 0
	fi
	
	if [[ "$1" == "realpath" ]] || [[ "$1" == "readlink" ]] || [[ "$1" == "dirname" ]] || [[ "$1" == "basename" ]] || [[ "$1" == "sha512sum" ]] || [[ "$1" == "sha256sum" ]] || [[ "$1" == "head" ]] || [[ "$1" == "tail" ]] || [[ "$1" == "sleep" ]] || [[ "$1" == "env" ]] || [[ "$1" == "cat" ]] || [[ "$1" == "mkdir" ]] || [[ "$1" == "dd" ]] || [[ "$1" == "rm" ]] || [[ "$1" == "ln" ]] || [[ "$1" == "ls" ]] || [[ "$1" == "test" ]] || [[ "$1" == "true" ]] || [[ "$1" == "false" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y coreutils
		return 0
	fi
	
	if [[ "$1" == "mount" ]] || [[ "$1" == "umount" ]] || [[ "$1" == "losetup" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y mount
		return 0
	fi
	
	if [[ "$1" == "mountpoint" ]] || [[ "$1" == "mkfs" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y util-linux
		return 0
	fi
	
	if [[ "$1" == "mkfs.ext4" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y e2fsprogs
		return 0
	fi
	
	if [[ "$1" == "parted" ]] || [[ "$1" == "partprobe" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y parted
		return 0
	fi
	
	if [[ "$1" == "qemu-arm-static" ]] || [[ "$1" == "qemu-armeb-static" ]] || [[ "$1" == "update-binfmts" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qemu qemu-user-static binfmt-support
		#update-binfmts --display
		return 0
	fi
	
	if [[ "$1" == "qemu-system-x86_64" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qemu-system-x86
		return 0
	fi
	
	if [[ "$1" == "qemu-img" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qemu-utils
		return 0
	fi
	
	if [[ "$1" == "VirtualBox" ]] || [[ "$1" == "VBoxSDL" ]] || [[ "$1" == "VBoxManage" ]] || [[ "$1" == "VBoxHeadless" ]]
	then
		sudo -n mkdir -p /etc/apt/sources.list.d
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bookworm contrib' | sudo -n tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		"$scriptAbsoluteLocation" _getDep wget
		! _wantDep wget && return 1
		
		# TODO Check key fingerprints match "B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF" and "7B0F AB3A 13B9 0743 5925  D9C9 5442 2A4B 98AB 5139" respectively.
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo -n apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo -n apt-key add -
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y dkms virtualbox-6.1
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y dkms virtualbox-7.0
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y dkms virtualbox-7.1
		
		# https://www.virtualbox.org/ticket/20949
		if ! type -p virtualbox > /dev/null 2>&1 && ! type -p VirtualBox > /dev/null 2>&1
		then
			#curl -L "https://download.virtualbox.org/virtualbox/6.1.34/virtualbox-6.1_6.1.34-150636.1~Debian~bookworm_amd64.deb" -o "$safeTmp"/"virtualbox-6.1_6.1.34-150636.1~Debian~bookworm_amd64.deb"
			#curl -L "https://download.virtualbox.org/virtualbox/7.0.10/virtualbox-7.0_7.0.10-158379~Debian~bookworm_amd64.deb" -o "$safeTmp"/"virtualbox-7.0_7.0.10-158379~Debian~bookworm_amd64.deb"
			curl -L "https://download.virtualbox.org/virtualbox/7.1.4/virtualbox-7.1_7.1.4-165100~Debian~bookworm_amd64.deb" -o "$safeTmp"/"virtualbox-7.1_7.1.4-165100~Debian~bookworm_amd64.deb"
			sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y dkms
			#yes | sudo -n dpkg -i "$safeTmp"/"virtualbox-6.1_6.1.34-150636.1~Debian~bookworm_amd64.deb"
			#yes | sudo -n dpkg -i "$safeTmp"/"virtualbox-7.0_7.0.10-158379~Debian~bookworm_amd64.deb"
			yes | sudo -n dpkg -i "$safeTmp"/"virtualbox-7.1_7.1.4-165100~Debian~bookworm_amd64.deb"
			sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y -f
		fi
		
		echo "WARNING: Recommend manual system configuration after install. See https://www.virtualbox.org/wiki/Downloads ."
		
		return 0
	fi
	
	if [[ "$1" == "gpg" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y gnupg
		return 0
	fi
	
	#Unlikely scenario for hosts.
	if [[ "$1" == "grub-install" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grub2
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grub-legacy
		return 0
	fi
	
	if [[ "$1" == "MAKEDEV" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y makedev
		return 0
	fi
	
	if [[ "$1" == "fgrep" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grep
		return 0
	fi
	
	if [[ "$1" == "fgrep" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grep
		return 0
	fi
	
	if [[ "$1" == "awk" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y mawk
		return 0
	fi
	
	if [[ "$1" == "kill" ]] || [[ "$1" == "ps" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y procps
		return 0
	fi
	
	if [[ "$1" == "find" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y findutils
		return 0
	fi
	
	if [[ "$1" == "docker" ]] || [[ "$1" == "docker-compose" ]]
	then
		sudo -n update-alternatives --set iptables /usr/sbin/iptables-legacy
		sudo -n update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
		#sudo -n systemctl restart docker
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
		
		# Sometimes may be useful as a workaround for docker 'overlay2' 'storage-driver' .
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y fuse-overlayfs
		
		"$scriptAbsoluteLocation" _getDep curl
		! _wantDep curl && return 1
		
		curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo -n apt-key add -
		local aptKeyFingerprint
		aptKeyFingerprint=$(sudo -n apt-key fingerprint 0EBFCD88 2> /dev/null)
		[[ "$aptKeyFingerprint" == "" ]] && return 1
		
		sudo -n add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get remove -y docker docker-engine docker.io docker-ce docker
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y docker-ce
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y docker-compose-plugin
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y docker-ce

		
		# WARNING: Untested. May cause problems.
		##_getMost_backend_aptGetInstall docker-ce
		###_getMost_backend_aptGetInstall docker-compose-plugin
		##_getMost_backend_aptGetInstall docker-ce
		##_getMost_backend_aptGetInstall docker-buildx-plugin docker-ce-cli docker-ce-rootless-extras
		#_getMost_backend apt-get -d install -y docker-ce
		##_getMost_backend apt-get -d install -y docker-compose-plugin
		#_getMost_backend apt-get -d install -y docker-ce
		##_getMost_backend apt-get -d install -y docker-buildx-plugin docker-ce-cli docker-ce-rootless-extras

		# ATTENTION: Speculative . May be untested. Enable if ever necessary.
		#https://docs.docker.com/compose/install/
		#https://docs.docker.com/compose/install/linux/#install-the-plugin-manually
		#if ! _getMost_backend type docker-compose > /dev/null 2>&1
		#then
			#mkdir -p /usr/local/lib/docker/cli-plugins/docker-compose
			#curl -SL https://github.com/docker/compose/releases/download/v2.32.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
			#chmod 755 /usr/local/lib/docker/cli-plugins/docker-compose
		#fi

		
		sudo -n usermod -a -G docker "$USER"
		
		return 0
	fi
	
	if [[ "$1" == "smbd" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y samba
		return 0
	fi
	
	if [[ "$1" == "atom" ]]
	then
		#curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo -n apt-key add -
		#sudo -n sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/ub_atom.list'
		
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y atom
		
		#return 0
		return 1
	fi
	
	if [[ "$1" == "GL/gl.h" ]] || [[ "$1" == "GL/glext.h" ]] || [[ "$1" == "GL/glx.h" ]] || [[ "$1" == "GL/glxext.h" ]] || [[ "$1" == "GL/dri_interface.h" ]] || [[ "$1" == "x86_64-linux-gnu/pkgconfig/dri.pc" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y mesa-common-dev
		
		return 0
	fi
	
	if [[ "$1" == "go" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y golang-go
		
		return 0
	fi
	
	if [[ "$1" == "php" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y php
		
		return 0
	fi
	
	if [[ "$1" == "cura-lulzbot" ]]
	then
		#Testing/Sid only as of Stretch release cycle.
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y rustc cargo
		
		echo "Requires manual installation. See https://www.lulzbot.com/learn/tutorials/cura-lulzbot-edition-installation-debian ."
cat << 'CZXWXcRMTo8EmM8i4d'
wget -qO - https://download.alephobjects.com/ao/aodeb/aokey.pub | sudo -n apt-key add -
sudo -n cp /etc/apt/sources.list /etc/apt/sources.list.bak && sudo -n sed -i '$a deb http://download.alephobjects.com/ao/aodeb jessie main' /etc/apt/sources.list && sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update && sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install cura-lulzbot
CZXWXcRMTo8EmM8i4d
		echo "(typical)"
		_stop 1
	fi
	
	if [[ "$1" =~ "FlashPrint" ]]
	then
		#Testing/Sid only as of Stretch release cycle.
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y rustc cargo
		
		echo "Requires manual installation. See http://www.flashforge.com/support-center/flashprint-support/ ."
		_stop 1
	fi
	
	if [[ "$1" == "cargo" ]] || [[ "$1" == "rustc" ]]
	then
		#Testing/Sid only as of Stretch release cycle.
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y rustc cargo
		
		echo "Requires manual installation."
cat << 'CZXWXcRMTo8EmM8i4d'
curl https://sh.rustup.rs -sSf | sh
echo '[[ -e "$HOME"/.cargo/bin ]] && export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
CZXWXcRMTo8EmM8i4d
		echo "(typical)"
		_stop 1
	fi
	
	if [[ "$1" == "firejail" ]]
	then
		echo "WARNING: Recommend manual system configuration after install. See https://firejail.wordpress.com/download-2/ ."
		echo "WARNING: Desktop override symlinks may cause problems, especially preventing proxy host jumping by CoreAutoSSH!"
		return 1
	fi
	
	
	if [[ "$1" == "nix-env" ]]
	then
		_tryExec '_test_nix-env_upstream'
		#_tryExec '_test_nix-env_upstream_beta'
		
		return 0
	fi
	
	
	if [[ "$1" == "croc" ]]
	then
		_tryExec '_test_croc_upstream'
		#_tryExec '_test_croc_upstream_beta'
		
		return 0
	fi
	
	if [[ "$1" == "rclone" ]]
	then
		_tryExec '_test_rclone_upstream'
		#_tryExec '_test_rclone_upstream_beta'
		
		return 0
	fi
	
	
	if [[ "$1" == "terraform" ]]
	then
		curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo -n apt-key add -
		sudo -n apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y terraform
		
		return 0
	fi
	
	if [[ "$1" == "vagrant" ]]
	then
		#curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo -n apt-key add -
		#sudo -n apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y vagrant-libvirt
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y vagrant
		
		return 0
	fi
	
	if [[ "$1" == "digimend-debug" ]] || [[ "$1" == 'udev/rules.d/90-digimend.rules' ]] || [[ "$1" == 'X11/xorg.conf.d/50-digimend.conf' ]]
	then
		if ! _wantDep digimend-debug && [[ -e /etc/issue ]] && cat /etc/issue | grep 'Debian' > /dev/null 2>&1
		then
			if [[ -e "$HOME"/core/installations/digimend-dkms/digimend-dkms_10_all.deb ]]
			then
				yes | sudo -n dpkg -i "$HOME"/core/installations/digimend-dkms/digimend-dkms_10_all.deb
			fi
			
			sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y digimend-dkms
			
			#curl -L "https://github.com/DIGImend/digimend-kernel-drivers/releases/download/v10/digimend-dkms_10_all.deb" -o "$safeTmp"/"digimend-dkms_10_all.deb"
			curl -L "https://deb.debian.org/debian/pool/main/d/digimend-dkms/digimend-dkms_11-3_amd64.deb" -o "$safeTmp"/"digimend-dkms_11-3_amd64.deb"
			yes | sudo -n dpkg -i "$safeTmp"/"digimend-dkms_11-3_amd64.deb"
			sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y -f
			sudo -n rm -f "$safeTmp"/"digimend-dkms_11-3_amd64.deb"
		fi
		
		return 0
	fi
	
	if [[ "$1" == "openssl/ssl.h" ]] || [[ "$1" == "include/openssl/ssl.h" ]] || [[ "$1" == "/usr/include/openssl/ssl.h" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y libssl-dev
		
		return 0
	fi
	
	if [[ "$1" == "sqlite3.h" ]] || [[ "$1" == "sqlite3ext.h" ]] || [[ "$1" == "pkgconfig/sqlite3.pc" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y libsqlite3-dev
		
		return 0
	fi
	
	if [[ "$1" == "qalculate-gtk" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qalculate-gtk
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y -t bookworm-backports qalc
		
		! _wantDep 'qalculate-gtk' && echo 'warn: missing: qalculate-gtk'
		
		return 0
	fi
	
	if [[ "$1" == "qalc" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y -t bookworm-backports qalc
		
		! _wantDep 'qalc' && echo 'warn: missing: qalc'
		
		return 0
	fi
	
	if [[ "$1" == "nc" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y netcat-openbsd
		
		! _wantDep 'nc' && echo 'warn: missing: nc'
		
		return 0
	fi

	if [[ "$1" == "curlftpfs" ]]
	then
		if [[ -e "$HOME"/"core/installations/curlftpfs/curlftpfs_0.9.2-9+b1_amd64.deb" ]]
		then
			yes | sudo -n dpkg -i "$HOME"/"core/installations/curlftpfs/curlftpfs_0.9.2-9+b1_amd64.deb"
		fi

		if ! [[ -e "$HOME"/"core/installations/curlftpfs/curlftpfs_0.9.2-9+b1_amd64.deb" ]]
		then
			curl -L 'http://deb.debian.org/debian/pool/main/c/curlftpfs/curlftpfs_0.9.2-9+b1_amd64.deb' -o "$safeTmp"/"curlftpfs_0.9.2-9+b1_amd64.deb"
			yes | sudo -n dpkg -i "$safeTmp"/"curlftpfs_0.9.2-9+b1_amd64.deb"
		fi
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y -f
		sudo -n rm -f "$safeTmp"/"curlftpfs_0.9.2-9+b1_amd64.deb"
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y curlftpfs
	fi
	
	
	return 1
}

_fetchDep_debianBookworm_sequence() {
	_start
	
	_mustGetSudo
	
	_wantDep "$1" && _stop 0
	
	_fetchDep_debianBookworm_special "$@" && _wantDep "$1" && _stop 0
	
	sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y "$1" && _wantDep "$1" && _stop 0
	
	_apt-file search "$1" > "$safeTmp"/pkgsOut 2> "$safeTmp"/pkgsErr
	
	local sysPathAll
	sysPathAll=$(sudo -n bash -c "echo \$PATH")
	sysPathAll="$PATH":"$sysPathAll"
	local sysPathArray
	IFS=':' read -r -a sysPathArray <<< "$sysPathAll"
	
	local currentSysPath
	local matchingPackageFile
	local matchingPackagePattern
	local matchingPackage
	for currentSysPath in "${sysPathArray[@]}"
	do
		matchingPackageFile=""
		matchingPackagePath=""
		matchingPackage=""
		matchingPackagePattern="$currentSysPath"/"$1"
		matchingPackageFile=$(grep ': '$matchingPackagePattern'$' "$safeTmp"/pkgsOut | cut -f2- -d' ')
		matchingPackage=$(grep ': '$matchingPackagePattern'$' "$safeTmp"/pkgsOut | cut -f1 -d':')
		if [[ "$matchingPackage" != "" ]]
		then
			sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y "$matchingPackage"
			_wantDep "$1" && _stop 0
		fi
	done
	matchingPackage=""
	matchingPackage=$(head -n 1 "$safeTmp"/pkgsOut | cut -f1 -d':')
	sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y "$matchingPackage"
	_wantDep "$1" && _stop 0
	
	_stop 1
}

_fetchDep_debianBookworm() {
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | sudo -n tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | sudo -n tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	export DEBIAN_FRONTEND=noninteractive
	
	#Run up to 2 times. On rare occasion, cache will become unusable again by apt-find before an installation can be completed. Overall, apt-find is the single weakest link in the system.
	"$scriptAbsoluteLocation" _fetchDep_debianBookworm_sequence "$@"
	"$scriptAbsoluteLocation" _fetchDep_debianBookworm_sequence "$@"
}





























































































_fetchDep_debian() {
	
	# WARNING: Obsolete. Disabled.
	#if [[ -e /etc/debian_version ]] && cat /etc/debian_version | head -c 1 | grep 9 > /dev/null 2>&1
	#then
		#_fetchDep_debianStretch "$@"
		#return
	#fi
	
	
	# WARNING: Obsolete. Disabled.
	#if [[ -e /etc/debian_version ]] && cat /etc/debian_version | head -c 2 | grep 10 > /dev/null 2>&1
	#then
		#_fetchDep_debianBuster "$@"
		#return
	#fi
	
	
	# WARNING: Obsolete. Disabled.
	# ATTENTION: May be revived if important deployments of Debian Bullseye are discovered to still exist. Revive from '_ref/debian_bullseye.sh' if necessary.
	#if [[ -e /etc/debian_version ]] && cat /etc/debian_version | head -c 2 | grep 11 > /dev/null 2>&1
	#then
		#_fetchDep_debianBullseye "$@"
		#return
	#fi


	if [[ -e /etc/debian_version ]] && cat /etc/debian_version | head -c 2 | grep 12 > /dev/null 2>&1
	then
		_fetchDep_debianBookworm "$@"
		return
	fi
	
	return 1
}



_fetchDep_ubuntuFocalFossa_special() {
	sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
	
# 	if [[ "$1" == *"java"* ]]
# 	then
# 		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y default-jdk default-jre
# 		return 0
# 	fi
	
	if [[ "$1" == *"wine"* ]] && ! dpkg --print-foreign-architectures | grep i386 > /dev/null 2>&1
	then
		sudo -n dpkg --add-architecture i386
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y wine wine32 wine64 libwine libwine:i386 fonts-wine
		return 0
	fi
	
	if [[ "$1" == "realpath" ]] || [[ "$1" == "readlink" ]] || [[ "$1" == "dirname" ]] || [[ "$1" == "basename" ]] || [[ "$1" == "sha512sum" ]] || [[ "$1" == "sha256sum" ]] || [[ "$1" == "head" ]] || [[ "$1" == "tail" ]] || [[ "$1" == "sleep" ]] || [[ "$1" == "env" ]] || [[ "$1" == "cat" ]] || [[ "$1" == "mkdir" ]] || [[ "$1" == "dd" ]] || [[ "$1" == "rm" ]] || [[ "$1" == "ln" ]] || [[ "$1" == "ls" ]] || [[ "$1" == "test" ]] || [[ "$1" == "true" ]] || [[ "$1" == "false" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y coreutils
		return 0
	fi
	
	if [[ "$1" == "mount" ]] || [[ "$1" == "umount" ]] || [[ "$1" == "losetup" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y mount
		return 0
	fi
	
	if [[ "$1" == "mountpoint" ]] || [[ "$1" == "mkfs" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y util-linux
		return 0
	fi
	
	if [[ "$1" == "mkfs.ext4" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y e2fsprogs
		return 0
	fi
	
	if [[ "$1" == "parted" ]] || [[ "$1" == "partprobe" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y parted
		return 0
	fi
	
	if [[ "$1" == "qemu-arm-static" ]] || [[ "$1" == "qemu-armeb-static" ]] || [[ "$1" == "update-binfmts" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qemu qemu-user-static binfmt-support
		#update-binfmts --display
		return 0
	fi
	
	if [[ "$1" == "qemu-system-x86_64" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qemu-system-x86
		return 0
	fi
	
	if [[ "$1" == "qemu-img" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qemu-utils
		return 0
	fi
	
	if [[ "$1" == "VirtualBox" ]] || [[ "$1" == "VBoxSDL" ]] || [[ "$1" == "VBoxManage" ]] || [[ "$1" == "VBoxHeadless" ]]
	then
		sudo -n mkdir -p /etc/apt/sources.list.d
		if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '20.04' > /dev/null 2>&1
		then
			echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian focal contrib' | sudo -n tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		fi
		
		if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '21.10' > /dev/null 2>&1
		then
			echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian impish contrib' | sudo -n tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		fi
		if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '22.04' > /dev/null 2>&1
		then
			echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian jammy contrib' | sudo -n tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		fi
		if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '24.04' > /dev/null 2>&1
		then
			echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian noble contrib' | sudo -n tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		fi
		
		"$scriptAbsoluteLocation" _getDep wget
		! _wantDep wget && return 1
		
		# TODO Check key fingerprints match "B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF" and "7B0F AB3A 13B9 0743 5925  D9C9 5442 2A4B 98AB 5139" respectively.
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo -n apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo -n apt-key add -
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y dkms virtualbox-6.1
		
		echo "WARNING: Recommend manual system configuration after install. See https://www.virtualbox.org/wiki/Downloads ."
		
		return 0
	fi
	
	if [[ "$1" == "gpg" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y gnupg
		return 0
	fi
	
	#Unlikely scenario for hosts.
	if [[ "$1" == "grub-install" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grub2
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grub-legacy
		return 0
	fi
	
	if [[ "$1" == "MAKEDEV" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y makedev
		return 0
	fi
	
	if [[ "$1" == "fgrep" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grep
		return 0
	fi
	
	if [[ "$1" == "fgrep" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y grep
		return 0
	fi
	
	if [[ "$1" == "awk" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y mawk
		return 0
	fi
	
	if [[ "$1" == "kill" ]] || [[ "$1" == "ps" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y procps
		return 0
	fi
	
	if [[ "$1" == "find" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y findutils
		return 0
	fi
	
	if [[ "$1" == "docker" ]] || [[ "$1" == "docker-compose" ]]
	then
		sudo -n update-alternatives --set iptables /usr/sbin/iptables-legacy
		sudo -n update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
		#sudo -n systemctl restart docker
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
		
		# Sometimes may be useful as a workaround for docker 'overlay2' 'storage-driver' .
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y fuse-overlayfs
		
		"$scriptAbsoluteLocation" _getDep curl
		! _wantDep curl && return 1
		
		curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo -n apt-key add -
		local aptKeyFingerprint
		aptKeyFingerprint=$(sudo -n apt-key fingerprint 0EBFCD88 2> /dev/null)
		[[ "$aptKeyFingerprint" == "" ]] && return 1
		
		sudo -n add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get remove -y docker docker-engine docker.io docker-ce docker
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y docker-ce
		
		sudo -n usermod -a -G docker "$USER"
		
		return 0
	fi
	
	if [[ "$1" == "smbd" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y samba
		return 0
	fi
	
	if [[ "$1" == "atom" ]]
	then
		#curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo -n apt-key add -
		#sudo -n sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/ub_atom.list'
		
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y atom
		
		#return 0
		return 1
	fi
	
	if [[ "$1" == "GL/gl.h" ]] || [[ "$1" == "GL/glext.h" ]] || [[ "$1" == "GL/glx.h" ]] || [[ "$1" == "GL/glxext.h" ]] || [[ "$1" == "GL/dri_interface.h" ]] || [[ "$1" == "x86_64-linux-gnu/pkgconfig/dri.pc" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y mesa-common-dev
		
		return 0
	fi
	
	if [[ "$1" == "go" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y golang-go
		
		return 0
	fi
	
	if [[ "$1" == "php" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y php
		
		return 0
	fi
	
	if [[ "$1" == "cura-lulzbot" ]]
	then
		#Testing/Sid only as of Stretch release cycle.
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y rustc cargo
		
		echo "Requires manual installation. See https://www.lulzbot.com/learn/tutorials/cura-lulzbot-edition-installation-debian ."
cat << 'CZXWXcRMTo8EmM8i4d'
wget -qO - https://download.alephobjects.com/ao/aodeb/aokey.pub | sudo -n apt-key add -
sudo -n cp /etc/apt/sources.list /etc/apt/sources.list.bak && sudo -n sed -i '$a deb http://download.alephobjects.com/ao/aodeb jessie main' /etc/apt/sources.list && sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update && sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install cura-lulzbot
CZXWXcRMTo8EmM8i4d
		echo "(typical)"
		_stop 1
	fi
	
	if [[ "$1" =~ "FlashPrint" ]]
	then
		#Testing/Sid only as of Stretch release cycle.
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y rustc cargo
		
		echo "Requires manual installation. See http://www.flashforge.com/support-center/flashprint-support/ ."
		_stop 1
	fi
	
	if [[ "$1" == "cargo" ]] || [[ "$1" == "rustc" ]]
	then
		#Testing/Sid only as of Stretch release cycle.
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y rustc cargo
		
		echo "Requires manual installation."
cat << 'CZXWXcRMTo8EmM8i4d'
curl https://sh.rustup.rs -sSf | sh
echo '[[ -e "$HOME"/.cargo/bin ]] && export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
CZXWXcRMTo8EmM8i4d
		echo "(typical)"
		_stop 1
	fi
	
	if [[ "$1" == "firejail" ]]
	then
		echo "WARNING: Recommend manual system configuration after install. See https://firejail.wordpress.com/download-2/ ."
		echo "WARNING: Desktop override symlinks may cause problems, especially preventing proxy host jumping by CoreAutoSSH!"
		return 1
	fi
	
	
	if [[ "$1" == "nix-env" ]]
	then
		_tryExec '_test_nix-env_upstream'
		#_tryExec '_test_nix-env_upstream_beta'
		
		return 0
	fi
	
	
	if [[ "$1" == "croc" ]]
	then
		_tryExec '_test_croc_upstream'
		#_tryExec '_test_croc_upstream_beta'
		
		return 0
	fi
	
	if [[ "$1" == "rclone" ]]
	then
		_tryExec '_test_rclone_upstream'
		#_tryExec '_test_rclone_upstream_beta'
		
		return 0
	fi
	
	
	if [[ "$1" == "terraform" ]]
	then
		curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo -n apt-key add -
		sudo -n apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y terraform
		
		return 0
	fi
	
	if [[ "$1" == "vagrant" ]]
	then
		#curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo -n apt-key add -
		#sudo -n apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
		#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y vagrant-libvirt
		
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y vagrant
		
		return 0
	fi
	
	if [[ "$1" == "digimend-debug" ]] || [[ "$1" == 'udev/rules.d/90-digimend.rules' ]] || [[ "$1" == 'X11/xorg.conf.d/50-digimend.conf' ]]
	then
		if ! _wantDep digimend-debug && [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' > /dev/null 2>&1
		then
			if [[ -e "$HOME"/core/installations/digimend-dkms/digimend-dkms_10_all.deb ]]
			then
				if ! yes | sudo -n dpkg -i "$HOME"/core/installations/digimend-dkms/digimend-dkms_10_all.deb
				then
					sudo -n env DEBIAN_FRONTEND=noninteractive apt-get remove -y digimend-dkms
				fi
			fi
			
			if ! sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y digimend-dkms
			then
				sudo -n env DEBIAN_FRONTEND=noninteractive apt-get remove -y digimend-dkms
			fi
			
			curl -L "https://github.com/DIGImend/digimend-kernel-drivers/releases/download/v10/digimend-dkms_10_all.deb" -o "$safeTmp"/"digimend-dkms_10_all.deb"
			if ! yes | sudo -n dpkg -i "$safeTmp"/"digimend-dkms_10_all.deb"
			then
				sudo -n env DEBIAN_FRONTEND=noninteractive apt-get remove -y digimend-dkms
			fi
			if ! sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y digimend-dkms
			then
				sudo -n env DEBIAN_FRONTEND=noninteractive apt-get remove -y digimend-dkms
			fi
			sudo rm -f "$safeTmp"/"digimend-dkms_10_all.deb"
		fi
		
		return 0
	fi
	
	if [[ "$1" == "openssl/ssl.h" ]] || [[ "$1" == "include/openssl/ssl.h" ]] || [[ "$1" == "/usr/include/openssl/ssl.h" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y libssl-dev
		
		return 0
	fi
	
	if [[ "$1" == "sqlite3.h" ]] || [[ "$1" == "sqlite3ext.h" ]] || [[ "$1" == "pkgconfig/sqlite3.pc" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y libsqlite3-dev
		
		return 0
	fi
	
	if [[ "$1" == "qalculate-gtk" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y qalculate-gtk
		
		! _wantDep 'qalculate-gtk' && echo 'warn: missing: qalculate-gtk'
		
		return 0
	fi
	
	if [[ "$1" == "bup" ]]
	then
		sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y bup
		
		! _wantDep 'bup' && echo 'warn: missing: bup'
		
		return 0
	fi
	
	
	return 1
}





_fetchDep_ubuntuFocalFossa_sequence() {
	_start
	
	_mustGetSudo
	
	_wantDep "$1" && _stop 0
	
	_fetchDep_ubuntuFocalFossa_special "$@" && _wantDep "$1" && _stop 0
	
	sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y "$1" && _wantDep "$1" && _stop 0
	
	_apt-file search "$1" > "$safeTmp"/pkgsOut 2> "$safeTmp"/pkgsErr
	
	local sysPathAll
	sysPathAll=$(sudo -n bash -c "echo \$PATH")
	sysPathAll="$PATH":"$sysPathAll"
	local sysPathArray
	IFS=':' read -r -a sysPathArray <<< "$sysPathAll"
	
	local currentSysPath
	local matchingPackageFile
	local matchingPackagePattern
	local matchingPackage
	for currentSysPath in "${sysPathArray[@]}"
	do
		matchingPackageFile=""
		matchingPackagePath=""
		matchingPackage=""
		matchingPackagePattern="$currentSysPath"/"$1"
		matchingPackageFile=$(grep ': '$matchingPackagePattern'$' "$safeTmp"/pkgsOut | cut -f2- -d' ')
		matchingPackage=$(grep ': '$matchingPackagePattern'$' "$safeTmp"/pkgsOut | cut -f1 -d':')
		if [[ "$matchingPackage" != "" ]]
		then
			sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y "$matchingPackage"
			_wantDep "$1" && _stop 0
		fi
	done
	matchingPackage=""
	matchingPackage=$(head -n 1 "$safeTmp"/pkgsOut | cut -f1 -d':')
	sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y "$matchingPackage"
	_wantDep "$1" && _stop 0
	
	_stop 1
}

_fetchDep_ubuntuFocalFossa() {
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | sudo tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | sudo tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	export DEBIAN_FRONTEND=noninteractive
	
	#Run up to 2 times. On rare occasion, cache will become unusable again by apt-find before an installation can be completed. Overall, apt-find is the single weakest link in the system.
	"$scriptAbsoluteLocation" _fetchDep_ubuntuFocalFossa_sequence "$@"
	"$scriptAbsoluteLocation" _fetchDep_ubuntuFocalFossa_sequence "$@"
}

# WARNING: Workarounds may be by exception only (more dist/OS version specific workarounds for other dist/OS such as Debian).
_fetchDep_ubuntu() {
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '20.04' > /dev/null 2>&1
	then
		_fetchDep_ubuntuFocalFossa "$@"
		return
	fi
	
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '21.10' > /dev/null 2>&1
	then
		_fetchDep_ubuntuFocalFossa "$@"
		return
	fi
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '22.04' > /dev/null 2>&1
	then
		_fetchDep_ubuntuFocalFossa "$@"
		return
	fi
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '24.04' > /dev/null 2>&1
	then
		_fetchDep_ubuntuFocalFossa "$@"
		return
	fi
	
	
	return 1
}



# WARNING: Untested!
# Especially needed, testing with chroot and ssh backends.

# ATTENTION: Expected use case is to attempt installation of dependencies and user software, once, before using '_test'. Not every command is expected to succeed.



# ATTENTION: Examples. Copy relevant files to automatically enable such installations (file existence will be detected).
	#[[ "$getMost_backend" == "chroot" ]]
		#sudo -n cp "$scriptLib"/debian/packages/bup_0.29-3_amd64.deb "$globalVirtFS"/
	#[[ "$getMost_backend" == "ssh" ]]
		#_rsync -axvz --rsync-path='mkdir -p '"'"$currentDestinationDirPath"'"' ; rsync' --delete "$1" "$2"







_install_debian11() {
	! "$scriptAbsoluteLocation" _mustGetSudo && _messageError 'FAIL: _mustGetSudo' && return 1
	_mustGetSudo
	
	"$scriptAbsoluteLocation" _setupUbiquitous
	"$scriptAbsoluteLocation" _getMost_debian11
	type _get_veracrypt > /dev/null 2>&1 && "$scriptAbsoluteLocation" _get_veracrypt
	"$scriptAbsoluteLocation" _test
	
	#sudo -n env DEBIAN_FRONTEND=noninteractive apt-get --install-recommends -y upgrade
	sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --install-recommends -y upgrade
}





# Workaround to prevent 'tasksel' from going to 'background' locking subsequent other 'apt-get' and similar commands.
# Nevertheless, using any 'tasksel' commands only at the end of any script is preferable.
_wait_debianInstall() {
	# Loop expected much slower than 0.1s/iteration, expect reasonable CPU and such ~0.3s/iteration.
	# If CPU and such are faster, than both this loop and any debian install program to detect, are both expected to change timing comparably, so adjustments are expected NOT necessary.
	
	# https://blog.sinjakli.co.uk/2021/10/25/waiting-for-apt-locks-without-the-hacky-bash-scripts/
	local currentIteration
	local currentIteration_continuing
	currentIteration=0
	currentIteration_continuing=99999
	while [[ "$currentIteration" -lt 900 ]] && [[ "$currentIteration_continuing" == 99999 ]] ; do
		_messagePlain_probe 'wait: install: debian'
		
		currentIteration_continuing=0
		while [[ "$currentIteration_continuing" -lt 300 ]] ; do
			sleep 0.1
			echo 'busy: '"$currentIteration_continuing"
			let currentIteration_continuing="$currentIteration_continuing"+1
			if pgrep ^tasksel$ || pgrep ^apt-get$ || pgrep ^dpkg$ || ( fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 || ( type -p sudo > /dev/null 2>&1 && sudo -n fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 ) )
			then
				currentIteration_continuing=99999
			fi
			let currentIteration="$currentIteration"+1
		done
		echo 'wait: '"$currentIteration"
	done
	sleep 1
}


_getMost_debian11_aptSources() {
	# May be an image copied while dpkg was locked. Especially if 'chroot'.
	_getMost_backend rm -f /var/lib/apt/lists/lock
	_getMost_backend rm -f /var/lib/dpkg/lock
	
	
	_getMost_backend_aptGetInstall wget
	_getMost_backend_aptGetInstall gpg
	
	
	_getMost_backend mkdir -p /etc/apt/sources.list.d
	
	#echo 'deb http://deb.debian.org/debian bullseye-backports main contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_backports.list > /dev/null 2>&1
	#echo 'deb http://download.virtualbox.org/virtualbox/debian bullseye contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
	#echo 'deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable' | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
	
	if ! ( [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' > /dev/null 2>&1 ) || ( [[ -e /etc/debian_version ]] && cat /etc/debian_version | head -c 2 | grep 11 > /dev/null 2>&1 )
	then
		echo 'deb http://deb.debian.org/debian bullseye-backports main contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_backports.list > /dev/null 2>&1
		
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bullseye contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		echo 'deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable' | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
		curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
		
		## https://fasttrack.debian.net/
		#if ! grep 'fasttrack' /etc/apt/sources.list
		#then
			#_getMost_backend apt install -y fasttrack-archive-keyring
			#echo 'deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib' | _getMost_backend tee -a /etc/apt/sources.list
			#echo 'deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-backports-staging main contrib' | _getMost_backend tee -a /etc/apt/sources.list
		#fi
		
	elif [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '20.04' > /dev/null 2>&1
	then
		true
		
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian focal contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
		echo "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable" | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
		_getMost_backend add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable"
	elif [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '22.04' > /dev/null 2>&1
	then
		true
		
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian jammy contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
		echo "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable" | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
		_getMost_backend add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable"
	fi
	
	curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
	_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
	_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
}

_getMost_debian12_aptSources() {
	# May be an image copied while dpkg was locked. Especially if 'chroot'.
	_getMost_backend rm -f /var/lib/apt/lists/lock
	_getMost_backend rm -f /var/lib/dpkg/lock
	
	
	_getMost_backend_aptGetInstall wget
	_getMost_backend_aptGetInstall gpg
	
	
	_getMost_backend mkdir -p /etc/apt/sources.list.d
	
	#echo 'deb http://deb.debian.org/debian bookworm-backports main contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_backports.list > /dev/null 2>&1
	#echo 'deb http://download.virtualbox.org/virtualbox/debian bookworm contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
	#echo 'deb [arch=amd64] https://download.docker.com/linux/debian bookworm stable' | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
	
	if ! ( [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' > /dev/null 2>&1 ) || ( [[ -e /etc/debian_version ]] && cat /etc/debian_version | head -c 2 | grep 12 > /dev/null 2>&1 )
	then
		echo 'deb http://deb.debian.org/debian bookworm-backports main contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_backports.list > /dev/null 2>&1
		
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bookworm contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] https://download.docker.com/linux/debian bookworm stable' | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
		
		## https://fasttrack.debian.net/
		#if ! grep 'fasttrack' /etc/apt/sources.list
		#then
			#_getMost_backend apt install -y fasttrack-archive-keyring
			#echo 'deb https://fasttrack.debian.net/debian-fasttrack/ bookworm-fasttrack main contrib' | _getMost_backend tee -a /etc/apt/sources.list
			#echo 'deb https://fasttrack.debian.net/debian-fasttrack/ bookworm-backports-staging main contrib' | _getMost_backend tee -a /etc/apt/sources.list
		#fi
		
		# https://github.com/wireapp/wire-desktop/wiki/How-to-install-Wire-for-Desktop-on-Linux
		#wget -q https://wire-app.wire.com/linux/releases.key -O- | sudo -n apt-key add -
		#echo "deb [arch=amd64] https://wire-app.wire.com/linux/debian stable main" | sudo -n tee /etc/apt/sources.list.d/wire-desktop.list
	fi
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '20.04' > /dev/null 2>&1
	then
		true
		
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian focal contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
		echo "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable" | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
		_getMost_backend add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable"
	fi
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '22.04' > /dev/null 2>&1
	then
		true
		
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian jammy contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
		echo "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable" | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
		_getMost_backend add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable"
	fi
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '24.04' > /dev/null 2>&1
	then
		true
		
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
		echo 'deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian noble contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
		
		curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
		echo "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable" | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
		_getMost_backend add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"') $(_getMost_backend bash -c 'lsb_release -cs') stable"
	fi
	
	curl -fsSL https://download.docker.com/linux/$(_getMost_backend bash -c '. /etc/os-release; echo "$ID"')/gpg | _getMost_backend apt-key add -
	_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
	_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
}

_getMost_debian11_special_early() {
	true
}

_getMost_debian11_special_late() {
	_getMost_backend_aptGetInstall curl
	
	_messagePlain_probe 'install: rclone'
	#_getMost_backend curl https://rclone.org/install.sh | _getMost_backend bash -s beta
	_getMost_backend curl https://rclone.org/install.sh | _getMost_backend bash
}

_getMost_debian12_install() {
	_getMost_debian11_install "$@"

	_getMost_backend_aptGetInstall qalculate-gtk
	_getMost_backend_aptGetInstall qalc
	
	# CAUTION: Workaround. Debian defaults to an obsolete version of qalc which is unusable.
	_getMost_backend_aptGetInstall -t bookworm-backports qalc

	#_getMost_backend_aptGetInstall wire-desktop

	# ATTENTION: SEVERE: Cause for concern. Absence of this is not properly detected by '_getDep python', '_getDep /usr/bin/python'  .
	_getMost_backend_aptGetInstall python-is-python3


	# May be useful for WSL2 .
	_getMost_backend_aptGetInstall usbip

	
	#_getMost_backend apt-get -d install -y virtualbox-7.0
	_getMost_backend apt-get -d install -y virtualbox-7.1

	#_getMost_backend_aptGetInstall virtualbox-7.0
	_getMost_backend_aptGetInstall virtualbox-7.1


	_getMost_backend_aptGetInstall git-filter-repo
}

_getMost_debian11_install() {
	_messagePlain_probe 'apt-get update'
	_getMost_backend apt-get update
	
	
	_getMost_debian11_special_early
	
	
	
	
	_getMost_backend_aptGetInstall sudo
	_getMost_backend_aptGetInstall gpg
	_getMost_backend_aptGetInstall --reinstall wget
	
	_getMost_backend_aptGetInstall apt-utils
	
	_getMost_backend_aptGetInstall pigz
	_getMost_backend_aptGetInstall pixz


	_getMost_backend_aptGetInstall bash dash

	_getMost_backend_aptGetInstall aria2 curl gpg
	_getMost_backend_aptGetInstall gnupg
	_getMost_backend_aptGetInstall lsb-release

	if ! _getMost_backend dash -c 'type apt-fast' > /dev/null 2>&1
	then
		_getMost_backend_aptGetInstall aria2 curl gpg
		
		_getMost_backend mkdir -p /etc/apt/keyrings
		_getMost_backend curl -fsSL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xA2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B' | _getMost_backend gpg --dearmor -o /etc/apt/keyrings/apt-fast.gpg
		_getMost_backend apt-get update
		_getMost_backend_aptGetInstall apt-fast

		echo debconf apt-fast/maxdownloads string 16 | _getMost_backend debconf-set-selections
		echo debconf apt-fast/dlflag boolean true | _getMost_backend debconf-set-selections
		echo debconf apt-fast/aptmanager string apt-get | _getMost_backend debconf-set-selections
	fi

	
	_messagePlain_probe 'apt-get update'
	_getMost_backend apt-get update
	
	# DANGER: Requires expanded (raspi) image (ie. raspi image is too small by default)!
	# May be able to resize with some combination of 'dd' and 'gparted' , possibly '_gparted' . May be untested.
	#_messagePlain_probe 'apt-get upgrade'
	#_getMost_backend apt-get upgrade

	# https://github.com/wireapp/wire-desktop/wiki/How-to-install-Wire-for-Desktop-on-Linux
	_getMost_backend_aptGetInstall apt-transport-https
	
	
	_getMost_backend_aptGetInstall locales-all
	
	
	if _getMost_backend_fileExists "/bup_0.29-3_amd64.deb"
	then
		_getMost_backend dpkg -i "/bup_0.29-3_amd64.deb"
		_getMost_backend rm -f /bup_0.29-3_amd64.deb
		_getMost_backend env DEBIAN_FRONTEND=noninteractive apt-get install -y -f
	fi
	
	_getMost_backend_aptGetInstall git
	
	_getMost_backend_aptGetInstall git-lfs

	_getMost_backend_aptGetInstall bup
	
	# ATTENTION: WSL2 distribution instances may also need 'socat' for internal network port forwarding.
	_getMost_backend_aptGetInstall bc autossh nmap socat sockstat rsync net-tools
	_getMost_backend_aptGetInstall bc nmap autossh socat sshfs tor
	_getMost_backend_aptGetInstall sockstat
	_getMost_backend_aptGetInstall x11-xserver-utils
	_getMost_backend_aptGetInstall arandr

	if _getMost_backend_fileExists "/curlftpfs_0.9.2-9+b1_amd64.deb"
	then
		_getMost_backend dpkg -i "/curlftpfs_0.9.2-9+b1_amd64.deb"
		_getMost_backend rm -f "/curlftpfs_0.9.2-9+b1_amd64.deb"
		_getMost_backend env DEBIAN_FRONTEND=noninteractive apt-get install -y -f
	fi

	_getMost_backend_aptGetInstall curlftpfs

	_getMost_backend_aptGetInstall liblinear4 liblua5.3-0 lua-lpeg nmap nmap-common
	
	_getMost_backend_aptGetInstall uuid-runtime
	
	_getMost_backend_aptGetInstall tigervnc-viewer
	_getMost_backend_aptGetInstall x11vnc
	_getMost_backend_aptGetInstall tigervnc-standalone-server
	_getMost_backend_aptGetInstall tigervnc-scraping-server
	
	_getMost_backend_aptGetInstall iperf3
	
	_getMost_backend_aptGetInstall ufw
	_getMost_backend_aptGetInstall gufw
	
	#_getMost_backend_aptGetInstall synergy quicksynergy
	
	_getMost_backend_aptGetInstall vim
	
	_getMost_backend_aptGetInstall strace

	_getMost_backend_aptGetInstall man-db
	
	# WARNING: Rust is not yet (2023-11-12) anywhere near as editable on the fly or pervasively available as bash .
	#  Criteria for such are far more necessarily far more stringent than might be intuitively obvious.
	#  Rust is expected to remain non-competitive with bash for purposes of 'ubiquitous_bash', even for reference implementations, for at least 6years .
	#   6 years
	# https://users.rust-lang.org/t/does-rust-work-in-cygwin-if-so-how-can-i-get-it-working/25735
	# https://stackoverflow.com/questions/31492799/cross-compile-a-rust-application-from-linux-to-windows
	# https://rustup.rs/
	#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	# https://packages.debian.org/search?keywords=rustup&searchon=names&suite=all&section=all
	# https://wiki.debian.org/Rust
	#  DANGER: Do NOT regard 'rustup' as available.
	_getMost_backend_aptGetInstall rustc
	_getMost_backend_aptGetInstall cargo
	#_getMost_backend_aptGetInstall rustup
	_getMost_backend_aptGetInstall mingw-w64
	_getMost_backend_aptGetInstall g++-mingw-w64-x86-64-win32
	_getMost_backend_aptGetInstall binutils-mingw-w64
	_getMost_backend_aptGetInstall mingw-w64-tools
	_getMost_backend_aptGetInstall gdb-mingw-w64
	
	if _getMost_backend bash -c '! dpkg --print-foreign-architectures | grep i386'
	then
		_getMost_backend dpkg --add-architecture i386
		_getMost_backend apt-get update
	fi
	_getMost_backend_aptGetInstall wmctrl xprintidle


	_getMost_backend_aptGetInstall dbus-x11


	_getMost_backend_aptGetInstall gnulib

	_getMost_backend_aptGetInstall libtool
	_getMost_backend_aptGetInstall libtool-bin

	_getMost_backend_aptGetInstall libgtk2.0-dev

	_getMost_backend_aptGetInstall libxss-dev
	_getMost_backend_aptGetInstall intltool
	_getMost_backend_aptGetInstall libgts-dev
	_getMost_backend_aptGetInstall libdbus-1-dev
	_getMost_backend_aptGetInstall libglu1-mesa-dev
	_getMost_backend_aptGetInstall libgtkglext1-dev
	_getMost_backend_aptGetInstall libgd-dev

	_getMost_backend_aptGetInstall libxcb-screensaver0-dev

	_getMost_backend_aptGetInstall desktop-file-utils

	
	_getMost_backend_aptGetInstall okular
	_getMost_backend_aptGetInstall libreoffice
	_getMost_backend_aptGetInstall firefox-esr
	_getMost_backend_aptGetInstall xournal
	_getMost_backend_aptGetInstall kwrite
	_getMost_backend_aptGetInstall netcat-openbsd
	_getMost_backend_aptGetInstall iperf
	_getMost_backend_aptGetInstall axel
	_getMost_backend_aptGetInstall aria2
	_getMost_backend_aptGetInstall unionfs-fuse
	_getMost_backend_aptGetInstall samba
	
	_getMost_backend_aptGetInstall dia
	
	_getMost_backend_aptGetInstall libcups2-dev

	_getMost_backend_aptGetInstall gimp
	_getMost_backend_aptGetInstall gimp-data-extras
	
	_getMost_backend_aptGetInstall aria2
	
	_getMost_backend_aptGetInstall qemu
	_getMost_backend_aptGetInstall qemu-system-x86
	_getMost_backend_aptGetInstall qemu-system-arm
	_getMost_backend_aptGetInstall qemu-efi-arm qemu-efi-aarch64 qemu-user-static qemu-utils
	_getMost_backend_aptGetInstall dosbox
	_getMost_backend_aptGetInstall wine wine32 wine64 libwine libwine:i386 fonts-wine
	_getMost_backend_aptGetInstall debootstrap xclip xinput gparted bup emacs xterm mesa-utils
	_getMost_backend_aptGetInstall kde-standard
	_getMost_backend_aptGetInstall chromium
	_getMost_backend_aptGetInstall openjdk-11-jdk openjdk-11-jre
	
	_getMost_backend_aptGetInstall openjdk-17-jdk openjdk-17-jre


	_getMost_backend_aptGetInstall vainfo
	_getMost_backend_aptGetInstall mesa-va-drivers
	_getMost_backend_aptGetInstall ffmpeg


	_getMost_backend_aptGetInstall gstreamer1.0-tools

	# ATTENTION: From analysis .
	#_getMost_backend_aptGetInstall gstreamer1.0-plugins-good


	_getMost_backend_aptGetInstall vdpau-driver-all
	_getMost_backend_aptGetInstall va-driver-all
	#_getMost_backend_aptGetInstall mesa-va-drivers
	_getMost_backend_aptGetInstall mesa-vdpau-drivers

	_getMost_backend_aptGetInstall libva-drm2
	_getMost_backend_aptGetInstall libva-x11-2
	_getMost_backend_aptGetInstall libva2
	_getMost_backend_aptGetInstall libvdpau-va-gl1
	_getMost_backend_aptGetInstall libvdpau1
	_getMost_backend_aptGetInstall libvpx7

	_getMost_backend_aptGetInstall libxv1
	

	_getMost_backend_aptGetInstall xvfb

	# terminal-serial: agetty, screen, resize
	_getMost_backend_aptGetInstall util-linux
	_getMost_backend_aptGetInstall screen
	_getMost_backend_aptGetInstall xterm
	
	#_getMost_backend_aptGetInstall original-awk
	_getMost_backend_aptGetInstall gawk
	
	_getMost_backend_aptGetInstall build-essential
	_getMost_backend_aptGetInstall flex
	_getMost_backend_aptGetInstall libelf-dev
	_getMost_backend_aptGetInstall libncurses-dev
	_getMost_backend_aptGetInstall autoconf
	_getMost_backend_aptGetInstall libudev-dev

	_getMost_backend_aptGetInstall imagemagick
	_getMost_backend_aptGetInstall graphicsmagick-imagemagick-compat

	_getMost_backend_aptGetInstall dwarves
	_getMost_backend_aptGetInstall pahole

	_getMost_backend_aptGetInstall cmake
	
	
	_getMost_backend_aptGetInstall gh
	
	
	
	_getMost_backend_aptGetInstall haskell-platform
	_getMost_backend_aptGetInstall pkg-haskell-tools
	_getMost_backend_aptGetInstall alex
	_getMost_backend_aptGetInstall cabal-install
	_getMost_backend_aptGetInstall happy
	_getMost_backend_aptGetInstall hscolour
	_getMost_backend_aptGetInstall ghc


	_getMost_backend_aptGetInstall libusb-dev
	_getMost_backend_aptGetInstall avrdude
	_getMost_backend_aptGetInstall gcc-avr
	_getMost_backend_aptGetInstall binutils-avr
	_getMost_backend_aptGetInstall avr-libc
	_getMost_backend_aptGetInstall stm32flash
	_getMost_backend_aptGetInstall dfu-util
	_getMost_backend_aptGetInstall libnewlib-arm-none-eabi
	_getMost_backend_aptGetInstall gcc-arm-none-eabi
	_getMost_backend_aptGetInstall binutils-arm-none-eabi
	_getMost_backend_aptGetInstall libusb-1.0
	
	_getMost_backend_aptGetInstall setserial

	_getMost_backend_aptGetInstall virtualenv
	_getMost_backend_aptGetInstall python3-dev
	_getMost_backend_aptGetInstall libffi-dev
	#_getMost_backend_aptGetInstall build-essential
	#_getMost_backend_aptGetInstall libncurses-dev
	#_getMost_backend_aptGetInstall libusb-dev
	#_getMost_backend_aptGetInstall avrdude
	#_getMost_backend_aptGetInstall gcc-avr
	#_getMost_backend_aptGetInstall binutils-avr
	#_getMost_backend_aptGetInstall avr-libc
	#_getMost_backend_aptGetInstall stm32flash
	#_getMost_backend_aptGetInstall libnewlib-arm-none-eabi
	#_getMost_backend_aptGetInstall gcc-arm-none-eabi
	#_getMost_backend_aptGetInstall binutils-arm-none-eabi
	#_getMost_backend_aptGetInstall libusb-1.0
	_getMost_backend_aptGetInstall libusb-1.0-0
	_getMost_backend_aptGetInstall libusb-1.0-0-dev
	_getMost_backend_aptGetInstall libusb-1.0-doc
	_getMost_backend_aptGetInstall pkg-config
	#_getMost_backend_aptGetInstall dfu-util
	
	_getMost_backend_aptGetInstall crudini
	_getMost_backend_aptGetInstall bsdutils
	_getMost_backend_aptGetInstall findutils
	_getMost_backend_aptGetInstall v4l-utils
	_getMost_backend_aptGetInstall libevent-dev
	_getMost_backend_aptGetInstall libjpeg-dev
	_getMost_backend_aptGetInstall libbsd-dev

	_getMost_backend_aptGetInstall libusb-1.0



	_getMost_backend_aptGetInstall ddd
	_getMost_backend_aptGetInstall gdb
	_getMost_backend_aptGetInstall libbabeltrace1
	_getMost_backend_aptGetInstall libc6-dbg
	_getMost_backend_aptGetInstall libsource-highlight-common
	_getMost_backend_aptGetInstall libsource-highlight4v5


	
	# ATTENTION: ONLY change (eg. to 'remove') if needed to ensure a kernel is installed AND custom kernel is not in use.
	_getMost_backend_aptGetInstall linux-image-amd64
	
	if [[ "$chrootName" == "" ]] && [[ "$getMost_backend" != "chroot" ]] && [[ "$CI" == "" ]]
	then
		_getMost_backend_aptGetInstall linux-headers-$(uname -r)
	fi

	_getMost_backend_aptGetInstall initramfs-tools
	
	_getMost_backend_aptGetInstall net-tools wireless-tools rfkill
	
	_getMost_backend_aptGetInstall dmidecode
	
	
	_getMost_backend_aptGetInstall p7zip
	_getMost_backend_aptGetInstall p7zip-full
	_getMost_backend_aptGetInstall unzip zip
	_getMost_backend_aptGetInstall lbzip2

	
	_getMost_backend_aptGetInstall jp2a
	
	
	
	_getMost_backend_aptGetInstall open-vm-tools-desktop
	
	#_getMost_backend_aptGetInstall virtualbox-guest-utils
	#_getMost_backend_aptGetInstall virtualbox-guest-x11
	
	
	
	# ATTENTION: ATTENTION: WARNING: CAUTION: DANGER: High maintenance. Expect to break and manually update frequently!
	#_getMost_backend wget -qO- 'https://download.virtualbox.org/virtualbox/6.1.34/VBoxGuestAdditions_6.1.34.iso' | _getMost_backend tee /VBoxGuestAdditions.iso > /dev/null
	#_getMost_backend wget -qO- 'https://download.virtualbox.org/virtualbox/7.0.10/VBoxGuestAdditions_7.0.10.iso' | _getMost_backend tee /VBoxGuestAdditions.iso > /dev/null
	_getMost_backend wget -qO- 'https://download.virtualbox.org/virtualbox/7.1.4/VBoxGuestAdditions_7.1.4.iso' | _getMost_backend tee /VBoxGuestAdditions.iso > /dev/null
	_getMost_backend 7z x /VBoxGuestAdditions.iso -o/VBoxGuestAdditions -aoa -y
	_getMost_backend rm -f /VBoxGuestAdditions.iso
	_getMost_backend chmod u+x /VBoxGuestAdditions/VBoxLinuxAdditions.run
	
	# https://forums.virtualbox.org/viewtopic.php?t=112770
	echo 'GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT kvm.enable_virt_at_load=0"' | _getMost_backend tee ""/etc/default/grub.d/99_vbox_kvm_compatibility.cfg


	
	# From '/var/log/vboxadd-*' , 'shared folder support module' 'modprobe vboxguest failed'
	# Due to 'rcvboxadd setup' and/or 'rcvboxadd quicksetup all' apparently ceasing to build subsequent modules (ie. 'vboxsf') after any error (ie. due to 'modprobe' failing unless VirtualBox virtual hardware is present).
	_getMost_backend mv -n /sbin/modprobe /sbin/modprobe.real
	_getMost_backend ln -s /bin/true /sbin/modprobe
	
	_getMost_backend /VBoxGuestAdditions/VBoxLinuxAdditions.run
	_getMost_backend /sbin/rcvboxadd quicksetup all
	_getMost_backend /sbin/rcvboxadd setup
	_getMost_backend /sbin/rcvboxadd quicksetup all
	#_getMost_backend /sbin/rcvboxadd setup

	_getMost_backend /sbin/rcvboxadd quicksetup $(_getMost_backend cat /boot/grub/grub.cfg 2>/dev/null | awk -F\' '/menuentry / {print $2}' | grep -v "Advanced options" | grep 'Linux [0-9]' | sed 's/ (.*//' | awk '{print $NF}' | head -n1)
	
	_getMost_backend rm -f /sbin/modprobe
	_getMost_backend mv -f /sbin/modprobe.real /sbin/modprobe
	
	
	
	
	# https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/install-linux-host.html
	echo 'virtualbox virtualbox/module-compilation-allowed boolean true
	virtualbox virtualbox/delete-old-modules boolean true' | _getMost_backend debconf-set-selections
	
	if false && !  [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' > /dev/null 2>&1
	then
		# WARNING: Untested. May be old version of VirtualBox. May conflict with guest additions.
		#_getMost_backend_aptGetInstall virtualbox-6.1
		_getMost_backend apt-get -d install -y virtualbox-6.1
	fi

		
	# WARNING: May be untested. May cause problems.
	#_getMost_backend_aptGetInstall docker-ce
	##_getMost_backend_aptGetInstall docker-compose-plugin
	#_getMost_backend_aptGetInstall docker-ce
	#_getMost_backend_aptGetInstall docker-buildx-plugin docker-ce-cli docker-ce-rootless-extras
	_getMost_backend apt-get -d install -y docker-ce
	#_getMost_backend apt-get -d install -y docker-compose-plugin
	_getMost_backend apt-get -d install -y docker-ce
	#_getMost_backend apt-get -d install -y docker-buildx-plugin docker-ce-cli docker-ce-rootless-extras

	# ATTENTION: Speculative . May be untested. Enable if ever necessary.
	#https://docs.docker.com/compose/install/
	#https://docs.docker.com/compose/install/linux/#install-the-plugin-manually
	#if ! _getMost_backend type docker-compose > /dev/null 2>&1
	#then
		#mkdir -p /usr/local/lib/docker/cli-plugins/docker-compose
		#curl -SL https://github.com/docker/compose/releases/download/v2.32.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
		#chmod 755 /usr/local/lib/docker/cli-plugins/docker-compose
	#fi
	
	
	# WARNING: If VirtualBox was not installed by now (eg. due to 'if false' comment block or wrong distribution), this must be called later.
	# https://en.wiktionary.org/wiki/poke_the_bear
	# https://forums.virtualbox.org/viewtopic.php?t=25797
	_getMost_backend /usr/bin/VBoxManage setextradata global GUI/SuppressMessages "Update"
	_getMost_backend /usr/local/bin/VBoxManage setextradata global GUI/SuppressMessages "Update"
	
	
	
	# WARNING: Untested. May incorrectly remove supposedly 'old' kernel versions.
	#_getMost_backend apt-get autoremove -y
	
	
	# WARNING: Strongly discouraged here.
	#sudo -n rm -f "$globalVirtFS"/ubtest.sh > /dev/null 2>&1
	#sudo -n cp "$scriptAbsoluteLocation" "$globalVirtFS"/ubtest.sh
	#_getMost_backend /ubtest.sh _test
	

	_getMost_backend_aptGetInstall dnsutils
	_getMost_backend_aptGetInstall bind9-dnsutils

	
	_getMost_backend_aptGetInstall live-boot
	#_getMost_backend_aptGetInstall pigz
	
	_getMost_backend_aptGetInstall falkon
	_getMost_backend_aptGetInstall konqueror
	
	_getMost_backend_aptGetInstall xserver-xorg-video-all
	_getMost_backend_aptGetInstall xserver-xorg-video-amdgpu
	
	_getMost_backend_aptGetInstall qalculate-gtk
	_getMost_backend_aptGetInstall qalc
	
	# CAUTION: Workaround. Debian defaults to an obsolete version of qalc which is unusable.
	_getMost_backend_aptGetInstall -t bullseye-backports qalc
	
	
	
	_getMost_backend_aptGetInstall octave
	_getMost_backend_aptGetInstall octave-arduino
	_getMost_backend_aptGetInstall octave-bart
	_getMost_backend_aptGetInstall octave-bim
	_getMost_backend_aptGetInstall octave-biosig
	_getMost_backend_aptGetInstall octave-bsltl
	_getMost_backend_aptGetInstall octave-cgi
	_getMost_backend_aptGetInstall octave-communications
	_getMost_backend_aptGetInstall octave-control
	_getMost_backend_aptGetInstall octave-data-smoothing
	_getMost_backend_aptGetInstall octave-dataframe
	_getMost_backend_aptGetInstall octave-dicom
	_getMost_backend_aptGetInstall octave-divand
	_getMost_backend_aptGetInstall octave-econometrics
	_getMost_backend_aptGetInstall octave-financial
	_getMost_backend_aptGetInstall octave-fits
	_getMost_backend_aptGetInstall octave-fuzzy-logic-toolkit
	_getMost_backend_aptGetInstall octave-ga
	_getMost_backend_aptGetInstall octave-gdf
	_getMost_backend_aptGetInstall octave-geometry
	_getMost_backend_aptGetInstall octave-gsl
	_getMost_backend_aptGetInstall octave-image
	_getMost_backend_aptGetInstall octave-image-acquisition
	_getMost_backend_aptGetInstall octave-instrument-control
	_getMost_backend_aptGetInstall octave-interval
	_getMost_backend_aptGetInstall octave-io
	_getMost_backend_aptGetInstall octave-level-set
	_getMost_backend_aptGetInstall octave-linear-algebra
	_getMost_backend_aptGetInstall octave-lssa
	#_getMost_backend_aptGetInstall octave-ltfat
	_getMost_backend_aptGetInstall octave-mapping
	_getMost_backend_aptGetInstall octave-miscellaneous
	_getMost_backend_aptGetInstall octave-missing-functions
	#_getMost_backend_aptGetInstall octave-mpi
	_getMost_backend_aptGetInstall octave-msh
	_getMost_backend_aptGetInstall octave-mvn
	_getMost_backend_aptGetInstall octave-nan
	_getMost_backend_aptGetInstall octave-ncarry
	_getMost_backend_aptGetInstall octave-netcdf
	_getMost_backend_aptGetInstall octave-nlopt
	_getMost_backend_aptGetInstall octave-nurbs
	_getMost_backend_aptGetInstall octave-octclip
	_getMost_backend_aptGetInstall octave-octproj
	_getMost_backend_aptGetInstall octave-openems
	_getMost_backend_aptGetInstall octave-optics
	_getMost_backend_aptGetInstall octave-optim
	_getMost_backend_aptGetInstall octave-optiminterp
	_getMost_backend_aptGetInstall octave-parallel
	_getMost_backend_aptGetInstall octave-pfstools
	_getMost_backend_aptGetInstall octave-plplot
	_getMost_backend_aptGetInstall octave-psychtoolbox-3
	_getMost_backend_aptGetInstall octave-quarternion
	_getMost_backend_aptGetInstall octave-queueing
	_getMost_backend_aptGetInstall octave-secs1d
	_getMost_backend_aptGetInstall octave-secs2d
	_getMost_backend_aptGetInstall octave-secs3d
	_getMost_backend_aptGetInstall octave-signal
	_getMost_backend_aptGetInstall octave-sockets
	_getMost_backend_aptGetInstall octave-sparsersb
	_getMost_backend_aptGetInstall octave-specfun
	_getMost_backend_aptGetInstall octave-splines
	_getMost_backend_aptGetInstall octave-stk
	_getMost_backend_aptGetInstall octave-strings
	_getMost_backend_aptGetInstall octave-struct
	_getMost_backend_aptGetInstall octave-symbolic
	_getMost_backend_aptGetInstall octave-tsa
	_getMost_backend_aptGetInstall octave-vibes
	_getMost_backend_aptGetInstall octave-vlfeat
	_getMost_backend_aptGetInstall octave-rml
	_getMost_backend_aptGetInstall octave-zenity
	_getMost_backend_aptGetInstall octave-zeromq
	
	
	_getMost_backend_aptGetInstall mktorrent
	_getMost_backend_aptGetInstall curl
	_getMost_backend_aptGetInstall gdisk
	_getMost_backend_aptGetInstall kate
	_getMost_backend_aptGetInstall kde-config-tablet
	_getMost_backend_aptGetInstall kwrite
	_getMost_backend_aptGetInstall lz4
	_getMost_backend_aptGetInstall mawk
	_getMost_backend_aptGetInstall nano
	_getMost_backend_aptGetInstall nilfs-tools

	_getMost_backend_aptGetInstall jq
	
	_getMost_backend_aptGetInstall build-essential
	_getMost_backend_aptGetInstall bison
	_getMost_backend_aptGetInstall libelf-dev
	_getMost_backend_aptGetInstall elfutils
	
	_getMost_backend_aptGetInstall patch
	
	_getMost_backend_aptGetInstall tar
	_getMost_backend_aptGetInstall xz
	_getMost_backend_aptGetInstall gzip
	_getMost_backend_aptGetInstall bzip2
	
	_getMost_backend_aptGetInstall librecode0
	_getMost_backend_aptGetInstall wkhtmltopdf
	
	_getMost_backend_aptGetInstall recoll
	_getMost_backend_aptGetInstall sed
	_getMost_backend_aptGetInstall texinfo
	_getMost_backend_aptGetInstall udftools
	_getMost_backend_aptGetInstall wondershaper
	_getMost_backend_aptGetInstall sddm
	_getMost_backend_aptGetInstall task-kde-desktop
	
	
	_getMost_backend_aptGetInstall kdiff3
	_getMost_backend_aptGetInstall pstoedit
	_getMost_backend_aptGetInstall pdftk
	
	_getMost_backend_aptGetInstall sysbench
	
	_getMost_backend_aptGetInstall libssl-dev
	
	
	_getMost_backend_aptGetInstall cpio
	
	
	_getMost_backend_aptGetInstall pv
	_getMost_backend_aptGetInstall expect
	
	_getMost_backend_aptGetInstall libfuse2
	
	_getMost_backend_aptGetInstall libgtk2.0-0
	
	_getMost_backend_aptGetInstall libwxgtk3.0-gtk3-0v5
	
	_getMost_backend_aptGetInstall wipe
	
	_getMost_backend_aptGetInstall udftools
	
	
	
	_getMost_backend_aptGetInstall iputils-ping
	
	_getMost_backend_aptGetInstall btrfs-tools
	_getMost_backend_aptGetInstall btrfs-progs
	_getMost_backend_aptGetInstall btrfs-compsize
	_getMost_backend_aptGetInstall zstd
	
	_getMost_backend_aptGetInstall zlib1g
	
	_getMost_backend_aptGetInstall nilfs-tools
	
	
	
	# md5sum , sha512sum
	_getMost_backend_aptGetInstall coreutils
	
	_getMost_backend_aptGetInstall python3
	_getMost_backend_aptGetInstall python3.11-venv
	_getMost_backend_aptGetInstall python3-serial

	#_getMost_backend_aptGetInstall python3-websocket
	
	
	# blkdiscard
	_getMost_backend_aptGetInstall util-linux
	
	# sg_format
	_getMost_backend_aptGetInstall sg3-utils
	
	_getMost_backend_aptGetInstall kpartx
	
	_getMost_backend_aptGetInstall openssl
	
	_getMost_backend_aptGetInstall growisofs
	
	_getMost_backend_aptGetInstall udev
	
	_getMost_backend_aptGetInstall gdisk
	
	_getMost_backend_aptGetInstall cryptsetup
	
	_getMost_backend_aptGetInstall util-linux
	
	_getMost_backend_aptGetInstall parted
	
	_getMost_backend_aptGetInstall bc
	
	_getMost_backend_aptGetInstall e2fsprogs
	
	_getMost_backend_aptGetInstall xz-utils
	
	_getMost_backend_aptGetInstall libreadline8
	_getMost_backend_aptGetInstall libreadline-dev
	
	
	_getMost_backend_aptGetInstall mkisofs
	_getMost_backend_aptGetInstall genisoimage
	
	
	_getMost_backend_aptGetInstall wodim
	
	_getMost_backend_aptGetInstall eject
	
	
	
	
	
	_getMost_backend_aptGetInstall hdparm
	_getMost_backend_aptGetInstall sdparm
	
	
	
	
	
	_getMost_backend_aptGetInstall php
	
	
	
	
	
	_getMost_backend_aptGetInstall synaptic
	
	_getMost_backend_aptGetInstall cifs-utils


	_getMost_backend_aptGetInstall debhelper
	
	_getMost_backend_aptGetInstall p7zip
	_getMost_backend_aptGetInstall p7zip-full
	_getMost_backend_aptGetInstall nsis

	_getMost_backend_aptGetInstall dos2unix


	_getMost_backend_aptGetInstall xxd
	
	
	# Sometimes may be useful as a workaround for docker 'overlay2' 'storage-driver' .
	_getMost_backend_aptGetInstall fuse-overlayfs
	
	
	
	# purge-old-kernels
	_getMost_backend_aptGetInstall byobu
	
	
	
	
	_getMost_backend_aptGetInstall xorriso
	_getMost_backend_aptGetInstall squashfs-tools
	_getMost_backend_aptGetInstall grub-pc-bin
	_getMost_backend_aptGetInstall grub-efi-amd64-bin
	_getMost_backend_aptGetInstall mtools
	_getMost_backend_aptGetInstall mksquashfs
	_getMost_backend_aptGetInstall grub-mkstandalone
	_getMost_backend_aptGetInstall mkfs.vfat
	_getMost_backend_aptGetInstall dosfstools
	_getMost_backend_aptGetInstall mkswap
	_getMost_backend_aptGetInstall mmd
	_getMost_backend_aptGetInstall mcopy
	_getMost_backend_aptGetInstall fdisk
	_getMost_backend_aptGetInstall mkswap
	
	
	
	
	
	
	_messagePlain_probe _getMost_backend curl croc
	if ! _getMost_backend type croc > /dev/null 2>&1
	then
		_getMost_backend curl https://getcroc.schollz.com | _getMost_backend bash
	fi
	
	
	
	_getMost_backend_aptGetInstall iotop
	
	_getMost_backend_aptGetInstall latencytop
	
	
	_getMost_backend_aptGetInstall lsof
	
	
	
	#_getMost_backend_aptGetInstall nvflash
	
	_getMost_backend_aptGetInstall usbutils
	
	_getMost_backend_aptGetInstall lm-sensors
	_getMost_backend_aptGetInstall hddtemp
	_getMost_backend_aptGetInstall aptitude
	_getMost_backend_aptGetInstall recode
	_getMost_backend_aptGetInstall asciidoc
	
	_getMost_backend_aptGetInstall pandoc
	_getMost_backend_aptGetInstall texlive-xetex
	_getMost_backend_aptGetInstall texlive-latex-recommended
	_getMost_backend_aptGetInstall texlive-latex-extra
	_getMost_backend_aptGetInstall fonts-texgyre
	_getMost_backend_aptGetInstall fonts-texgyre-math
	_getMost_backend_aptGetInstall tex-gyre
	_getMost_backend_aptGetInstall texlive-fonts-recommended
	
	_getMost_backend_aptGetInstall asciinema
	_getMost_backend_aptGetInstall gifsicle imagemagick apngasm ffmpeg
	_getMost_backend_aptGetInstall webp

	_getMost_backend_aptGetInstall ansifilter
	_getMost_backend_aptGetInstall ansifilter-gui
	
	
	
	_getMost_backend_aptGetInstall pavucontrol
	_getMost_backend_aptGetInstall filelight
	
	_getMost_backend_aptGetInstall obs-studio
	
	
	_getMost_backend_aptGetInstall lepton-eda
	_getMost_backend_aptGetInstall pcb
	_getMost_backend_aptGetInstall pcb-rnd
	_getMost_backend_aptGetInstall gerbv
	_getMost_backend_aptGetInstall electronics-pcb
	_getMost_backend_aptGetInstall pcb2gcode
	
	_getMost_backend_aptGetInstall inkscape
	_getMost_backend_aptGetInstall libgdl-3-5
	_getMost_backend_aptGetInstall libgdl-3-common
	_getMost_backend_aptGetInstall libgtkspell3-3-0
	_getMost_backend_aptGetInstall libimage-magick-perl
	_getMost_backend_aptGetInstall libimage-magick-q16-perl
	_getMost_backend_aptGetInstall libpotrace0
	_getMost_backend_aptGetInstall libwmf-bin
	_getMost_backend_aptGetInstall python3-scour
	
	
	_getMost_backend_aptGetInstall kicad
	
	_getMost_backend_aptGetInstall electric
	
	
	
	_getMost_backend python -m pip install --upgrade pip
	_getMost_backend sudo -n pip install --upgrade pip
	
	_getMost_backend_aptGetInstall freecad
	
	
	_getMost_backend_aptGetInstall audacity
	
	
	_getMost_backend_aptGetInstall w3m


	_getMost_backend_aptGetInstall xclip

	_getMost_backend_aptGetInstall tcl
	_getMost_backend_aptGetInstall tk

	_getMost_backend_aptGetInstall xserver-xephyr


	_getMost_backend_aptGetInstall qt5-style-plugins
	_getMost_backend_aptGetInstall qt5ct



	_getMost_backend_aptGetInstall fldigi
	_getMost_backend_aptGetInstall flamp
	_getMost_backend_aptGetInstall psk31lx


	_getMost_backend_aptGetInstall zip
	_getMost_backend_aptGetInstall unzip
	
	_getMost_backend_aptGetInstall par2
	
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover
	
	
	
	_getMost_backend_aptGetInstall yubikey-manager
	


	_getMost_backend_aptGetInstall tboot

	_getMost_backend_aptGetInstall trousers
	_getMost_backend_aptGetInstall tpm-tools
	_getMost_backend_aptGetInstall trousers-dbg
	
	
	
	_getMost_backend_aptGetInstall scdaemon
	
	_getMost_backend_aptGetInstall tpm2-openssl
	_getMost_backend_aptGetInstall tpm2-openssl tpm2-tools tpm2-abrmd libtss2-tcti-tabrmd0
	
	_getMost_backend_aptGetInstall tpm2-abrmd
	
	
	
	_getMost_backend_aptGetInstall qrencode
	
	_getMost_backend_aptGetInstall qtqr
	
	_getMost_backend_aptGetInstall zbar-tools
	_getMost_backend_aptGetInstall zbarcam-gtk
	_getMost_backend_aptGetInstall zbarcam-qt
	
	
	_getMost_backend_aptGetInstall cloud-guest-utils




	
	
	_getMost_backend_aptGetInstall python3-piexif
	

	_getMost_backend_aptGetInstall python3-torch
	_getMost_backend_aptGetInstall python3-torchaudio
	_getMost_backend_aptGetInstall python3-torchtext
	_getMost_backend_aptGetInstall python3-torchvision





	_getMost_backend_aptGetInstall dialog
	_getMost_backend_aptGetInstall whiptail
	
	
	
	_getMost_debian11_special_late
}

# ATTENTION: End user function.
_getMost_debian12() {
	_messagePlain_probe 'begin: _getMost_debian12'
	
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | _getMost_backend tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | _getMost_backend tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	
	_getMost_debian12_aptSources "$@"
	
	_getMost_debian12_install "$@"



	_here_opensslConfig_legacy | _getMost_backend tee /etc/ssl/openssl_legacy.cnf > /dev/null 2>&1

    if ! _getMost_backend grep 'openssl_legacy' /etc/ssl/openssl.cnf > /dev/null 2>&1
    then
        _getMost_backend cp -f /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.orig
        echo '


.include = /etc/ssl/openssl_legacy.cnf

' | _getMost_backend cat /etc/ssl/openssl.cnf.orig - | _getMost_backend tee /etc/ssl/openssl.cnf > /dev/null 2>&1
    fi
	
	
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover
	
	
	_messagePlain_probe 'end: _getMost_debian12'
}

# ATTENTION: End user function.
_getMost_debian11() {
	_messagePlain_probe 'begin: _getMost_debian11'
	
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | _getMost_backend tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | _getMost_backend tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	
	_getMost_debian11_aptSources "$@"
	
	_getMost_debian11_install "$@"
	
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover
	
	
	_messagePlain_probe 'end: _getMost_debian11'
}




_getMost_ubuntu24_aptSources() {
	## May be an image copied while dpkg was locked. Especially if 'chroot'.
	#_getMost_backend rm -f /var/lib/apt/lists/lock
	#_getMost_backend rm -f /var/lib/dpkg/lock
	
	
	#_getMost_backend_aptGetInstall wget
	#_getMost_backend_aptGetInstall gpg
	
	
	#_getMost_backend mkdir -p /etc/apt/sources.list.d
	#echo 'deb http://download.virtualbox.org/virtualbox/debian focal contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
	#echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable' | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
	
	#_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
	#_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
	
	#_getMost_debian11_aptSources "$@"
	_getMost_debian12_aptSources "$@"
}
_getMost_ubuntu22_aptSources() {
	## May be an image copied while dpkg was locked. Especially if 'chroot'.
	#_getMost_backend rm -f /var/lib/apt/lists/lock
	#_getMost_backend rm -f /var/lib/dpkg/lock
	
	
	#_getMost_backend_aptGetInstall wget
	#_getMost_backend_aptGetInstall gpg
	
	
	#_getMost_backend mkdir -p /etc/apt/sources.list.d
	#echo 'deb http://download.virtualbox.org/virtualbox/debian focal contrib' | _getMost_backend tee /etc/apt/sources.list.d/ub_vbox.list > /dev/null 2>&1
	#echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable' | _getMost_backend tee /etc/apt/sources.list.d/ub_docker.list > /dev/null 2>&1
	
	#_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | _getMost_backend apt-key add -
	#_getMost_backend wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | _getMost_backend apt-key add -
	
	_getMost_debian11_aptSources "$@"
}
_getMost_ubuntu24_install() {
	_getMost_debian12_install "$@"
	
	# WARNING: Untested. May be old version of VirtualBox. May conflict with guest additions.
	#_getMost_backend_aptGetInstall virtualbox-6.1
	#_getMost_backend apt-get -d install -y virtualbox-6.1
	_getMost_backend apt-get -d install -y virtualbox-7.1
	
	
	# WARNING: Untested. May cause problems.
	#_getMost_backend_aptGetInstall docker-ce
	_getMost_backend apt-get -d install -y docker-ce
	
	_getMost_backend_aptGetInstall tasksel
	_getMost_backend_aptGetInstall kde-plasma-desktop
	
	#_getMost_backend tasksel --new-install install "ubuntu-desktop"
	#_wait_debianInstall
	_getMost_backend_aptGetInstall ubuntu-desktop
}
_getMost_ubuntu22_install() {
	_getMost_debian11_install "$@"
	
	# WARNING: Untested. May be old version of VirtualBox. May conflict with guest additions.
	#_getMost_backend_aptGetInstall virtualbox-6.1
	_getMost_backend apt-get -d install -y virtualbox-6.1
	
	
	# WARNING: Untested. May cause problems.
	#_getMost_backend_aptGetInstall docker-ce
	_getMost_backend apt-get -d install -y docker-ce
	
	_getMost_backend_aptGetInstall tasksel
	_getMost_backend_aptGetInstall kde-plasma-desktop
	
	#_getMost_backend tasksel --new-install install "ubuntu-desktop"
	#_wait_debianInstall
	_getMost_backend_aptGetInstall ubuntu-desktop
}

# ATTENTION: End user function.
_getMost_ubuntu24() {
	_messagePlain_probe 'begin: _getMost_ubuntu24'
	
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | _getMost_backend tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | _getMost_backend tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	
	_getMost_ubuntu24_aptSources "$@"
	
	_getMost_ubuntu24_install "$@"
	
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover
	
	
	_messagePlain_probe 'end: _getMost_ubuntu24'
}
_getMost_ubuntu22() {
	_messagePlain_probe 'begin: _getMost_ubuntu22'
	
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | _getMost_backend tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | _getMost_backend tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	
	_getMost_ubuntu22_aptSources "$@"
	
	_getMost_ubuntu22_install "$@"
	
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover
	
	
	_messagePlain_probe 'end: _getMost_ubuntu22'
}

# ATTENTION: Cloud 'end user' function.
_getMost_ubuntu24-VBoxManage() {
	_messagePlain_probe 'begin: _getMost_ubuntu24-VBoxManage'
	
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | _getMost_backend tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | _getMost_backend tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	
	_getMost_ubuntu24_aptSources "$@"
	
	#_getMost_ubuntu24_install "$@"
	#_getMost_backend apt-get -d install -y virtualbox-6.1
	#_getMost_backend apt-get -d install -y virtualbox-7.0
	_getMost_backend apt-get -d install -y virtualbox-7.1
	
	#_getMost_backend_aptGetInstall virtualbox-7.0
	_getMost_backend_aptGetInstall virtualbox-7.1
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover
	
	_getMost_backend apt-get -y clean
	
	
	_messagePlain_probe 'end: _getMost_ubuntu24-VBoxManage'
}
_getMost_ubuntu22-VBoxManage() {
	_messagePlain_probe 'begin: _getMost_ubuntu22-VBoxManage'
	
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
	echo 'Dpkg::Options {"--force-confdef"};' | _getMost_backend tee /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	echo 'Dpkg::Options {"--force-confold"};' | _getMost_backend tee -a /etc/apt/apt.conf.d/50unattended-replaceconfig-ub > /dev/null
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	
	_getMost_ubuntu22_aptSources "$@"
	
	#_getMost_ubuntu22_install "$@"
	#_getMost_backend apt-get -d install -y virtualbox-6.1
	#_getMost_backend apt-get -d install -y virtualbox-7.0
	_getMost_backend apt-get -d install -y virtualbox-7.1
	
	#_getMost_backend_aptGetInstall virtualbox-7.0
	_getMost_backend_aptGetInstall virtualbox-7.1
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover
	
	_getMost_backend apt-get -y clean
	
	
	_messagePlain_probe 'end: _getMost_ubuntu22-VBoxManage'
}



# ATTENTION: Override with 'ops.sh' or similar .
# https://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu
_set_getMost_backend_debian() {
	_getMost_backend_aptGetInstall() {
		# --no-upgrade
		# -o Dpkg::Options::="--force-confold"

		# ATTRIBUTION-AI: ChatGPT o1-preview 2024-11-20 .
		echo 'APT::AutoRemove::RecommendsImportant "true";
APT::AutoRemove::SuggestsImportant "true";' | _getMost_backend tee /etc/apt/apt.conf.d/99autoremove-recommends > /dev/null
		
		if ! _getMost_backend dash -c 'type apt-fast' > /dev/null 2>&1 || [[ "$RUNNER_OS" != "" ]]
		then
			_messagePlain_probe _getMost_backend env XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -q --install-recommends -y "$@"
			_getMost_backend env XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -q --install-recommends -y "$@"
		else
			#DOWNLOADBEFORE=true
			_messagePlain_probe _getMost_backend env DOWNLOADBEFORE=true XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt-fast -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -q --install-recommends -y "$@"
			_getMost_backend env DOWNLOADBEFORE=true XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt-fast -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -q --install-recommends -y "$@"
		fi
		
		#_messagePlain_probe _getMost_backend env XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install --install-recommends -y "$@"
		#_getMost_backend env XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install --install-recommends -y "$@"
	}
	
	#if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' > /dev/null 2>&1
	#then
		#_getMost_backend_aptGetInstall() {
		## --no-upgrade
			#_messagePlain_probe _getMost_backend env DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install --install-recommends -y "$@"
			#_getMost_backend env DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install --install-recommends -y "$@"
		#}
	#fi
	
	export -f _getMost_backend_aptGetInstall
}
_set_getMost_backend_command() {
	[[ "$getMost_backend" == "" ]] && export getMost_backend="direct"
	#[[ "$getMost_backend" == "" ]] && export getMost_backend="chroot"
	#[[ "$getMost_backend" == "" ]] && export getMost_backend="ssh"
	
	
	
	if [[ "$getMost_backend" == "direct" ]] && [[ $(id -u) == 0 ]]
	then
		! _mustBeRoot && exit 1
		_getMost_backend() {
			"$@"
		}
		export -f _getMost_backend
		return 0
	fi
	if [[ "$getMost_backend" == "direct" ]]
	then
		! _mustGetSudo && exit 1
		_getMost_backend() {
			sudo -n "$@"
		}
		export -f _getMost_backend
		return 0
	fi
	[[ "$getMost_backend" == "direct" ]] && return 1
	
	
	
	if [[ "$getMost_backend" == "chroot" ]]
	then
		_getMost_backend() {
			_chroot "$@"
		}
		export -f _getMost_backend
	fi
	
	if [[ "$getMost_backend" == "ssh" ]]
	then
		_getMost_backend() {
			local currentExitStatus
			
			#export custom_user="user"
			#export custom_hostname='hostname'
			#export custom_netName="$netName"
			#export SSHuserAndMachine="$custom_user""@""$custom_hostname"-"$custom_netName"
			#export SSHuserAndMachine="$1"
			_ssh_internal_command "$SSHuserAndMachine" "$@"
			currentExitStatus="$?"
			
			#Preventative workaround, not normally necessary.
			stty echo > /dev/null 2>&1
			return "$currentExitStatus"
		}
		export -f _getMost_backend
	fi
	
	return 0
}
_set_getMost_backend_fileExists() {
	_getMost_backend_fileExists() {
		# Any modern GNU/Linux, Cygwin/MSW, etc, OS distribution, is expected to have '/bin/bash'.
		# Override to '/bin/dash' may very slightly improve performance, the compatibility tradeoff is NOT expected worthwhile.
		_getMost_backend /bin/bash -c '[ -e "'"$1"'" ]'
	}
	export -f _getMost_backend_fileExists
}
_set_getMost_backend() {
	_set_getMost_backend_command "$@"
	_set_getMost_backend_fileExists "$@"
	
	_set_getMost_backend_debian "$@"
}

# WARNING: Do NOT call from '_test' or similar.
_test_getMost_backend() {
	_getMost_backend false && _messagePlain_bad 'fail: incorrect: _getMost_backend false' && _messageFAIL && _stop 1
	! _getMost_backend true && _messagePlain_bad 'fail: incorrect: _getMost_backend true' && _messageFAIL && _stop 1
}


# WARNING: No production use. Installation commands may be called through 'chroot' or 'ssh' , expected as such not reasonably able to detect the OS distribution . User is expected to instead call the correct function with the correct configuration.
_getMost() {
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Debian\|Raspbian' > /dev/null 2>&1 && [[ -e /etc/debian_version ]] && cat /etc/debian_version | head -c 2 | grep 12 > /dev/null 2>&1
	then
		_tryExecFull _getMost_debian12 "$@"
		return
	elif [[ -e /etc/issue ]] && cat /etc/issue | grep 'Debian\|Raspbian' > /dev/null 2>&1
	then
		_tryExecFull _getMost_debian11 "$@"
		return
	elif [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '24.04' > /dev/null 2>&1
	then
		_tryExecFull _getMost_ubuntu24 "$@"
		return
	elif [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' > /dev/null 2>&1
	then
		_tryExecFull _getMost_ubuntu22 "$@"
		return
	else
		_tryExecFull _getMost_debian12 "$@"
		return
	fi
	return 1
}










# ATTENTION: Override with 'ops.sh' or similar.
#./ubiquitous_bash.sh _getMost_backend true
#./ubiquitous_bash.sh _getMost_backend false
if [[ "$1" == "_getMost"* ]] && [[ "$ub_import" != "true" ]] && [[ "$objectName" == "ubiquitous_bash" ]] && ( ! type -f _getMost_backend > /dev/null 2>&1 || ! type -f _getMost_backend_fileExists > /dev/null 2>&1 || ! type -f _getMost_backend_aptGetInstall > /dev/null 2>&1 )
then
	_set_getMost_backend
fi


# ATTENTION: NOTICE: Unusual. Installs only dependencies necessary for some purposes (eg. kernel compiling). May be useful for cloud build (aka. 'Continious Integration' services which (eg. due to slow mirrors configured for Ubuntu) are unable to quickly install all of more normal 'desktop' packages.
# ATTENTION: Override with 'core.sh' or similar.


# Unusual. Strongly discouraged.
# CAUTION: Pulls in as much as >1GB (uncompressed) of binaries. May be unaffordable on uncompressed filesystems.
# Unless your CI job is specifically cross compiling for MSW, you almost certainly do NOT want this.
_getMinimal_cloud-msw() {
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	_set_getMost_backend "$@"
	_test_getMost_backend "$@"
	#_getMost_debian11_aptSources "$@"
	
	_getMost_backend_aptGetInstall mingw-w64
	_getMost_backend_aptGetInstall g++-mingw-w64-x86-64-win32
	_getMost_backend_aptGetInstall binutils-mingw-w64
	_getMost_backend_aptGetInstall mingw-w64-tools
	_getMost_backend_aptGetInstall gdb-mingw-w64
}

# Unusual. Strongly discouraged. Building Linux Kernel with fewer resources is helpful for compatibility and performance with some constrained and repetitive cloud services.
_getMinimal_cloud() {
	"$scriptAbsoluteLocation" _setupUbiquitous
	
	
	
	#https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
	#apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	
	_set_getMost_backend "$@"
	_test_getMost_backend "$@"
	#_getMost_debian11_aptSources "$@"
	
	
	
	_getMost_backend apt-get update
	_getMost_backend_aptGetInstall sudo
	_getMost_backend_aptGetInstall gpg
	_getMost_backend_aptGetInstall --reinstall wget
	
	_getMost_backend_aptGetInstall vim
	
	_getMost_backend_aptGetInstall linux-image-amd64
	
	_getMost_backend_aptGetInstall strace
	
	# WARNING: Rust is not yet (2023-11-12) anywhere near as editable on the fly or pervasively available as bash .
	#  Criteria for such are far more necessarily far more stringent than might be intuitively obvious.
	#  Rust is expected to remain non-competitive with bash for purposes of 'ubiquitous_bash', even for reference implementations, for at least 6years .
	#   6 years
	# https://users.rust-lang.org/t/does-rust-work-in-cygwin-if-so-how-can-i-get-it-working/25735
	# https://stackoverflow.com/questions/31492799/cross-compile-a-rust-application-from-linux-to-windows
	# https://rustup.rs/
	#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	# https://packages.debian.org/search?keywords=rustup&searchon=names&suite=all&section=all
	# https://wiki.debian.org/Rust
	#  DANGER: Do NOT regard 'rustup' as available.
	_getMost_backend_aptGetInstall rustc
	_getMost_backend_aptGetInstall cargo
	#_getMost_backend_aptGetInstall rustup
	
	_getMost_backend_aptGetInstall pigz

	_getMost_backend_aptGetInstall dnsutils
	_getMost_backend_aptGetInstall bind9-dnsutils
	
	_getMost_backend_aptGetInstall qalc
	
	_getMost_backend_aptGetInstall octave
	
	_getMost_backend_aptGetInstall curl
	_getMost_backend_aptGetInstall gdisk
	_getMost_backend_aptGetInstall lz4
	_getMost_backend_aptGetInstall mawk
	_getMost_backend_aptGetInstall nano
	
	_getMost_backend_aptGetInstall jq
	
	_getMost_backend_aptGetInstall sloccount
	
	#_getMost_backend_aptGetInstall original-awk
	_getMost_backend_aptGetInstall gawk
	
	_getMost_backend_aptGetInstall build-essential
	_getMost_backend_aptGetInstall bison
	_getMost_backend_aptGetInstall libelf-dev
	_getMost_backend_aptGetInstall elfutils
	_getMost_backend_aptGetInstall flex
	_getMost_backend_aptGetInstall libncurses-dev
	_getMost_backend_aptGetInstall autoconf
	_getMost_backend_aptGetInstall libudev-dev

	_getMost_backend_aptGetInstall dwarves
	_getMost_backend_aptGetInstall pahole

	_getMost_backend_aptGetInstall cmake
	
	_getMost_backend_aptGetInstall pkg-config
	
	_getMost_backend_aptGetInstall bsdutils
	_getMost_backend_aptGetInstall findutils
	
	_getMost_backend_aptGetInstall patch
	
	_getMost_backend_aptGetInstall tar
	_getMost_backend_aptGetInstall xz
	_getMost_backend_aptGetInstall gzip
	_getMost_backend_aptGetInstall bzip2
	
	_getMost_backend_aptGetInstall flex

	_getMost_backend_aptGetInstall imagemagick
	_getMost_backend_aptGetInstall graphicsmagick-imagemagick-compat
	
	_getMost_backend_aptGetInstall librecode0
	_getMost_backend_aptGetInstall wkhtmltopdf
	
	_getMost_backend_aptGetInstall sed
	
	
	_getMost_backend_aptGetInstall curl
	
	_messagePlain_probe 'install: rclone'
	#_getMost_backend curl https://rclone.org/install.sh | _getMost_backend bash -s beta
	_getMost_backend curl https://rclone.org/install.sh | _getMost_backend bash
	
	# Apparently Github Actions does not have IPv6.
	# https://github.com/actions/virtual-environments/issues/668#issuecomment-624080758
	[[ "$CI" != "" ]] && _getMost_backend curl -4 https://rclone.org/install.sh | _getMost_backend bash
	
	if ! _getMost_backend type rclone > /dev/null 2>&1
	then
		_getMost_backend_aptGetInstall rclone
	fi
	
	
	_getMost_backend_aptGetInstall sockstat
	_getMost_backend_aptGetInstall liblinear4 liblua5.3-0 lua-lpeg nmap nmap-common
	
	_getMost_backend_aptGetInstall socat
	
	#_getMost_backend_aptGetInstall octave
	#_getMost_backend_aptGetInstall octave-arduino
	#_getMost_backend_aptGetInstall octave-bart
	#_getMost_backend_aptGetInstall octave-bim
	#_getMost_backend_aptGetInstall octave-biosig
	#_getMost_backend_aptGetInstall octave-bsltl
	#_getMost_backend_aptGetInstall octave-cgi
	#_getMost_backend_aptGetInstall octave-communications
	#_getMost_backend_aptGetInstall octave-control
	#_getMost_backend_aptGetInstall octave-data-smoothing
	#_getMost_backend_aptGetInstall octave-dataframe
	#_getMost_backend_aptGetInstall octave-dicom
	#_getMost_backend_aptGetInstall octave-divand
	#_getMost_backend_aptGetInstall octave-econometrics
	#_getMost_backend_aptGetInstall octave-financial
	#_getMost_backend_aptGetInstall octave-fits
	#_getMost_backend_aptGetInstall octave-fuzzy-logic-toolkit
	#_getMost_backend_aptGetInstall octave-ga
	#_getMost_backend_aptGetInstall octave-gdf
	#_getMost_backend_aptGetInstall octave-geometry
	#_getMost_backend_aptGetInstall octave-gsl
	#_getMost_backend_aptGetInstall octave-image
	#_getMost_backend_aptGetInstall octave-image-acquisition
	#_getMost_backend_aptGetInstall octave-instrument-control
	#_getMost_backend_aptGetInstall octave-interval
	#_getMost_backend_aptGetInstall octave-io
	#_getMost_backend_aptGetInstall octave-level-set
	#_getMost_backend_aptGetInstall octave-linear-algebra
	#_getMost_backend_aptGetInstall octave-lssa
	#_getMost_backend_aptGetInstall octave-ltfat
	#_getMost_backend_aptGetInstall octave-mapping
	#_getMost_backend_aptGetInstall octave-miscellaneous
	#_getMost_backend_aptGetInstall octave-missing-functions
	#_getMost_backend_aptGetInstall octave-mpi
	#_getMost_backend_aptGetInstall octave-msh
	#_getMost_backend_aptGetInstall octave-mvn
	#_getMost_backend_aptGetInstall octave-nan
	#_getMost_backend_aptGetInstall octave-ncarry
	#_getMost_backend_aptGetInstall octave-netcdf
	#_getMost_backend_aptGetInstall octave-nlopt
	#_getMost_backend_aptGetInstall octave-nurbs
	#_getMost_backend_aptGetInstall octave-octclip
	#_getMost_backend_aptGetInstall octave-octproj
	#_getMost_backend_aptGetInstall octave-openems
	#_getMost_backend_aptGetInstall octave-optics
	#_getMost_backend_aptGetInstall octave-optim
	#_getMost_backend_aptGetInstall octave-optiminterp
	#_getMost_backend_aptGetInstall octave-parallel
	#_getMost_backend_aptGetInstall octave-pfstools
	#_getMost_backend_aptGetInstall octave-plplot
	#_getMost_backend_aptGetInstall octave-psychtoolbox-3
	#_getMost_backend_aptGetInstall octave-quarternion
	#_getMost_backend_aptGetInstall octave-queueing
	#_getMost_backend_aptGetInstall octave-secs1d
	#_getMost_backend_aptGetInstall octave-secs2d
	#_getMost_backend_aptGetInstall octave-secs3d
	#_getMost_backend_aptGetInstall octave-signal
	#_getMost_backend_aptGetInstall octave-sockets
	#_getMost_backend_aptGetInstall octave-sparsersb
	#_getMost_backend_aptGetInstall octave-specfun
	#_getMost_backend_aptGetInstall octave-splines
	#_getMost_backend_aptGetInstall octave-stk
	#_getMost_backend_aptGetInstall octave-strings
	#_getMost_backend_aptGetInstall octave-struct
	#_getMost_backend_aptGetInstall octave-symbolic
	#_getMost_backend_aptGetInstall octave-tsa
	#_getMost_backend_aptGetInstall octave-vibes
	#_getMost_backend_aptGetInstall octave-vlfeat
	#_getMost_backend_aptGetInstall octave-rml
	#_getMost_backend_aptGetInstall octave-zenity
	#_getMost_backend_aptGetInstall octave-zeromq
	#_getMost_backend_aptGetInstall gnuplot-qt libdouble-conversion3 libegl-mesa0 libegl1 libevdev2 libinput-bin libinput10 libmtdev1 libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5printsupport5 libqt5svg5 libqt5widgets5 libwacom-bin libwacom-common libwacom2 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-util1 libxcb-xinerama0 libxcb-xinput0 libxcb-xkb1 libxkbcommon-x11-0 qt5-gtk-platformtheme qttranslations5-l10n
	#_getMost_backend_aptGetInstall hdf5-helpers libaec-dev libegl-dev libfftw3-bin libfftw3-dev libfftw3-long3 libfftw3-quad3 libgl-dev libgl1-mesa-dev libgles-dev libgles1 libgles libglvnd-dev libglx-dev libhdf5-cpp-103 libhdf5-dev liboctave-dev libopengl-dev libopengl0
	
	
	_getMost_backend_aptGetInstall axel
	_getMost_backend_aptGetInstall aria2
	
	
	_getMost_backend_aptGetInstall gh
	
	
	_getMost_backend_aptGetInstall dwarves
	_getMost_backend_aptGetInstall pahole
	
	
	_getMost_backend_aptGetInstall rsync
	
	
	_getMost_backend_aptGetInstall libssl-dev
	
	
	_getMost_backend_aptGetInstall cpio
	
	
	_getMost_backend_aptGetInstall pv
	_getMost_backend_aptGetInstall expect
	
	_getMost_backend_aptGetInstall libfuse2
	
	_getMost_backend_aptGetInstall libgtk2.0-0
	
	_getMost_backend_aptGetInstall libwxgtk3.0-gtk3-0v5
	
	_getMost_backend_aptGetInstall wipe
	
	_getMost_backend_aptGetInstall udftools
	
	
	_getMost_backend_aptGetInstall debootstrap
	
	#_getMost_backend_aptGetInstall qemu-user qemu-utils
	_getMost_backend_aptGetInstall qemu-system-x86
	
	_getMost_backend_aptGetInstall cifs-utils
	
	_getMost_backend_aptGetInstall dos2unix


	_getMost_backend_aptGetInstall xxd


	_getMost_backend_aptGetInstall debhelper
	
	_getMost_backend_aptGetInstall p7zip
	_getMost_backend_aptGetInstall nsis

	
	_getMost_backend_aptGetInstall jp2a

	
	_getMost_backend_aptGetInstall iputils-ping
	
	_getMost_backend_aptGetInstall btrfs-tools
	_getMost_backend_aptGetInstall btrfs-progs
	_getMost_backend_aptGetInstall btrfs-compsize
	_getMost_backend_aptGetInstall zstd
	
	_getMost_backend_aptGetInstall zlib1g
	
	_getMost_backend_aptGetInstall nilfs-tools
	
	
	
	# md5sum , sha512sum
	_getMost_backend_aptGetInstall coreutils
	
	_getMost_backend_aptGetInstall python3
	
	# blkdiscard
	_getMost_backend_aptGetInstall util-linux
	
	# sg_format
	_getMost_backend_aptGetInstall sg3-utils
	
	_getMost_backend_aptGetInstall kpartx
	
	_getMost_backend_aptGetInstall openssl
	
	_getMost_backend_aptGetInstall growisofs
	
	_getMost_backend_aptGetInstall udev
	
	_getMost_backend_aptGetInstall gdisk
	
	_getMost_backend_aptGetInstall cryptsetup
	
	_getMost_backend_aptGetInstall util-linux
	
	_getMost_backend_aptGetInstall parted
	
	_getMost_backend_aptGetInstall bc
	
	_getMost_backend_aptGetInstall e2fsprogs
	
	_getMost_backend_aptGetInstall xz-utils
	
	_getMost_backend_aptGetInstall libreadline8
	_getMost_backend_aptGetInstall libreadline-dev
	
	
	_getMost_backend_aptGetInstall mkisofs
	_getMost_backend_aptGetInstall genisoimage
	
	
	
	_getMost_backend_aptGetInstall php
	
	
	
	# purge-old-kernels
	_getMost_backend_aptGetInstall byobu
	
	
	
	
	
	_getMost_backend_aptGetInstall xorriso
	_getMost_backend_aptGetInstall squashfs-tools
	_getMost_backend_aptGetInstall grub-pc-bin
	_getMost_backend_aptGetInstall grub-efi-amd64-bin
	_getMost_backend_aptGetInstall mtools
	_getMost_backend_aptGetInstall mksquashfs
	_getMost_backend_aptGetInstall grub-mkstandalone
	_getMost_backend_aptGetInstall mkfs.vfat
	_getMost_backend_aptGetInstall dosfstools
	_getMost_backend_aptGetInstall mkswap
	_getMost_backend_aptGetInstall mmd
	_getMost_backend_aptGetInstall mcopy
	_getMost_backend_aptGetInstall fdisk
	_getMost_backend_aptGetInstall mkswap
	
	



	# ATTRIBUTION-AI ChatGPT o1 2025-01-03 ... partially. Seems there is some evidence newer dist/OS versions may be more likely to break by default, 'i386', needed for building MSW installers, etc.
	_getMost_backend dpkg --add-architecture i386
	_getMost_backend env DEBIAN_FRONTEND=noninteractive apt-get -y update
	_getMost_backend_aptGetInstall libc6:i386 lib32z1
	#_getMost_backend_aptGetInstall wine wine32 wine64 libwine libwine:i386 fonts-wine


	
	
	
	
	_messagePlain_probe _getMost_backend curl croc
	if ! _getMost_backend type croc > /dev/null 2>&1
	then
		_getMost_backend curl https://getcroc.schollz.com | _getMost_backend bash
		[[ "$CI" != "" ]] && _getMost_backend curl -4 | _getMost_backend bash
	fi
	
	
	
	_getMost_backend_aptGetInstall iotop
	
	
	
	# May not be useful for anything, may cause delay or fail .
	#_getMost_backend apt-get upgrade
	
	
	
	
	type _get_veracrypt > /dev/null 2>&1 && "$scriptAbsoluteLocation" _get_veracrypt
	
	
	
	_getMost_backend apt-get remove --autoremove -y plasma-discover


	
	#_getMost_backend_aptGetInstall tboot

	_getMost_backend_aptGetInstall trousers
	_getMost_backend_aptGetInstall tpm-tools
	_getMost_backend_aptGetInstall trousers-dbg
	
	
	_getMost_backend_aptGetInstall cloud-guest-utils

	
	_getMost_backend apt-get -y clean
	
	
	# ATTENTION: Enable. Disabled by default to avoid testing for all dependencies of *complete* 'ubiquitous_bash' .
	#export devfast="true"
	#"$scriptAbsoluteLocation" _test
	#export devfast=
	#unset devfast


	_messagePlain_probe _custom_splice_opensslConfig
	_here_opensslConfig_legacy | _getMost_backend tee /etc/ssl/openssl_legacy.cnf > /dev/null 2>&1

    if ! _getMost_backend grep 'openssl_legacy' /etc/ssl/openssl.cnf > /dev/null 2>&1
    then
        _getMost_backend cp -f /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.orig
        echo '


.include = /etc/ssl/openssl_legacy.cnf

' | _getMost_backend cat /etc/ssl/openssl.cnf.orig - | _getMost_backend tee /etc/ssl/openssl.cnf > /dev/null 2>&1
    fi
	
	
	return 0
}


# Minimizes runtime (to avoid timeouts) and conflicts with installed software. Usually used by specialized Docker containers (eg. 'ghcr.io/openai/codex-universal' , 'openai-heavy' , etc) , within environments unable (unlike a usual VPS) to directly use a custom dist/OS (eg. OpenAI ChatGPT Codex WebUI , RunPod , etc).
_getMinimal_special() {
	echo 'APT::AutoRemove::RecommendsImportant "true";
APT::AutoRemove::SuggestsImportant "true";' | tee /etc/apt/apt.conf.d/99autoremove-recommends > /dev/null


	
	unset _aptGetInstall
	unalias _aptGetInstall 2>/dev/null
	_aptGetInstall() {
		env XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -q --install-recommends -y "$@"
	}

	# ubiquitous_bash  fast alternative
	#procps strace sudo wget gpg curl pigz pixz bash aria2 git git-lfs bc nmap socat sockstat rsync net-tools uuid-runtime netcat-openbsd axel util-linux gawk libncurses-dev gh crudini bsdutils findutils p7zip p7zip-full unzip zip lbzip2 dnsutils bind9-dnsutils lz4 mawk patch tar gzip bzip2 sed pv expect wipe iputils-ping zstd zlib1g coreutils openssl xz-utils libreadline8 libreadline-dev mkisofs genisoimage dos2unix lsof aptitude jq xxd sloccount dosfstools apt-utils git-filter-repo qalc apt-transport-https tcl tk

	# ubiquitous_bash  basic alternative
	#procps strace sudo wget gpg curl pigz pixz bash aria2 git git-lfs bc nmap socat sockstat rsync net-tools uuid-runtime netcat-openbsd axel unionfs-fuse util-linux screen gawk libelf-dev libncurses-dev gh crudini bsdutils findutils p7zip p7zip-full unzip zip lbzip2 jp2a dnsutils bind9-dnsutils lz4 mawk libelf-dev elfutils patch tar gzip bzip2 librecode0 udftools sed cpio pv expect wipe iputils-ping btrfs-progs btrfs-compsize zstd zlib1g coreutils openssl growisofs e2fsprogs xz-utils libreadline8 libreadline-dev mkisofs genisoimage wodim dos2unix fuse-overlayfs xorriso squashfs-tools mtools lsof aptitude jq xxd sloccount dosfstools apt-utils git-filter-repo qalc apt-transport-https tcl tk

	_aptGetInstall procps strace sudo wget gpg curl pigz pixz bash aria2 git git-lfs bc nmap socat sockstat rsync net-tools uuid-runtime iperf3 vim man-db gnulib libtool libtool-bin intltool libgts-dev netcat-openbsd iperf axel unionfs-fuse debootstrap util-linux screen gawk build-essential flex libelf-dev libncurses-dev autoconf libudev-dev dwarves pahole cmake gh libusb-dev libusb-1.0 setserial libffi-dev libusb-1.0-0 libusb-1.0-0-dev libusb-1.0-doc pkg-config crudini bsdutils findutils v4l-utils libevent-dev libjpeg-dev libbsd-dev libusb-1.0 gdb libbabeltrace1 libc6-dbg libsource-highlight-common libsource-highlight4v5 initramfs-tools dmidecode p7zip p7zip-full unzip zip lbzip2 jp2a dnsutils bind9-dnsutils live-boot mktorrent gdisk lz4 mawk nano bison libelf-dev elfutils patch tar gzip bzip2 librecode0 sed texinfo udftools wondershaper sysbench libssl-dev cpio pv expect libfuse2 wipe iputils-ping btrfs-progs btrfs-compsize zstd zlib1g nilfs-tools coreutils sg3-utils kpartx openssl growisofs udev cryptsetup parted e2fsprogs xz-utils libreadline8 libreadline-dev mkisofs genisoimage wodim eject hdparm sdparm php cifs-utils debhelper nsis dos2unix fuse-overlayfs xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin mtools squashfs-tools squashfs-tools-ng fdisk lsof usbutils aptitude recode libpotrace0 libwmf-bin w3m par2 yubikey-manager qrencode tasksel jq xxd sloccount dosfstools apt-utils git-filter-repo qalc apt-transport-https tcl tk libgdl-3-5 libgdl-3-common > /quicklog.tmp 2>&1
	tail /quicklog.tmp
	rm -f /quicklog.tmp

	#tcl tk libgdl-3-5 libgdl-3-common

	#avrdude gcc-avr binutils-avr avr-libc stm32flash dfu-util libnewlib-arm-none-eabi gcc-arm-none-eabi binutils-arm-none-eabi

	#mingw-w64 g++-mingw-w64-x86-64-win32 binutils-mingw-w64 mingw-w64-tools gdb-mingw-w64

	#pkg-haskell-tools alex cabal-install happy hscolour ghc

	#kicad electric lepton-eda pcb-rnd gerbv electronics-pcb pstoedit pdftk

	#wkhtmltopdf asciidoc

	#vainfo ffmpeg

	#samba qemu-system-x86 qemu-system-arm qemu-efi-arm qemu-efi-aarch64 qemu-user-static qemu-utils dosbox

	#wireless-tools rfkill cloud-guest-utils

	#recoll

	#zbar-tools



	#rustc cargo

	#openjdk-17-jdk openjdk-17-jre

	#psk31lx

	#emacs

	#python3-serial



	#locales-all

	# ddd

	

	apt-get remove --autoremove -y
	apt-get -y clean



	"$scriptAbsoluteLocation" _here_opensslConfig_legacy | tee /etc/ssl/openssl_legacy.cnf > /dev/null 2>&1
	echo '

	.include = /etc/ssl/openssl_legacy.cnf

	' | cat /etc/ssl/openssl.cnf.orig - 2>/dev/null | tee /etc/ssl/openssl.cnf > /dev/null 2>&1


}




# ATTENTION
# NOTICE
# May be able to automatically respond to nix package manager file conflicts.
# WARNING: May be untested.
# ATTRIBUTION-AI: Suggested by CLI Codex (ie. _codexAuto) 2025-07-20 .
#
#_nixInstallRetry() {
	#local -a cmd=( "$@" ) out status file
	#if out=$( "${cmd[@]}" 2>&1 ); then
		#printf '%s\n' "$out"
		#return 0
	#else
		#status=$?
		#if printf '%s\n' "$out" | grep -q "file conflict over '"; then
			#file=$(printf '%s\n' "$out" | sed -n "s/.*file conflict over '\([^']*\)'.*/\1/p")
			#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'rm -f "$HOME/.nix-profile/'"$file"'"'
			#"${cmd[@]}"
			#return $?
		#else
			#printf '%s\n' "$out" >&2
			#return $status
		#fi
	#fi
#}
#export -f _nixInstallRetry
#
#_nixInstallRetry _getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA pcb -f https://github.com/NixOS/nixpkgs/archive/00a3a62a70f6c2ca919befeda4b8a7319ce8be2b.tar.gz'










# NOTICE
# https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=geda
# https://lazamar.co.uk/nix-versions/?package=geda&version=1.10.2&fullName=geda-1.10.2&keyName=geda&revision=9957cd48326fe8dbd52fdc50dd2502307f188b0d&channel=nixpkgs-unstable#instructions
#nix-env --query
#nix-env --uninstall geda
#export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA nixpkgs.geda
#export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA geda -f https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz
#nix-collect-garbage -d
#nix-env -iA geda -f https://github.com/NixOS/nixpkgs/archive/773a8314ef05364d856e46299722a9d849aacf8b.tar.gz
#nix-channel --update nixpkgs
#nix-store --realise /nix/store/a7gf7plqv6zj1zxplazzib02ank05hxj-geda-1.10.2.drv
#nix-store --verify --repair
#nix-store --delete /nix/store/a7gf7plqv6zj1zxplazzib02ank05hxj-geda-1.10.2.drv
#nix-store --gc
#nix-env --rollback
#nix-env --install
#sudo rm -rf /nix/var/nix/db/*
#sudo rm -rf /nix/var/nix/temproots/*
#sh <(curl -L https://nixos.org/nix/install) --repair

#export NIXPKGS_ALLOW_INSECURE=1

# ATTRIBUTION: ChatGPT-3.5 and ChatGPT4 2032-11-02 . ^

_get_from_nix-user() {
	local currentUser
	currentUser="$1"
	[[ "$currentUser" == "" ]] && currentUser="user"
	
	
	local current_getMost_backend_wasSet
	current_getMost_backend_wasSet=true
	
	if ! type _getMost_backend > /dev/null 2>&1
	then
		_getMost_backend() {
			"$@"
		}
		export -f _getMost_backend
		
		current_getMost_backend_wasSet="false"
	fi


	# ATTENTION: Though otherwise bad practice, some particularly both crucial and non-standard or particular version packages, such as 'geda', but also 'package_kde.tar.xz', are kept in "$HOME" . Thus,  bash -c 'cd ; ', followed by wget, etc, can be appropriate.

	
	# . "$HOME"/.nix-profile/etc/profile.d/nix.sh


	#_nix_fetch_alternatives
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; [[ ! -e geda-gaf-1.10.2.tar.gz ]] && wget ftp.geda-project.org/geda-gaf/stable/v1.10/1.10.2/geda-gaf-1.10.2.tar.gz'
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; [[ ! -e geda-gaf-1.10.2.tar.gz ]] && wget https://web.archive.org/web/20230413214011/http://ftp.geda-project.org/geda-gaf/stable/v1.10/1.10.2/geda-gaf-1.10.2.tar.gz'
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; [[ ! -e geda-gaf-1.10.2.tar.gz ]] && wget https://web.archive.org/web/http://ftp.geda-project.org/geda-gaf/stable/v1.10/1.10.2/geda-gaf-1.10.2.tar.gz'
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; [[ ! -e geda-gaf-1.10.2.tar.gz ]] && wget https://github.com/soaringDistributions/ubDistBuild_bundle/raw/main/geda-gaf/geda-gaf-1.10.2.tar.gz'

	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; nix-prefetch-url file://"$(~/.ubcore/ubiquitous_bash/ubiquitous_bash.sh _getAbsoluteLocation ./geda-gaf-1.10.2.tar.gz)"'
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; nix-prefetch-url file:///home/'"$currentUser"'/geda-gaf-1.10.2.tar.gz'

	#_nix_update
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; nix-channel --list'
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; nix-channel --update'

	
	# CAUTION: May correctly fail, due to marked insecure, due to CVE-2024-6775 , or similar. Do NOT force.
	#_custom_installDeb /root/core/installations/Wire.deb
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; nix-env -iA nixpkgs.wire-desktop'
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; xdg-desktop-menu install "$HOME"/.nix-profile/share/applications/wire-desktop.desktop'
	

	_getMost_backend sudo -n -u "$currentUser" cp -a /home/"$currentUser"/.nix-profile/share/icons /home/"$currentUser"/.local/share/
	
	sleep 3

	
	#nix-env --uninstall geda
	#export NIXPKGS_ALLOW_INSECURE=1
	# Note: For `nix shell`, `nix build`, `nix develop` or any other Nix 2.4+ (Flake) command, `--impure` must be passed in order to read this environment variable.
	
	# WARNING: ERROR from gschem when installed by nix as of 2023-08-11 .
	
#(process:109925): Gtk-WARNING **: 17:53:57.226: Locale not supported by C library.
        #Using the fallback 'C' locale.
#Backtrace:
           #1 (apply-smob/1 #<catch-closure 7f7085b29340>)
           #0 (apply-smob/1 #<catch-closure 7f7085b39740>)

#ERROR: In procedure apply-smob/1:
#In procedure setlocale: Invalid argument

	# ATTENTION: NOTICE: ERROR from gschem has RESOLUTION .
	#  export LANG=C
	#  https://bbs.archlinux.org/viewtopic.php?id=23505

	nix-env --uninstall 'geda.*' || true
	nix-env --uninstall 'pcb.*'  || true
	
	
	
	
	
	# ATTENTION: NOTICE: https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/applications/science/electronics/geda/default.nix
	# ATTENTION: NOTICE: CAUTION: MAJOR: SEVERE: WATCH ANALYSIS for potentially unfavorable changes. Regressions seem likely, python2 deprecation seems to be causing frequent repeated removals of possibly significant functionality. High risk.
	#  ATTENTION: Alternative frozen version commands documented for EMERGENCY use.
	# https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/applications/science/electronics/geda/default.nix
	#  CAUTION: Be wary if this file has changed recently.
	
	# ###
	# Remove previous geda and pcb to prevent overlapping file conflicts (e.g. gnet-pcbfwd.scm).
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; nix-env --uninstall geda.* || true'
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; nix-env --uninstall pcb.*  || true'
	# Seems to have removed xorn, python2.7 . May not have been tested through ubdist/WSL . May be accepted for now due to some apparently successful testing expected to match this specific version.
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA geda -f https://github.com/NixOS/nixpkgs/archive/773a8314ef05364d856e46299722a9d849aacf8b.tar.gz'
	
	# Seems to still have xorn, python2.7, etc . Should have the most functionality, and should match previously tested versions, both through ubdist/OS and ubdist/WSL .
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA geda -f https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz'
	
	# Most recent version. May freeze until there is sufficient experience with newer versions.
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA nixpkgs.geda'
	# ###
	
	
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; xdg-desktop-menu install "$HOME"/.nix-profile/share/applications/geda-gschem.desktop'
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; xdg-desktop-menu install "$HOME"/.nix-profile/share/applications/geda-gattrib.desktop'
	_getMost_backend sudo -n -u "$currentUser" cp -a /home/"$currentUser"/.nix-profile/share/icons /home/"$currentUser"/.local/share/

	# nixpkgs.pcb
	# Remove conflicting shared scheme file before installing pcb
	#_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd; rm -f "$HOME"/.nix-profile/share/gEDA/gnet-pcbfwd.scm'

	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA pcb -f https://github.com/NixOS/nixpkgs/archive/00a3a62a70f6c2ca919befeda4b8a7319ce8be2b.tar.gz'

	
	# Necessary, do NOT remove. Necessary for 'gsch2pcb' , 'gnetlist' , etc, since installation as a dependency does not make the necessary binaries available to the usual predictable PATH .
	#nixpkgs.python2
	_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; export NIXPKGS_ALLOW_INSECURE=1 ; nix-env -iA python2 -f https://github.com/NixOS/nixpkgs/archive/00a3a62a70f6c2ca919befeda4b8a7319ce8be2b.tar.gz'


	
	
	
	
	
	# Workaround to make macros needed from 'pcb' package available to such programs as 'gsch2pcb' from the 'geda' package .
	#sed 's/.*\/\(.*\)\/bin\/pcb.*/\1/')
	local currentDerivationPath_pcb
	currentDerivationPath_pcb=$(_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; readlink -f "$(type -p pcb)"')
	currentDerivationPath_pcb=$(echo "$currentDerivationPath_pcb" | sed 's/\(.*\)\/bin\/pcb.*/\1/')

	local currentDerivationPath_gsch2pcb
	currentDerivationPath_gsch2pcb=$(_getMost_backend sudo -n -u "$currentUser" /bin/bash -l -c 'cd ; readlink -f "$(type -p gsch2pcb)"')
	currentDerivationPath_gsch2pcb=$(echo "$currentDerivationPath_gsch2pcb" | sed 's/\(.*\)\/bin\/gsch2pcb.*/\1/')

	_getMost_backend sudo -n cp -a "$currentDerivationPath_pcb"/share/pcb "$currentDerivationPath_gsch2pcb"/share/
	_getMost_backend sudo -n cp -a "$currentDerivationPath_pcb"/share/gEDA "$currentDerivationPath_gsch2pcb"/share/

	# ATTENTION: Unusual .
	# CAUTION: Seems unnecessary - maybe 'legacy' gnetlist no longer needs xorn or python ?
	_getMost_backend sudo -n sed -i 's/import errno, os, stat, tempfile$/& , sys/' "$currentDerivationPath_gsch2pcb"/lib/python2.7/site-packages/xorn/fileutils.py

	# DOCUMENTATION - interesting copilot suggestions that may or may not be relevant
	# --option allow-substitutes false --option allow-unsafe-native-code-during-evaluation true --option substituters 'https://cache.nixos.org https://hydra.iohk.io' --option trusted-public-keys 'cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ='
	#export NIXPKGS_ALLOW_INSECURE=1 ; nix-env --option binary-caches "" -iA nixpkgs.geda nixpkgs.pcb --option keep-outputs true --option merge-outputs-by-path true
	
	
	[[ ! -e /home/"$currentUser"/.nix-profile/bin/gnetlist ]] && [[ -e /home/"$currentUser"/.nix-profile/bin/gnetlist-legacy ]] && sudo -n ln -s /home/"$currentUser"/.nix-profile/bin/gnetlist-legacy /home/"$currentUser"/.nix-profile/bin/gnetlist

	
	[[ "$current_getMost_backend_wasSet" == "false" ]] && unset _getMost_backend



	return 0
}

_get_from_nix() {
	_get_from_nix-user "$@"
}







# NOTICE: getMost_special.sh will be included if either getMost.sh or gitMinimal.sh are included



# echo -n | openssl dgst -whirlpool -binary - | xxd -p -c 256

# https://github.com/openssl/openssl/issues/10145#issuecomment-1054074144
# https://github.com/openssl/openssl/issues/5118#issuecomment-1707860097
# https://gist.github.com/rdh27785/97210d439a280063bd768006450c435d#file-openssl-cnf-diff
# https://gist.githubusercontent.com/rdh27785/97210d439a280063bd768006450c435d/raw/3789f079442d35c2ae2dc0ff06c314e7169adf7b/openssl.cnf.diff
# https://help.heroku.com/88GYDTB2/how-do-i-configure-openssl-to-allow-the-use-of-legacy-cryptographic-algorithms
# https://wiki.openssl.org/index.php/OpenSSL_3.0
_here_opensslConfig_legacy() {
	cat << 'CZXWXcRMTo8EmM8i4d'

# legacy_enable

openssl_conf = openssl_init

[openssl_init]
providers = provider_sect

[provider_sect]
default = default_sect
legacy = legacy_sect

[default_sect]
activate = 1

[legacy_sect]
activate = 1

CZXWXcRMTo8EmM8i4d
}
_custom_splice_opensslConfig() {
	if _if_cygwin
	then
		_currentBackend() {
			"$@"
		}
	else
		_currentBackend() {
			sudo -n "$@"
		}
	fi

	#local functionEntryPWD
	#functionEntryPWD="$PWD"

	#cd /
	_here_opensslConfig_legacy | _currentBackend tee /etc/ssl/openssl_legacy.cnf > /dev/null 2>&1
	
	_if_cygwin && [[ ! -e /etc/ssl/openssl.cnf ]] && _here_opensslConfig_legacy | _currentBackend tee /etc/ssl/openssl.cnf > /dev/null 2>&1

    if ! _currentBackend grep 'openssl_legacy' /etc/ssl/openssl.cnf > /dev/null 2>&1 && ( ! _if_cygwin && ! grep 'legacy_enable' /etc/ssl/openssl.cnf > /dev/null 2>&1 )
    then
        _currentBackend cp -f /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.orig > /dev/null 2>&1
        echo '


.include = /etc/ssl/openssl_legacy.cnf

' | _currentBackend cat /etc/ssl/openssl.cnf.orig - 2>/dev/null | _currentBackend tee /etc/ssl/openssl.cnf > /dev/null 2>&1
    fi

	#cd "$functionEntryPWD"
}





# NOTICE: Destroying developer functionality on programs made for local use is NEVER an acceptable solution. At minimum such functionality must, for an ephemeral CI environment, still be usable.
#  CAUTION: In this case, the relevant functionality is necessary to create accurate PDF output from PCB designs for integrating electronics with CAD models and for printing and comparing with 3D printed models. Such basic hardware design capability is absolutely NOT something the world can just do without.
# https://www.kb.cert.org/vuls/id/332928/
#  'This issue is addressed in Ghostscript version 9.24. Please also consider the following workarounds:'
#   NO. Using these workarounds, especially on Debian Stable systems which already are up to version 10, which essentially disables all functionality, is completely unacceptable. Such intolerance of developers will NOT be tolerated, and a fork of GhostScript absolutely WILL be maintained if ever necessary.
# https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
#  'I believe that the PDF policy was added due to a bug in Ghostscript, which I believe has now been fixed. So it you are using the current Ghostscript, then you should be fine giving this policy read|write rights.'
_get_workarounds_ghostscript_policyXML() {
	
	# ATTRIBUTION: ChatGPT-3.5 2023-11-02 .
	
	# WARNING: May be untested .
	#sudo -n sed -i '/<!-- disable ghostscript format types -->/,/<\/policymap>/d' "$1"
	#echo '</policymap>' | sudo -n tee -a "$1"
	
	sudo -n sed -i '/<policy domain="coder" rights="none" pattern="PS" \/>/d' "$1"
	sudo -n sed -i '/<policy domain="coder" rights="none" pattern="PS2" \/>/d' "$1"
	sudo -n sed -i '/<policy domain="coder" rights="none" pattern="PS3" \/>/d' "$1"
	sudo -n sed -i '/<policy domain="coder" rights="none" pattern="EPS" \/>/d' "$1"
	sudo -n sed -i '/<policy domain="coder" rights="none" pattern="PDF" \/>/d' "$1"
	sudo -n sed -i '/<policy domain="coder" rights="none" pattern="XPS" \/>/d' "$1"
	
	
	sudo -n sed -i '/<\/policymap>/i \  <policy domain="coder" rights="read | write" pattern="PDF" />\n  <policy domain="coder" rights="read | write" pattern="EPS" />\n  <policy domain="coder" rights="read | write" pattern="PS" />' "$1"
}

# No production use. Yet.
_get_workarounds_ghostscript_policyXML_here() {

cat << 'CZXWXcRMTo8EmM8i4d'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE policymap [
  <!ELEMENT policymap (policy)*>
  <!ATTLIST policymap xmlns CDATA #FIXED ''>
  <!ELEMENT policy EMPTY>
  <!ATTLIST policy xmlns CDATA #FIXED '' domain NMTOKEN #REQUIRED
    name NMTOKEN #IMPLIED pattern CDATA #IMPLIED rights NMTOKEN #IMPLIED
    stealth NMTOKEN #IMPLIED value CDATA #IMPLIED>
]>
<!--
  Configure ImageMagick policies.

  Domains include system, delegate, coder, filter, path, or resource.

  Rights include none, read, write, execute and all.  Use | to combine them,
  for example: "read | write" to permit read from, or write to, a path.

  Use a glob expression as a pattern.

  Suppose we do not want users to process MPEG video images:

    <policy domain="delegate" rights="none" pattern="mpeg:decode" />

  Here we do not want users reading images from HTTP:

    <policy domain="coder" rights="none" pattern="HTTP" />

  The /repository file system is restricted to read only.  We use a glob
  expression to match all paths that start with /repository:

    <policy domain="path" rights="read" pattern="/repository/*" />

  Lets prevent users from executing any image filters:

    <policy domain="filter" rights="none" pattern="*" />

  Any large image is cached to disk rather than memory:

    <policy domain="resource" name="area" value="1GP"/>

  Use the default system font unless overwridden by the application:

    <policy domain="system" name="font" value="/usr/share/fonts/favorite.ttf"/>

  Define arguments for the memory, map, area, width, height and disk resources
  with SI prefixes (.e.g 100MB).  In addition, resource policies are maximums
  for each instance of ImageMagick (e.g. policy memory limit 1GB, -limit 2GB
  exceeds policy maximum so memory limit is 1GB).

  Rules are processed in order.  Here we want to restrict ImageMagick to only
  read or write a small subset of proven web-safe image types:

    <policy domain="delegate" rights="none" pattern="*" />
    <policy domain="filter" rights="none" pattern="*" />
    <policy domain="coder" rights="none" pattern="*" />
    <policy domain="coder" rights="read|write" pattern="{GIF,JPEG,PNG,WEBP}" />
-->
<policymap>
  <!-- <policy domain="resource" name="temporary-path" value="/tmp"/> -->
  <policy domain="resource" name="memory" value="256MiB"/>
  <policy domain="resource" name="map" value="512MiB"/>
  <policy domain="resource" name="width" value="16KP"/>
  <policy domain="resource" name="height" value="16KP"/>
  <!-- <policy domain="resource" name="list-length" value="128"/> -->
  <policy domain="resource" name="area" value="128MP"/>
  <policy domain="resource" name="disk" value="1GiB"/>
  <!-- <policy domain="resource" name="file" value="768"/> -->
  <!-- <policy domain="resource" name="thread" value="4"/> -->
  <!-- <policy domain="resource" name="throttle" value="0"/> -->
  <!-- <policy domain="resource" name="time" value="3600"/> -->
  <!-- <policy domain="coder" rights="none" pattern="MVG" /> -->
  <!-- <policy domain="module" rights="none" pattern="{PS,PDF,XPS}" /> -->
  <!-- <policy domain="path" rights="none" pattern="@*" /> -->
  <!-- <policy domain="cache" name="memory-map" value="anonymous"/> -->
  <!-- <policy domain="cache" name="synchronize" value="True"/> -->
  <!-- <policy domain="cache" name="shared-secret" value="passphrase" stealth="true"/>
  <!-- <policy domain="system" name="max-memory-request" value="256MiB"/> -->
  <!-- <policy domain="system" name="shred" value="2"/> -->
  <!-- <policy domain="system" name="precision" value="6"/> -->
  <!-- <policy domain="system" name="font" value="/path/to/font.ttf"/> -->
  <!-- <policy domain="system" name="pixel-cache-memory" value="anonymous"/> -->
  <!-- <policy domain="system" name="shred" value="2"/> -->
  <!-- <policy domain="system" name="precision" value="6"/> -->
  <!-- not needed due to the need to use explicitly by mvg: -->
  <!-- <policy domain="delegate" rights="none" pattern="MVG" /> -->
  <!-- use curl -->
  <policy domain="delegate" rights="none" pattern="URL" />
  <policy domain="delegate" rights="none" pattern="HTTPS" />
  <policy domain="delegate" rights="none" pattern="HTTP" />
  <!-- in order to avoid to get image with password text -->
  <policy domain="path" rights="none" pattern="@*"/>
  <!-- disable ghostscript format types -->
  <policy domain="coder" rights="read | write" pattern="PDF" />
  <policy domain="coder" rights="read | write" pattern="EPS" />
  <policy domain="coder" rights="read | write" pattern="PS" />
</policymap>
CZXWXcRMTo8EmM8i4d


}














_get_workarounds_ghostscript_policyXML_write() {
	local currentExitStatus
	currentExitStatus="1"
	_get_workarounds_ghostscript_policyXML /etc/ImageMagick-6/policy.xml > /dev/null 2>&1
	[[ "$?" == "0" ]] && currentExitStatus="0"
	_get_workarounds_ghostscript_policyXML /etc/ImageMagick-7/policy.xml > /dev/null 2>&1
	[[ "$?" == "0" ]] && currentExitStatus="0"
	
	return "$currentExitStatus"
}



_get_workarounds() {
	_get_workarounds_ghostscript_policyXML_write "$@"
	
	
}





# https://github.com/nodesource/distributions?tab=readme-ov-file#debian-versions
#codex
#claude
_get_npm() {
    _mustGetSudo

    if _if_cygwin
    then
        ! type npm > /dev/null 2>&1 && echo 'request: https://github.com/coreybutler/nvm-windows/releases' && exit 1

        type npm > /dev/null 2>&1
        return
    fi

    ##sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install -y curl
    _getDep curl

    #sudo -n curl -fsSL https://deb.nodesource.com/setup_23.x -o /nodesource_setup.sh
    #sudo -n bash /nodesource_setup.sh
    sudo -n curl -fsSL https://deb.nodesource.com/setup_23.x -o - | sudo -n bash

    sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs


    #sudo -n npm install -g @openai/codex
    ##npm install -g @anthropic-ai/claude-code
    #sudo -n npm install -g @anthropic-ai/claude-code

    ! type npm > /dev/null 2>&1 && exit 1
    return 0
}





_get_veracrypt() {
	_messagePlain_nominal 'init: _get_veracrypt'
	if type veracrypt > /dev/null 2>&1
	then
		_messagePlain_good 'good: found: veracrypt'
	fi
	
	if _if_cygwin && type "choco"
	then
		choco install veracrypt -y
		return
	fi
	
	
	_start
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	cd "$safeTmp"
	
	
	_getDep lbzip2

	_getDep libfuse.so.2
	
	
	
	# https://launchpad.net/veracrypt/trunk/1.25.9/+download/veracrypt-1.25.9-setup.tar.bz2
	export currentVeracryptURL=$(wget -q -O - 'https://www.veracrypt.fr/en/Downloads.html' | grep https | grep 'tar\.bz2' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.bz2.*$/\.tar\.bz2/' | sed 's/&#43;/+/g' | tr -dc 'a-zA-Z0-9.:\=\_\-/%+')
	export currentVeracryptName=$(_safeEcho_newline "$currentVeracryptURL" | sed 's/^.*\///' | sed 's/\.tar\.bz2$//')
	
	wget "$currentVeracryptURL"
	
	tar xf "$currentVeracryptName".tar.bz2
	
	
	#./veracrypt-1.25.9-setup-gui-x64 --nox11 --quiet
	
	
	_getDep expect
	
	
	
	# https://stackoverflow.com/questions/58239247/veracript-install-script-fails-if-run-from-script
	# -console-x64
	# -gui-x64
	echo '#!/usr/bin/expect -f

set timeout -1
spawn '"$safeTmp"/"$currentVeracryptName"-console-x64'
expect "To select, enter 1 or 2:"
send -- "1\r"
expect "Press Enter to display the license terms..."
send -- "\r"
expect ":"
send -- "q\r"
expect "Do you accept and agree to be bound by the license terms?"
send -- "yes\r"
expect "Press Enter to continue..."
send -- "\r"
expect "Press Enter to exit..."
send -- "\r"
send -- "\r"
send -- "\r"
expect eof' > "$safeTmp"/veracrypt.exp
	
	expect -f "$safeTmp"/veracrypt.exp
	
	cd "$functionEntryPWD"
	
	
	if ! type veracrypt > /dev/null 2>&1
	then
		_messagePlain_bad 'bad: missing: veracrypt'
		_messageFAIL
	fi
	_stop
}






# WARNING: Infinite loop risk, do not call '_wantGetDep nix-env' within this function.
_test_nix-env_upstream() {
	# WARNING: May be untested. Do NOT attempt upstream install for NixOS distribution.
	[[ -e /etc/issue ]] && ! cat /etc/issue | grep 'Debian\|Raspbian\|Ubuntu' > /dev/null 2>&1 && type nix-env && return 0
	
	! _wantSudo && return 1
	
	# https://ariya.io/2020/05/nix-package-manager-on-ubuntu-or-debian
	#  'Note that if you use WSL 1'
	#   'sandbox = false'
	#     WSL is NOT expected fully compatible with Ubiquitous Bash . MS commitment to WSL end-user usability, or so much as WSL having any better functionality than Cygwin, Qemu, VirtualBox, etc, is not obvious.
	# https://github.com/microsoft/WSL/issues/6301
	
	
	# Prefer to develop software not to expect multi-user features from nix. Expected not normally necessary.
	# https://nixos.org/download.html
	#  'Harder to uninstall'
	# https://nixos.org/manual/nix/stable/installation/multi-user.html
	#  'unprivileged users' ... 'pre-built binaries'
	# https://nixos.wiki/wiki/Nix
	#  'remove further hidden dependencies' ... 'access to the network' ... 'inter process communication is isolated on Linux'
	# https://ariya.io/2020/05/nix-package-manager-on-ubuntu-or-debian
	echo
	sh <(curl -L https://nixos.org/nix/install) --no-daemon
	echo
}




# ATTENTION: Override with 'core.sh', 'ops', or similar!
# Software which specifically may rely upon a recent feature of cloud services software (eg. aws, gcloud) should force this to instead always return 'true' .
_test_nixenv_updateInterval() {
	! find "$HOME"/.ubcore/.retest-"$1" -type f -mtime -9 2>/dev/null | grep '.retest-' > /dev/null 2>&1
	
	#return 0
	return
}

_test_nix-env_sequence() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_mustHave_nixos
	
	cd "$safeTmp"
	
	# https://ariya.io/2016/06/isolated-development-environment-using-nix
	#cat << 'CZXWXcRMTo8EmM8i4d' > ./default.nix
#with import <nixpkgs> {};
#stdenv.mkDerivation rec {
  #name = "env";
  #env = buildEnv { name = name; paths = buildInputs; };
  #buildInputs = [
    #hello
  #];
#}
#CZXWXcRMTo8EmM8i4d

	cat << 'CZXWXcRMTo8EmM8i4d' > ./default.nix
with import <nixpkgs> {};
mkShell {
  buildInputs = [
    hello
  ];
}
CZXWXcRMTo8EmM8i4d
	
	! nix-shell --run hello | grep -i 'hello' > /dev/null && echo 'fail: nix-shell: hello' && _stop 1
	! nix-shell --run true && echo 'fail: nix-shell: true' && _stop 1
	nix-shell --run false && echo 'fail: nix-shell: false' && _stop 1
	[[ $(nix-shell --run 'type hello' | tr -dc 'a-zA-Z0-9/ ') == $(type hello 2>/dev/null | tr -dc 'a-zA-Z0-9/ ') ]] && echo 'fail: nix-shell: type: hello' && _stop 1
	[[ $(nix-shell --run 'type -P true' | tr -dc 'a-zA-Z0-9/ ') == $(type -P true | tr -dc 'a-zA-Z0-9/ ') ]] && echo 'fail: nix-shell: type: true' && _stop 1
	[[ $(nix-shell --run 'type -P false' | tr -dc 'a-zA-Z0-9/ ') == $(type -P false | tr -dc 'a-zA-Z0-9/ ') ]] && echo 'fail: nix-shell: type: false' && _stop 1
	
	cd "$functionEntryPWD"
	_stop
}


_test_nix-env_enter() {
	cd "$HOME"
	_test_nix-env "$@"
}
_test_nix-env() {
	# Cygwin implies other package managers (ie. 'chocolatey'), NOT nix .
	_if_cygwin && return 0
	
	# Root installation of nixenv is not expected either necessary or possible.
	if [[ $(id -u 2> /dev/null) == "0" ]]
	then
		local sudoAvailable
		sudoAvailable=false
		sudoAvailable=$(sudo -n echo true 2> /dev/null)
		
		local currentUser
		currentUser="$custom_user"
		[[ "$currentUser" == "" ]] && currentUser="user"
		
		local currentScript
		currentScript="$scriptAbsoluteLocation"
		[[ -e /home/"$currentUser"/ubiquitous_bash.sh ]] && currentScript=/home/"$currentUser"/ubiquitous_bash.sh
		
		[[ -e /home/"$currentUser" ]] && [[ "$sudoAvailable" == "true" ]] && [[ $(sudo -n -u "$currentUser" id -u | tr -dc '0-9') != "0" ]] && sudo -n -u "$currentUser" "$currentScript" _test_nix-env_enter
		return
	fi
	
	! _test_nixenv_updateInterval 'nixenv' && return 0
	rm -f "$HOME"/.ubcore/.retest-'nixenv' > /dev/null 2>&1
	
	if [[ "$nonet" != "true" ]] && ! _if_cygwin
	then
		_messagePlain_request 'ignore: upstream progress ->'
		
		_test_nix-env_upstream "$@"
		#_test_nix-env_upstream_beta "$@"
		
		_messagePlain_request 'ignore: <- upstream progress'
	fi
	
	_mustHave_nixos
	
	_wantSudo && _wantGetDep nix-env
	
	
	! _typeDep nix-env && echo 'fail: missing: nix-env' && _messageFAIL
	
	! _typeDep nix-shell && echo 'fail: missing: nix-shell' && _messageFAIL
	
	
	if ! "$scriptAbsoluteLocation" _test_nix-env_sequence "$@"
	then
		_messageFAIL
		_stop 1
		return 1
	fi
	#! nix-shell true && echo 'fail: nix-shell: true' && _messageFAIL
	#! nix-shell false && echo 'fail: nix-shell: false' && _messageFAIL
	
	
	
	touch "$HOME"/.ubcore/.retest-'nixenv'
	date +%s > "$HOME"/.ubcore/.retest-'nixenv'
	
	return 0
}

_mustHave_nixos() {
	#_setupUbiquitous_accessories_here-nixenv-bashrc
	[[ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME"/.nix-profile/etc/profile.d/nix.sh
	
	if ! type nix-env > /dev/null 2>&1
	then
		_test_nix-env_upstream > /dev/null 2>&1
		[[ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME"/.nix-profile/etc/profile.d/nix.sh
		! type nix-env > /dev/null 2>&1 && _stop 1
	fi
	
	! type nix-env > /dev/null 2>&1 && _stop 1
	
	return 0
}

# WARNING: No production use. Prefer '_mustHave_nixos' .
_nix-env() {
	_mustHave_nixos
	
	nix-env "$@"
}


_nix-shell() {
	_mustHave_nixos
	
	# https://forum.holochain.org/t/how-to-load-your-bash-profile-into-nix-shell/2070
	nix-shell --command '. ~/.bashrc; return' "$@"
}
_nix() {
	_nix-shell "$@"
}
_nixShell() {
	_nix-shell "$@"
}
_ns() {
	_nix-shell "$@"
}
nixshell() {
	_nix-shell "$@"
}
nixShell() {
	_nix-shell "$@"
}
ns() {
	_nix-shell "$@"
}


_nix_update() {
	[[ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME"/.nix-profile/etc/profile.d/nix.sh
	
	nix-channel --list
	nix-channel --update
}




# ATTRIBUTION-AI: ChatGPT o1-preview 2024-11-25 .
# This is a tricky issue, which is not easily reproduced nor solved. Presumably due to '| tee' under the powershell environment used by 'build.yml', or possibly due to standard input somehow being piped as well, stdout is redirected while stderr actually does exist but is reported as a non-existent file when written to, and cannot be replaced, with error messages 'No such file or directory' and 'Read-only file system'. Redirections of subshells through other means, such as ' 2>&1 ' does not work.
# ATTENTION: There may not be any real solution other than simply avoiding depending on usable /dev/stderr , such as by using quiet mode with apt-cyg --quiet .
_cygwin_workaround_dev_stderr() {
    # ChatGPT search found this link, which strongly implicates the '| tee' used for logging by build.yml as causing the absence of stderr .
    # https://cygwin.com/pipermail/cygwin/2017-July/233639.html?utm_source=chatgpt.com

    #if [ ! -e /dev/stderr ] || ! echo x | tee /dev/stderr > /dev/null
    #then
        #_messagePlain_warn 'warn: workaround /dev/stderr: exec 2>&1'
        ## ATTRIBUTION-AI: ChatGPT 4o 2024-11-25 .
        #exec 2>&1
    #fi
    
    # DUBIOUS
    #if [ ! -e /dev/stderr ] || ! echo x | tee /dev/stderr > /dev/null
    #then
        #mkdir -p /dev
        #ln -sf /proc/self/fd/1 /dev/stderr
    #fi

    # DUBIOUS
    #if [ ! -e /dev/stderr ] || ! echo x | tee /dev/stderr > /dev/null
    #then
        #mkdir -p /dev
        #ln -sf /proc/self/fd/1 /dev/stderr
    #fi
    #if [ ! -e /dev/stderr ] || ! echo x | tee /dev/stderr > /dev/null
    #then
        #mkdir -p /dev
        #ln -sf /dev/fd/1 /dev/stderr
    #fi
    #if [ ! -e /dev/stderr ] || ! echo x | tee /dev/stderr > /dev/null
    #then
        #mkdir -p /dev
        #ln -sf /proc/$$/fd/1 /dev/stderr
    #fi

    
    # Local experiments with a functional Cygwin/MSW environment show creating /dev/stderr_experiment this way is apparently not usable anyway.
    #if [ ! -e /dev/stderr ] || ! echo x | tee /dev/stderr > /dev/null
    #then
        #mkdir -p /dev
        #mknod /dev/stderr c 1 3
        #chmod 622 /dev/stderr
    #fi

    #if [ ! -e /dev/stderr ] || ! echo x | tee /dev/stderr > /dev/null
    #then
        #_messagePlain_bad 'fail: missing: /dev/stderr'
        #_messageFAIL
    #fi

    return 0
}




_getMost_cygwin_sequence-priority() {
    _cygwin_workaround_dev_stderr

    _start

    _messageNormal "_getMost_cygwin_priority: apt-cyg --quiet install"
    
    #nc,

cat << 'CZXWXcRMTo8EmM8i4d' | grep -v '^#' | tee "$safeTmp"/cygwin_package_list_priority_01
bash-completion
bc
bzip
coreutils
curl
dos2unix
expect
git
git-svn
gnupg
inetutils
jq
lz4
mc
nc
openssh
openssl
perl
psmisc
python37
pv
rsync
ssh-pageant
screen
subversion
unzip
vim
wget
zip
zstd
tigervnc-server
flex
bison
libncurses-devel
par2
python3-pip
gnupg2
CZXWXcRMTo8EmM8i4d



cat << 'CZXWXcRMTo8EmM8i4d' | grep -v '^#' | tee "$safeTmp"/cygwin_package_list_priority_02
bash-completion
bc
bzip
coreutils
curl
dos2unix
expect
git
git-svn
gnupg
inetutils
jq
lz4
mc
nc
openssh
openssl
perl
psmisc
python37
pv
rsync
ssh-pageant
screen
subversion
unzip
vim
wget
zip
zstd
procps-ng
awk
socat
aria2
jq
gnupg2
php
php-PEAR
php-devel
gnuplot-base
gnuplot-doc
gnuplot-qt5
gnuplot-wx
gnuplot-X11
libqalculate-common
libqalculate-devel
libqalculate5
cantor-backend-qalculate
octave
octave-devel
octave-parallel
octave-linear-algebra
octave-general
octave-geometry
octave-strings
octave-financial
octave-communications
octave-control
mkisofs
genisoimage
dbus
dbus-x11
tigervnc-server
flex
bison
libncurses-devel
p7zip
par2
python3-pip
gnupg2 2>&1
CZXWXcRMTo8EmM8i4d


    local currentLine

    cat "$safeTmp/cygwin_package_list_priority_01" | while read currentLine
    do
        #echo "$currentLine"
        _messagePlain_probe apt-cyg --quiet install "$currentLine"
        apt-cyg --quiet install "$currentLine" 2>&1
    done

    cat "$safeTmp/cygwin_package_list_priority_02" | while read currentLine
    do
        #echo "$currentLine"
        _messagePlain_probe apt-cyg --quiet install "$currentLine"
        apt-cyg --quiet install "$currentLine" 2>&1
    done

    _stop
}
_getMost_cygwin-priority() {
    "$scriptAbsoluteLocation" _getMost_cygwin_sequence-priority "$@"
}

_getMost_cygwin_sequence() {
    _cygwin_workaround_dev_stderr

    _start

    _messageNormal "_getMost_cygwin: list installed"
    apt-cyg --quiet show | cut -f1 -d\ | tail -n +2 | tee "$safeTmp"/cygwin_package_list_installed

    _messageNormal "_getMost_cygwin: list desired"
    cat << 'CZXWXcRMTo8EmM8i4d' | grep -v '^#' | tee "$safeTmp"/cygwin_package_list_desired
#_autorebase
#adwaita-icon-theme
#alternatives
aria2
#at-spi2-core
autoconf
#autoconf2.1
#autoconf2.5
#autoconf2.7
base-cygwin
base-files
bash
bash-completion
bc
binutils
bison
bsdtar
build-docbook-catalog
bzip2
#ca-certificates
cantor
cantor-backend-qalculate
coreutils
#crypto-policies
#csih
curl
#cygrunsrv
#cygutils
#cygwin
#cygwin-devel
dash
dbus
dbus-x11
dconf-service
#dejavu-fonts
desktop-file-utils
dialog
diffutils
docbook-xml45
docbook-xsl
dos2unix
#dri-drivers
ed
editrights
expect
file
findutils
flex
gamin
gawk
gcc-core
gcr
gdk-pixbuf2.0-svg
genisoimage
#getent
#gettext
ghostscript
ghostscript-fonts-other
git
git-svn
glib2.0-networking
gnome-keyring
gnupg2
gnuplot-X11
gnuplot-base
gnuplot-doc
gnuplot-qt5
gnuplot-wx
grep
groff
gsettings-desktop-schemas
#gtk-update-icon-cache
gzip
#hicolor-icon-theme
hostname
inetutils
#info
ipc-utils
iso-codes
jq
#kf5-kdoctools
less
#libEGL1
libFLAC8
#libGL1
#libGLU1
#libGraphicsMagick++12 # ATTENTION
#libGraphicsMagick3 # ATTENTION
#libICE6
#libKF5Archive5
#libKF5Attica5
#libKF5Auth5
#libKF5Bookmarks5
#libKF5Codecs5
#libKF5Completion5
#libKF5Config5
#libKF5ConfigWidgets5
#libKF5CoreAddons5
#libKF5Crash5
#libKF5DBusAddons5
#libKF5GlobalAccel5
#libKF5GuiAddons5
#libKF5I18n5
#libKF5IconThemes5
#libKF5ItemViews5
#libKF5JobWidgets5
#libKF5KIO5
#libKF5NewStuff5
#libKF5Notifications5
#libKF5Parts5
#libKF5Service5
#libKF5Solid5
#libKF5Sonnet5
#libKF5SyntaxHighlighting5
#libKF5TextEditor5
#libKF5TextWidgets5
#libKF5Wallet5
#libKF5WidgetsAddons5
#libKF5WindowSystem5
#libKF5XmlGui5
#libQt5Core5
#libQt5Gui5
#libQt5Help5
#libQt5Quick5
#libQt5Script5
#libQt5Sql5
#libQt5Svg5
#libQt5TextToSpeech5
#libQt5X11Extras5
#libQt5XmlPatterns5
libSDL2_2.0_0
#libSM6
#libX11-xcb1
#libX11_6
#libXau6
#libXaw7
#libXcomposite1
#libXcursor1
#libXdamage1
#libXdmcp6
#libXext6
#libXfixes3
#libXfont2_2
#libXft2
#libXi6
#libXinerama1
#libXmu6
#libXmuu1
#libXpm4
#libXrandr2
#libXrender1
#libXss1
#libXt6
#libXtst6
#libaec0
#libamd2
#libapr1
#libaprutil1
libarchive13
#libargon2_1
libargp
#libarpack0
#libaspell15
#libassuan0
#libasyncns0
#libatk-bridge2.0_0
#libatk1.0_0
#libatomic1
#libatspi0
libattr1
libblkid1
#libbrotlicommon1
#libbrotlidec1
#libbsd0
#libbtf1
#libbz2_1
libcairo2
#libcamd2
#libcares2
#libccolamd2
#libcerf1
#libcharset1
#libcholmod3
#libcln-devel
#libcln6
#libcolamd2
#libcom_err2
#libcroco0.6_3
libcrypt0
libcrypt2
libcurl4
#libcxsparse3
#libdatrie1
#libdb5.3
libdbus-glib_1_2
libdbus1_3
libdbusmenu-qt5_2
#libde265_0
libdeflate0
libdialog15
libdotconf0
libe2p2
#libedit0
#libenchant1
#libepoxy0
#libespeak1
libexpat1
libext2fs2
libfam0
libfdisk1
libffi-devel
libffi6
libffi8
#libfftw3_3
libfido2
libflite1
libfltk1.3
#libfontconfig-common
#libfontconfig1
#libfontenc1
#libfreetype6
#libfribidi0
#libgailutil3_0
#libgc1
libgcc1
libgck1_0
libgcr-base3_1
libgcr-ui3-common
libgcr-ui3_1
libgcrypt20
libgd3
#libgdbm4
#libgdbm6
#libgdbm_compat4
libgdk_pixbuf2.0_0
#libgeoclue0
#libgfortran5
#libgit2_25
libgl2ps1
#libglapi0
#libglib2.0-devel
#libglib2.0_0
#libglpk40
#libgmp-devel
#libgmp10
#libgmpxx4
libgnutls30
#libgomp1
#libgpg-error0
#libgpgme11
#libgpgmepp6
#libgraphite2_3
libgs10
libgs9
#libgsasl-common
#libgsasl18
#libgssapi_krb5_2
#libgstinterfaces1.0_0
#libgstreamer1.0_0
#libgtk3_0
#libguile3.0_1
#libharfbuzz-icu0
#libharfbuzz0
#libhdf5_200
#libheif1
libhogweed4
libhogweed6
#libhunspell1.6_0
#libiconv
#libiconv-devel
#libiconv2
#libicu56
#libicu61
#libicu74
#libidn12
#libidn2_0
#libimagequant0
#libintl-devel
#libintl8
#libiodbc2
#libisl23
#libjasper4
#libjavascriptcoregtk3.0_0
#libjbig2
#libjpeg8
#libjq1
#libk5crypto3
libklu1
#libkpathsea6
#libkrb5_3
#libkrb5support0
#libksba8
#liblapack0
#liblcms2_2
libllvm8
libltdl7
liblua5.3
#liblz4_1
#liblzma5
#liblzo2_2
libmd0
libmetalink3
#libmetis0
#libmp3lame0
#libmpc3
#libmpfr6
#libmpg123_0
#libmspack0
#libmysqlclient18
#libncurses++w10
libncurses-devel
#libncursesw10
libnettle6
libnettle8
#libnghttp2_14
#libnotify4
#libnpth0
#libntlm0
#libogg0
#libonig5
#libopenblas
#libopenldap2
#libopenldap2_4_2
#libopus0
#liborc0.4_0
libp11-kit0
#libpango1.0_0
#libpaper-common
#libpaper1
#libpcre-devel
#libpcre1
#libpcre16_0
#libpcre2_16_0
#libpcre2_8_0
#libpcre32_0
#libpcrecpp0
#libpcreposix0
#libphonon4qt5_4
#libpipeline1
libpixman1_0
libpkgconf5
libpng16
libpopt-common
libpopt0
#libportaudio2
libpotrace0
#libpq5
#libproc2_0
#libproxy1
#libpsl5
libptexenc1
#libpulse-simple0
#libpulse0
libqalculate-common
libqalculate-devel
libqalculate5
#libqhull_8
#libqrupdate0
#libqscintilla2_qt5-common
#libqscintilla2_qt5_13
#libquadmath0
libraqm0
libreadline7
libretls26
librsvg2_2
#libsamplerate0
#libsasl2_3
libsecret1_0
#libserf1_0
#libslang2
#libsmartcols1
#libsndfile1
#libsodium-common
#libsodium23
#libsoup2.4_1
libspectre1
#libspeechd2
#libspqr2
#libsqlite3_0
#libssh2_1
#libssl1.0
#libssl1.1
#libssl3
#libstdc++6
#libsuitesparseconfig5
#libsundials_ida5
#libsundials_sunlinsol3
#libsundials_sunmatrix3
#libsybdb5
#libsynctex2
#libsz2
#libtasn1_6
#libteckit0
#libtexlua53_5
#libtexluajit2
#libthai0
#libtiff6
#libtiff7
#libuchardet0
#libumfpack5
#libunistring5
#libusb1.0
libuuid1
#libvoikko1
#libvorbis
#libvorbis0
#libvorbisenc2
#libwebkitgtk3.0_0
#libwebp5
#libwebp7
#libwebpdemux2
#libwebpmux3
libwrap0
libwx_baseu3.0_0
libwx_gtk3u3.0_0
#libxcb-dri2_0
#libxcb-glx0
#libxcb-icccm4
#libxcb-image0
#libxcb-keysyms1
#libxcb-randr0
#libxcb-render-util0
#libxcb-render0
#libxcb-shape0
#libxcb-shm0
#libxcb-sync1
#libxcb-util1
#libxcb-xfixes0
#libxcb-xinerama0
#libxcb-xkb1
#libxcb1
#libxkbcommon0
#libxkbfile1
#libxml2
libxml2-devel
#libxslt
libxxhash0
#libzstd1
#libzzip0.13
#login
lz4
m4
make
#man-db
#mariadb-common
mc
#mintty
mkisofs
#mysql-common
#ncurses
netcat
octave
octave-communications
octave-control
octave-devel
octave-financial
octave-general
octave-geometry
octave-io
octave-linear-algebra
octave-parallel
octave-signal
octave-strings
octave-struct
openssh
openssl
p11-kit
p11-kit-trust
p7zip
par2
patch
perl
#perl-Clone
#perl-Encode-Locale
#perl-Error
#perl-File-Listing
#perl-HTML-Parser
#perl-HTML-Tagset
#perl-HTTP-Cookies
#perl-HTTP-Date
#perl-HTTP-Message
#perl-HTTP-Negotiate
#perl-IO-HTML
#perl-IO-String
#perl-JSON-PP
#perl-LWP-MediaTypes
#perl-Net-HTTP
#perl-TermReadKey
#perl-TimeDate
#perl-Tk
#perl-Try-Tiny
#perl-URI
#perl-WWW-RobotRules
#perl-XML-Parser
#perl-YAML
#perl-libwww-perl
#perl_autorebase
perl_base
php
php-PEAR
php-bz2
php-devel
php-zlib
pinentry
pkg-config
pkgconf
poppler-data
procps-ng
psmisc
#publicsuffix-list-dafsa
pv
python3
python3-pip
#python37
#python37-pip
#python37-setuptools
#python39
#python39-babel
#python39-chardet
#python39-docutils
#python39-idna
#python39-imagesize
#python39-imaging
#python39-iniconfig
#python39-jinja2
#python39-markupsafe
#python39-olefile
#python39-packaging
#python39-pip
#python39-platformdirs
#python39-pluggy
#python39-pygments
#python39-pyparsing
#python39-pytest
#python39-railroad-diagrams
#python39-requests
#python39-setuptools
#python39-six
#python39-snowballstemmer
#python39-sphinx
#python39-sphinxcontrib-serializinghtml
#python39-toml
#python39-urllib3
rebase
rsync
run
screen
sed
#sgml-common
#shared-mime-info
socat
#speech-dispatcher
#ssh-pageant
subversion
#subversion-perl
#suomi-malaga
tar
tcl
tcl-tk
terminfo
texlive
texlive-collection-basic
texlive-collection-latex
tigervnc-server
tzcode
tzdata
unzip
#urw-base35-fonts
util-linux
vim
vim-common
vim-minimal
w32api-headers
w32api-runtime
wget
which
windows-default-manifest
#xauth
#xcursor-themes
#xkbcomp
#xkeyboard-config
#xorg-server-common
xxd
xz
zip
zlib-devel
zlib0
zstd
CZXWXcRMTo8EmM8i4d

    _messageNormal "_getMost_cygwin: todo"
    # ATTRIBUTION-AI: ChatGPT o1-preview 2024-11-25 .
    grep -F -x -v -f "$safeTmp/cygwin_package_list_installed" "$safeTmp/cygwin_package_list_desired" | tee "$safeTmp/cygwin_package_list_todo"


    local currentLine
    cat "$safeTmp/cygwin_package_list_todo" | while read currentLine
    do
        #echo "$currentLine"
        _messagePlain_probe apt-cyg --quiet install "$currentLine"
        apt-cyg --quiet install "$currentLine" 2>&1
    done


    _stop
}
_getMost_cygwin() {
    "$scriptAbsoluteLocation" _getMost_cygwin_sequence "$@" 2>&1
}



_custom_ubcp_prog() {
	true
}
_custom_ubcp_sequence() {
	_cygwin_workaround_dev_stderr

    local functionEntryPWD
    functionEntryPWD="$PWD"
    
    _messageNormal '_custom_ubcp: apt-cyg --quiet'
	_messagePlain_probe apt-cyg --quiet install ImageMagick
    apt-cyg --quiet install ImageMagick 2>&1
	#_messagePlain_probe_cmd apt-cyg --quiet install ffmpeg
	
	_messageNormal '_custom_ubcp: pip3'
	_messagePlain_probe pip3 install piexif
    pip3 install piexif 2>&1



    _messageNormal '_custom_ubcp: runpodctl'

    #wget -qO- 'https://cli.runpod.net' | sed 's/\[ "\$EUID" -ne 0 \]/false/' | bash

    mkdir -p "$HOME"/core/installations
    cd "$HOME"/core/installations
    _gitBest clone --recursive --depth 1 git@github.com:runpod/runpodctl.git
    
    cd "$HOME"/bin/
    rm -f runpodctl.exe
    #wget 'https://github.com/runpod/runpodctl/releases/download/v1.14.3/runpodctl-windows-amd64.exe' -O runpodctl.exe
    wget 'https://github.com/runpod/runpodctl/releases/download/v1.14.4/runpodctl-windows-amd64.exe' -O runpodctl.exe
    chmod ugoa+rx runpodctl.exe

    cd "$functionEntryPWD"



    # https://github.com/asciinema/asciinema/issues/467
    # wsl asciinema rec -c cmd.exe
    # https://github.com/Watfaq/PowerSession-rs
    _messageNormal '_custom_ubcp: PowerSession - asciinema alternative for MSWindows'

    mkdir -p "$HOME"/core/installations
    cd "$HOME"/core/installations
    _gitBest clone --recursive --depth 1 git@github.com:Watfaq/PowerSession-rs.git
    
    cd "$HOME"/bin/
    rm -f PowerSession.exe
    wget 'https://github.com/Watfaq/PowerSession-rs/releases/latest/download/PowerSession.exe' -O PowerSession.exe
    chmod ugoa+rx PowerSession.exe


    cd "$functionEntryPWD"



    # https://gitlab.com/saalen/ansifilter/-/releases
    # http://andre-simon.de/zip/ansifilter-2.21-x64.zip
    # https://web.archive.org/web/20250618063648/http://andre-simon.de/zip/ansifilter-2.21-x64.zip
    _messageNormal '_custom_ubcp: ansifilter'

    mkdir -p "$HOME"/core/installations
    cd "$HOME"/core/installations
    wget 'https://web.archive.org/web/20250618063648/http://andre-simon.de/zip/ansifilter-2.21-x64.zip'
    if [[ $(sha256sum ansifilter-2.21-x64.zip | cut -f1 -d' ' | tr -dc 'a-fA-F0-9') != '57624ae40be4c9173937d15c97f68413daa271a0ec2248ec83394f220b88adb9' ]]
    then
        rm -f ansifilter-2.21-x64.zip
    else
        unzip -o ansifilter-2.21-x64.zip
        rm -f ansifilter-2.21-x64.zip
        cd ansifilter-2.21-x64
        chmod ugoa+rx ansifilter.exe
        chmod ugoa+rx ansifilter-gui.exe
        #cp -a ansifilter.exe "$HOME"/bin/ansifilter.exe
        #cp -a ansifilter-gui.exe "$HOME"/bin/ansifilter-gui.exe
        mv -f ansifilter.exe "$HOME"/bin/ansifilter.exe
        mv -f ansifilter-gui.exe "$HOME"/bin/ansifilter-gui.exe
    fi

    cd "$functionEntryPWD"



    cd "$functionEntryPWD"

    _cygwin_workaround_dev_stderr
	_custom_ubcp_prog "$@"
}
_custom_ubcp() {
    "$scriptAbsoluteLocation" _custom_ubcp_sequence "$@" 2>&1
}


#https://unix.stackexchange.com/questions/39226/how-to-run-a-script-with-systemd-right-before-shutdown
# In theory, 'sleep 1892160000' should create a process that will run for at least 60 years, with 'sleep' binaries that support 'floating point' numbers of seconds, which should be tested for by timetest. This should not be depended upon unless necessary however.

_here_systemd_shutdown_action() {

cat << 'CZXWXcRMTo8EmM8i4d'
[Unit]
CZXWXcRMTo8EmM8i4d


echo Description=$sessionid

cat << 'CZXWXcRMTo8EmM8i4d'

[Service]
ExecStart=/bin/true
CZXWXcRMTo8EmM8i4d

echo ExecStop=\""$scriptAbsoluteLocation"\" "$@"

cat << 'CZXWXcRMTo8EmM8i4d'
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=multi-user.target

CZXWXcRMTo8EmM8i4d

}

_here_systemd_shutdown() {

cat << 'CZXWXcRMTo8EmM8i4d'
[Unit]
CZXWXcRMTo8EmM8i4d


echo Description=$sessionid

cat << 'CZXWXcRMTo8EmM8i4d'

[Service]
ExecStart=/bin/true
CZXWXcRMTo8EmM8i4d

echo ExecStop=\""$scriptAbsoluteLocation"\" "$@"

cat << 'CZXWXcRMTo8EmM8i4d'
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=multi-user.target

CZXWXcRMTo8EmM8i4d

}

_hook_systemd_shutdown() {
	[[ -e /etc/systemd/system/"$sessionid""$sessionid""$sessionid""$sessionid".service ]] && return 0
	
	! _wantSudo && return 1
	
	! [[ -e /etc/systemd/system ]] && return 0
	
	_here_systemd_shutdown | sudo -n tee /etc/systemd/system/"$sessionid""$sessionid""$sessionid""$sessionid".service > /dev/null
	sudo -n systemctl enable "$sessionid""$sessionid""$sessionid""$sessionid".service 2>&1 | sudo -n tee -a "$permaLog"/gsysd.log > /dev/null 2>&1
	sudo -n systemctl start "$sessionid""$sessionid""$sessionid""$sessionid".service 2>&1 | sudo -n tee -a "$permaLog"/gsysd.log > /dev/null 2>&1
}

_hook_systemd_shutdown_action() {
	[[ -e /etc/systemd/system/"$sessionid""$sessionid""$sessionid""$sessionid".service ]] && return 0
	
	! _wantSudo && return 1
	
	! [[ -e /etc/systemd/system ]] && return 0
	
	_here_systemd_shutdown_action "$@" | sudo -n tee /etc/systemd/system/"$sessionid""$sessionid""$sessionid""$sessionid".service > /dev/null
	sudo -n systemctl enable "$sessionid""$sessionid""$sessionid""$sessionid".service 2>&1 | sudo -n tee -a "$permaLog"/gsysd.log > /dev/null 2>&1
	sudo -n systemctl start "$sessionid""$sessionid""$sessionid""$sessionid".service 2>&1 | sudo -n tee -a "$permaLog"/gsysd.log > /dev/null 2>&1
	
}

#"$1" == sessionid (optional override for cleaning up stale systemd files)
_unhook_systemd_shutdown() {
	local hookSessionid
	hookSessionid="$sessionid"
	[[ "$1" != "" ]] && hookSessionid="$1"
	
	[[ ! -e /etc/systemd/system/"$hookSessionid""$hookSessionid""$hookSessionid""$hookSessionid".service ]] && return 0
	
	! _wantSudo && return 1
	
	! [[ -e /etc/systemd/system ]] && return 0
	
	[[ "$SYSTEMCTLDISABLE" == "true" ]] && echo SYSTEMCTLDISABLE | sudo -n tee -a "$permaLog"/gsysd.log > /dev/null 2>&1 && return 0
	export SYSTEMCTLDISABLE=true
	
	sudo -n systemctl disable "$hookSessionid""$hookSessionid""$hookSessionid""$hookSessionid".service 2>&1 | sudo -n tee -a "$permaLog"/gsysd.log > /dev/null 2>&1
	sudo -n rm -f /etc/systemd/system/"$hookSessionid""$hookSessionid""$hookSessionid""$hookSessionid".service 2>&1 | sudo -n tee -a "$permaLog"/gsysd.log > /dev/null 2>&1
}

_stopwatch() {
	local currentExitStatus_bin
	local currentExitStatus_self
	
	local measureDateA
	local measureDateB
	
	measureDateA=$(date +%s%N | cut -b1-13)

	"$@"
	currentExitStatus_bin="$?"

	measureDateB=$(date +%s%N | cut -b1-13)

	bc <<< "$measureDateB - $measureDateA"
	currentExitStatus_self="$?"

	[[ "$currentExitStatus_bin" != "0" ]] && return "$currentExitStatus_bin"
	[[ "$currentExitStatus_self" != "0" ]] && return "$currentExitStatus_self"
	return 0
}

_resetFakeHomeEnv_extra() {
	true
}

_resetFakeHomeEnv_nokeep() {
	! [[ "$setFakeHome" == "true" ]] && return 0
	export setFakeHome="false"
	
	export HOME="$realHome"
	
	#export realHome=""
	
	_resetFakeHomeEnv_extra
}

_resetFakeHomeEnv() {
	#[[ "$keepFakeHome" == "true" ]] && return 0
	[[ "$keepFakeHome" != "false" ]] && return 0
	
	_resetFakeHomeEnv_nokeep
} 



_write_wslconfig() {
    ! _if_cygwin && _messagePlain_bad 'fail: Cygwin/MSW only' && return 1
    if _if_cygwin
    then
        [[ -e /cygdrive/c/Windows/System32 ]] && _here_wsl_config "$1" > /cygdrive/c/Windows/System32/config/systemprofile/.wslconfig
        [[ -e /cygdrive/c/Windows/ServiceProfiles/LocalService ]] && _here_wsl_config "$1" > /cygdrive/c/Windows/ServiceProfiles/LocalService/.wslconfig
        _here_wsl_config "$1" > "$USERPROFILE"/.wslconfig
        return
    fi
}




if false
then

# Experiment - boot .

netsh interface portproxy delete v4tov4 listenport=11434 listenaddress=$(wsl -d ubdist cat /net-hostip)
netsh interface portproxy delete v4tov4 listenport=11434 listenaddress=0.0.0.0
netsh interface portproxy show v4tov4

wsl -d "ubdist" sudo -n systemctl disable hostport-proxy.service
wsl -d "ubdist" sudo -n systemctl disable ollama.service





# Experiment - run .

wsl -d ubdist wget --timeout=1 --tries=3 'http://127.0.0.1:11434' -q -O -
netsh interface portproxy show v4tov4

netsh interface portproxy delete v4tov4 listenport=11434 listenaddress=$(wsl -d ubdist cat /net-hostip)
netsh interface portproxy delete v4tov4 listenport=11434 listenaddress=0.0.0.0
netsh interface portproxy show v4tov4

wsl -d ubdist wget --timeout=1 --tries=3 'http://127.0.0.1:11434' -q -O -

cd /cygdrive/c/q/p/zCore/infrastructure/ubiquitous_bash
./ubiquitous_bash.sh _setup_wsl2_procedure-fw
./ubiquitous_bash.sh _setup_wsl2_procedure-portproxy
./ubiquitous_bash.sh _setup_wsl2_guest-portForward

netsh interface portproxy add v4tov4 listenport=11434 listenaddress=0.0.0.0 connectport=11434 connectaddress=127.0.0.1
netsh interface portproxy show v4tov4

sc.exe query iphlpsvc
netstat -ano | findstr :11434
wget --timeout=1 --tries=3 'http://127.0.0.1:11434' -q -O -

wsl -d ubdist wget --timeout=1 --tries=3 'http://127.0.0.1:11434' -q -O -
wsl -d ubdist cat /net-hostip ; wsl -d ubdist wget --timeout=1 --tries=3 'http://'$(wsl -d ubdist cat /net-hostip)':11434' -q -O -



# Scrap

wsl -d "ubdist" sudo -n systemctl daemon-reload
#wsl -d "ubdist" sudo -n systemctl enable --now hostport-proxy.service

wsl -d "ubdist" sudo -n systemctl disable hostport-proxy.service

wsl -d "ubdist" sudo -n systemctl restart hostport-proxy.service





#_setup_wsl2


fi



_setup_wsl2_guest-portForward() {
    _messagePlain_nominal 'setup: guest: portForward'

    local current_wsldist
    current_wsldist="$1"
    [[ "$current_wsldist" == "" ]] && current_wsldist="ubdist"

    echo "$current_wsldist"

    local current_wsl_scriptAbsoluteLocation
    current_wsl_scriptAbsoluteLocation=$(cygpath -m "$scriptAbsoluteLocation")
    current_wsl_scriptAbsoluteLocation=$(wsl -d "$current_wsldist" wslpath "$current_wsl_scriptAbsoluteLocation")

    _messagePlain_probe '_getDep socat'
    wsl -d "$current_wsldist" "$current_wsl_scriptAbsoluteLocation" _getDep socat

    # ATTRIBUTION-AI: ChatGPT o3  2025-06-01  (partially)


    _messagePlain_probe 'write: /usr/local/bin/hostport-proxy.sh'
    cat << 'CZXWXcRMTo8EmM8i4d' | wsl -d "$current_wsldist" sudo -n tee /usr/local/bin/hostport-proxy.sh > /dev/null
#!/usr/bin/env bash
set -euo pipefail

PORT=${PORT:-11434}               # default; override in the service if you like
HOST_IP_FILE="/net-hostip"

while true; do
  # Bail out quickly if the helper file doesn't exist (yet)
  [[ -r "$HOST_IP_FILE" ]] || { sleep 2; continue; }

  HOST_IP=$(<"$HOST_IP_FILE")
  [[ -n "$HOST_IP" ]] || { sleep 2; continue; }

  wget --timeout=1 --tries=3 http://"$HOST_IP":11434 -q -O - > /dev/null 2>&1 || { sleep 2; continue; }

  echo "$(date '+%F %T') 127.0.0.1:$PORT → $HOST_IP:$PORT"
  # --fork lets a single socat instance serve many clients in parallel
  socat TCP-LISTEN:"$PORT",fork,reuseaddr TCP4:"$HOST_IP":"$PORT" || true
  # If socat exits (network flap, etc.) loop and start again
  sleep 1
done
CZXWXcRMTo8EmM8i4d
    wsl -d "$current_wsldist" sudo -n chmod +x /usr/local/bin/hostport-proxy.sh
    #wsl -d "$current_wsldist" sudo -n cat /usr/local/bin/hostport-proxy.sh


    #_messagePlain_probe 'write: /etc/wsl.conf'
    # "$current_wsldist" /etc/wsl.conf already enables systemd by default
    #_here_wsl_conf
    #printf "[boot]\nsystemd=true\n" | sudo tee /etc/wsl.conf
    ## then from Windows:
    #wsl --shutdown <your-distro>


    _messagePlain_probe 'write: /etc/systemd/system/hostport-proxy.service'
    cat << 'CZXWXcRMTo8EmM8i4d' | wsl -d "$current_wsldist" sudo -n tee /etc/systemd/system/hostport-proxy.service > /dev/null
[Unit]
Description=Forward 127.0.0.1:11434 to Windows host (WSL2)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
Environment=PORT=11434      # edit or duplicate the unit to forward more ports
ExecStart=/usr/local/bin/hostport-proxy.sh
Restart=always
RestartSec=1

# Hardening (optional but nice)
NoNewPrivileges=true
ProtectSystem=full
ProtectHome=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target

CZXWXcRMTo8EmM8i4d
    #wsl -d "$current_wsldist" sudo -n cat /etc/systemd/system/hostport-proxy.service

    _messagePlain_probe 'systemctl'
    wsl -d "$current_wsldist" sudo -n systemctl daemon-reload
    #wsl -d "$current_wsldist" sudo -n systemctl enable --now hostport-proxy.service

    wsl -d "$current_wsldist" sudo -n systemctl disable hostport-proxy.service

    wsl -d "$current_wsldist" sudo -n systemctl restart hostport-proxy.service

}











_setup_wsl2_procedure-fw() {
    _messagePlain_nominal 'setup: write: fw'

    #_powershell
    #powershell
    #powershell.exe
    
    # ATTRIBUTION-AI: ChatGPT o3 Deep Research  2025-06-01
    cat << 'CZXWXcRMTo8EmM8i4d' > /dev/null 2>&1
New-NetFirewallRule -Name "AllowWSL2-11434" -DisplayName "Allow WSL2 Port 11434 (TCP)" `
    -Description "Allows inbound TCP port 11434 from WSL2 virtual network only (for NAT port proxy)" `
    -Protocol TCP -Direction Inbound -Action Allow -LocalPort 11434 `
    -InterfaceAlias "vEthernet (WSL)"
CZXWXcRMTo8EmM8i4d

    # ATTRIBUTION-AI: ChatGPT o4-mini  2025-06-01
    # ATTRIBUTION-AI: Llama 3.1 Nemotron Ultra 253b v1  2025-06-01  (translation to one-liner)
    powershell -Command "Remove-NetFirewallRule -Name 'AllowWSL2-11434 - vEthernet (WSL (Hyper-V firewall))'; Remove-NetFirewallRule -Name 'AllowWSL2-11434 - vEthernet (Default Switch)'; Remove-NetFirewallRule -Name 'AllowWSL2-11434 - vEthernet (WSL)'"
    powershell -Command "Get-NetFirewallRule -Name 'AllowWSL2-11434*' | Remove-NetFirewallRule"
    #
    # DUBIOUS
    #netsh advfirewall firewall delete rule name="AllowWSL2-11434 - vEthernet (WSL (Hyper-V firewall))"
    #netsh advfirewall firewall delete rule name="AllowWSL2-11434 - vEthernet (Default Switch)"
    #netsh advfirewall firewall delete rule name="AllowWSL2-11434 - vEthernet (WSL)"

    # ATTRIBUTION-AI: Llama 3.1 Nemotron Ultra 253b v1  2025-06-01  (translation from PowerShell interactive terminal to powershell command call under Cygwin/MSW bash shell)
    # ATTENTION: Not all of these named interfaces usually exist. Cosmetic errors usually occur.
    powershell -Command "New-NetFirewallRule -Name 'AllowWSL2-11434 - vEthernet (WSL (Hyper-V firewall))' -DisplayName 'Allow WSL2 Port 11434 (TCP) - vEthernet (WSL (Hyper-V firewall))' -Description 'Allows inbound TCP port 11434 from WSL2 virtual network only (for NAT port proxy)' -Protocol TCP -Direction Inbound -Action Allow -LocalPort 11434 -InterfaceAlias 'vEthernet (WSL (Hyper-V firewall))'"
    powershell -Command "New-NetFirewallRule -Name 'AllowWSL2-11434 - vEthernet (Default Switch)' -DisplayName 'Allow WSL2 Port 11434 (TCP) - vEthernet (Default Switch)' -Description 'Allows inbound TCP port 11434 from WSL2 virtual network only (for NAT port proxy)' -Protocol TCP -Direction Inbound -Action Allow -LocalPort 11434 -InterfaceAlias 'vEthernet (Default Switch)'"
    powershell -Command "New-NetFirewallRule -Name 'AllowWSL2-11434 - vEthernet (WSL)' -DisplayName 'Allow WSL2 Port 11434 (TCP) - vEthernet (WSL)' -Description 'Allows inbound TCP port 11434 from WSL2 virtual network only (for NAT port proxy)' -Protocol TCP -Direction Inbound -Action Allow -LocalPort 11434 -InterfaceAlias 'vEthernet (WSL)'"

    powershell -Command "New-NetFirewallRule -Name 'AllowWSL2-11434 - InterfaceType' -InterfaceType HyperV -Direction Inbound -LocalPort 11434 -Protocol TCP -Action Allow"
    
}

# ATTENTION: NOTICE: Add to 'startup' of MSWindows host, etc, if necessary.
_setup_wsl2_procedure-portproxy() {
    _messagePlain_nominal 'setup: write: portproxy'

    local current_wsldist
    current_wsldist="$1"
    [[ "$current_wsldist" == "" ]] && current_wsldist="ubdist"

    echo "$current_wsldist"

    wsl -d "$current_wsldist" -u root -- sh -c "rm -f /net-hostip"

    # ATTRIBUTION-AI: Llama 3.1 Nemotron Ultra 253b v1  2025-06-01
    powershell.exe -Command - <<CZXWXcRMTo8EmM8i4d
    # ATTRIBUTION-AI: ChatGPT o3 Deep Research  2025-06-01  (partially)
    # Ensure running as Admin for registry and netsh access if needed.
    # Step 1: Try reading WSL NAT info from registry (requires recent WSL).
    \$wslKey = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss'
    try {
        \$reg = Get-ItemProperty -Path \$wslKey -ErrorAction Stop
        \$HostIP = \$reg.NatGatewayIpAddress
    } catch {
        \$HostIP = \$null
    }

    # Step 2: If not found in registry, use WSL to query the default gateway.
    if (-not \$HostIP) {
        try {
            \$routeInfo = wsl -e sh -c "ip route show default 2>/dev/null || route -n"
        } catch {
            \$routeInfo = ""
        }
        if (\$routeInfo) {
            if (\$routeInfo -match 'default via\s+([0-9\.]+)') {
                \$HostIP = \$Matches[1]
            } elseif (\$routeInfo -match '0\.0\.0\.0\s+0\.0\.0\.0\s+([0-9\.]+)') {
                \$HostIP = \$Matches[1]
            }
        }
    }

    # Step 3: If still not found, fall back to scanning network adapters.
    if (-not \$HostIP) {
        \$allIPs = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { 
            \$_.IPAddress -notlike '127.*' -and \$_.IPAddress -notlike '169.254*' 
        }
        \$wslAdapterIP = \$allIPs | Where-Object { \$_.InterfaceAlias -match 'WSL' } | Select-Object -First 1
        if (\$wslAdapterIP) {
            \$HostIP = \$wslAdapterIP.IPAddress
        } else {
            \$defSwitchIP = \$allIPs | Where-Object { \$_.InterfaceAlias -match 'Default Switch' } | Select-Object -First 1
            if (\$defSwitchIP) {
                \$HostIP = \$defSwitchIP.IPAddress
            } else {
                \$hvAdapters = Get-NetAdapter | Where-Object { 
                    \$_.InterfaceDescription -like '*Hyper-V Virtual Ethernet*' -and \$_.Status -eq 'Up' 
                }
                foreach (\$adapter in \$hvAdapters) {
                    \$ip = \$allIPs | Where-Object { 
                        \$_.InterfaceIndex -eq \$adapter.InterfaceIndex -and 
                        \$_.IPAddress -match '^(10\.|172\.(1[6-9]|2\d|3[0-1])\.|192\.168\.)' 
                    }
                    if (\$ip) {
                        \$HostIP = \$ip.IPAddress
                        break
                    }
                }
            }
        }
    }

    # Step 4: Output result or error.
    if (\$HostIP) {
        Write-Output \$HostIP
    } else {
        Write-Error "WSL2 host IP could not be determined. Ensure WSL2 is installed and running (NAT mode)."
    }

    
    #netsh interface portproxy delete v4tov4 listenport=11434
    #netsh interface portproxy delete v4tov4 listenport=11434 listenaddress=\$HostIP
    #netsh interface portproxy add v4tov4 listenaddress=\$HostIP listenport=11434 connectaddress=127.0.0.1 connectport=11434
    #sc query iphlpsvc
    #sc start iphlpsvc
    #netsh interface portproxy show v4tov4


    # ATTRIBUTION-AI: ChatGPT o3  2025-06-01
    # --- Native tools -------------------------------------------------
    \$netsh = "\$env:SystemRoot\System32\netsh.exe"   # avoids “nets” typo
    \$sc    = "\$env:SystemRoot\System32\sc.exe"      # avoids Set-Content alias

    # make sure the helper service is running
    & \$sc   query iphlpsvc
    & \$sc   start iphlpsvc

    \$delArgs = @(
    'interface','portproxy','delete','v4tov4',
    "listenaddress=\$HostIP",
    'listenport=11434'
    )
    & \$netsh  @delArgs  2>\$null   # suppress harmless “not found”

    # (re-)create the port-proxy rule
    \$addArgs = @(
    'interface','portproxy','add','v4tov4',
    "listenaddress=\$HostIP",
    'listenport=11434',
    'connectaddress=127.0.0.1',
    'connectport=11434'
    )
    & \$netsh  @addArgs          # ← “@” splats the array as arguments

    # show the table so you can verify
    & \$netsh  interface portproxy show v4tov4



    # ATTRIBUTION-AI: Llama 3.1 Nemotron Ultra 253b v1  2025-06-01
    # Step 5: Output result or error.
    if (\$HostIP) {
        #Write-Output \$HostIP
        # Write \$HostIP to /net-hostip in WSL
        wsl -d "$current_wsldist" -u root -- sh -c "echo '\$(\$HostIP)' > /net-hostip"
    } else {
        wsl -d "$current_wsldist" -u root -- sh -c "echo '...' > /net-hostip"
    }

CZXWXcRMTo8EmM8i4d

    sleep 3
}










# End user function .
_setup_wsl2_procedure() {
    ! _if_cygwin && _messagePlain_bad 'fail: Cygwin/MSW only' && return 1
    
    _messageNormal 'init: _setup_wsl2'
    
    _messagePlain_nominal 'setup: write: _write_msw_WSLENV'
    _write_msw_WSLENV

    _messagePlain_nominal 'setup: write: _write_msw_wslconfig'
    _write_wslconfig "ub_ignore_kernel_wsl"

    _messagePlain_nominal 'setup: wsl2'
    
    # https://www.omgubuntu.co.uk/how-to-install-wsl2-on-windows-10
    
    _messagePlain_probe dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

    _messagePlain_probe dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    _messagePlain_probe wsl --set-default-version 2
    wsl --set-default-version 2

    _messagePlain_probe wsl --update
    wsl --update

    _messagePlain_probe wsl --install --no-launch
    wsl --install --no-launch
    
    echo 'WSL errors and usage information above may or may not be disregarded.'

    _messagePlain_probe wsl --update
    wsl --update
    
    _messagePlain_probe wsl --set-default-version 2
    wsl --set-default-version 2

    _messagePlain_probe wsl --update
    wsl --update

    sleep 45
    wsl --update

    sleep 5
    wsl --update
    
    sleep 5
    wsl --set-default-version 2

    sleep 5
    wsl --update
    
    sleep 5
    wsl --set-default-version 2

    #sleep 5
    #_setup_wsl2_procedure-fw
    #_setup_wsl2_procedure-portproxy
}
_setup_wsl2() {
    "$scriptAbsoluteLocation" _setup_wsl2_procedure "$@"
}
_setup_wsl() {
    _setup_wsl2 "$@"
}









_here_wsl_config() {
# ATTENTION: If nested virtualization configuration is necessary (ie. the apparently now default 'nestedVirtualization=true' directive is somehow not already in effect), this may be a better place for that directive (normally writing a '.wslconfig' file).
#[wsl2]
#nestedVirtualization=true
    cat << 'CZXWXcRMTo8EmM8i4d'
[wsl2]
memory=999GB
kernelCommandLine = "sysctl.net.core.bpf_jit_harden=1"

CZXWXcRMTo8EmM8i4d

    if [[ -e /cygdrive/c/core/infrastructure/ubdist-kernel/ubdist-kernel ]] && [[ "$1" != "ub_ignore_kernel_wsl" ]]
    then
        echo 'kernel=C:\\core\\infrastructure\\ubdist-kernel\\ubdist-kernel'
    fi

    echo
}


_here_wsl_conf() {
# ATTENTION: Directive for nested virtualization may have moved to being more appropriate for a host '.wslconfig' file than a guest '/etc/wsl.conf' file .
#[wsl2]
#nestedVirtualization=true
#
# ATTENTION: Disabling 'appendWindowsPath' is expected very appropriate for 'ubdist/OS' , as this distribution is already very general purpose, and usual 'ubiquitous_bash' scripting already provides overrides for and calls cmd, powershell, explorer, as very rarely appropriate or needed.
#[interop]
#appendWindowsPath = false   # keep Linux-only PATH
#enabled = false           # uncomment to disable Windows interop entirely
    cat << 'CZXWXcRMTo8EmM8i4d'

[boot]
systemd = true
command = /bin/bash -c 'systemctl stop sddm ; rm -f /root/_rootGrab.sh ; usermod -a -G kvm user ; chown -v root:kvm /dev/kvm ; chmod 660 /dev/kvm ; ( rm /home/user/___quick/mount.sh ; rmdir /home/user/___quick ; ( [[ ! -e /home/user/___quick ]] && ln -s /mnt/c/q /home/user/___quick ) ; rm -f /home/user/___quick/q )'

[user]
default = user

[automount]
options = "metadata"

[interop]
appendWindowsPath = false

CZXWXcRMTo8EmM8i4d
}









_here_wsl_qt5ct_conf() {
    cat << 'CZXWXcRMTo8EmM8i4d'

[Appearance]
color_scheme_path=/usr/share/qt5ct/colors/airy.conf
custom_palette=false
icon_theme=breeze-dark
standard_dialogs=default
style=Breeze

[Interface]
activate_item_on_single_click=1
buttonbox_layout=0
cursor_flash_time=1000
dialog_buttons_have_icons=1
double_click_interval=400
gui_effects=@Invalid()
keyboard_scheme=2
menus_have_icons=true
show_shortcuts_in_context_menus=true
stylesheets=@Invalid()
toolbutton_style=4
underline_shortcut=1
wheel_scroll_lines=3

[Troubleshooting]
force_raster_widgets=1
ignored_applications=@Invalid()

CZXWXcRMTo8EmM8i4d
}

_write_wsl_qt5ct_conf() {
    if [[ "$HOME" == "/root" ]] || [[ $(id -u) == 0 ]]
    then
        return 1
    fi

    local currentHome
    currentHome="$HOME"
    [[ "$currentHome" == "/root" ]] && currentHome="/home/user"
    [[ "$1" != "" ]] && currentHome="$1"

    [[ -e "$currentHome"/.config/qt5ct/qt5ct.conf ]] && return 0
    
    mkdir -p "$currentHome"/.config/qt5ct
    mkdir -p "$currentHome"/.config/qt5ct/colors
    mkdir -p "$currentHome"/.config/qt5ct/qss
    
    _here_wsl_qt5ct_conf > "$currentHome"/.config/qt5ct/qt5ct.conf

    [[ -e "$currentHome"/.config/qt5ct/qt5ct.conf ]] && return 0

    return 1
}



# WARNING: Experimental. Installer use only. May cause issues with applications running natively from the MSW side. Fortunately, it seems QT_QPA_PLATFORMTHEME is ignored if qt5ct is not present, as expected in the case of 'native' QT MSW applications.
_write_msw_qt5ct() {
    setx QT_QPA_PLATFORMTHEME qt5ct /m
}

# https://www.ibm.com/docs/en/sva/7.0.0?topic=SSPREK_7.0.0/com.ibm.isam.doc_80/ameb_audit_guide/concept/con_lang_var_win.htm
# Seems 'LANG=C' would also be a normal setting for MSW .
# nix-shell --run "locale -a" -p bash
#  C   C.utf8   POSIX
_write_msw_LANG() {
    setx LANG C /m
}


# KDE Plasma, FreeCAD, etc, may not be usable without usable OpenGL .
# https://github.com/microsoft/wslg/wiki/GPU-selection-in-WSLg
_write_msw_discreteGPU() {
    #glxinfo -B | grep -i intel > /dev/null 2>&1 && setx MESA_D3D12_DEFAULT_ADAPTER_NAME NVIDIA /m
    
    "$(cygpath -S)"/wbem/wmic.exe path win32_VideoController get name | grep -i 'intel' > /dev/null 2>&1 && "$(cygpath -S)"/wbem/wmic.exe path win32_VideoController get name | grep -i 'nvidia' > /dev/null 2>&1 && setx MESA_D3D12_DEFAULT_ADAPTER_NAME NVIDIA /m
}


_write_msw_WSLENV() {
    _messagePlain_request 'request: If the value of system variable WSLENV is important to you, the previous value is noted here.'
    _messagePlain_probe_var WSLENV
    
    _write_msw_qt5ct
    #setx WSLENV QT_QPA_PLATFORMTHEME /m

    _write_msw_LANG
    #setx WSLENV LANG /m

    _write_msw_discreteGPU
    #setx MESA_D3D12_DEFAULT_ADAPTER_NAME NVIDIA /m

    #setx WSLENV LANG:QT_QPA_PLATFORMTHEME:MESA_D3D12_DEFAULT_ADAPTER_NAME /m

    setx WSLENV LANG:QT_QPA_PLATFORMTHEME:MESA_D3D12_DEFAULT_ADAPTER_NAME:GH_TOKEN /m
}



#####Shortcuts

# https://unix.stackexchange.com/questions/434409/make-a-bash-ps1-that-counts-streak-of-correct-commands
_visualPrompt_promptCommand() {
	[[ "$PS1_lineNumber" == "" ]] && PS1_lineNumber='0'
	#echo "$PS1_lineNumber"
	let PS1_lineNumber="$PS1_lineNumber"+1
	#export PS1_lineNumber

	PS1_lineNumberText="$PS1_lineNumber"
	if [[ "$PS1_lineNumber" == '1' ]]
	then
		# https://unix.stackexchange.com/questions/266921/is-it-possible-to-use-ansi-color-escape-codes-in-bash-here-documents
		#PS1_lineNumberText=$(echo -e -n '\E[1;36m'1)
		##PS1_lineNumberText=$(echo -e -n '\E[1;36m'1)
		##PS1_lineNumberText=$(echo -e -n '\[\033[01;36m\]'1)
		##PS1_lineNumberText=$(echo -e -n '\033[01;36m'1)

		PS1_lineNumberText=$(echo -e -n '\E[1;36;109m'1)
	fi
}

_visualPrompt() {
	local currentHostname
	currentHostname="$HOSTNAME"
	
	[[ -e /etc/hostname ]] && export currentHostname=$(cat /etc/hostname)

	local currentHostname_concatenate

	[[ "$RUNPOD_POD_ID" != "" ]] && currentHostname_concatenate='runpod--'

	if [[ -e /info_factoryName.txt ]]
	then
		currentHostname_concatenate=$(cat /info_factoryName.txt)
		currentHostname_concatenate="$currentHostname_concatenate"'--'
	fi

	[[ "$RUNPOD_POD_ID" != "" ]] && currentHostname_concatenate="$currentHostname_concatenate""$RUNPOD_POD_ID"'--'

	[[ "$RUNPOD_PUBLIC_IP" != "" ]] && currentHostname_concatenate="$currentHostname_concatenate""$RUNPOD_PUBLIC_IP"'--'
	#if [[ "$RUNPOD_PUBLIC_IP" != "" ]]
	#then
		#export currentHostname_concatenate="$currentHostname_concatenate"$(wget -qO- https://icanhazip.com/ | tr -dc '0-9a-fA-F:.')'--'
	#fi
	
	export currentHostname="$currentHostname_concatenate""$currentHostname"
	
	
	
	export currentChroot=
	[[ "$chrootName" != "" ]] && export currentChroot="$chrootName"
	#[[ "$VIRTUAL_ENV_PROMPT" != "" ]] && export currentChroot=python_"$VIRTUAL_ENV_PROMPT"
	
	
	#+%H:%M:%S\ %Y-%m-%d\ Q%q
	#+%H:%M:%S\ %b\ %d,\ %y

	#Long.
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]-|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])-\[\033[01;36m\]--\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\ .%d)\[\033[01;34m\])-\[\033[01;36m\]-|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]-|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]+\[\033[01;34m\]-|\#) \[\033[36m\]>\[\033[00m\] '

	#Short.
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])-\[\033[01;36m\]-\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\ .%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]+\[\033[01;34m\]|\#) \[\033[36m\]>\[\033[00m\] '
	
	#Truncated, 40 columns.
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|\#) \[\033[36m\]>\[\033[00m\] '
	
	
	# https://unix.stackexchange.com/questions/434409/make-a-bash-ps1-that-counts-streak-of-correct-commands
	
	#export PROMPT_COMMAND=$(declare -f _visualPrompt_promptCommand)' ; _visualPrompt_promptCommand'
	#export PROMPT_COMMAND='_visualPrompt_promptCommand () { [[ "$PS1_lineNumber" == "" ]] && PS1_lineNumber="0"; let PS1_lineNumber="$PS1_lineNumber"+1; PS1_lineNumberText="$PS1_lineNumber"; if [[ "$PS1_lineNumber" == "1" ]]; then PS1_lineNumberText=$(echo -e -n "'"\E[1;36m"'"1"'"\E[0m"'"); fi } ; _visualPrompt_promptCommand'
	
	export -f _visualPrompt_promptCommand
	export PROMPT_COMMAND=_visualPrompt_promptCommand
	
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$PS1_lineNumberText\[\033[01;34m\]) \[\033[36m\]>\[\033[00m\] '
	
	
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$PS1_lineNumberText\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	
	
	export prompt_specialInfo=""

	# ATTRIBUTION-AI: ChatGPT o3 (high)  2025-05-06
	#We want to see 'RTX 2000 Ada 16GB' and 'RTX 4090 16GB' , not just 'RTX 2000 16GB' . Please revise.
	#
	# RTX 2000 Ada 16GB
	# RTX 2000 16GB
	#
	_filter_nvidia_smi_gpuInfo() {
		# write the capacities any way you like:
		#             ↓ commas, spaces or a mixture ↓
		local sizes='2,3,4,6,8,10,11,12,16,20,24,32,40,48,56,64,80,94,96,128,141,180,192,256,320,384,512,640,768,896,1024,1280,1536,1792,2048'

		awk -F', *' -v sizes="$sizes" '
			BEGIN {
				# accept both commas and blanks as separators
				n = split(sizes, S, /[ ,]+/)
			}
			{
				# ----- tidy up the model name -----
				name = $1
				gsub(/NVIDIA |GeForce |Laptop GPU|[[:space:]]+Generation/, "", name)
				gsub(/  +/, " ", name)
				sub(/^ +| +$/, "", name)

				# ----- MiB -> decimal GB -----
				mib   = $2 + 0
				bytes = mib * 1048576
				decGB = bytes / 1e9     # decimal gigabytes

				# pick the nearest marketing size
				best = S[1]
				diff = (decGB > S[1] ? decGB - S[1] : S[1] - decGB)

				for (i = 2; i <= n; i++) {
					d = (decGB > S[i] ? decGB - S[i] : S[i] - decGB)
					if (d < diff) { diff = d; best = S[i] }
				}

				printf "%s %dGB\n", name, best
			}'
	}


	if type nvidia-smi > /dev/null 2>&1
	then
		export prompt_specialInfo=$(
			nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits | _filter_nvidia_smi_gpuInfo
		)
	fi

	if _if_wsl && [[ -e "/mnt/c/Windows/System32/cmd.exe" ]] && /mnt/c/Windows/System32/cmd.exe /C where nvidia-smi > /dev/null 2>&1
	then
		export prompt_specialInfo=$(
			( cd /mnt/c ; /mnt/c/Windows/System32/cmd.exe /C nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits 2>/dev/null | _filter_nvidia_smi_gpuInfo )
		)
	fi

	if [[ "$SHELL" == *"/nix/store/"*"/bin/bash"* ]]
	then
		export prompt_specialInfo="nixShell"
	fi
	
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	
	
	
	#if _if_cygwin
	#then
		#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\]\u\[\033[01;32m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]\[\033[37m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	#elif ( uname -a | grep -i 'microsoft' > /dev/null 2>&1 || uname -a | grep -i 'WSL2' > /dev/null 2>&1 )
	#then
		#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\]\u\[\033[01;32m\]@'"$currentHostname"-wsl2'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]\[\033[37m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	#else
		#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\]\u\[\033[01;32m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '	
	#fi
	


	# NOTICE: ATTENTION: Bright colors. More compatible with older terminals (in theory).
	#
	# https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
	# Slightly darker yellow will be more printable on white background (ie. Pandoc rendering from HTML from asciinema cat ).
	#01;33m
	#38;5;214m
	#
	#\[\033[01;33m\]
	#'\[\e[01;33m\e[38;5;214m\]'
	#'\[\033[01;33m\033[38;5;214m\]'
	#if _if_cygwin
	#then
		#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\033[38;5;214m\]\u\[\033[01;32m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(([[ "$VIRTUAL_ENV_PROMPT" != "" ]] && echo -n "$VIRTUAL_ENV_PROMPT") || date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_specialInfo"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]\[\033[37m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	#elif ( uname -a | grep -i 'microsoft' > /dev/null 2>&1 || uname -a | grep -i 'WSL2' > /dev/null 2>&1 )
	#then
		#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\033[38;5;214m\]\u\[\033[01;32m\]@'"$currentHostname"-wsl2'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(([[ "$VIRTUAL_ENV_PROMPT" != "" ]] && echo -n "$VIRTUAL_ENV_PROMPT") || date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_specialInfo"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]\[\033[37m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	#else
		#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\033[38;5;214m\]\u\[\033[01;32m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(([[ "$VIRTUAL_ENV_PROMPT" != "" ]] && echo -n "$VIRTUAL_ENV_PROMPT") || date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_specialInfo"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '	
	#fi

	# ATTRIBUTION-AI: ChatGPT o4-mini-high  2025-06-29 .
	#echo -e "\033[01;40m\033[01;36m\033[01;34m|\033[01;31m0:(exampleChroot)\033[01;33m\033[38;5;214muser\033[01;32m@exampleHost\033[01;36m\033[01;34m)\033[01;36m\033[01;34m-cloudNet(\033[01;35mvenv\033[01;34m)\033[01;36m|\033[00mINFO\n\033[01;40m\033[01;36m\033[01;34m\033[37m/home/user\033[00m\n\033[01;36m\033[01;34m|1\033[01;34m \033[36m> \033[00m"



	# NOTICE: ATTENTION: Color saturation reduced. Similar benefits, delineating separate information strings and command prompts between commands.
	# Less distracting.
	
	if _if_cygwin
	then
		export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]|\[\033[01;31m\]\[\033[38;5;138m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\033[38;5;179m\]\u\[\033[01;32m\033[38;5;108m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\])\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\033[38;5;96m\]$(([[ "$VIRTUAL_ENV_PROMPT" != "" ]] && echo -n "$VIRTUAL_ENV_PROMPT") || date +%H:%M:%S\.%d)\[\033[01;34m\033[38;5;103m\])\[\033[01;36m\]\[\033[38;5;109m\]|\[\033[00m\]'"$prompt_specialInfo"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]\[\033[37m\033[38;5;253m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]\[\033[38;5;109m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\033[38;5;103m\]) \[\033[36m\]\[\033[38;5;109m\]'""'>\[\033[00m\] '
	elif ( uname -a | grep -i 'microsoft' > /dev/null 2>&1 || uname -a | grep -i 'WSL2' > /dev/null 2>&1 )
	then
		export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]|\[\033[01;31m\]\[\033[38;5;138m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\033[38;5;179m\]\u\[\033[01;32m\033[38;5;108m\]@'"$currentHostname"-wsl2'\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\])\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\033[38;5;96m\]$(([[ "$VIRTUAL_ENV_PROMPT" != "" ]] && echo -n "$VIRTUAL_ENV_PROMPT") || date +%H:%M:%S\.%d)\[\033[01;34m\033[38;5;103m\])\[\033[01;36m\]\[\033[38;5;109m\]|\[\033[00m\]'"$prompt_specialInfo"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]\[\033[37m\033[38;5;253m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]\[\033[38;5;109m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\033[38;5;103m\]) \[\033[36m\]\[\033[38;5;109m\]'""'>\[\033[00m\] '
	else
		export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]|\[\033[01;31m\]\[\033[38;5;138m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\033[38;5;179m\]\u\[\033[01;32m\033[38;5;108m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\])\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\033[38;5;96m\]$(([[ "$VIRTUAL_ENV_PROMPT" != "" ]] && echo -n "$VIRTUAL_ENV_PROMPT") || date +%H:%M:%S\.%d)\[\033[01;34m\033[38;5;103m\])\[\033[01;36m\]\[\033[38;5;109m\]|\[\033[00m\]'"$prompt_specialInfo"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]|\[\033[37m\033[38;5;253m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[38;5;109m\]\[\033[01;34m\033[38;5;103m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]\[\033[38;5;109m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\033[38;5;103m\]) \[\033[36m\]\[\033[38;5;109m\]'""'>\[\033[00m\] '	
	fi

	
	#export PS1="$prompt_specialInfo""$PS1"
}


_request_visualPrompt() {
	_messagePlain_request 'export profileScriptLocation="'"$scriptAbsoluteLocation"'"'
	_messagePlain_request 'export profileScriptFolder="'"$scriptAbsoluteFolder"'"'
	_messagePlain_request ". "'"'"$scriptAbsoluteLocation"'"' --profile _importShortcuts
}

#https://stackoverflow.com/questions/15432156/display-filename-before-matching-line-grep
_grepFileLine() {
	grep -n "$@" /dev/null
}

_findFunction() {
	#-name '*.sh'
	#-not -path "./_local/*"
	#find ./blockchain -name '*.sh' -type f -size -10000k -exec grep -n "$@" '{}' /dev/null \;
	#find ./generic -name '*.sh' -type f -size -10000k -exec grep -n "$@" '{}' /dev/null \;
	#find ./instrumentation -name '*.sh' -type f -size -10000k -exec grep -n "$@" '{}' /dev/null \;
	#find ./labels -name '*.sh' -type f -size -10000k -exec grep -n "$@" '{}' /dev/null \;
	#find ./os -name '*.sh' -type f -size -10000k -exec grep -n "$@" '{}' /dev/null \;
	#find ./shortcuts -name '*.sh' -type f -size -10000k -exec grep -n "$@" '{}' /dev/null \;
	#find . -name '*.sh' -type f -size -10000k -exec grep -n "$@" '{}' /dev/null \;
	
	find . -not -path "./_local/*" -name '*.sh' -type f -size -3000k -exec grep -n "$@" '{}' /dev/null \;
}

#Simulated client/server discussion testing.

_log_query() {
	[[ "$1" == "" ]] && return 1
	
	tee "$1"
	
	return 0
}

_report_query_stdout() {
	[[ "$1" == "" ]] && return 1
	
	_messagePlain_probe 'stdout: strings'
	strings "$1"
	
	_messagePlain_probe 'stdout: hex'
	xxd -p "$1" | tr -d '\n'
	echo
	
	return 0
}

# ATTENTION: Overload with "core.sh" or similar.
_prepare_query_prog() {
	true
}

_prepare_query() {
	export ub_queryclientdir="$queryTmp"/client
	export qc="$ub_queryclientdir"
	
	export ub_queryclient="$ub_queryclientdir"/script
	export qce="$ub_queryclient"
	
	export ub_queryserverdir="$queryTmp"/server
	export qs="$ub_queryserverdir"
	
	export ub_queryserver="$ub_queryserverdir"/script
	export qse="$ub_queryserver"
	
	mkdir -p "$ub_queryclientdir"
	mkdir -p "$ub_queryserverdir"
	
	! [[ -e "$ub_queryclient" ]] && cp "$scriptAbsoluteLocation" "$ub_queryclient"
	! [[ -e "$ub_queryserver" ]] && cp "$scriptAbsoluteLocation" "$ub_queryserver"
	
	_prepare_query_prog "$@"
	
	_safe_declare_uid
}

_queryServer_sequence() {
	_start
	
	_safe_declare_uid
	
	local currentExitStatus
	
	export queryType="server"
	"$ub_queryserver" "$@"
	currentExitStatus="$?"
	
	env > env_$(_uid)
	
	_stop "$currentExitStatus"
}
_queryServer() {
	"$scriptAbsoluteLocation" _queryServer_sequence "$@"
}
_qs() {
	_queryServer "$@"
}

_queryClient_sequence() {
	_start
	
	_safe_declare_uid
	
	local currentExitStatus
	
	export queryType="client"
	"$ub_queryclient" "$@"
	currentExitStatus="$?"
	
	env > env_$(_uid)
	
	_stop "$currentExitStatus"
}
_queryClient() {
	"$scriptAbsoluteLocation" _queryClient_sequence "$@"
}
_qc() {
	_queryClient "$@"
}

_query_diag() {
	echo test | _query "$@"
	local currentExitStatus="$?"
	
	_messagePlain_nominal 'diag: tx.log'
	_report_query_stdout "$queryTmp"/tx.log
	
	_messagePlain_nominal 'diag: xc.log'
	_report_query_stdout "$queryTmp"/xc.log
	
	_messagePlain_nominal 'diag: rx.log'
	_report_query_stdout "$queryTmp"/rx.log
	
	return "$currentExitStatus"
}

# ATTENTION: Overload with "core.sh" or similar.
_query() {
	_prepare_query
	
	( cd "$qc" ; _queryClient _bin cat | _log_query "$queryTmp"/tx.log | ( cd "$qs" ; _queryServer _bin cat | _log_query "$queryTmp"/xc.log | ( cd "$qc" ; _queryClient _bin cat | _log_query "$queryTmp"/rx.log ; return "${PIPESTATUS[0]}" )))
}


_github_removeActionsHTTPS-filter() {
    _messagePlain_probe '_github_removeActionsHTTPS-filter: '"$1"
    
    sed -i 's/^\sextraheader.*$//g' "$1"
    sed -i 's/^\sinsteadOf = git@github.com:.*$//g' "$1"
    sed -i 's/^\sinsteadOf = org.*@github.com:.*$//g' "$1"
}

_github_removeActionsHTTPS() {
    if [[ "$1" != *".git"* ]] && [[ "$1" != *".git" ]]
    then
        _messagePlain_bad 'warn: missing: .git: '"$1"
        _messageFAIL
        _stop 1
        return 1
    fi

    find "$1" -type f -name 'config' -exec "$scriptAbsoluteLocation" _github_removeActionsHTTPS-filter {} \;
    

}







# "$1" == build-${{ github.run_id }}-${{ github.run_attempt }}
#shift
# "$@" == ./_local/package_image_beforeBoot.tar.flx.part*
_gh_release_upload_parts-multiple() {
    "$scriptAbsoluteLocation" _gh_release_upload_parts-multiple_sequence "$@"
}
_gh_release_upload_parts-multiple_sequence() {
    _messageNormal '_gh_release_upload_parts: '"$@"
    local currentTag="$1"
    shift

    local currentStream_max=12

    local currentStreamNum=0

    for currentFile in "$@"
    do
        let currentStreamNum++

        "$scriptAbsoluteLocation" _gh_release_upload_part-single_sequence "$currentTag" "$currentFile" &
        eval local currentStream_${currentStreamNum}_PID="$!"
        _messagePlain_probe_var currentStream_${currentStreamNum}_PID
        
        while [[ $(jobs | wc -l) -ge "$currentStream_max" ]]
        do
            echo
            jobs
            echo
            sleep 2
            true
        done
    done

    local currentStreamPause
    for currentStreamPause in $(seq "1" "$currentStreamNum")
	do
        _messagePlain_probe currentStream_${currentStreamPause}_PID= $(eval "echo \$currentStream_${currentStreamPause}_PID")
		if eval "[[ \$currentStream_${currentStreamPause}_PID != '' ]]"
        then
           _messagePlain_probe _pauseForProcess $(eval "echo \$currentStream_${currentStreamPause}_PID")
           _pauseForProcess $(eval "echo \$currentStream_${currentStreamPause}_PID")
        fi
	done

    while [[ $(jobs | wc -l) -ge 1 ]]
    do
        echo
        jobs
        echo
        sleep 2
        true
    done
    
    wait
}
_gh_release_upload_part-single_sequence() {
    _messagePlain_nominal '_gh_release_upload: '"$1"' '"$2"
    local currentTag="$1"
    local currentFile="$2"

    #local currentPID
    #"$scriptAbsoluteLocation" _stopwatch gh release upload "$currentTag" "$currentFile" &
    #currentPID="$!"

    #_pauseForProcess "$currentPID"
    #wait

    #while ! "$scriptAbsoluteLocation" _stopwatch _timeout 10 dd if="$currentFile" bs=1M status=progress > /dev/null
    #do
        #sleep 7
    #done
    #return 0

    # Maximum file size is 2GigaBytes .
    local currentIteration=0
    while ! "$scriptAbsoluteLocation" _stopwatch _timeout 600 gh release upload --clobber "$currentTag" "$currentFile" && [[ "$currentIteration" -lt 30 ]]
    do
        sleep 7
        let currentIteration++
    done
    return 0
}



_testGit() {
	_wantGetDep git
}

#Ignores file modes, suitable for use with possibly broken filesystems like NTFS.
_gitCompatible() {
	git -c core.fileMode=false "$@"
}

_gitInfo() {
	#Git Repository Information
	export repoDir="$PWD"

	export repoName=$(basename "$repoDir")
	export bareRepoDir=../."$repoName".git
	export bareRepoAbsoluteDir=$(_getAbsoluteLocation "$bareRepoDir")

	#Set $repoHostName in user ".bashrc" or similar. May also set $repoPort including colon prefix.
	[[ "$repoHostname" == "" ]] && export repoHostname=$(hostname -f)
	
	true
}

_gitRemote() {
	_gitInfo
	
	if [[ -e "$bareRepoDir" ]]
	then
		_showGitRepoURI
		return 0
	fi
	
	if ! [[ -e "$repoDir"/.git ]]
	then
		return 1
	fi
	
	if git config --get remote.origin.url > /dev/null 2>&1
	then
		echo -n "git clone --recursive "
		git config --get remote.origin.url
		return 0
	fi
	_gitBare
}

_gitNew() {
	git init
	git add .
	git commit -a -m "first commit"
	git branch -M main
}

_gitImport() {
	cd "$scriptFolder"
	
	mkdir -p "$1"
	cd "$1"
	shift
	git clone "$@"
	
	cd "$scriptFolder"
}

_findGit_procedure() {
	cd "$1"
	shift
	
	if [[ -e "./.git" ]]
	then
		"$@"
		return 0
	fi
	
	find -L . -mindepth 1 -maxdepth 1 -not \( -path \*_arc\* -prune \) -not \( -path \*/_local/ubcp/\* -prune \) -type d -exec "$scriptAbsoluteLocation" _findGit_procedure '{}' "$@" \;
}

#Recursively searches for directories containing ".git".
_findGit() {
	if [[ -e "./.git" ]]
	then
		"$@"
		return 0
	fi
	
	find -L . -mindepth 1 -maxdepth 1 -not \( -path \*_arc\* -prune \) -not \( -path \*/_local/ubcp/\* -prune \) -type d -exec "$scriptAbsoluteLocation" _findGit_procedure '{}' "$@" \;
}

_gitPull() {
	git pull
	git submodule update --recursive
}

_gitCheck_sequence() {
	echo '-----'
	
	local checkRealpath
	checkRealpath=$(realpath .)
	local checkBasename
	checkBasename=$(basename "$checkRealpath")
	
	echo "$checkBasename"
	
	git status
}

_gitCheck() {
	_findGit "$scriptAbsoluteLocation" _gitCheck_sequence
}

_gitPullRecursive_sequence() {
	echo '-----'
	
	local checkRealpath
	checkRealpath=$(realpath .)
	local checkBasename
	checkBasename=$(basename "$checkRealpath")
	
	echo "$checkBasename"
	
	"$scriptAbsoluteLocation" _gitPull
}

# DANGER
#Updates all git repositories recursively.
_gitPullRecursive() {
	_findGit "$scriptAbsoluteLocation" _gitPullRecursive_sequence
}

# DANGER
# Pushes all changes as a commit described as "Upstream."
_gitUpstream() {
	git add -A . ; git commit -a -m "Upstream." ; git push
}
_gitUp() {
	_gitUpstream
}

# DANGER
#Removes all but the .git folder from the working directory.
#_gitFresh() {
#	find . -not -path '\.\/\.git*' -delete
#}




# DANGER: Intended for use ONLY by dist/OS build scripts and similar within ChRoot, ephemeral containers, or other at least mostly replaceable root filesystems.
# The dangerous function is not defined by default and only becomes available after running gitFresh_enable
#
# ATTRIBUTION-AI: DeepSeek-R1-Distill-Llama-70B  2025-03-15
# Define the enable function
_gitFresh_enable() {
    if [[ "$ub_dryRun" == "true" ]]
    then
        _stop
        exit
        return
    fi
	
	# Define the dangerous function here
	#_gitFresh() {
		#[[ "$PWD" == "/" ]] && return 1
		#[[ "$PWD" == "-"* ]] && return 1

		#[[ "$PWD" == "/home" ]] && return 1
		#[[ "$PWD" == "/home/" ]] && return 1
		#[[ "$PWD" == "/home/$USER" ]] && return 1
		#[[ "$PWD" == "/home/$USER/" ]] && return 1
		#[[ "$PWD" == "/$USER" ]] && return 1
		#[[ "$PWD" == "/$USER/" ]] && return 1
		
		#[[ "$PWD" == "/tmp" ]] && return 1
		#[[ "$PWD" == "/tmp/" ]] && return 1
		
		#[[ "$PWD" == "$HOME" ]] && return 1
		#[[ "$PWD" == "$HOME/" ]] && return 1
		
		#find . -not -path '\.\/\.git*' -delete
	#}
	# ATTRIBUTION-AI: DeepSeek-R1-Distill-Llama-8B  2025-03-15
	#  Do NOT take that as an endorsement of a chain-of-reasoning 8B model, way too few parameters for that. This was one result of very many.
	source <(echo "_gitFresh() { [[ "$PWD" == "/" ]] && return 1 ; [[ "$PWD" == "-"* ]] && return 1 ; [[ "$PWD" == "/home" ]] && return 1 ; [[ "$PWD" == "/home/" ]] && return 1 ; [[ "$PWD" == "/home/$USER" ]] && return 1 ; [[ "$PWD" == "/home/$USER/" ]] && return 1 ; [[ "$PWD" == "/$USER" ]] && return 1 ; [[ "$PWD" == "/$USER/" ]] && return 1 ; [[ "$PWD" == "/tmp" ]] && return 1 ; [[ "$PWD" == "/tmp/" ]] && return 1 ; [[ "$PWD" == "$HOME" ]] && return 1 ; [[ "$PWD" == "$HOME/" ]] && return 1 ; find . -not -path '\.\/\.git*' -delete ; }")

	# Export the function to make it available
	export -f _gitFresh
}







# DANGER: CAUTION: WARNING: Calls '_git_shallow'.
_git_shallow-ubiquitous() {
	[[ "$1" != "true" ]] && exit 1
	
	_git_shallow 'git@github.com:mirage335/ubiquitous_bash.git' '_lib/ubiquitous_bash'
}

# DANGER: Not robust. May damage repository and/or submodules, as well as any history not remotely available, causing *severe* data loss.
# CAUTION: Intended only for developers to correct a rare mistake of adding a non-shallow git submodule. No production use.
# WARNING: Submodule path must NOT have trailing or preceeding slash!
# "$1" == uri (eg. git@github.com:mirage335/ubiquitous_bash.git)
# "$2" == path/to/submodule (eg. '_lib/ubiquitous_bash')
_git_shallow() {
	[[ "$1" == "" ]] && exit 1
	[[ "$2" == "" ]] && exit 1
	! [[ -e "$2" ]] && exit 1
	! [[ -e "$scriptAbsoluteFolder"/"$2" ]] && exit 1
	cd "$scriptAbsoluteFolder"
	! [[ -e "$2" ]] && exit 1
	! [[ -e "$scriptAbsoluteFolder"/"$2" ]] && exit 1
	
	
	! [[ -e "$scriptAbsoluteFolder"/.gitmodules ]] && exit 1
	! [[ -e "$scriptAbsoluteFolder"/.git/config ]] && exit 1
	
	_start
	
	# https://gist.github.com/myusuf3/7f645819ded92bda6677
	
	# Remove the submodule entry from .git/config
	git submodule deinit -f "$2"

	# Remove the submodule directory from the superproject's .git/modules directory
	#rm -rf .git/modules/"$2"
	export safeToDeleteGit="true"
	_safeRMR "$scriptAbsoluteFolder"/.git/modules/"$2"

	# Remove the entry in .gitmodules and remove the submodule directory located at path/to/submodule
	git rm -f "$2"
	
	git commit -m "WIP."
	
	
	# https://stackoverflow.com/questions/2144406/how-to-make-shallow-git-submodules
	
	git submodule add --depth 1 "$1" "$2"
	
	git config -f .gitmodules submodule."$2".shallow true
	
	_messagePlain_request git commit -a -m "Draft."
	_messagePlain_request git push
	
	_stop
}





#####Program

_createBareGitRepo() {
	mkdir -p "$bareRepoDir"
	cd $bareRepoDir
	
	git --bare init
	git branch -M main
	
	echo "-----"
}


_setBareGitRepo() {
	cd "$repoDir"
	
	git remote rm origin
	git remote add origin "$bareRepoDir"
	git push --set-upstream origin master
	
	# WARNING: TODO: Experimental, requires further testing. Use branch 'main' if extant.
	git push --set-upstream origin main
	
	echo "-----"
}

_showGitRepoURI() {
	echo git clone --recursive "$bareRepoAbsoluteDir" "$repoName"
	echo git clone --recursive ssh://"$USER"@"$repoHostname""$repoPort""$bareRepoAbsoluteDir" "$repoName"
	
	
	#if [[ "$repoHostname" != "" ]]
	#then
	#	clear
	#	echo ssh://"$USER"@"$repoHostname""$repoPort""$bareRepoAbsoluteDir"
	#	sleep 15
	#fi
}

_gitBareSequence() {
	_gitInfo
	
	if [[ -e "$bareRepoDir" ]]
	then
		_showGitRepoURI
		return 2
	fi
	
	if ! [[ -e "$repoDir"/.git ]]
	then
		return 1
	fi
	
	_createBareGitRepo
	
	_setBareGitRepo
	
	_showGitRepoURI
	
}

_gitBare() {
	
	"$scriptAbsoluteLocation" _gitBareSequence
	
}




_self_gitMad_procedure() {
	local functionEntryPWD
	functionEntryPWD="$PWD"

	cd "$scriptAbsoluteFolder"
	_gitMad
	
	cd "$functionEntryPWD"
}
_self_gitMad() {
	"$scriptAbsoluteLocation" _self_gitMad_procedure "$@"
}
# https://stackoverflow.com/questions/1580596/how-do-i-make-git-ignore-file-mode-chmod-changes
_gitMad() {
	local currentDirectory=$(_getAbsoluteLocation "$PWD")
	_write_configure_git_safe_directory_if_admin_owned "$currentDirectory"

	git config core.fileMode false
	git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
	git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git submodule foreach git config core.fileMode false
}


_gitBest_detect_github_procedure() {
	[[ "$current_gitBest_source_GitHub" == "FAIL" ]] && export current_gitBest_source_GitHub=""
	[[ "$current_gitBest_source_GitHub" != "" ]] && return
	
	_messagePlain_nominal 'init: _gitBest_detect_github_procedure'
	
	if [[ "$current_gitBest_source_GitHub" == "" ]]
	then
		_messagePlain_request 'performance: export current_gitBest_source_GitHub=$("'"$scriptAbsoluteLocation"'" _gitBest_detect_github_sequence | tail -n1)'
		
		if [[ -e "$HOME"/core ]] && [[ "$gitBestNoCore" != "true" ]]
		then
			export current_gitBest_source_GitHub="github_core"
		fi
		
		local currentSSHoutput
		# CAUTION: Disabling this presumes "$HOME"/.ssh/config for GitHub (possibly through 'CoreAutoSSH') is now not necessary to support by default.
		#  ATTENTION: Good assumption. GH_TOKEN/INPUT_GITHUB_TOKEN is now used by _gitBest within 'compendium' functions, etc, usually much safer and more convenient.
		#   Strongly Discouraged: Override with ops.sh if necessary.
		# || [[ -e "$HOME"/.ssh/config ]]
		if ( [[ -e "$HOME"/.ssh/id_rsa ]] || ( [[ ! -e "$HOME"/.ssh/id_ed25519_sk ]] && [[ ! -e "$HOME"/.ssh/ecdsa-sk ]] ) ) && currentSSHoutput=$(ssh -o StrictHostKeyChecking=no -o Compression=yes -o ConnectionAttempts=3 -o ServerAliveInterval=6 -o ServerAliveCountMax=9 -o ConnectTimeout="$netTimeout" -o PubkeyAuthentication=yes -o PasswordAuthentication=no git@github.com 2>&1 ; true) && _safeEcho_newline "$currentSSHoutput" | grep 'successfully authenticated'
		then
			export current_gitBest_source_GitHub="github_ssh"
			return
		fi
		_safeEcho_newline "$currentSSHoutput"
		
		# Exceptionally rare cases of 'github.com' accessed from within GitHub Actions runner (most surprisingly) not responding have apparently happened.
		local currentIteration
		for currentIteration in $(seq 1 2)
		do
			#if _checkPort github.com 443
			if wget -qO- https://github.com > /dev/null
			then
				export current_gitBest_source_GitHub="github_https"
				return
			fi
		done
		
		
		[[ "$current_gitBest_source_GitHub" == "" ]] && export current_gitBest_source_GitHub="FAIL"
		return 1
	fi
	return 0
}
_gitBest_detect_github_sequence() {
	_gitBest_detect_github_procedure "$@"
	_messagePlain_probe_var current_gitBest_source_GitHub
	echo "$current_gitBest_source_GitHub"
}
_gitBest_detect_github() {
	local currentOutput
	currentOutput=$("$scriptAbsoluteLocation" _gitBest_detect_github_sequence "$@")
	_safeEcho_newline "$currentOutput"
	export current_gitBest_source_GitHub=$(_safeEcho_newline "$currentOutput" | tail -n 1)
	[[ "$current_gitBest_source_GitHub" != "github_"* ]] && export current_gitBest_source_GitHub="FAIL"
	
	return 0
}
_gitBest_detect() {
	_gitBest_detect_github "$@"
}



_gitBest_override_config_insteadOf-core() {
	git config --global url."file://""$realHome""/core/infrastructure/""$1".insteadOf git@github.com:mirage335/"$1".git git@github.com:mirage335/"$1"
}
_gitBest_override_config_insteadOf-core--colossus() {
	git config --global url."file://""$realHome""/core/infrastructure/""$1".insteadOf git@github.com:mirage335-colossus/"$1".git git@github.com:mirage335-colossus/"$1"
}
_gitBest_override_config_insteadOf-core--gizmos() {
	git config --global url."file://""$realHome""/core/infrastructure/""$1".insteadOf git@github.com:mirage335-gizmos/"$1".git git@github.com:mirage335-gizmos/"$1"
}
_gitBest_override_config_insteadOf-core--distllc() {
	git config --global url."file://""$realHome""/core/infrastructure/""$1".insteadOf git@github.com:soaringDistributions/"$1".git git@github.com:soaringDistributions/"$1"
}


_gitBest_override_github-github_core() {
	_gitBest_override_config_insteadOf-core--colossus ubiquitous_bash
	_gitBest_override_config_insteadOf-core--colossus extendedInterface

	_gitBest_override_config_insteadOf-core--gizmos flightDeck
	_gitBest_override_config_insteadOf-core--gizmos kinematicBase-large

	_gitBest_override_config_insteadOf-core--distllc ubDistBuild
	_gitBest_override_config_insteadOf-core--distllc ubDistFetch
	
	_gitBest_override_config_insteadOf-core mirage335_documents
	_gitBest_override_config_insteadOf-core mirage335GizmoScience

	_gitBest_override_config_insteadOf-core scriptedIllustrator
	_gitBest_override_config_insteadOf-core arduinoUbiquitous
	
	_gitBest_override_config_insteadOf-core BOM_designer
	_gitBest_override_config_insteadOf-core CoreAutoSSH
	_gitBest_override_config_insteadOf-core coreoracle
	_gitBest_override_config_insteadOf-core flipKey
	_gitBest_override_config_insteadOf-core freecad-assembly2
	_gitBest_override_config_insteadOf-core Freerouting
	_gitBest_override_config_insteadOf-core gEDA_designer
	_gitBest_override_config_insteadOf-core metaBus
	_gitBest_override_config_insteadOf-core PanelBoard
	_gitBest_override_config_insteadOf-core PatchRap
	_gitBest_override_config_insteadOf-core PatchRap_LulzBot
	_gitBest_override_config_insteadOf-core PatchRap_to_CNC
	_gitBest_override_config_insteadOf-core pcb-ioAutorouter
	_gitBest_override_config_insteadOf-core RigidTable
	_gitBest_override_config_insteadOf-core SigBlockly-mod
	_gitBest_override_config_insteadOf-core stepperTester
	_gitBest_override_config_insteadOf-core TazIntermediate
	_gitBest_override_config_insteadOf-core translate2geda
	_gitBest_override_config_insteadOf-core webClient
	_gitBest_override_config_insteadOf-core zipTiePanel
}
_gitBest_override_github-github_https() {
	# && [[ "$1" == "push" ]]
	if [[ "$INPUT_GITHUB_TOKEN" == "" ]]
	then
		git config --global url."https://github.com/".insteadOf git@github.com:
	elif [[ "$INPUT_GITHUB_TOKEN" != "" ]]
	then
		git config --global url."https://""$INPUT_GITHUB_TOKEN""@github.com/".insteadOf git@github.com:
	fi
}



_gitBest_override_github() {
	_messagePlain_nominal 'init: _gitBest_override_github'
	
	cat "$realHome"/.gitconfig >> "$HOME"/.gitconfig
	
	if [[ "$current_gitBest_source_GitHub" == "github_core" ]]
	then
		_gitBest_override_github-github_core
	fi
	
	if [[ "$current_gitBest_source_GitHub" == "github_https" ]]
	then
		_gitBest_override_github-github_https "$@"
	fi
	
	if [[ "$current_gitBest_source_GitHub" == "github_ssh" ]]
	then
		_messagePlain_good 'good: preferred: github_ssh'
	fi
	
	if [[ "$current_gitBest_source_GitHub" == "FAIL" ]]
	then
		_messageError 'FAIL: missing: GitHub'
		_stop 1
	fi
	return 0
}








_gitBest_sequence() {
	_messagePlain_nominal 'init: _gitBest_sequence'
	
	_start scriptLocal_mkdir_disable
	
	export realHome="$HOME"
	export HOME="$safeTmp"/special_fakeHome
	mkdir -p "$HOME"
	
	_messagePlain_probe_var current_gitBest_source_GitHub
	_messagePlain_probe_var HOME
	
	
	_gitBest_override_github "$@"
	
	if ! [[ -e "$HOME"/.gitconfig ]]
	then
		_messagePlain_good 'good: write: overrides: none'
	else
		echo
		echo
		cat "$HOME"/.gitconfig
		echo
		echo
	fi
	
	
	_messagePlain_nominal 'init: git'
	
	local currentExitStatus
	git "$@"
	currentExitStatus="$?"


	export HOME="$realHome"
	if _if_cygwin
	then
		if [ "$1" = "clone" ]
		then
			_messagePlain_nominal 'init: git safe directory'

			# ATTRIBUTION-AI: ChatGPT 4.5-preview  2025-04-12  (partially)
			local currentDirectory
			local currentURL
			local currentArg=""
			local currentArg_previous=""
			for currentArg in "$@"
			do
				# Ignore parameters:
				#  begins with "-" dash
				#  preceeded by parameter taking an argument, but no argument or "="
				if [[ "$currentArg" != -* ]] && [[ "$currentArg" != "clone" ]] && [[ "$currentArg_previous" != "--template" ]] && [[ "$currentArg_previous" != "-o" ]] && [[ "$currentArg_previous" != "-b" ]] && [[ "$currentArg_previous" != "-u" ]] && [[ "$currentArg_previous" != "--reference" ]] && [[ "$currentArg_previous" != "--separate-git-dir" ]] && [[ "$currentArg_previous" != "--depth" ]] && [[ "$currentArg_previous" != "--jobs" ]] && [[ "$currentArg_previous" != "--filter" ]]
				then
					currentURL="$currentArg"
					echo "$currentURL"
					#break

					[[ -e "$currentArg" ]] && currentDirectory="$currentArg"
				fi
				currentArg_previous="$currentArg"
			done
		fi
		
		[[ "$currentDirectory" == "" ]] && [[ "$currentURL" != "" ]] && currentDirectory=$(basename --suffix=".git" "$currentURL")
		
		if [[ -e "$currentDirectory" ]]
		then
			_messagePlain_probe 'exists: '"$currentDirectory"
			if type _write_configure_git_safe_directory_if_admin_owned > /dev/null 2>&1
			then
				currentDirectory=$(_getAbsoluteLocation "$currentDirectory")
				_write_configure_git_safe_directory_if_admin_owned "$currentDirectory"
			fi
		fi
	fi
	
	_stop "$currentExitStatus"
}

_gitBest() {
	_messageNormal 'init: _gitBest'
	
	_gitBest_detect "$@"
	
	"$scriptAbsoluteLocation" _gitBest_sequence "$@"
}


_test_gitBest() {
	_wantGetDep stty
	_wantGetDep ssh
	
	_wantGetDep git
	
	#_wantGetDep nmap
	#_wantGetDep curl
	#_wantGetDep wget
}






# CAUTION: This file is very necessarily part of 'rotten' . Do NOT move functions or rename to other files without updating the build shellcode for 'rotten' !

# Refactored from code which was very robust with fast ISP, however often failed with slower ISP, as explained by ChatGPT due to AWS S3 temporary link expiration.
# See "_ref/wget_githubRelease_internal-OBSOLETE.sh" for original code, which due to the more iterative development process at the time, may be more reliable in untested cases.

# WARNING: May be untested.

# CAUTION: WARNING: Unusually, inheritance of local variables in procedure functions is relied upon. Theoretically, this has been long tested by 'ubiquitous_bash.sh _test' .
#"$api_address_type"
#"$currentStream"
#"$currentAxelTmpFileRelative" "$currentAxelTmpFile"
#
#"$currentAbsoluteRepo"' '"$currentReleaseLabel"' '"$currentFile"
#"$currentOutFile"

# WARNING: CAUTION: Many functions rely on emitting to standard output . Experiment/diagnose by copying code to override with 'ops.sh' . CAUTION: Be very careful enabling or using diagnostic output to stderr, as stderr may also be redirected by calling functions, terminal may not be present, etc.
#( echo x >&2 ) > /dev/null
#_messagePlain_probe_var page >&2 | cat /dev/null
#_messagePlain_probe_safe "current_API_page_URL= ""$current_API_page_URL" >&2 | cat /dev/null
# WARNING: Limit stderr pollution for log (including CI logs) and terminal readability , using 'tail' .
#( cat ubiquitous_bash.sh >&2 ) 2> >(tail -n 10 >&2) | tail -n 10
#( set -o pipefail ; false | cat ubiquitous_bash.sh >&2 ) 2> >(tail -n 10 >&2) | cat > /dev/null
#( set -o pipefail ; false 2> >(tail -n 10 >&2) | cat > /dev/null )

# DANGER: Use _messagePlain_probe_safe , _safeEcho , _safeEcho_newline , etc .

# CAUTION: ATTENTION: Uncommented lines add to ALL 'compiled' bash shell scripts - INCLUDING rotten_compressed.sh !
# Thus, it may be preferable to keep example code as a separate line commented at the beginning of that line, rather than a comment character after code on the same line .





# ATTENTION: 'MANDATORY_HASH == true' claim requirement can be imposed without any important effect on reliability or performance.
# In practice, such multi-part-per-file download programs as 'aria2c' may or may not have any worse integrity safety concerns than other download programs.
# NOTICE: Track record from historically imposing MANDATORY_HASH has been long enough to establish excellent confidence for imposing the requirement for this safety claim again without serious issue if necessary.
# https://www.cvedetails.com/vulnerability-list/vendor_id-12682/Haxx.html
#  'Haxx'
# https://www.cvedetails.com/vulnerability-list/vendor_id-3385/Wget.html
# https://www.cvedetails.com/vulnerability-list/vendor_id-19755/product_id-53327/Aria2-Project-Aria2.html
# https://www.cvedetails.com/vulnerability-list/vendor_id-2842/Axel.html
# ATTENTION: DANGER: Client downloading function explicitly sets 'MANDATORY_HASH == true' to claim resulting file EITHER will be checked by external hash before production use OR file is downloaded within an internal safer network (ie. GitHub Actions) using integrity guarded computers (ie. GitHub Runners). Potentially less integrity-safe downloading as multi-part-per-file parallel 'axel' 'download accelerator' style downloading can be limited to require a safety check for the MANDATORY_HASH claim.
# NOTICE: Imposing safety check for MANDATORY_HASH claim has long track record and no known use cases combine BOTH the jittery contentious internet connections over which multi-part-per-file downloading may or may not be more reliable, AND cannot test build steps without download large files to cycle the entire build completely. That is to say, ONLY CI environments would be usefully faster from not requiring a MANDATORY_HASH claim, yet CI environments can already make an integrity claim relevant for MANDATORY_HASH, and CI environments usually have high-quality internet connections not needing complex trickery to improve download reliability/speed.
#[[ "$FORCE_AXEL" != "" ]] && ( [[ "$MANDATORY_HASH" == "true" ]] )



#export FORCE_DIRECT="true"
#export FORCE_WGET="true"
#export FORCE_AXEL="4"

# Actually buffers files in progress behind completed files, in addition to downloading over multiple connections. Streaming without buffer underrun (ie. directly to packetDisc, ie. directly to optical disc) regardless of internet connection quality may require such buffer.
#export FORCE_PARALLEL="3"

# Already default. FORCE_BUFFER="true" implies FORCE_PARALLEL=3 or similar and sets FORCE_DIRECT="false". FORCE_BUFFER="false" implies and sets FORCE_DIRECT="true" .
#FORCE_BUFFER="true"

#export GH_TOKEN="..."





#_get_vmImg_ubDistBuild_sequence
#export MANDATORY_HASH="true"
# write file
#_wget_githubRelease_join-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "package_image.tar.flx" | _get_extract_ubDistBuild-tar xv --overwrite
# write disk (eg. '/dev/sda')
#_wget_githubRelease_join-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "package_image.tar.flx" | _get_extract_ubDistBuild-tar --extract ./vm.img --to-stdout | sudo -n dd of="$3" bs=1M status=progress
#
#export MANDATORY_HASH=
#unset MANDATORY_HASH
#_wget_githubRelease-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "_hash-ubdist.txt"


#_get_vmImg_beforeBoot_ubDistBuild_sequence
#export MANDATORY_HASH="true"
# write file
#_wget_githubRelease_join-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "package_image_beforeBoot.tar.flx" | _get_extract_ubDistBuild-tar xv --overwrite
# write disk (eg. '/dev/sda')
#_wget_githubRelease_join-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "package_image_beforeBoot.tar.flx" | _get_extract_ubDistBuild-tar --extract ./vm.img --to-stdout | sudo -n dd of="$3" bs=1M status=progress
#
#export MANDATORY_HASH=
#unset MANDATORY_HASH
#_wget_githubRelease-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "_hash-ubdist_beforeBoot.txt"


#_get_vmImg_ubDistBuild-live_sequence
#export MANDATORY_HASH="true"
# write file
#_wget_githubRelease_join "soaringDistributions/ubDistBuild" "$releaseLabel" "vm-live.iso"
#currentHash_bytes=$(_wget_githubRelease-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "_hash-ubdist.txt" | head -n 14 | tail -n 1 | sed 's/^.*count=$(bc <<< '"'"'//' | cut -f1 -d\  )
# write packetDisc (eg. '/dev/sr0', '/dev/dvd'*, '/dev/cdrom'*)
#_wget_githubRelease_join-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "vm-live.iso" | tee >(openssl dgst -whirlpool -binary | xxd -p -c 256 >> "$scriptLocal"/hash-download.txt) ; dd if=/dev/zero bs=2048 count=$(bc <<< '1000000000000 / 2048' ) ) | sudo -n growisofs -speed=3 -dvd-compat -Z "$3"=/dev/stdin -use-the-force-luke=notray -use-the-force-luke=spare:min -use-the-force-luke=bufsize:128m
# write disk (eg. '/dev/sda')
#_wget_githubRelease_join-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "vm-live.iso" | tee >(openssl dgst -whirlpool -binary | xxd -p -c 256 >> "$scriptLocal"/hash-download.txt) ; dd if=/dev/zero bs=2048 count=$(bc <<< '1000000000000 / 2048' ) ) | sudo -n dd of="$3" bs=1M status=progress
#
#export MANDATORY_HASH=
#unset MANDATORY_HASH
#_wget_githubRelease-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "_hash-ubdist.txt"


#_get_vmImg_ubDistBuild-rootfs_sequence
#export MANDATORY_HASH="true"
#_wget_githubRelease_join-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "package_rootfs.tar.flx" | lz4 -d -c > ./package_rootfs.tar
#
#export MANDATORY_HASH=
#unset MANDATORY_HASH
#_wget_githubRelease-stdout "soaringDistributions/ubDistBuild" "$releaseLabel" "_hash-ubdist.txt"



#! "$scriptAbsoluteLocation" _wget_githubRelease_join "owner/repo" "internal" "file.ext"
#! _wget_githubRelease "owner/repo" "" "file.ext"


#_wget_githubRelease_join "soaringDistributions/Llama-3-augment_bundle" "" "llama-3.1-8b-instruct-abliterated.Q4_K_M.gguf"



#_wget_githubRelease-stdout
#export MANDATORY_HASH="true"
#export MANDATORY_HASH=""

#_wget_githubRelease_join
#export MANDATORY_HASH="true"
#export MANDATORY_HASH=""

#_wget_githubRelease_join-stdout
#export MANDATORY_HASH="true"







#type -p gh > /dev/null 2>&1


#_wget_githubRelease_internal

#curl --no-progress-meter
#gh release download "$current_tagName" -R "$current_repo" -p "$current_file" "$@" 2> >(tail -n 10 >&2) | tail -n 10

## Use variables to construct the gh release download command
#local currentIteration
#currentIteration=0
#while ! [[ -e "$current_fileOut" ]] && [[ "$currentIteration" -lt 3 ]]
#do
	##gh release download "$current_tagName" -R "$current_repo" -p "$current_file" "$@"
	#gh release download "$current_tagName" -R "$current_repo" -p "$current_file" "$@" 2> >(tail -n 10 >&2) | tail -n 10
	#! [[ -e "$current_fileOut" ]] && sleep 7
	#let currentIteration=currentIteration+1
#done
#[[ -e "$current_fileOut" ]]
#return "$?"



# ATTENTION: Override with 'ops.sh' or similar. Do NOT attempt to override with exported variables: do indeed override the function.

_set_wget_githubRelease() {
	export githubRelease_retriesMax=25
	export githubRelease_retriesWait=18
}
_set_wget_githubRelease

_set_wget_githubRelease-detect() {
	export githubRelease_retriesMax=2
	export githubRelease_retriesWait=4
}

_set_wget_githubRelease-detect-parallel() {
	export githubRelease_retriesMax=25
	export githubRelease_retriesWait=18
}

_set_curl_github_retry() {
	export curl_retries_args=( --retry 5 --retry-delay 90 --connect-timeout 45 --max-time 600 )
}
#_set_wget_githubRelease
#unset curl_retries_args


_if_gh() {
	if type -p gh > /dev/null 2>&1 && [[ "$GH_TOKEN" != "" ]]
	then
		( _messagePlain_probe '_if_gh: gh' >&2 ) > /dev/null
		return 0
	fi
	( _messagePlain_probe '_if_gh: NOT gh' >&2 ) > /dev/null
	return 1
}


#_wget_githubRelease-URL "owner/repo" "" "file.ext"
#_wget_githubRelease-URL "owner/repo" "latest" "file.ext"
#_wget_githubRelease-URL "owner/repo" "internal" "file.ext"
_wget_githubRelease-URL() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ init: _wget_githubRelease-URL' >&2 ) > /dev/null
	if _if_gh
	then
		( _messagePlain_probe_safe _wget_githubRelease-URL-gh "$@" >&2 ) > /dev/null
		_wget_githubRelease-URL-gh "$@"
		return
	else
		( _messagePlain_probe_safe _wget_githubRelease-URL-curl "$@" >&2 ) > /dev/null
		_wget_githubRelease-URL-curl "$@"
		return
	fi
}
#_wget_githubRelease-URL "owner/repo" "file.ext"
_wget_githubRelease_internal-URL() {
	_wget_githubRelease-URL "$1" "internal" "$2"
}
#_wget_githubRelease-address "owner/repo" "" "file.ext"
#_wget_githubRelease-address "owner/repo" "latest" "file.ext"
#_wget_githubRelease-address "owner/repo" "internal" "file.ext"
_wget_githubRelease-address() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ init: _wget_githubRelease-address' >&2 ) > /dev/null
	if _if_gh
	then
		( _messagePlain_probe_safe _wget_githubRelease-address-gh "$@" >&2 ) > /dev/null
		_wget_githubRelease-address-gh "$@"
		return
	else
		( _messagePlain_probe_safe _wget_githubRelease-address-curl "$@" >&2 ) > /dev/null
		_wget_githubRelease-address-curl "$@"
		return
	fi
}

#"$api_address_type" == "tagName" || "$api_address_type" == "url"
# ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
_jq_github_browser_download_address() {
	( _messagePlain_probe 'init: _jq_github_browser_download_address' >&2 ) > /dev/null
	local currentReleaseLabel="$2"
	local currentFile="$3"
	
	# 'latest'
	#  or alternatively (untested, apparently incompatible), for all tags from the 'currentData' regardless of 'currentReleaseLabel'
	if [[ "$currentReleaseLabel" == "latest" ]] || [[ "$currentReleaseLabel" == "" ]]
	then
		if [[ "$api_address_type" == "" ]] || [[ "$api_address_type" == "url" ]]
        then
            #jq -r ".assets[] | select(.name == "'"$currentFile"'") | .browser_download_url"
			jq --arg filename "$currentFile" --arg releaseLabel "$currentReleaseLabel" -r '.assets[] | select(.name == $filename) | .browser_download_url'
            return
        fi
		if [[ "$api_address_type" == "tagName" ]]
        then
            #jq -r ".tag_name"
			jq --arg filename "$currentFile" --arg releaseLabel "$currentReleaseLabel" -r '.tag_name'
            return
        fi
		if [[ "$api_address_type" == "api_url" ]]
		then
			#jq -r ".assets[] | select(.name == "'"$currentFile"'") | .url"
			jq --arg filename "$currentFile" --arg releaseLabel "$currentReleaseLabel" -r '.assets[] | select(.name == $filename) | .url'
			return
		fi
	# eg. 'internal', 'build', etc
	else
		if [[ "$api_address_type" == "" ]] || [[ "$api_address_type" == "url" ]]
        then
            #jq -r "sort_by(.published_at) | reverse | .[] | select(.name == "'"$currentReleaseLabel"'") | .assets[] | select(.name == "'"$currentFile"'") | .browser_download_url"
			jq --arg filename "$currentFile" --arg releaseLabel "$currentReleaseLabel" -r 'sort_by(.published_at) | reverse | .[] | select(.name == $releaseLabel) | .assets[] | select(.name == $filename) | .browser_download_url'
            return
        fi
		if [[ "$api_address_type" == "tagName" ]]
        then
            #jq -r "sort_by(.published_at) | reverse | .[] | select(.name == "'"$currentReleaseLabel"'") | .tag_name"
			jq --arg filename "$currentFile" --arg releaseLabel "$currentReleaseLabel" -r 'sort_by(.published_at) | reverse | .[] | select(.name == $releaseLabel) | .tag_name'
            return
        fi
		if [[ "$api_address_type" == "api_url" ]]
		then
			#jq -r "sort_by(.published_at) | reverse | .[] | select(.name == "'"$currentReleaseLabel"'") | .assets[] | select(.name == "'"$currentFile"'") | .url"
			jq --arg filename "$currentFile" --arg releaseLabel "$currentReleaseLabel" -r 'sort_by(.published_at) | reverse | .[] | select(.name == $releaseLabel) | .assets[] | select(.name == $filename) | .url'
			return
		fi
	fi
}
_curl_githubAPI_releases_page() {
	( _messagePlain_nominal "$currentStream"'\/\/\/ init: _curl_githubAPI_releases_page' >&2 ) > /dev/null
	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	[[ "$currentFile" == "" ]] && return 1

	local currentPageNum="$4"
	[[ "$currentPageNum" == "" ]] && currentPageNum="1"
	_messagePlain_probe_var currentPageNum >&2 | cat /dev/null
	
	local current_API_page_URL
	current_API_page_URL="https://api.github.com/repos/""$currentAbsoluteRepo""/releases?per_page=100&page=""$currentPageNum"
	[[ "$currentReleaseLabel" == "latest" ]] && current_API_page_URL="https://api.github.com/repos/""$currentAbsoluteRepo""/releases""/latest"
	_messagePlain_probe_safe "current_API_page_URL= ""$current_API_page_URL" >&2 | cat /dev/null

	local current_curl_args
	current_curl_args=()
	[[ "$GH_TOKEN" != "" ]] && current_curl_args+=( -H "Authorization: Bearer $GH_TOKEN" )
	#current_curl_args+=( -H "Accept: application/octet-stream" )
	current_curl_args+=( -S )
	current_curl_args+=( -s )

    local currentFailParam="$5"
    [[ "$currentFailParam" != "--no-fail" ]] && currentFailParam="--fail"
	current_curl_args+=( "$currentFailParam" )
	shift ; shift ; shift ; shift ; shift
	# CAUTION: Discouraged unless proven necessary. Causes delays and latency beyond "$githubRelease_retriesWait"*"$githubRelease_retriesMax" , possibly exceeding prebuffering on a single error.
	#--retry 5 --retry-delay 90 --connect-timeout 45 --max-time 600
	#_set_curl_github_retry
	#"${curl_retries_args[@]}"
	current_curl_args+=( "$@" )

	local currentPage
	currentPage=""

	local currentExitStatus_ipv4=1
	local currentExitStatus_ipv6=1

	( _messagePlain_probe '_curl_githubAPI_releases_page: IPv6 (false)' >&2 ) > /dev/null
	# ATTENTION: IPv6 is NOT offered by GitHub API, and so usually only wastes time at best.
	#currentPage=$(curl -6 "${current_curl_args[@]}" "$current_API_page_URL")
	false
	currentExitStatus_ipv6="$?"
	if [[ "$currentExitStatus_ipv6" != "0" ]]
	then
		( _messagePlain_probe '_curl_githubAPI_releases_page: IPv4' >&2 ) > /dev/null
		[[ "$currentPage" == "" ]] && currentPage=$(curl -4 "${current_curl_args[@]}" "$current_API_page_URL")
		currentExitStatus_ipv4="$?"
	fi
	
	_safeEcho_newline "$currentPage"

	if [[ "$currentExitStatus_ipv6" != "0" ]] && [[ "$currentExitStatus_ipv4" != "0" ]]
	then
		( _messagePlain_bad 'bad: FAIL: _curl_githubAPI_releases_page' >&2 ) > /dev/null
		[[ "$currentExitStatus_ipv4" != "1" ]] && [[ "$currentExitStatus_ipv4" != "0" ]] && return "$currentExitStatus_ipv4"
		[[ "$currentExitStatus_ipv6" != "1" ]] && [[ "$currentExitStatus_ipv6" != "0" ]] && return "$currentExitStatus_ipv6"
		return "$currentExitStatus_ipv4"
	fi

	[[ "$currentPage" == "" ]] && return 1
	return 0
}
# WARNING: No production use. May be untested.
#  Rapidly skips part files which are not upstream, using only a single page from the GitHub API, saving time and API calls.
# Not guaranteed reliable. Structure of this non-essential function is provider-specific, code is written ad-hoc.
# Duplicates much code from other functions:
#  '_wget_githubRelease_procedure-address-curl'
#  '_wget_githubRelease_procedure-address_fromTag-curl'
#  '_wget_githubRelease-address-backend-curl'
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_join-skip soaringDistributions/ubDistBuild spring package_image.tar.flx
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_join-skip soaringDistributions/ubDistBuild latest package_image.tar.flx
_curl_githubAPI_releases_join-skip() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _curl_githubAPI_releases_join-skip' >&2 ) > /dev/null
	( _messagePlain_probe_safe _curl_githubAPI_releases_join-skip "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    [[ "$GH_TOKEN" != "" ]] && local api_address_type="api_url"
	[[ "$GH_TOKEN" == "" ]] && local api_address_type="url"

	local currentPartDownload
	currentPartDownload=""

	local currentExitStatus=1

	local currentIteration=0

	#[[ "$currentPartDownload" == "" ]] || 
	while ( [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		currentPartDownload=""

		if [[ "$currentIteration" != "0" ]]
		then
			( _messagePlain_warn 'warn: BAD: RETRY: _curl_githubAPI_releases_join-skip: _curl_githubAPI_releases_join_procedure-skip: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe _curl_githubAPI_releases_join_procedure-skip >&2 ) > /dev/null
		currentPartDownload=$(_curl_githubAPI_releases_join_procedure-skip "$@")
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
	
	_safeEcho_newline "$currentPartDownload"

	[[ "$currentIteration" -ge "$githubRelease_retriesMax" ]] && ( _messagePlain_bad 'bad: FAIL: _curl_githubAPI_releases_join-skip: maxRetries' >&2 ) > /dev/null && return 1

	return 0
}
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_join_procedure-skip soaringDistributions/ubDistBuild spring package_image.tar.flx
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_join_procedure-skip soaringDistributions/ubDistBuild latest package_image.tar.flx
_curl_githubAPI_releases_join_procedure-skip() {
	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	[[ "$currentFile" == "" ]] && return 1


	local currentExitStatus_tmp=0
	local currentExitStatus=0


	local currentPart
	local currentAddress


	if [[ "$currentReleaseLabel" == "latest" ]]
	then
		local currentData
		local currentData_page
		
		#(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile")
		#return

		currentData_page=$(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		currentExitStatus="$?"

		currentData="$currentData_page"

		[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
		
		[[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: empty: currentData' >&2 ) > /dev/null && return 1

		#( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 )
		#currentExitStatus_tmp="$?"

		# ###
		for currentPart in $(seq -f "%02g" 0 "$maxCurrentPart" | sort -r)
		do
			currentAddress=$(set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile".part"$currentPart" | head -n 1)
			currentExitStatus_tmp="$?"

			[[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: pipefail: _jq_github_browser_download_address: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"

			[[ "$currentAddress" != "" ]] && echo "$currentPart" && return 0
		done

		
		# ### ATTENTION: No part files found is not 'skip' but FAIL .
		[[ "$currentAddress" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _curl_githubAPI_releases_join-skip: empty: _safeEcho_newline | _jq_github_browser_download_address' >&2 ) > /dev/null && return 1
		
		return 0
	else
		local currentData
		currentData=""
		
		local currentData_page
		currentData_page="doNotMatch"
		
		local currentIteration
		currentIteration=1
		
		# ATTRIBUTION-AI: Many-Chat 2025-03-23
		# Alternative detection of empty array, as suggested by AI LLM .
		#[[ $(jq 'length' <<< "$currentData_page") -gt 0 ]]
		while ( [[ "$currentData_page" != "" ]] && [[ $(_safeEcho_newline "$currentData_page" | tr -dc 'a-zA-Z\[\]' | sed '/^$/d') != $(echo 'WwoKXQo=' | base64 -d | tr -dc 'a-zA-Z\[\]') ]] ) && ( [[ "$currentIteration" -le "1" ]] || ( [[ "$GH_TOKEN" != "" ]] && [[ "$currentIteration" -le "3" ]] ) )
		do
			currentData_page=$(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$currentIteration")
			currentExitStatus_tmp="$?"
			[[ "$currentIteration" == "1" ]] && currentExitStatus="$currentExitStatus_tmp"
			currentData="$currentData"'
'"$currentData_page"

            ( _messagePlain_probe "_wget_githubRelease_procedure-address-curl: ""$currentIteration" >&2 ) > /dev/null
            #( _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 >&2 ) > /dev/null
            [[ "$currentIteration" -ge 4 ]] && ( _safeEcho_newline "$currentData_page" >&2 ) > /dev/null

			let currentIteration=currentIteration+1
		done

		#( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 )
		#currentExitStatus_tmp="$?"

		# ###
		for currentPart in $(seq -f "%02g" 0 "$maxCurrentPart" | sort -r)
		do
			currentAddress=$( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile".part"$currentPart" | head -n 1 )
			currentExitStatus_tmp="$?"

			[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: _curl_githubAPI_releases_page: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
			[[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: pipefail: _jq_github_browser_download_address: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"
			[[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: empty: currentData' >&2 ) > /dev/null && return 1

			[[ "$currentAddress" != "" ]] && echo "$currentPart" && return 0
		done

		
		# ### ATTENTION: No part files found is not 'skip' but FAIL .
		[[ "$currentAddress" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _curl_githubAPI_releases_join-skip: empty: _safeEcho_newline | _jq_github_browser_download_address' >&2 ) > /dev/null && return 1
		
        return 0
	fi
}
_wget_githubRelease_procedure-address-curl() {
	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	[[ "$currentFile" == "" ]] && return 1


	local currentExitStatus_tmp=0
	local currentExitStatus=0

	if [[ "$currentReleaseLabel" == "latest" ]]
	then
		local currentData
		local currentData_page
		
		#(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile")
		#return

		currentData_page=$(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		currentExitStatus="$?"

		currentData="$currentData_page"

		[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
		
		[[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: empty: currentData' >&2 ) > /dev/null && return 1

		( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 )
		currentExitStatus_tmp="$?"

		[[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: pipefail: _jq_github_browser_download_address: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"

		# ATTENTION: Part file does NOT exist upstream. Page did NOT match 'Not Found', page NOT empty, and data NOT empty, implying repo, releaseLabel , indeed EXISTS upstream.
		# Retries/wait must NOT continue in that case - calling function must detect and either fail or skip file on empty address if appropriate.
		#[[ "$(_safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 | wc -c )" -le 0 ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: empty: _safeEcho_newline | _jq_github_browser_download_address' >&2 ) > /dev/null  && return 1
		
		return 0
	else
		local currentData
		currentData=""
		
		local currentData_page
		currentData_page="doNotMatch"
		
		local currentIteration
		currentIteration=1
		
		# ATTRIBUTION-AI: Many-Chat 2025-03-23
		# Alternative detection of empty array, as suggested by AI LLM .
		#[[ $(jq 'length' <<< "$currentData_page") -gt 0 ]]
		while ( [[ "$currentData_page" != "" ]] && [[ $(_safeEcho_newline "$currentData_page" | tr -dc 'a-zA-Z\[\]' | sed '/^$/d') != $(echo 'WwoKXQo=' | base64 -d | tr -dc 'a-zA-Z\[\]') ]] ) && ( [[ "$currentIteration" -le "1" ]] || ( [[ "$GH_TOKEN" != "" ]] && [[ "$currentIteration" -le "3" ]] ) )
		do
			currentData_page=$(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$currentIteration")
			currentExitStatus_tmp="$?"
			[[ "$currentIteration" == "1" ]] && currentExitStatus="$currentExitStatus_tmp"
			currentData="$currentData"'
'"$currentData_page"

            ( _messagePlain_probe "_wget_githubRelease_procedure-address-curl: ""$currentIteration" >&2 ) > /dev/null
            #( _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 >&2 ) > /dev/null
            [[ "$currentIteration" -ge 4 ]] && ( _safeEcho_newline "$currentData_page" >&2 ) > /dev/null

			let currentIteration=currentIteration+1
		done

		( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 )
		currentExitStatus_tmp="$?"

		[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: _curl_githubAPI_releases_page: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
		[[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: pipefail: _jq_github_browser_download_address: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"
		[[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: empty: currentData' >&2 ) > /dev/null && return 1

		# ATTENTION: Part file does NOT exist upstream. Page did NOT match 'Not Found', page NOT empty, and data NOT empty, implying repo, releaseLabel , indeed EXISTS upstream.
		# Retries/wait must NOT continue in that case - calling function must detect and either fail or skip file on empty address if appropriate.
		#[[ "$(_safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 | wc -c )" -le 0 ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: empty: _safeEcho_newline | _jq_github_browser_download_address' >&2 ) > /dev/null  && return 1
		
        return 0
	fi
}
_wget_githubRelease-address-backend-curl() {
	local currentAddress
	currentAddress=""

	local currentExitStatus=1

	local currentIteration=0

	#[[ "$currentAddress" == "" ]] || 
	while ( [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		currentAddress=""

		if [[ "$currentIteration" != "0" ]]
		then
			( _messagePlain_warn 'warn: BAD: RETRY: _wget_githubRelease-URL-curl: _wget_githubRelease_procedure-address-curl: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe _wget_githubRelease_procedure-address-curl >&2 ) > /dev/null
		currentAddress=$(_wget_githubRelease_procedure-address-curl "$@")
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
	
	_safeEcho_newline "$currentAddress"

	[[ "$currentIteration" -ge "$githubRelease_retriesMax" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-URL-curl: maxRetries' >&2 ) > /dev/null && return 1

	return 0
}
_wget_githubRelease-address-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-address-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-URL-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="tagName"

    _wget_githubRelease-address-backend-curl "$@"
    return
}
_wget_githubRelease-URL-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-URL-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-URL-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="url"

	local currentAddress

	local currentExitStatus=1

    #_wget_githubRelease-address-backend-curl "$@"
	currentAddress=$(_wget_githubRelease-address-backend-curl "$@")
	currentExitStatus="$?"
	
	_safeEcho_newline "$currentAddress"

	[[ "$currentAddress" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-URL-curl: empty: currentAddress' >&2 ) > /dev/null && return 1

    return "$currentExitStatus"
}

# Calling functions MUST attempt download unless skip function conclusively determines BOTH that releaseLabel exists in upstream repo, AND file does NOT exist upstream. Functions may use such skip to skip high-numbered part files that do not exist.
_wget_githubRelease-skip-URL-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-skip-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-skip-URL-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-skip-URL-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="url"

	local currentAddress

	local currentExitStatus=1

    #_wget_githubRelease-address-backend-curl "$@"
	currentAddress=$(_wget_githubRelease-address-backend-curl "$@")
	currentExitStatus="$?"
	
	( _safeEcho_newline "$currentAddress" >&2 ) > /dev/null
	[[ "$currentExitStatus" != "0" ]] && return "$currentExitStatus"

	if [[ "$currentAddress" == "" ]]
	then
		echo skip
		( _messagePlain_good 'good: _wget_githubRelease-skip-URL-curl: empty: currentAddress: PRESUME skip' >&2 ) > /dev/null
		return 0
	fi

	if [[ "$currentAddress" != "" ]]
	then
		echo download
		( _messagePlain_good 'good: _wget_githubRelease-skip-URL-curl: found: currentAddress: PRESUME download' >&2 ) > /dev/null
		return 0
	fi

	return 1
}
_wget_githubRelease-detect-URL-curl() {
	_wget_githubRelease-skip-URL-curl "$@"
}

# WARNING: May be untested.
_wget_githubRelease-API_URL-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-API_URL-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-API_URL-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="api_url"

	local currentAddress

	local currentExitStatus=1

    #_wget_githubRelease-address-backend-curl "$@"
	currentAddress=$(_wget_githubRelease-address-backend-curl "$@")
	currentExitStatus="$?"
	
	_safeEcho_newline "$currentAddress"

	[[ "$currentAddress" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-API_URL-curl: empty: currentAddress' >&2 ) > /dev/null && return 1

    return "$currentExitStatus"
}

# WARNING: May be untested.
# Calling functions MUST attempt download unless skip function conclusively determines BOTH that releaseLabel exists in upstream repo, AND file does NOT exist upstream. Functions may use such skip to skip high-numbered part files that do not exist.
_wget_githubRelease-skip-API_URL-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-skip-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-skip-API_URL-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="api_url"

	local currentAddress

	local currentExitStatus=1

    #_wget_githubRelease-address-backend-curl "$@"
	currentAddress=$(_wget_githubRelease-address-backend-curl "$@")
	currentExitStatus="$?"
	
	( _safeEcho_newline "$currentAddress" >&2 ) > /dev/null
	[[ "$currentExitStatus" != "0" ]] && return "$currentExitStatus"

	if [[ "$currentAddress" == "" ]]
	then
		echo skip
		( _messagePlain_good 'good: _wget_githubRelease-skip-API_URL-curl: empty: currentAddress: PRESUME skip' >&2 ) > /dev/null
		return 0
	fi

	if [[ "$currentAddress" != "" ]]
	then
		echo download
		( _messagePlain_good 'good: _wget_githubRelease-skip-API_URL-curl: found: currentAddress: PRESUME download' >&2 ) > /dev/null
		return 0
	fi

	return 1
}
_wget_githubRelease-detect-API_URL-curl() {
	_wget_githubRelease-skip-API_URL-curl "$@"
}

_wget_githubRelease_procedure-address-gh-awk() {
	#( _messagePlain_probe 'init: _wget_githubRelease_procedure-address-gh-awk' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease_procedure-address-gh-awk "$@" >&2 ) > /dev/null
    local currentReleaseLabel="$2"
    #( _messagePlain_probe_var currentReleaseLabel >&2 ) > /dev/null
    
    # WARNING: Use of complex 'awk' scripts historically has seemed less resilient, less portable, less reliable.
    # ATTRIBUTION-AI: ChatGPT o1 2025-01-22 , 2025-01-27 .
	if [[ "$currentReleaseLabel" == "latest" ]]
	then
		#gh release list -L 1
		# In theory, simply accepting single line output from gh release list (ie. -L 1) should provide the same result (in case this awk script ever breaks).
		awk '
			# Skip a header line if it appears first:
			NR == 1 && $1 == "TITLE" && $2 == "TYPE" {
				# Just move on to the next line and do nothing else
				next
			}
			
			# The real match: find the line whose second column is "Latest"
			$2 == "Latest" {
				# Print the third column (TAG NAME) and exit
				print $3
				exit
			}
		'
	else
		awk -v label="$currentReleaseLabel" '
		# For each line where the first column equals the label we are looking for...
		$1 == label {
			# If the second column is one of the known “types,” shift fields left so
			# the *real* tag moves into $2. Repeat until no more known types remain.
			while ($2 == "Latest" || $2 == "draft" || $2 == "pre-release" || $2 == "prerelease") {
			for (i=2; i<NF; i++) {
				$i = $(i+1)
			}
			NF--
			}
			# At this point, $2 is guaranteed to be the actual tag.
			print $2
		}
		'
	fi
}
# Requires "$GH_TOKEN" .
_wget_githubRelease_procedure-address-gh() {
	( _messagePlain_nominal "$currentStream"'\/\/\/ init: _wget_githubRelease_procedure-address-gh' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease_procedure-address-gh "$@" >&2 ) > /dev/null
    ! _if_gh && return 1
	
	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	[[ "$currentFile" == "" ]] && return 1

    local currentTag

	local currentExitStatus=0
	local currentExitStatus_tmp=0

    local currentIteration
    currentIteration=1

    while [[ "$currentTag" == "" ]] && ( [[ "$currentIteration" -le "1" ]] || ( [[ "$GH_TOKEN" != "" ]] && [[ "$currentIteration" -le "3" ]] ) )
    do
        #currentTag=$(gh release list -L 100 -R "$currentAbsoluteRepo" | sed 's/Latest//' | grep '^'"$currentReleaseLabel" | awk '{ print $2 }' | head -n 1)
        
        currentTag=$(set -o pipefail ; gh release list -L $(( $currentIteration * 100 )) -R "$currentAbsoluteRepo" | _wget_githubRelease_procedure-address-gh-awk "" "$currentReleaseLabel" "" | head -n 1)    # or pick whichever match you want
        currentExitStatus_tmp="$?"
		[[ "$currentIteration" == "1" ]] && currentExitStatus="$currentExitStatus_tmp"
		
        let currentIteration++
    done

    _safeEcho_newline "$currentTag"
    #_safeEcho_newline "https://github.com/""$currentAbsoluteRepo""/releases/download/""$currentTag""/""$currentFile"

	[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-gh: pipefail: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
    [[ "$currentTag" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-gh: empty: currentTag' >&2 ) > /dev/null && return 1

    return 0
}
_wget_githubRelease-address-gh() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-address-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-address-gh' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-address-gh "$@" >&2 ) > /dev/null
    ! _if_gh && return 1

	#local currentURL
	#currentURL=""
	local currentTag
	currentTag=""

	local currentExitStatus=1

	local currentIteration=0

	#while ( [[ "$currentURL" == "" ]] || [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	while ( [[ "$currentTag" == "" ]] || [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		#currentURL=""
		currentTag=""

		if [[ "$currentIteration" != "0" ]]
		then 
			( _messagePlain_warn 'warn: BAD: RETRY: _wget_githubRelease-address-gh: _wget_githubRelease_procedure-address-gh: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe _wget_githubRelease_procedure-address-gh >&2 ) > /dev/null
		#currentURL=$(_wget_githubRelease_procedure-address-gh "$@")
		currentTag=$(_wget_githubRelease_procedure-address-gh "$@")
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
	
	#_safeEcho_newline "$currentURL"
	_safeEcho_newline "$currentTag"

	[[ "$currentIteration" -ge "$githubRelease_retriesMax" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-address-gh: maxRetries' >&2 ) > /dev/null && return 1

	return 0
}
_wget_githubRelease-URL-gh() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-URL-gh' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-URL-gh "$@" >&2 ) > /dev/null
    ! _if_gh && return 1
	
	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	[[ "$currentFile" == "" ]] && return 1

    local currentTag

	local currentExitStatus=1

	currentTag=$(_wget_githubRelease-address-gh "$@")
	currentExitStatus="$?"
	

	#echo "$currentTag"
    _safeEcho_newline "https://github.com/""$currentAbsoluteRepo""/releases/download/""$currentTag""/""$currentFile"

	[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-URL-gh: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
	[[ "$currentTag" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-URL-gh: empty: currentTag' >&2 ) > /dev/null && return 1
	
	return 0
}





# _gh_download "$currentAbsoluteRepo" "$currentTagName" "$currentFile" -O "$currentOutFile"
# Requires "$GH_TOKEN" .
_gh_download() {
	# Similar retry logic for all similar functions: _gh_download , _wget_githubRelease_loop-curl .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ init: _gh_download' >&2 ) > /dev/null
	
	! _if_gh && return 1
	
	local currentAbsoluteRepo="$1"
	local currentTagName="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFileParameter="$5"

	local currentOutFile="$currentFile"

	shift
	shift
	shift
	[[ "$currentOutParameter" == "--output" ]] && currentOutParameter="-O"
	[[ "$currentOutParameter" == "-O" ]] && currentOutFile="$currentOutFileParameter" && shift && shift

	[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && _messagePlain_bad 'bad: fail: unexpected: unspecified: currentOutFile' && return 1

	#[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1
	[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"

	# CAUTION: Assumed 'false' by 'rotten' !
	# (ie. 'rotten' does NOT support Cygwin/MSW)
	local currentOutFile_translated_cygwinMSW=""
	( _if_cygwin && type -p cygpath > /dev/null 2>&1 ) && ( [[ "$currentOutFile" != "" ]] && [[ "$currentOutFile" != "-" ]] ) && currentOutFile_translated_cygwinMSW=$(cygpath -w $(_getAbsoluteLocation "$currentOutFile"))

	local currentExitStatus=1

	local currentIteration
	currentIteration=0
	# && ( [[ "$currentIteration" != "0" ]] && sleep "$githubRelease_retriesWait" )
	while ( [[ "$currentExitStatus" != "0" ]] || ( ! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] ) ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		if [[ "$currentIteration" != "0" ]]
		then 
			( _messagePlain_warn 'warn: BAD: RETRY: _gh_download: gh release download: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		# CAUTION: Assumed 'false' by 'rotten' !
		# (ie. 'rotten' does NOT support Cygwin/MSW)
		if [[ "$currentOutFile_translated_cygwinMSW" != "" ]]
		then
			# WARNING: Apparently, 'gh release download' will throw an error with filename '/cygdrive'...'.m_axelTmp__'"$(_uid14)" .
			( _messagePlain_probe_safe gh release download --clobber "$currentTagName" -R "$currentAbsoluteRepo" -p "$currentFile" -O "$currentOutFile_translated_cygwinMSW" "$@" >&2 ) > /dev/null
			( set -o pipefail ; gh release download --clobber "$currentTagName" -R "$currentAbsoluteRepo" -p "$currentFile" -O "$currentOutFile_translated_cygwinMSW" "$@" 2> >(tail -n 30 >&2) )
			currentExitStatus="$?"
		else
			( _messagePlain_probe_safe gh release download --clobber "$currentTagName" -R "$currentAbsoluteRepo" -p "$currentFile" -O "$currentOutFile" "$@" >&2 ) > /dev/null
			( set -o pipefail ; gh release download --clobber "$currentTagName" -R "$currentAbsoluteRepo" -p "$currentFile" -O "$currentOutFile" "$@" 2> >(tail -n 30 >&2) )
			currentExitStatus="$?"
		fi

		let currentIteration=currentIteration+1
	done
	
	[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _gh_download: gh release download: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
	! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && ( _messagePlain_bad 'bad: FAIL: missing: currentOutFile' >&2 ) > /dev/null && return 1

	return 0
}
#_gh_downloadURL "https://github.com/""$currentAbsoluteRepo""/releases/download/""$currentTagName""/""$currentFile" "$currentOutFile"
# Requires "$GH_TOKEN" .
_gh_downloadURL() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ init: _gh_downloadURL' >&2 ) > /dev/null
	
	! _if_gh && return 1

	# ATTRIBUTION-AI: ChatGPT GPT-4 2023-11-04 ... refactored 2025-01-22 ... .

	local currentURL="$1"
	local currentOutParameter="$2"
	local currentOutFileParameter="$3"

	[[ "$currentURL" == "" ]] && return 1

	# Use `sed` to extract the parts of the URL
	local currentAbsoluteRepo=$(echo "$currentURL" | sed -n 's|https://github.com/\([^/]*\)/\([^/]*\)/.*|\1/\2|p')
	[[ "$?" != "0" ]] && return 1
	local currentTagName=$(echo "$currentURL" | sed -n 's|https://github.com/[^/]*/[^/]*/releases/download/\([^/]*\)/.*|\1|p')
	[[ "$?" != "0" ]] && return 1
	local currentFile=$(echo "$currentURL" | sed -n 's|https://github.com/[^/]*/[^/]*/releases/download/[^/]*/\(.*\)|\1|p')
	[[ "$?" != "0" ]] && return 1

	local currentOutFile="$currentFile"

	shift
	[[ "$currentOutParameter" == "--output" ]] && currentOutParameter="-O"
	[[ "$currentOutParameter" == "-O" ]] && currentOutFile="$currentOutFileParameter" && shift && shift

	[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && _messagePlain_bad 'bad: fail: unexpected: unspecified: currentOutFile' && return 1

	#[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile"
	##[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"

	local currentExitStatus=1
	#currentExitStatus=1

	#local currentIteration
	#currentIteration=0
	# && ( [[ "$currentIteration" != "0" ]] && sleep "$githubRelease_retriesWait" )
	#while ( [[ "$currentExitStatus" != "0" ]] || ( ! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] ) ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	#do
		#if [[ "$currentIteration" != "0" ]]
		#then 
			#( _messagePlain_warn 'warn: BAD: RETRY: _gh_downloadURL: _gh_download: currentIteration != 0' >&2 ) > /dev/null
			#sleep "$githubRelease_retriesWait"
		#fi

		# CAUTION: Do NOT translate file parameter (ie. for Cygwin/MSW) for an underlying backend function (ie. '_gh_download') - that will be done by underlying backend function if at all. Similarly, also do NOT state '--clobber' or similar parameters to backend function.
		#[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile"
		##[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"
		( _messagePlain_probe_safe _gh_download "$currentAbsoluteRepo" "$currentTagName" "$currentFile" -O "$currentOutFile" "$@" >&2 ) > /dev/null
		_gh_download "$currentAbsoluteRepo" "$currentTagName" "$currentFile" -O "$currentOutFile" "$@"
		currentExitStatus="$?"

		#let currentIteration=currentIteration+1
	#done

	[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _gh_downloadURL: _gh_download: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
	! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && ( _messagePlain_bad 'bad: FAIL: missing: currentOutFile' >&2 ) > /dev/null && return 1

	return 0
}






#_wget_githubRelease-stdout

#_wget_githubRelease



_wget_githubRelease-stdout() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/\/ init: _wget_githubRelease-stdout' >&2 ) > /dev/null
	local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"
	
	local currentExitStatus

	# WARNING: Very strongly discouraged. Any retry/continue of any interruption will nevertheless unavoidably result in a corrupted output stream.
	[[ "$FORCE_DIRECT" == "true" ]] && _wget_githubRelease_procedure-stdout "$@"

	# ATTENTION: /dev/null assures that stdout is not corrupted by any unexpected output that should have been sent to stderr
	[[ "$FORCE_DIRECT" != "true" ]] && _wget_githubRelease_procedure-stdout "$@" > /dev/null

	if ! [[ -e "$currentAxelTmpFile".PASS ]]
	then
		currentExitStatus=$(cat "$currentAxelTmpFile".FAIL)
		( [[ "$currentExitStatus" == "" ]] || [[ "$currentExitStatus" = "0" ]] || [[ "$currentExitStatus" = "0"* ]] ) && currentExitStatus=1
		#rm -f "$currentAxelTmpFile".PASS > /dev/null 2>&1
		_destroy_lock "$currentAxelTmpFile".PASS
		#rm -f "$currentAxelTmpFile".FAIL > /dev/null 2>&1
		_destroy_lock "$currentAxelTmpFile".FAIL
		#rm -f "$currentAxelTmpFile" > /dev/null 2>&1
		_destroy_lock "$currentAxelTmpFile"
		return "$currentExitStatus"
		#return 1
	fi
	[[ "$FORCE_DIRECT" != "true" ]] && cat "$currentAxelTmpFile"
	#rm -f "$currentAxelTmpFile" > /dev/null 2>&1
	_destroy_lock "$currentAxelTmpFile"
	#rm -f "$currentAxelTmpFile".PASS > /dev/null 2>&1
	_destroy_lock "$currentAxelTmpFile".PASS
	#rm -f "$currentAxelTmpFile".FAIL > /dev/null 2>&1
	_destroy_lock "$currentAxelTmpFile".FAIL
	return 0
}
_wget_githubRelease_procedure-stdout() {
	( _messagePlain_probe_safe _wget_githubRelease_procedure-stdout "$@" >&2 ) > /dev/null

	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi

	#local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	#local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"

	local currentExitStatus

	# WARNING: Very strongly discouraged. Any retry/continue of any interruption will nevertheless unavoidably result in a corrupted output stream.
	if [[ "$FORCE_DIRECT" == "true" ]]
	then
		_wget_githubRelease_procedure "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" -O - "$@"
		currentExitStatus="$?"
		if [[ "$currentExitStatus" != "0" ]]
		then
			echo > "$currentAxelTmpFile".FAIL
			return "$currentExitStatus"
		fi
		echo > "$currentAxelTmpFile".PASS
		return 0
	fi

	_wget_githubRelease_procedure "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" -O "$currentAxelTmpFile" "$@"
	currentExitStatus="$?"
	if [[ "$currentExitStatus" != "0" ]]
	then
		echo "$currentExitStatus" > "$currentAxelTmpFile".FAIL
		return "$currentExitStatus"
	fi
	echo > "$currentAxelTmpFile".PASS
	return 0
}





#! "$scriptAbsoluteLocation" _wget_githubRelease_join "owner/repo" "internal" "file.ext" -O "file.ext"
#! _wget_githubRelease "owner/repo" "" "file.ext" -O "file.ext"
# ATTENTION: WARNING: Warn messages correspond to inability to assuredly, effectively, use GH_TOKEN .
_wget_githubRelease() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/\/ init: _wget_githubRelease' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease "$@" >&2 ) > /dev/null

	_wget_githubRelease_procedure "$@"
}
_wget_githubRelease_internal() {
	_wget_githubRelease "$1" "internal" "$2"
}
_wget_githubRelease_procedure() {
	# ATTENTION: Distinction nominally between '_wget_githubRelease' and '_wget_githubRelease_procedure' should only be necessary if a while loop retries the procedure .
	# ATTENTION: Potentially more specialized logic within download procedures should remain delegated with the responsibility to attempt retries , for now.
	# NOTICE: Several functions should already have retry logic: '_gh_download' , '_gh_downloadURL' , '_wget_githubRelease-address' , '_wget_githubRelease_procedure-curl' , '_wget_githubRelease-URL-curl' , etc .
	#( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/ init: _wget_githubRelease_procedure' >&2 ) > /dev/null
	#( _messagePlain_probe_safe _wget_githubRelease_procedure "$@" >&2 ) > /dev/null

    local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	[[ "$currentOutParameter" != "-O" ]] && currentOutFile="$currentFile"
	#[[ "$currentOutParameter" == "-O" ]] && currentOutFile="$currentOutFile"

	#[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && currentOutFile="$currentFile"
	[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && ( _messagePlain_bad 'bad: fail: unexpected: unspecified: currentOutFile' >&2 ) > /dev/null && return 1

	#[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1
	[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"

    local currentExitStatus=1

    # Discouraged .
    if [[ "$FORCE_WGET" == "true" ]]
    then
		local currentURL_typeSelected=""
        _warn_githubRelease_FORCE_WGET
        #local currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		local currentURL
		[[ "$GH_TOKEN" != "" ]] && currentURL_typeSelected="api_url" && currentURL=$(_wget_githubRelease-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		[[ "$GH_TOKEN" == "" ]] && currentURL_typeSelected="url" && currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")

        #"$GH_TOKEN"
        #"$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$currentOutFile"
        #_wget_githubRelease_procedure-curl
		_wget_githubRelease_loop-curl
        return "$?"
    fi

	# Discouraged . Benefits of multi-part-per-file downloading are less essential given that files are split into <2GB chunks.
	if [[ "$FORCE_AXEL" != "" ]] # && [[ "$MANDATORY_HASH" == "true" ]]
    then
		local currentURL_typeSelected=""
        ( _messagePlain_warn 'warn: WARNING: FORCE_AXEL not empty' >&2 ; echo 'FORCE_AXEL may have similar effects to FORCE_WGET and should not be necessary.' >&2  ) > /dev/null
        #local currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		local currentURL
		[[ "$GH_TOKEN" != "" ]] && currentURL_typeSelected="api_url" && currentURL=$(_wget_githubRelease-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		[[ "$GH_TOKEN" == "" ]] && currentURL_typeSelected="url" && currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")

		[[ "$FORCE_DIRECT" == "true" ]] && ( _messagePlain_bad 'bad: fail: FORCE_AXEL==true is NOT compatible with FORCE_DIRECT==true' >&2 ) > /dev/null && return 1

        #"$GH_TOKEN"
        #"$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$currentOutFile"
        #_wget_githubRelease_procedure-axel
		_wget_githubRelease_loop-axel
        return "$?"
    fi

    if _if_gh
    then
        #_wget_githubRelease-address-gh
        local currentTag=$(_wget_githubRelease-address "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")

        ( _messagePlain_probe _gh_download "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$@" >&2 ) > /dev/null
        _gh_download "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$@"
        currentExitStatus="$?"

        [[ "$currentExitStatus" != "0" ]] && _bad_fail_githubRelease_currentExitStatus && return "$currentExitStatus"
        [[ ! -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && _bad_fail_githubRelease_missing && return 1
        return 0
    fi

    if ! _if_gh
    then
		local currentURL_typeSelected=""
        ( _messagePlain_warn 'warn: WARNING: FALLBACK: wget/curl' >&2 ) > /dev/null
        #local currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		local currentURL
		[[ "$GH_TOKEN" != "" ]] && currentURL_typeSelected="api_url" && currentURL=$(_wget_githubRelease-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
		[[ "$GH_TOKEN" == "" ]] && currentURL_typeSelected="url" && currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")

        #"$GH_TOKEN"
        #"$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$currentOutFile"
        #_wget_githubRelease_procedure-curl
		_wget_githubRelease_loop-curl
        return "$?"
    fi
    
    return 1
}
_wget_githubRelease_procedure-curl() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/ init: _wget_githubRelease_procedure-curl' >&2 ) > /dev/null
    ( _messagePlain_probe_safe "currentURL= ""$currentURL" >&2 ) > /dev/null
    ( _messagePlain_probe_safe "currentOutFile= ""$currentOutFile" >&2 ) > /dev/null

	# ATTENTION: Better if the loop does this only once. Resume may be possible.
	##[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1
	#[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"

    local current_curl_args
	current_curl_args=()
	[[ "$GH_TOKEN" != "" ]] && current_curl_args+=( -H "Authorization: Bearer $GH_TOKEN" )
	current_curl_args+=( -H "Accept: application/octet-stream" )
	current_curl_args+=( -S )
	current_curl_args+=( -s )
	#current_curl_args+=( --clobber )
	current_curl_args+=( --continue-at - )

    local currentFailParam="$1"
    [[ "$currentFailParam" != "--no-fail" ]] && currentFailParam="--fail"
	current_curl_args+=( "$currentFailParam" )
	shift
	# ATTENTION: Usually '_wget_githubRelease_procedure-curl' is used ONLY through '_wget_githubRelease_loop-curl' - the total timeout is similar but the latency is much safer.
	# CAUTION: Discouraged unless proven necessary. Causes delays and latency beyond "$githubRelease_retriesWait"*"$githubRelease_retriesMax" , possibly exceeding prebuffering on a single error.
	#--retry 5 --retry-delay 90 --connect-timeout 45 --max-time 600
	#_set_curl_github_retry
	#"${curl_retries_args[@]}"
	current_curl_args+=( "$@" )
	
	local currentExitStatus_ipv4=1
	local currentExitStatus_ipv6=1

	( _messagePlain_probe '_wget_githubRelease_procedure-curl: IPv6 (false)' >&2 ) > /dev/null
	# ATTENTION: IPv6 is NOT offered by GitHub API, and so usually only wastes time at best.
	#curl -6 "${current_curl_args[@]}" -L -o "$currentOutFile" "$currentURL"
	false
	# WARNING: May be untested.
	#( set -o pipefail ; curl -6 "${current_curl_args[@]}" -L -o "$currentOutFile" "$currentURL" 2> >(tail -n 30 >&2) )
	currentExitStatus_ipv6="$?"
	if [[ "$currentExitStatus_ipv6" != "0" ]]
	then
		( _messagePlain_probe '_wget_githubRelease_procedure-curl: IPv4' >&2 ) > /dev/null
		curl -4 "${current_curl_args[@]}" -L -o "$currentOutFile" "$currentURL"
		# WARNING: May be untested.
		#( set -o pipefail ; curl -4 "${current_curl_args[@]}" -L -o "$currentOutFile" "$currentURL" 2> >(tail -n 30 >&2) )
		currentExitStatus_ipv4="$?"
	fi

	if [[ "$currentExitStatus_ipv6" != "0" ]] && [[ "$currentExitStatus_ipv4" != "0" ]]
	then
		#( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-curl' >&2 ) > /dev/null
        _bad_fail_githubRelease_currentExitStatus
		[[ "$currentExitStatus_ipv4" != "1" ]] && [[ "$currentExitStatus_ipv4" != "0" ]] && return "$currentExitStatus_ipv4"
		[[ "$currentExitStatus_ipv6" != "1" ]] && [[ "$currentExitStatus_ipv6" != "0" ]] && return "$currentExitStatus_ipv6"
		return "$currentExitStatus_ipv4"
	fi

    [[ ! -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && _bad_fail_githubRelease_missing && return 1

    return 0
}
_wget_githubRelease_loop-curl() {
	# Similar retry logic for all similar functions: _gh_download , _wget_githubRelease_loop-curl .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/ init: _wget_githubRelease_loop-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease_loop-curl "$@" >&2 ) > /dev/null

	#[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1
	[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"

	local currentExitStatus=1

	local currentIteration=0

	while ( [[ "$currentExitStatus" != "0" ]] || ( ! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] ) ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		if [[ "$currentIteration" != "0" ]]
		then 
			( _messagePlain_warn 'warn: BAD: RETRY: _wget_githubRelease_procedure-curl: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe_safe _wget_githubRelease_procedure-curl >&2 ) > /dev/null
		_wget_githubRelease_procedure-curl
		# WARNING: May be untested.
		#( set -o pipefail ; _wget_githubRelease_procedure-curl 2> >(tail -n 100 >&2) )
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
	
	[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_loop-curl: _wget_githubRelease_procedure-curl: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
	! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && ( _messagePlain_bad 'bad: FAIL: missing: currentOutFile' >&2 ) > /dev/null && return 1

	return 0
}
_wget_githubRelease_procedure-axel() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/ init: _wget_githubRelease_procedure-axel' >&2 ) > /dev/null
    ( _messagePlain_probe_safe "currentURL= ""$currentURL" >&2 ) > /dev/null
    ( _messagePlain_probe_safe "currentOutFile= ""$currentOutFile" >&2 ) > /dev/null

    # ATTENTION: Quirk of aria2c , default dir is "$PWD" , is prepended to absolute paths , and the resulting '//' does not direct the absolute path to root.
    local currentOutFile_relative=$(basename "$currentOutFile")
    local currentOutDir=$(_getAbsoluteFolder "$currentOutFile")
    ( _messagePlain_probe_safe "currentOutFile_relative= ""$currentOutFile_relative" >&2 ) > /dev/null
    ( _messagePlain_probe_safe "currentOutDir= ""$currentOutFile" >&2 ) > /dev/null

    ( _messagePlain_probe_safe "FORCE_AXEL= ""$FORCE_AXEL" >&2 ) > /dev/null

	# ATTENTION: Better if the loop does this only once. Resume may be possible.
	##[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1
	#[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"

	#aria2c --timeout=180 --max-tries=25 --retry-wait=15 "$@"
    ##_messagePlain_probe _aria2c_bin_githubRelease -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=false "${currentURL_array_reversed[$currentIteration]}" >&2
    ##_aria2c_bin_githubRelease --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=false "${currentURL_array_reversed[$currentIteration]}" | grep --color -i -E "Name resolution|$" >&2 &
    ##messagePlain_probe _aria2c_bin_githubRelease -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=true "${currentURL_array_reversed[$currentIterationNext1]}" >&2
    ##_aria2c_bin_githubRelease --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=true "${currentURL_array_reversed[$currentIterationNext1]}" | grep --color -i -E "Name resolution|$" >&2 &
    local current_axel_args
	current_axel_args=()
	##[[ "$GH_TOKEN" != "" ]] && current_axel_args+=( -H "Authorization: Bearer $GH_TOKEN" )
	[[ "$GH_TOKEN" != "" ]] && current_axel_args+=( --header="Authorization: token $GH_TOKEN" )
	current_axel_args+=( --header="Accept: application/octet-stream" )
	#current_axel_args+=( --quiet=true )
	#current_axel_args+=( --timeout=180 --max-tries=25 --retry-wait=15 )
    current_axel_args+=( --stderr=true --summary-interval=0 --console-log-level=error --async-dns=false )
    [[ "$FORCE_AXEL" != "" ]] && current_axel_args+=( -x "$FORCE_AXEL" )
	
	local currentExitStatus_ipv4=1
	local currentExitStatus_ipv6=1

	#( _messagePlain_probe '_wget_githubRelease_procedure-axel: IPv6' >&2 ) > /dev/null
	( _messagePlain_probe '_wget_githubRelease_procedure-axel: IPv6 (false)' >&2 ) > /dev/null
    #( _messagePlain_probe_safe aria2c --disable-ipv6=false "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL" >&2 ) > /dev/null
	##aria2c --disable-ipv6=false "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL"
	## WARNING: May be untested.
	##( set -o pipefail ; aria2c --disable-ipv6=false "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL" 2> >(tail -n 40 >&2) )
	#( set -o pipefail ; aria2c --disable-ipv6=false "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL" > "$currentOutFile".log 2>&1 )
	#currentExitStatus_ipv6="$?"
	#( tail -n 40 "$currentOutFile".log >&2 )
	#rm -f "$currentOutFile".log > /dev/null 2>&1
	false
    if [[ "$currentExitStatus_ipv6" != "0" ]]
    then
        ( _messagePlain_probe '_wget_githubRelease_procedure-axel: IPv4' >&2 ) > /dev/null
        ( _messagePlain_probe_safe aria2c --disable-ipv6=true "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL" >&2 ) > /dev/null
        #aria2c --disable-ipv6=true "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL"
        #( set -o pipefail ; aria2c --disable-ipv6=true "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL" 2> >(tail -n 40 >&2) )
		( set -o pipefail ; aria2c --disable-ipv6=true "${current_axel_args[@]}" -d "$currentOutDir" -o "$currentOutFile_relative" "$currentURL" > "$currentOutFile".log 2>&1 )
        currentExitStatus_ipv4="$?"
		( tail -n 40 "$currentOutFile".log >&2 )
		rm -f "$currentOutFile".log > /dev/null 2>&1
    fi

	if [[ "$currentExitStatus_ipv6" != "0" ]] && [[ "$currentExitStatus_ipv4" != "0" ]]
	then
		#( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-axel' >&2 ) > /dev/null
        _bad_fail_githubRelease_currentExitStatus
		[[ "$currentExitStatus_ipv4" != "1" ]] && [[ "$currentExitStatus_ipv4" != "0" ]] && return "$currentExitStatus_ipv4"
		[[ "$currentExitStatus_ipv6" != "1" ]] && [[ "$currentExitStatus_ipv6" != "0" ]] && return "$currentExitStatus_ipv6"
		return "$currentExitStatus_ipv4"
	fi

    [[ ! -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && _bad_fail_githubRelease_missing && return 1

	# WARNING: Partial download is FAIL, but aria2c may set exit status '0' (ie. true). Return FALSE in this case.
	#if ls -1 "$scriptAbsoluteFolder"/$(_axelTmp).aria2* > /dev/null 2>&1
	#if ls -1 "$currentAxelTmpFile".aria2* > /dev/null 2>&1
	#if ls -1 "$scriptAbsoluteFolder"/.m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID".aria2* > /dev/null 2>&1
	if ls -1 "$currentOutFile".aria2* > /dev/null 2>&1
	then
		return 1
	fi

	# Disabled (commented out). Contradictory state of PASS with part files remaining should terminate script with FAIL , _stop , exit , etc .
	# ie.
	##  _messagePlain_bad 'bad: FAIL: currentAxelTmpFile*: EXISTS !'
	##  _messageError 'FAIL'
	##_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).part*
	#_destroy_lock "$scriptAbsoluteFolder"/.m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID".part*
	##_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).aria2*
	#_destroy_lock "$scriptAbsoluteFolder"/.m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID".aria2*

    return 0
}
_wget_githubRelease_loop-axel() {
	# Similar retry logic for all similar functions: _gh_download , _wget_githubRelease_loop-axel .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/ init: _wget_githubRelease_loop-axel' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease_loop-axel "$@" >&2 ) > /dev/null

	#[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1
	[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"

	local currentExitStatus=1

	local currentIteration=0

	while ( [[ "$currentExitStatus" != "0" ]] || ( ! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] ) ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		if [[ "$currentIteration" != "0" ]]
		then 
			( _messagePlain_warn 'warn: BAD: RETRY: _wget_githubRelease_procedure-axel: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe_safe _wget_githubRelease_procedure-axel >&2 ) > /dev/null
		_wget_githubRelease_procedure-axel
		# WARNING: May be untested.
		#( set -o pipefail ; _wget_githubRelease_procedure-axel 2> >(tail -n 100 >&2) )
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
	
	[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_loop-axel: _wget_githubRelease_procedure-axel: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
	! [[ -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && ( _messagePlain_bad 'bad: FAIL: missing: currentOutFile' >&2 ) > /dev/null && return 1

	return 0
}















_wget_githubRelease_join() {
    local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	[[ "$currentOutParameter" != "-O" ]] && currentOutFile="$currentFile"
	#[[ "$currentOutParameter" == "-O" ]] && currentOutFile="$currentOutFile"

	#[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && currentOutFile="$currentFile"
	[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && ( _messagePlain_bad 'bad: fail: unexpected: unspecified: currentOutFile' >&2 ) > /dev/null && return 1

	if [[ "$currentOutParameter" == "-O" ]]
	then
		shift
		shift
	fi

	#[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1
	[[ "$currentOutFile" != "-" ]] && _destroy_lock "$currentOutFile"


	# ATTENTION
	currentFile=$(basename "$currentFile")




	( _messagePlain_probe_safe _wget_githubRelease_join "$@" >&2 ) > /dev/null

	_messagePlain_probe_safe _wget_githubRelease_join-stdout "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$@" '>' "$currentOutFile" >&2
	_wget_githubRelease_join-stdout "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$@" > "$currentOutFile"

	[[ ! -e "$currentOutFile" ]] && _messagePlain_bad 'missing: '"$1"' '"$2"' '"$3" && return 1

	return 0
}




_wget_githubRelease_join-stdout() {
	"$scriptAbsoluteLocation" _wget_githubRelease_join_sequence-stdout "$@"
}
_wget_githubRelease_join_sequence-stdout() {
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/\/ init: _wget_githubRelease_join-stdout' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease_join-stdout "$@" >&2 ) > /dev/null

	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			#echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi


    _set_wget_githubRelease "$@"


    local currentPart
    local currentSkip
    local currentStream
	local currentStream_wait
	local currentBusyStatus

	# CAUTION: Any greater than 50 is not expected to serve any purpose, may exhaust expected API rate limits, may greatly delay download, and may disrupt subsequent API requests. Any less than 50 may fall below the ~100GB capacity that is both expected necessary for some complete toolchains and at the limit of ~100GB archival quality optical disc (ie. M-Disc) .
	#local maxCurrentPart=50

	# ATTENTION: Graceful degradation to a maximum part count of 49 can be achieved by reducing API calls using the _curl_githubAPI_releases_join-skip function. That single API call can get 100 results, leaving 49 unused API calls remaining to get API_URL addresses to download 49 parts. Files larger than ~200GB are likely rare, specialized.
	#local maxCurrentPart=98

	# ATTENTION: In practice, 128GB storage media - reputable brand BD-XL near-archival quality optical disc, SSDs, etc - is the maximum file size that is convenient.
	# '1997537280' bytes truncate/tail
	# https://en.wikipedia.org/wiki/Blu-ray
	#  '128,001,769,472' ... 'Bytes'
	# https://fy.chalmers.se/~appro/linux/DVD+RW/Blu-ray/
	#  'only inner spare area of 256MB'
	local maxCurrentPart=63


    local currentExitStatus=1



    (( [[ "$FORCE_BUFFER" == "true" ]] && [[ "$FORCE_DIRECT" == "true" ]] ) || ( [[ "$FORCE_BUFFER" == "false" ]] && [[ "$FORCE_DIRECT" == "false" ]] )) && ( _messagePlain_bad 'bad: fail: FORCE_BUFFER , FORCE_DIRECT: conflict' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1

	[[ "$FORCE_PARALLEL" == "1" ]] && ( _messagePlain_bad 'bad: fail: FORCE_PARALLEL: sanity' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
	[[ "$FORCE_PARALLEL" == "0" ]] && ( _messagePlain_bad 'bad: fail: FORCE_PARALLEL: sanity' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
    
    [[ "$FORCE_AXEL" != "" ]] && [[ "$FORCE_DIRECT" == "true" ]] && ( _messagePlain_bad 'bad: fail: FORCE_AXEL is NOT compatible with FORCE_DIRECT==true' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1

    [[ "$FORCE_AXEL" != "" ]] && ( _messagePlain_warn 'warn: WARNING: FORCE_AXEL not empty' >&2 ; echo 'FORCE_AXEL may have similar effects to FORCE_WGET and should not be necessary.' >&2  ) > /dev/null



    _if_buffer() {
        if ( [[ "$FORCE_BUFFER" == "true" ]] || [[ "$FORCE_DIRECT" == "false" ]] ) || [[ "$FORCE_BUFFER" == "" ]]
        then
            true
            return
        else
            false
            return
        fi
        true
        return
    }


    
    # WARNING: FORCE_DIRECT="true" , "FORCE_BUFFER="false" very strongly discouraged. Any retry/continue of any interruption will nevertheless unavoidably result in a corrupted output stream.
    if ! _if_buffer
    then
        #export FORCE_DIRECT="true"

        _set_wget_githubRelease-detect "$@"
        currentSkip="skip"

        currentStream="noBuf"
        #local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	    #local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"

		maxCurrentPart=$(_curl_githubAPI_releases_join-skip "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")

        currentPart=""
        for currentPart in $(seq -f "%02g" 0 "$maxCurrentPart" | sort -r)
        do
            if [[ "$currentSkip" == "skip" ]]
            then
				# ATTENTION: Could expect to use the 'API_URL' function in both cases, since we are not using the resulting URL except to 'skip'/'download' .
				#currentSkip=$(_wget_githubRelease-skip-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part"$currentPart")
				if [[ "$GH_TOKEN" != "" ]]
				then
					currentSkip=$(_wget_githubRelease-skip-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part"$currentPart")
					#[[ "$?" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
					#[[ "$?" != "0" ]] && currentSkip="skip"
					[[ "$?" != "0" ]] && ( _messagePlain_warn 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null
				else
					currentSkip=$(_wget_githubRelease-skip-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part"$currentPart")
					#[[ "$?" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
					#[[ "$?" != "0" ]] && currentSkip="skip"
					[[ "$?" != "0" ]] && ( _messagePlain_warn 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null
				fi
            fi
            
            [[ "$currentSkip" == "skip" ]] && continue

            
            if [[ "$currentExitStatus" == "0" ]] || [[ "$currentSkip" != "skip" ]]
            then
                _set_wget_githubRelease "$@"
                currentSkip="download"
            fi


            _wget_githubRelease_procedure "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part"$currentPart" -O - "$@"
            currentExitStatus="$?"
            #[[ "$currentExitStatus" != "0" ]] && break
        done

        return "$currentExitStatus"
    fi





	# ### ATTENTION: _if_buffer (IMPLICIT)

	# NOTICE: Parallel downloads may, if necessary, be adapted to first cache a list of addresses (ie. URLs) to download. API rate limits could then have as much time as possible to recover before subsequent commands (eg. analysis of builds). Such a cache must be filled with addresses BEFORE the download loop.
	#  However, at best, this can only be used with non-ephemeral 'browser_download_url' addresses .


	export currentAxelTmpFileUID="$(_uid 14)"
	_axelTmp() {
		echo .m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID"
	}
	local currentAxelTmpFile
	#currentAxelTmpFile="$scriptAbsoluteFolder"/$(_axelTmp)

	local currentStream_min=1
	local currentStream_max=3
	[[ "$FORCE_PARALLEL" != "" ]] && currentStream_max="$FORCE_PARALLEL"

	currentStream="$currentStream_min"


	currentPart="$maxCurrentPart"


	_set_wget_githubRelease-detect "$@"
	currentSkip="skip"

	maxCurrentPart=$(_curl_githubAPI_releases_join-skip "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")

	currentPart=""
	for currentPart in $(seq -f "%02g" 0 "$maxCurrentPart" | sort -r)
	do
		if [[ "$currentSkip" == "skip" ]]
		then
			# ATTENTION: EXPERIMENT
			# ATTENTION: Could expect to use the 'API_URL' function in both cases, since we are not using the resulting URL except to 'skip'/'download' .
			#currentSkip=$(_wget_githubRelease-skip-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part"$currentPart")
			##currentSkip=$([[ "$currentPart" -gt "17" ]] && echo 'skip' ; true)
			if [[ "$GH_TOKEN" != "" ]]
			then
				currentSkip=$(_wget_githubRelease-skip-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part"$currentPart")
				#[[ "$?" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
				#[[ "$?" != "0" ]] && currentSkip="skip"
				[[ "$?" != "0" ]] && ( _messagePlain_warn 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null
			else
				currentSkip=$(_wget_githubRelease-skip-URL-curl "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part"$currentPart")
				#[[ "$?" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
				#[[ "$?" != "0" ]] && currentSkip="skip"
				[[ "$?" != "0" ]] && ( _messagePlain_warn 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null
			fi
		fi
		
		[[ "$currentSkip" == "skip" ]] && continue


		#[[ "$currentExitStatus" == "0" ]] || 
		if [[ "$currentSkip" != "skip" ]]
		then
			_set_wget_githubRelease "$@"
			currentSkip="download"
			break
		fi
	done

	export currentSkipPart="$currentPart"
	[[ "$currentStream_max" -gt "$currentSkipPart" ]] && currentStream_max=$(( "$currentSkipPart" + 1 ))

	"$scriptAbsoluteLocation" _wget_githubRelease_join_sequence-parallel "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" &


	# Prebuffer .
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  preBUFFER: WAIT  ...  currentPart='"$currentPart" >&2 ) > /dev/null
	if [[ "$currentPart" -ge "01" ]] && [[ "$currentStream_max" -ge "2" ]]
	then
		#currentStream="2"
		for currentStream in $(seq "$currentStream_min" "$currentStream_max" | sort -r)
		do
			( _messagePlain_probe 'prebuffer: currentStream= '"$currentStream" >&2 ) > /dev/null
			while ( ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] )
			do
				sleep 3
			done
		done
	fi
	currentStream="$currentStream_min"


	for currentPart in $(seq -f "%02g" 0 "$currentSkipPart" | sort -r)
	do
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  outputLOOP  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
	#( _messagePlain_probe_var currentPart >&2 ) > /dev/null
	#( _messagePlain_probe_var currentStream >&2 ) > /dev/null

		# Stream must have written PASS/FAIL file .
		local currentDiagnosticIteration_outputLOOP_wait=0
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  outputLOOP: WAIT:  P_A_S_S/F_A_I_L  ... currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		while ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).busy ]] || ( ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] )
		do
			sleep 1

			let currentDiagnosticIteration_outputLOOP_wait=currentDiagnosticIteration_outputLOOP_wait+1
			if [[ "$currentDiagnosticIteration_outputLOOP_wait" -gt 15 ]]
			then
				currentDiagnosticIteration_outputLOOP_wait=0
				( _messagePlain_probe "diagnostic_outputLOOP_wait: pid: ""$!" >&2 ) > /dev/null
				# ATTRIBUTION-AI: ChatGPT 4.5-preview 2025-03-29
				#( echo "diagnostic_outputLOOP_wait: checking filenames exactly as seen by script: |$scriptAbsoluteFolder/$(_axelTmp).busy| and |$scriptAbsoluteFolder/$(_axelTmp).PASS|" >&2 ) > /dev/null
				#( ls -l "$scriptAbsoluteFolder"/$(_axelTmp).* >&2 )
				#stat "$scriptAbsoluteFolder"/$(_axelTmp).busy >&2 || ( echo 'diagnostic_outputLOOP_wait: '"stat busy - file truly doesn't exist at this name!" >&2 )
				#stat "$scriptAbsoluteFolder"/$(_axelTmp).PASS >&2 || ( echo 'diagnostic_outputLOOP_wait: '"stat PASS - file truly doesn't exist at this name!" >&2 )
			fi
		done
		
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  outputLOOP: OUTPUT  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		# ATTENTION: EXPERIMENT
		#status=none
		dd if="$scriptAbsoluteFolder"/$(_axelTmp) bs=1M
		#cat "$scriptAbsoluteFolder"/$(_axelTmp)
		#dd if="$scriptAbsoluteFolder"/$(_axelTmp) bs=1M | pv --rate-limit 100M 2>/dev/null
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && currentSkip="download"
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] && [[ "$currentSkip" != "skip" ]] && ( _messageError 'FAIL' >&2 ) > /dev/null && return 1

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  outputLOOP: DELETE  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		#rm -f "$scriptAbsoluteFolder"/$(_axelTmp) > /dev/null 2>&1
		_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp)
		#rm -f "$scriptAbsoluteFolder"/$(_axelTmp).busy > /dev/null 2>&1
		_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).busy

		#_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).*
		#_destroy_lock "$scriptAbsoluteFolder"/.m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID".*

		let currentStream=currentStream+1
		[[ "$currentStream" -gt "$currentStream_max" ]] && currentStream="$currentStream_min"
	done

	true
}
_wget_githubRelease_join_sequence-parallel() {
	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			#echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi


	#export currentAxelTmpFileUID="$(_uid 14)"
	_axelTmp() {
		echo .m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID"
	}
	#local currentAxelTmpFile
	#currentAxelTmpFile="$scriptAbsoluteFolder"/$(_axelTmp)

	# Due to parallelism , only API rate limits, NOT download speeds, are a concern with larger number of retries. 
	_set_wget_githubRelease "$@"
	#_set_wget_githubRelease-detect "$@"
	#_set_wget_githubRelease-detect-parallel "$@"
	local currentSkip="skip"
	
	local currentStream_min=1
	local currentStream_max=3
	[[ "$FORCE_PARALLEL" != "" ]] && currentStream_max="$FORCE_PARALLEL"
	[[ "$currentStream_max" -gt "$currentSkipPart" ]] && currentStream_max=$(( "$currentSkipPart" + 1 ))
	
	currentStream="$currentStream_min"
	for currentPart in $(seq -f "%02g" 0 "$currentSkipPart" | sort -r)
	do
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  downloadLOOP  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
	#( _messagePlain_probe_var currentPart >&2 ) > /dev/null
	#( _messagePlain_probe_var currentStream >&2 ) > /dev/null

		# Slot in use. Downloaded  "$scriptAbsoluteFolder"/$(_axelTmp)  file will be DELETED after use by calling process.
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BUSY  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		while ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp) > /dev/null 2>&1 ) || ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp).busy > /dev/null 2>&1 )
		do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BUSY  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
			sleep 1
		done

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: detect skip  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && _set_wget_githubRelease "$@" && currentSkip="download"
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] && [[ "$currentSkip" != "skip" ]] && ( _messageError 'FAIL' >&2 ) > /dev/null && return 1

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: DELETE  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		#rm -f "$scriptAbsoluteFolder"/$(_axelTmp).PASS > /dev/null 2>&1
		_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).PASS
		#rm -f "$scriptAbsoluteFolder"/$(_axelTmp).FAIL > /dev/null 2>&1
		_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).FAIL

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: DELAY: stagger, Inter-Process Communication, _stop  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		# Staggered Delay.
		[[ "$currentPart" == "$currentSkipPart" ]] && sleep 2
		[[ "$currentPart" != "$currentSkipPart" ]] && sleep 6
		# Inter-Process Communication Delay.
		# Prevents new download from starting before previous download process has done  rm -f "$currentAxelTmpFile"*  .
		#  Beware that  rm  is inevitable or at least desirable - called by _stop() through trap, etc.
		sleep 7
		
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: DOWNLOAD  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		export currentAxelTmpFile="$scriptAbsoluteFolder"/$(_axelTmp)
		if ls -1 "$currentAxelTmpFile"* > /dev/null 2>&1
		then
			( _messagePlain_bad 'bad: FAIL: currentAxelTmpFile*: EXISTS !' >&2 ) > /dev/null
			echo "1" > "$currentAxelTmpFile".FAIL
			_messageError 'FAIL' >&2
			exit 1
			return 1
		fi
		"$scriptAbsoluteLocation" _wget_githubRelease_procedure-join "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile".part$(printf "%02g" "$currentPart") &
		echo "$!" > "$scriptAbsoluteFolder"/$(_axelTmp).pid

		# Stream must have written either in-progress download or PASS/FAIL file .
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BEGIN  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		while ! ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp)* > /dev/null 2>&1 )
		do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BEGIN  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
			sleep 0.6
		done

		let currentStream=currentStream+1
		[[ "$currentStream" -gt "$currentStream_max" ]] && currentStream="$currentStream_min"
	done

	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  download: DELETE' >&2 ) > /dev/null
	for currentStream in $(seq "$currentStream_min" "$currentStream_max")
	do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  download: WAIT: BUSY  ...  currentStream='"$currentStream" >&2 ) > /dev/null
		while ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp) > /dev/null 2>&1 ) || ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp).busy > /dev/null 2>&1 )
		do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  download: WAIT: BUSY  ...  currentStream='"$currentStream" >&2 ) > /dev/null
			sleep 1
		done

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  download: DELETE ...  currentStream='"$currentStream" >&2 ) > /dev/null
		#rm -f "$scriptAbsoluteFolder"/$(_axelTmp).PASS > /dev/null 2>&1
		_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).PASS
		#rm -f "$scriptAbsoluteFolder"/$(_axelTmp).FAIL > /dev/null 2>&1
		_destroy_lock "$scriptAbsoluteFolder"/$(_axelTmp).FAIL
	done

	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  download: WAIT PID  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
	for currentStream in $(seq "$currentStream_min" "$currentStream_max")
	do
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).pid ]] && _pauseForProcess $(cat "$scriptAbsoluteFolder"/$(_axelTmp).pid) > /dev/null
	done
	wait >&2

	true
}
_wget_githubRelease_procedure-join() {
	( _messagePlain_probe_safe _wget_githubRelease_procedure-join "$@" >&2 ) > /dev/null

	local currentAbsoluteRepo="$1"
	local currentReleaseLabel="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi

	#local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	#local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"

	local currentExitStatus

	echo -n > "$currentAxelTmpFile".busy

	# ATTENTION: EXPERIMENT
	_wget_githubRelease_procedure "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" -O "$currentAxelTmpFile" "$@"
    #dd if=/dev/zero bs=1M count=1500 > "$currentAxelTmpFile"
	#echo "$currentFile" >> "$currentAxelTmpFile"
    #dd if=/dev/urandom bs=1M count=1500 | pv --rate-limit 300M 2>/dev/null > "$currentAxelTmpFile"
	currentExitStatus="$?"

	# Inter-Process Communication Delay
	# Essentially a 'minimum download time' .
	sleep 7

	[[ "$currentExitStatus" == "0" ]] && echo "$currentExitStatus" > "$currentAxelTmpFile".PASS
	if [[ "$currentExitStatus" != "0" ]]
	then
		echo -n > "$currentAxelTmpFile"
		echo "$currentExitStatus" > "$currentAxelTmpFile".FAIL
	fi

    while [[ -e "$currentAxelTmpFile" ]] || [[ -e "$currentAxelTmpFile".busy ]] || [[ -e "$currentAxelTmpFile".PASS ]] || [[ -e "$currentAxelTmpFile".FAIL ]]
    do
        sleep 1
    done

	# WARNING: Already inevitable (due to _stop , etc).
    #[[ "$currentAxelTmpFile" != "" ]] && rm -f "$currentAxelTmpFile".*
	[[ "$currentAxelTmpFile" != "" ]] && _destroy_lock "$currentAxelTmpFile".*

    #unset currentAxelTmpFile

    [[ "$currentExitStatus" == "0" ]] && return 0
    return "$currentExitStatus"
}










_warn_githubRelease_FORCE_WGET() {
    ( _messagePlain_warn 'warn: WARNING: FORCE_WGET=true' >&2 ; echo 'FORCE_WGET is a workaround. Only expected FORCE_WGET uses: low RAM , cloud testing/diagnostics .' >&2  ) > /dev/null
    return 0
}
_bad_fail_githubRelease_currentExitStatus() {
    ( _messagePlain_bad 'fail: wget_githubRelease: currentExitStatus: '"$currentAbsoluteRepo"' '"$currentReleaseLabel"' '"$currentFile" >&2 ) > /dev/null
    return 0
}
_bad_fail_githubRelease_missing() {
    ( _messagePlain_bad 'fail: wget_githubRelease: missing: '"$currentAbsoluteRepo"' '"$currentReleaseLabel"' '"$currentFile" >&2 ) > /dev/null
    return 0
}






_vector_wget_githubRelease-URL-gh() {
    local currentReleaseLabel="build"
    
    [[ $(
cat <<'CZXWXcRMTo8EmM8i4d' | _wget_githubRelease_procedure-address-gh-awk "" "$currentReleaseLabel" "" 2> /dev/null
TITLE  TYPE    TAG NAME             PUBLISHED        
build  Latest  build-1002-1  about 1 days ago
build          build-1001-1  about 2 days ago
CZXWXcRMTo8EmM8i4d
) == "build-1002-1
build-1001-1" ]] || ( _messagePlain_bad 'fail: bad: _wget_githubRelease_procedure-address-gh-awk' && _messageFAIL )

	return 0
}















# WARNING: No production use. Non-essential.
# May be used nearly interchangeably in place of 'wget_githubRelease_internal' as an alternative to 'releaseLabel' downloads within 'build.yml, 'zCustom.yml', 'zUpgrade.yml', etc, GitHub Actions workflow builds (ie. internally downloading the ingredient, beforeBoot, etc, disk image, specifically for the currentTag, rather than the latest matching the 'build' label). Not regarded as production use since non-concurrent use of the 'releaseLabel' download functions is considered the production functions, as these have commonality with the functions tested by end-users over the vagarities of internet connections, and are the first functions maintained with any workarounds, etc, as needed.
#  ATTENTION: This definition of 'no production use', is consistent with the use of that phrase throughout 'ubiquitous_bash'. Production use of these functions, can be tolerated, but is NOT guaranteed. Best practice when using such 'no production use' functions in production scripting, is to leave a commented out, but adequately tested, alternative use of a function that is guaranteed, to quickly change this back if needed.
#
# Downloads single files through GitHub API by unique tag (instead of label).
#
# Only necessary for 'analysis' - downloading currentTag log files, comparing to log files from tags of previous releases.

# CAUTION: NOT included in 'rotten' .
# May depend on functions from 'wget_githubRelease_internal.sh', NOT vice-versa .









#env currentRepository='soaringDistributions/ubDistBuild' currentReleaseTag='build-13932580400-9999' ./ubiquitous_bash.sh _wget_githubRelease-fromTag-analysisReport-fetch 20 lsmodReport binReport coreReport dpkg
#env currentRepository='mirage335-colossus/ubiquitous_bash' currentReleaseTag='build-13917942290-9999' ./ubiquitous_bash.sh _wget_githubRelease-fromTag-analysisReport-fetch 20 'ubcp-binReport-UNIX_Linux'
#env:
#  currentRepository: ${{ github.repository }}
#  currentReleaseTag: build-${{ github.run_id }}-9999
#  GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
_wget_githubRelease-fromTag-analysisReport-fetch() {
    local currentLimit
    currentLimit="$1"
    shift

    mkdir -p "$scriptLocal"/analysisTmp

    local current_reportFiles_list
    current_reportFiles_list=()

    current_reportFiles_list=( "$@" )

    local current_reportFile

    #for current_reportFile in "${current_reportFiles_list[@]}"; do
        #_wget_githubRelease-fromTag-fetchReport "$currentRepository" "$currentReleaseTag" "$current_reportFile" > "$scriptLocal"/analysisTmp/"$current_reportFile"
    #done

    ! _wget_githubRelease-releasesTags "$currentRepository" "$currentLimit" | tr -dc 'a-zA-Z0-9\-_.:\n' > "$scriptLocal"/analysisTmp/releasesTags && _messageFAIL
    
    for current_reportFile in "${current_reportFiles_list[@]}"; do
        for current_reviewReleaseTag in $(cat "$scriptLocal"/analysisTmp/releasesTags); do
            # Download the (eg. binReport) report file for this release
            _wget_githubRelease-fromTag-fetchReport "$currentRepository" "$current_reviewReleaseTag" "$current_reportFile" --no-fail > "$scriptLocal"/analysisTmp/"$current_reportFile"-"$current_reviewReleaseTag"
        done
    done

    if [[ "$currentReleaseTag" != "" ]]
    then
        _wget_githubRelease-fromTag-analysisReport-select "${current_reportFiles_list[@]}"
        return
    fi
    return 0
}

#./ubiquitous_bash.sh _wget_githubRelease-fromTag-analysisReport-select 'ubcp-binReport-UNIX_Linux'
#env:
#  currentReleaseTag: build-${{ github.run_id }}-9999
_wget_githubRelease-fromTag-analysisReport-select() {
    mkdir -p "$scriptLocal"/analysisTmp

    local current_reportFiles_list
    current_reportFiles_list=()

    current_reportFiles_list=( "$@" )

    local current_reportFile

    if [[ "$currentReleaseTag" == "" ]]
    then
        ( echo 'FAIL: missing: currentReleaseTag' >&2 ) > /dev/null
        _messageFAIL
    fi
    
    for current_reportFile in "${current_reportFiles_list[@]}"; do
        ( _messagePlain_probe cat "$scriptLocal"/analysisTmp/"$current_reportFile"-"$currentReleaseTag" > "$scriptLocal"/analysisTmp/"$current_reportFile" >&2 ) > /dev/null
        if ! cat "$scriptLocal"/analysisTmp/"$current_reportFile"-"$currentReleaseTag" > "$scriptLocal"/analysisTmp/"$current_reportFile"
        then
            _messageFAIL
        fi
    done
    return 0
}


#env currentRepository='mirage335-colossus/ubiquitous_bash' currentReleaseTag='build-13917942290-9999' ./ubiquitous_bash.sh _wget_githubRelease-fromTag-analysisReport-analysis 65 lsmodReport binReport coreReport dpkg
#env currentRepository='mirage335-colossus/ubiquitous_bash' currentReleaseTag='build-13917942290-9999' ./ubiquitous_bash.sh _wget_githubRelease-fromTag-analysisReport-analysis 65 'ubcp-binReport-UNIX_Linux'
#env:
#  currentReleaseTag: build-${{ github.run_id }}-9999
_wget_githubRelease-fromTag-analysisReport-analysis() {
    local currentLimit
    currentLimit="$1"
    shift

    mkdir -p "$scriptLocal"/analysisTmp

    local current_reportFiles_list
    current_reportFiles_list=()

    current_reportFiles_list=( "$@" )

    local current_reportFile
    
	# Analysis - for each report file, compare for all tags.
    #for current_reportFile in "${current_reportFiles_list[@]}"; do
        #rm -f "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
        #for current_reviewReleaseTag in $(cat "$scriptLocal"/analysisTmp/releasesTags); do
            ## Compare the list of binaries, etc, in this release to the current release
            #if [ "$current_reviewReleaseTag" != "$currentReleaseTag" ]; then
                #echo | tee -a "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
                #echo 'Items (ie. '"$current_reportFile"') in '"$current_reviewReleaseTag"' but not in currentRelease '"$currentReleaseTag"':' | tee -a "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
                ##| tee -a "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
                #comm -23 <(sort "$scriptLocal"/analysisTmp/"$current_reportFile"-"$current_reviewReleaseTag") <(sort "$scriptLocal"/analysisTmp/"$current_reportFile") > "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp
                #cat "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp | head -n "$currentLimit"
                #cat "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp >> "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
                #rm -f "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp
            #fi
        #done
    #done


	# Analysis - for each tag, compare all report files. 
	#  More human readable stdout - shows all differences between current version and other tagged version , one tagged version at a time.
	# WARNING: Selected "$scriptLocal"/analysisTmp/"$current_reportFile" file is used directly, rather than "$scriptLocal"/analysisTmp/"$current_reportFile"-"$currentReleaseTag" , for compatibility with analysis solely for more rapid diagnostics which will not be uploaded (ie. 'ubDistBuild' 'build-analysis-beforeBoot').
	for current_reportFile in "${current_reportFiles_list[@]}"; do
		rm -f "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
	done
    for current_reviewReleaseTag in $(cat "$scriptLocal"/analysisTmp/releasesTags); do
    	for current_reportFile in "${current_reportFiles_list[@]}"; do
			 if [ "$current_reviewReleaseTag" != "$currentReleaseTag" ]; then

			 	echo | tee -a "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
				echo 'Items (ie. '"$current_reportFile"') in '"$current_reviewReleaseTag"' but not in currentRelease '"$currentReleaseTag"':' | tee -a "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
				
                #| tee -a "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
                comm -23 <(sort "$scriptLocal"/analysisTmp/"$current_reportFile"-"$current_reviewReleaseTag") <(sort "$scriptLocal"/analysisTmp/"$current_reportFile") > "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp
                cat "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp | head -n "$currentLimit"
                cat "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp >> "$scriptLocal"/analysisTmp/missing-"$current_reportFile"
                rm -f "$scriptLocal"/analysisTmp/missing-"$current_reportFile".tmp

			fi
		done
	done





    return 0
}

_safeRMR-analysisTmp() {
    [[ -e "$scriptLocal"/analysisTmp ]] && _safeRMR "$scriptLocal"/analysisTmp
}

#env currentRepository='mirage335-colossus/ubiquitous_bash' currentReleaseTag='build-13917942290-9999' ./ubiquitous_bash.sh _wget_githubRelease-fromTag-analysisReport 'ubcp-binReport-UNIX_Linux'
#env:
#  currentRepository: ${{ github.repository }}
#  currentReleaseTag: build-${{ github.run_id }}-9999
#  GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
# No production use.
_wget_githubRelease-fromTag-analysisReport() {
    _wget_githubRelease-fromTag-analysisReport-fetch 20 "$@"
    _wget_githubRelease-fromTag-analysisReport-select "$@"
    _wget_githubRelease-fromTag-analysisReport-analysis 65 "$@"
    _safeRMR-analysisTmp
}








#./ubiquitous_bash.sh _wget_githubRelease-fromTag-fetchReport 'soaringDistributions/ubDistBuild' 'build_upgrade-13945231768-9999' 'binReport'
#./ubiquitous_bash.sh _wget_githubRelease-fromTag-fetchReport 'soaringDistributions/ubDistBuild' 'build_upgrade-13945231768-9999' 'binReportX'
#"$GH_TOKEN"
_wget_githubRelease-fromTag-fetchReport() {
    ( _messagePlain_nominal '\/\/\/\/\/ init: _wget_githubRelease-fromTag-fetchReport' >&2 ) > /dev/null

    if [[ "$GH_TOKEN" == "" ]]
    then
        ( _messagePlain_bad 'bad: FAIL: GH_TOKEN not set' >&2 ) > /dev/null
        return 1
    fi
    
    local currentAbsoluteRepo="$1"
    local currentTag="$2"
    local currentFile="$3"
    local currentFailParam="$4"
    [[ "$currentFailParam" != "--no-fail" ]] && currentFailParam="--fail"
    shift ; shift ; shift ; shift

    local current

    # ATTRIBUTION-AI: 2025-03-23
    #_set_curl_github_retry
    #curl "$currentFailParam" "${curl_retries_args[@]}" -s -S -L -H "Authorization: token $GH_TOKEN" -H "Accept: application/octet-stream" "$(curl "$currentFailParam" "${curl_retries_args[@]}" -s -S -H "Authorization: token $GH_TOKEN" "https://api.github.com/repos/""$currentAbsoluteRepo""/releases/tags/""$currentTag"  | jq -r '.assets[] | select(.name=="'"$currentFile"'") | .url')" -o -


    export githubRelease_retriesMax=2
	export githubRelease_retriesWait=4
    _set_curl_github_retry
	
    local currentExitStatus=0

    #local currentSkip
    #currentSkip=$(_wget_githubRelease-skip-URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$currentFailParam")
    #currentExitStatus="$?"
    #[[ "$currentExitStatus" != "0" ]] && [[ "$currentFailParam" != "--no-fail" ]] && return "$currentExitStatus"
    #[[ "$currentSkip" == "skip" ]] && [[ "$currentFailParam" == "--no-fail" ]] && return 0
    #[[ "$currentSkip" != 'download' ]] && [[ "$currentFailParam" != "--no-fail" ]] && return 1

    #curl "$currentFailParam" "${curl_retries_args[@]}" -s -S -L -H "Authorization: token $GH_TOKEN" -H "Accept: application/octet-stream" "$(_wget_githubRelease-API_URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$currentFailParam")" -o -
    #currentExitStatus="$?"

    local current_API_URL
    current_API_URL=$(_wget_githubRelease-API_URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$currentFailParam")
    currentExitStatus="$?"
    [[ "$currentExitStatus" != "0" ]] && [[ "$currentFailParam" != "--no-fail" ]] && return "$currentExitStatus"
    [[ "$current_API_URL" == "" ]] && [[ "$currentFailParam" == "--no-fail" ]] && return 0
    [[ "$current_API_URL" == '' ]] && [[ "$currentFailParam" != "--no-fail" ]] && return 1

    curl "$currentFailParam" "${curl_retries_args[@]}" -s -S -L -H "Authorization: token $GH_TOKEN" -H "Accept: application/octet-stream" "$current_API_URL" -o -
    
    _set_wget_githubRelease
    unset curl_retries_args
    
    return "$currentExitStatus"
}







#"$api_address_type" == "tagName" || "$api_address_type" == "url"
# ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
# ATTRIBUTION-AI: Many-Chat 2025-03-23
_jq_github_browser_download_address_fromTag() {
	( _messagePlain_probe 'init: _jq_github_browser_download_address_fromTag' >&2 ) > /dev/null
	#local currentReleaseLabel="$2"
    local currentTag="$2"
	local currentFile="$3"
	

    if [[ "$api_address_type" == "" ]] || [[ "$api_address_type" == "url" ]]
    then
        #jq -r ".assets[] | select(.name == "'"$currentFile"'") | .browser_download_url"
        #jq -r ".assets | sort_by(.published_at) | reverse | .[] | select(.name == "'"$currentFile"'") | .browser_download_url"

        #jq -r '.[] | select(.tag_name == "'"$currentTag"'") | .assets[] | select(.name == "'"$currentFile"'") | .browser_download_url'
        jq --arg shellFile "$currentFile" --arg shellTag "$currentTag" -r '.[] | select(.tag_name == $shellTag) | .assets[] | select(.name == $shellFile) | .browser_download_url'
        
        return
    fi
    if [[ "$api_address_type" == "tagName" ]]
    then
        #jq -r ".tag_name"
        
        # ATTRIBUTION-AI: ChatGPT 4.5-preview 2025-03-23
        #jq -r '.[] | select(.tag_name == "'"$currentTag"'") | select(.assets[].name == "'"$currentFile"'") | .tag_name'
        jq --arg shellFile "$currentFile" --arg shellTag "$currentTag" -r '.[] | select(.tag_name == $shellTag) | select(.assets[].name == $shellFile) | .tag_name'

        return
    fi
    if [[ "$api_address_type" == "api_url" ]]
    then
        #jq -r ".assets[] | select(.name == "'"$currentFile"'") | .url"
        #jq -r ".assets | sort_by(.published_at) | reverse | .[] | select(.name == \"$currentFile\") | .url"
        
        #jq -r ".[] | select(.tag_name == \"$currentTag\") | .assets[] | select(.name == \"$currentFile\") | .url"
        #jq -r '.[] | select(.tag_name == "'"$currentTag"'") | .assets[] | select(.name == "'"$currentFile"'") | .url'
        jq --arg shellFile "$currentFile" --arg shellTag "$currentTag" -r '.[] | select(.tag_name == $shellTag) | .assets[] | select(.name == $shellFile) | .url'

        return
    fi
}



# WARNING: No production use. May be untested.
#  Rapidly skips part files which are not upstream, using only a single page from the GitHub API, saving time and API calls.
# Not guaranteed reliable. Structure of this non-essential function is provider-specific, code is written ad-hoc.
# Duplicates much code from other functions:
#  '_wget_githubRelease_procedure-address-curl'
#  '_wget_githubRelease_procedure-address_fromTag-curl'
#  '_wget_githubRelease-address-backend-curl'
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_fromTag_join-skip soaringDistributions/ubDistBuild build-14095557231-9999 package_image.tar.flx
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_fromTag_join-skip soaringDistributions/ubDistBuild build-13347565825-1 vm-ingredient.img.flx
_curl_githubAPI_releases_fromTag_join-skip() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _curl_githubAPI_releases_fromTag_join-skip' >&2 ) > /dev/null
	( _messagePlain_probe_safe _curl_githubAPI_releases_fromTag_join-skip "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    [[ "$GH_TOKEN" != "" ]] && local api_address_type="api_url"
	[[ "$GH_TOKEN" == "" ]] && local api_address_type="url"

	local currentPartDownload
	currentPartDownload=""

	local currentExitStatus=1

	local currentIteration=0

	#[[ "$currentPartDownload" == "" ]] || 
	while ( [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		currentPartDownload=""

		if [[ "$currentIteration" != "0" ]]
		then
			( _messagePlain_warn 'warn: BAD: RETRY: _curl_githubAPI_releases_fromTag_join-skip: _curl_githubAPI_releases_fromTag_join_procedure-skip: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe _curl_githubAPI_releases_fromTag_join_procedure-skip >&2 ) > /dev/null
		currentPartDownload=$(_curl_githubAPI_releases_fromTag_join_procedure-skip "$@")
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
	
	_safeEcho_newline "$currentPartDownload"

	[[ "$currentIteration" -ge "$githubRelease_retriesMax" ]] && ( _messagePlain_bad 'bad: FAIL: _curl_githubAPI_releases_fromTag_join-skip: maxRetries' >&2 ) > /dev/null && return 1

	return 0
}
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_fromTag_join_procedure-skip soaringDistributions/ubDistBuild spring package_image.tar.flx
#env maxCurrentPart=63 ./ubiquitous_bash.sh _curl_githubAPI_releases_fromTag_join_procedure-skip soaringDistributions/ubDistBuild latest package_image.tar.flx
_curl_githubAPI_releases_fromTag_join_procedure-skip() {
	local currentAbsoluteRepo="$1"
	local currentTag="$2"
	local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	[[ "$currentFile" == "" ]] && return 1


	local currentExitStatus_tmp=0
	local currentExitStatus=0


	local currentPart
	local currentAddress



	local currentData
	currentData=""
	
	local currentData_page
	currentData_page="doNotMatch"
	
	local currentIteration
	currentIteration=1
	
	# ATTRIBUTION-AI: Many-Chat 2025-03-23
	# Alternative detection of empty array, as suggested by AI LLM .
	#[[ $(jq 'length' <<< "$currentData_page") -gt 0 ]]
	while ( [[ "$currentData_page" != "" ]] && [[ $(_safeEcho_newline "$currentData_page" | tr -dc 'a-zA-Z\[\]' | sed '/^$/d') != $(echo 'WwoKXQo=' | base64 -d | tr -dc 'a-zA-Z\[\]') ]] ) && ( [[ "$currentIteration" -le "1" ]] || ( [[ "$GH_TOKEN" != "" ]] && [[ "$currentIteration" -le "3" ]] ) )
	do
		currentData_page=$(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$currentIteration")
		currentExitStatus_tmp="$?"
		[[ "$currentIteration" == "1" ]] && currentExitStatus="$currentExitStatus_tmp"
		currentData="$currentData"'
'"$currentData_page"

		( _messagePlain_probe "_wget_githubRelease_procedure-address-curl: ""$currentIteration" >&2 ) > /dev/null
		#( _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentTag" "$currentFile" | head -n 1 >&2 ) > /dev/null
		[[ "$currentIteration" -ge 4 ]] && ( _safeEcho_newline "$currentData_page" >&2 ) > /dev/null

		let currentIteration=currentIteration+1
	done

	#( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentTag" "$currentFile" | head -n 1 )
	#currentExitStatus_tmp="$?"

	# ###
	for currentPart in $(seq -f "%02g" 0 "$maxCurrentPart" | sort -r)
	do
		currentAddress=$( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address_fromTag "" "$currentTag" "$currentFile".part"$currentPart" | head -n 1 )
		currentExitStatus_tmp="$?"

		[[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: _curl_githubAPI_releases_fromTag_page: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
		[[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: pipefail: _jq_github_browser_download_address: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"
		[[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address-curl: empty: currentData' >&2 ) > /dev/null && return 1

		[[ "$currentAddress" != "" ]] && echo "$currentPart" && return 0
	done

	
	# ### ATTENTION: No part files found is not 'skip' but FAIL .
	[[ "$currentAddress" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _curl_githubAPI_releases_fromTag_join-skip: empty: _safeEcho_newline | _jq_github_browser_download_address' >&2 ) > /dev/null && return 1
	
	return 0

}









#./ubiquitous_bash.sh _wget_githubRelease-API_URL_fromTag-curl 'soaringDistributions/ubDistBuild' 'build_upgrade-13945231768-9999' 'binReport' --fail | head

_wget_githubRelease_procedure-address_fromTag-curl() {
	local currentAbsoluteRepo="$1"
    local currentTag="$2"
    local currentFile="$3"
    local currentFailParam="$4"
    [[ "$currentFailParam" != "--no-fail" ]] && currentFailParam="--fail"

	#local currentReleaseLabel="$2"
	#local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	#[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	[[ "$currentFile" == "" ]] && return 1


	local currentExitStatus_tmp=0
	local currentExitStatus=0


    local currentData
    currentData=""
    
    local currentData_page
    currentData_page="doNotMatch"
    
    local currentIteration
    currentIteration=1
    
    # ATTRIBUTION-AI: Many-Chat 2025-03-23
    # Alternative detection of empty array, as suggested by AI LLM .
    #[[ $(jq 'length' <<< "$currentData_page") -gt 0 ]]
    while ( [[ "$currentData_page" != "" ]] && [[ $(_safeEcho_newline "$currentData_page" | tr -dc 'a-zA-Z\[\]' | sed '/^$/d') != $(echo 'WwoKXQo=' | base64 -d | tr -dc 'a-zA-Z\[\]') ]] ) && ( [[ "$currentIteration" -le "1" ]] || ( [[ "$GH_TOKEN" != "" ]] && [[ "$currentIteration" -le "3" ]] ) )
    do
        #currentData_page=$(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile")
        #_set_curl_github_retry
        currentData_page=$(set -o pipefail ; _curl_githubAPI_releases_page "$currentAbsoluteRepo" "doNotMatch" "$currentFile" "$currentIteration" "$currentFailParam" "${curl_retries_args[@]}")
        unset curl_retries_args
        currentExitStatus_tmp="$?"
        [[ "$currentIteration" == "1" ]] && currentExitStatus="$currentExitStatus_tmp"
        currentData="$currentData"'
'"$currentData_page"

        ( _messagePlain_probe "_wget_githubRelease_procedure-address_fromTag-curl: ""$currentIteration" >&2 ) > /dev/null
        [[ "$currentIteration" -ge 4 ]] && ( _safeEcho_newline "$currentData_page" >&2 ) > /dev/null

        let currentIteration=currentIteration+1
    done

    #( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address "" "$currentReleaseLabel" "$currentFile" | head -n 1 )
    ( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_address_fromTag "" "$currentTag" "$currentFile" | head -n 1 )
    currentExitStatus_tmp="$?"

    [[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address_fromTag-curl: _curl_githubAPI_releases_page: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
    [[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address_fromTag-curl: pipefail: _jq_github_browser_download_address_fromTag: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"
    [[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-address_fromTag-curl: empty: currentData' >&2 ) > /dev/null && return 1
    
    return 0
}
_wget_githubRelease-address_fromTag-backend-curl() {
	local currentAddress
	currentAddress=""

	local currentExitStatus=1

	local currentIteration=0

    #export githubRelease_retriesMax=2
	#export githubRelease_retriesWait=4
	#[[ "$currentAddress" == "" ]] || 
	while ( [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		currentAddress=""

		if [[ "$currentIteration" != "0" ]]
		then
			( _messagePlain_warn 'warn: BAD: RETRY: _wget_githubRelease-URL_fromTag-curl: _wget_githubRelease_procedure-address_fromTag-curl: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe _wget_githubRelease_procedure-address_fromTag-curl >&2 ) > /dev/null
		currentAddress=$(_wget_githubRelease_procedure-address_fromTag-curl "$@")
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
    #_set_wget_githubRelease
	
	_safeEcho_newline "$currentAddress"

	[[ "$currentIteration" -ge "$githubRelease_retriesMax" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-URL_fromTag-curl: maxRetries' >&2 ) > /dev/null && return 1

	return 0
}
_wget_githubRelease-address_fromTag-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-address_fromTag-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-URL_fromTag-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="tagName"

    _wget_githubRelease-address_fromTag-backend-curl "$@"
    return
}
_wget_githubRelease-URL_fromTag-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-URL_fromTag-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-URL_fromTag-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="url"

	local currentAddress

	local currentExitStatus=1

	currentAddress=$(_wget_githubRelease-address_fromTag-backend-curl "$@")
	currentExitStatus="$?"
	
	_safeEcho_newline "$currentAddress"

	[[ "$currentAddress" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-URL_fromTag-curl: empty: currentAddress' >&2 ) > /dev/null && return 1

    return "$currentExitStatus"
}
_wget_githubRelease-address_fromTag() {
	local currentTag="$2"
    
    ( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ init: _wget_githubRelease-address_fromTag' >&2 ) > /dev/null
	if _if_gh
	then
		##( _messagePlain_probe_safe _wget_githubRelease-address_fromTag-gh "$@" >&2 ) > /dev/null
		##_wget_githubRelease-address_fromTag-gh "$@"
        _safeEcho_newline "$currentTag"
		return
	else
		#( _messagePlain_probe_safe _wget_githubRelease-address_fromTag-curl "$@" >&2 ) > /dev/null
		#_wget_githubRelease-address_fromTag-curl "$@"
        _safeEcho_newline "$currentTag"
		return
	fi
}

# Calling functions MUST attempt download unless skip function conclusively determines BOTH that releaseLabel exists in upstream repo, AND file does NOT exist upstream. Functions may use such skip to skip high-numbered part files that do not exist.
_wget_githubRelease-skip-URL_fromTag-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-skip-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-skip-URL_fromTag-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-skip-URL_fromTag-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="url"

	local currentAddress

	local currentExitStatus=1

	currentAddress=$(_wget_githubRelease-address_fromTag-backend-curl "$@")
	currentExitStatus="$?"
	
	( _safeEcho_newline "$currentAddress" >&2 ) > /dev/null
	[[ "$currentExitStatus" != "0" ]] && return "$currentExitStatus"

	if [[ "$currentAddress" == "" ]]
	then
		echo skip
		( _messagePlain_good 'good: _wget_githubRelease-skip-URL_fromTag-curl: empty: currentAddress: PRESUME skip' >&2 ) > /dev/null
		return 0
	fi

	if [[ "$currentAddress" != "" ]]
	then
		echo download
		( _messagePlain_good 'good: _wget_githubRelease-skip-URL_fromTag-curl: found: currentAddress: PRESUME download' >&2 ) > /dev/null
		return 0
	fi

	return 1
}
_wget_githubRelease-detect-URL_fromTag-curl() {
	_wget_githubRelease-skip-URL_fromTag-curl "$@"
}

# WARNING: May be untested.
_wget_githubRelease-API_URL_fromTag-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-API_URL_fromTag-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-API_URL_fromTag-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="api_url"

	local currentAddress

	local currentExitStatus=1

	currentAddress=$(_wget_githubRelease-address_fromTag-backend-curl "$@")
	currentExitStatus="$?"
	
	_safeEcho_newline "$currentAddress"

	[[ "$currentAddress" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-API_URL_fromTag-curl: empty: currentAddress' >&2 ) > /dev/null && return 1

    return "$currentExitStatus"
}

# WARNING: May be untested.
# Calling functions MUST attempt download unless skip function conclusively determines BOTH that releaseLabel exists in upstream repo, AND file does NOT exist upstream. Functions may use such skip to skip high-numbered part files that do not exist.
_wget_githubRelease-skip-API_URL_fromTag-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-skip-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-skip-API_URL_fromTag-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-skip-API_URL_fromTag-curl "$@" >&2 ) > /dev/null

    # ATTENTION: WARNING: Unusually, api_address_type , is a monolithic variable NEVER exported . Keep local, and do NOT use for any other purpose.
    local api_address_type="api_url"

	local currentAddress

	local currentExitStatus=1

	currentAddress=$(_wget_githubRelease-address_fromTag-backend-curl "$@")
	currentExitStatus="$?"
	
	( _safeEcho_newline "$currentAddress" >&2 ) > /dev/null
	[[ "$currentExitStatus" != "0" ]] && return "$currentExitStatus"

	if [[ "$currentAddress" == "" ]]
	then
		echo skip
		( _messagePlain_good 'good: _wget_githubRelease-skip-API_URL_fromTag-curl: empty: currentAddress: PRESUME skip' >&2 ) > /dev/null
		return 0
	fi

	if [[ "$currentAddress" != "" ]]
	then
		echo download
		( _messagePlain_good 'good: _wget_githubRelease-skip-API_URL_fromTag-curl: found: currentAddress: PRESUME download' >&2 ) > /dev/null
		return 0
	fi

	return 1
}
_wget_githubRelease-detect-API_URL_fromTag-curl() {
	_wget_githubRelease-skip-API_URL_fromTag-curl "$@"
}















#_wget_githubRelease-fromTag-stdout

#_wget_githubRelease-fromTag



_wget_githubRelease-fromTag-stdout() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/\/ init: _wget_githubRelease-fromTag-stdout' >&2 ) > /dev/null
	local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"
	
	local currentExitStatus

	# WARNING: Very strongly discouraged. Any retry/continue of any interruption will nevertheless unavoidably result in a corrupted output stream.
	[[ "$FORCE_DIRECT" == "true" ]] && _wget_githubRelease-fromTag_procedure-stdout "$@"

	# ATTENTION: /dev/null assures that stdout is not corrupted by any unexpected output that should have been sent to stderr
	[[ "$FORCE_DIRECT" != "true" ]] && _wget_githubRelease-fromTag_procedure-stdout "$@" > /dev/null

	if ! [[ -e "$currentAxelTmpFile".PASS ]]
	then
		currentExitStatus=$(cat "$currentAxelTmpFile".FAIL)
		( [[ "$currentExitStatus" == "" ]] || [[ "$currentExitStatus" = "0" ]] || [[ "$currentExitStatus" = "0"* ]] ) && currentExitStatus=1
		rm -f "$currentAxelTmpFile".PASS > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".FAIL > /dev/null 2>&1
		rm -f "$currentAxelTmpFile" > /dev/null 2>&1
		return "$currentExitStatus"
		#return 1
	fi
	[[ "$FORCE_DIRECT" != "true" ]] && cat "$currentAxelTmpFile"
	rm -f "$currentAxelTmpFile" > /dev/null 2>&1
	rm -f "$currentAxelTmpFile".PASS > /dev/null 2>&1
	rm -f "$currentAxelTmpFile".FAIL > /dev/null 2>&1
	return 0
}
_wget_githubRelease-fromTag_procedure-stdout() {
	( _messagePlain_probe_safe _wget_githubRelease-fromTag_procedure-stdout "$@" >&2 ) > /dev/null

	local currentAbsoluteRepo="$1"
	local currentReleaseTag="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi

	#local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	#local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"

	local currentExitStatus

	# WARNING: Very strongly discouraged. Any retry/continue of any interruption will nevertheless unavoidably result in a corrupted output stream.
	if [[ "$FORCE_DIRECT" == "true" ]]
	then
		_wget_githubRelease-fromTag_procedure "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile" -O - "$@"
		currentExitStatus="$?"
		if [[ "$currentExitStatus" != "0" ]]
		then
			echo > "$currentAxelTmpFile".FAIL
			return "$currentExitStatus"
		fi
		echo > "$currentAxelTmpFile".PASS
		return 0
	fi

	_wget_githubRelease-fromTag_procedure "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile" -O "$currentAxelTmpFile" "$@"
	currentExitStatus="$?"
	if [[ "$currentExitStatus" != "0" ]]
	then
		echo "$currentExitStatus" > "$currentAxelTmpFile".FAIL
		return "$currentExitStatus"
	fi
	echo > "$currentAxelTmpFile".PASS
	return 0
}



























#! "$scriptAbsoluteLocation" _wget_githubRelease-fromTag_join "owner/repo" "tag_name" "file.ext" -O "file.ext"
#! _wget_githubRelease "owner/repo" "" "file.ext" -O "file.ext"
# ATTENTION: WARNING: Warn messages correspond to inability to assuredly, effectively, use GH_TOKEN .
_wget_githubRelease-fromTag() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/\/ init: _wget_githubRelease-fromTag' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-fromTag "$@" >&2 ) > /dev/null

	_wget_githubRelease-fromTag_procedure "$@"
}
_wget_githubRelease-fromTag_procedure() {
    # Should be very similar to '_wget_githubRelease_procedure' , but we will already have the tag , and in the case of curl/axel, we will need to generate the API_URL, in the case of 'gh' we will simply proceed to download.
    #
	# ATTENTION: Distinction nominally between '_wget_githubRelease' and '_wget_githubRelease_procedure' should only be necessary if a while loop retries the procedure .
	# ATTENTION: Potentially more specialized logic within download procedures should remain delegated with the responsibility to attempt retries , for now.
	# NOTICE: Several functions should already have retry logic: '_gh_download' , '_gh_downloadURL' , '_wget_githubRelease-address' , '_wget_githubRelease_procedure-curl' , '_wget_githubRelease-URL-curl' , etc .
	#( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ \/\/\/\/ init: _wget_githubRelease_procedure' >&2 ) > /dev/null
	#( _messagePlain_probe_safe _wget_githubRelease_procedure "$@" >&2 ) > /dev/null

    local currentAbsoluteRepo="$1"
	#local currentReleaseLabel="$2"
    local currentTag="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	[[ "$currentOutParameter" != "-O" ]] && currentOutFile="$currentFile"
	#[[ "$currentOutParameter" == "-O" ]] && currentOutFile="$currentOutFile"

	#[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && currentOutFile="$currentFile"
	[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && ( _messagePlain_bad 'bad: fail: unexpected: unspecified: currentOutFile' >&2 ) > /dev/null && return 1

	[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1

    local currentExitStatus=1

    # Discouraged .
    if [[ "$FORCE_WGET" == "true" ]]
    then
        _warn_githubRelease_FORCE_WGET
        #local currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")
		local currentURL
		[[ "$GH_TOKEN" != "" ]] && currentURL=$(_wget_githubRelease-API_URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")
		[[ "$GH_TOKEN" == "" ]] && currentURL=$(_wget_githubRelease-URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")

		_wget_githubRelease_loop-curl
        return "$?"
    fi

	# Discouraged . Benefits of multi-part-per-file downloading are less essential given that files are split into <2GB chunks.
	if [[ "$FORCE_AXEL" != "" ]] # && [[ "$MANDATORY_HASH" == "true" ]]
    then
        ( _messagePlain_warn 'warn: WARNING: FORCE_AXEL not empty' >&2 ; echo 'FORCE_AXEL may have similar effects to FORCE_WGET and should not be necessary.' >&2  ) > /dev/null
        #local currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")
		local currentURL
		[[ "$GH_TOKEN" != "" ]] && currentURL=$(_wget_githubRelease-API_URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")
		[[ "$GH_TOKEN" == "" ]] && currentURL=$(_wget_githubRelease-URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")

		[[ "$FORCE_DIRECT" == "true" ]] && ( _messagePlain_bad 'bad: fail: FORCE_AXEL==true is NOT compatible with FORCE_DIRECT==true' >&2 ) > /dev/null && return 1

		_wget_githubRelease_loop-axel
        return "$?"
    fi

    if _if_gh
    then
        #_wget_githubRelease-address_fromTag-gh
        #local currentTag
        #currentTag=$(_wget_githubRelease-address_fromTag "$currentAbsoluteRepo" "$currentTag" "$currentFile")

        ( _messagePlain_probe _gh_download "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$@" >&2 ) > /dev/null
        _gh_download "$currentAbsoluteRepo" "$currentTag" "$currentFile" "$@"
        currentExitStatus="$?"

        [[ "$currentExitStatus" != "0" ]] && _bad_fail_githubRelease_currentExitStatus && return "$currentExitStatus"
        [[ ! -e "$currentOutFile" ]] && [[ "$currentOutFile" != "-" ]] && _bad_fail_githubRelease_missing && return 1
        return 0
    fi

    if ! _if_gh
    then
        ( _messagePlain_warn 'warn: WARNING: FALLBACK: wget/curl' >&2 ) > /dev/null
        #local currentURL=$(_wget_githubRelease-URL-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")
		local currentURL
		[[ "$GH_TOKEN" != "" ]] && currentURL=$(_wget_githubRelease-API_URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")
		[[ "$GH_TOKEN" == "" ]] && currentURL=$(_wget_githubRelease-URL_fromTag-curl "$currentAbsoluteRepo" "$currentTag" "$currentFile")

		_wget_githubRelease_loop-curl
        return "$?"
    fi
    
    return 1
}

































_wget_githubRelease-fromTag_join() {
    local currentAbsoluteRepo="$1"
	local currentReleaseTag="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	[[ "$currentOutParameter" != "-O" ]] && currentOutFile="$currentFile"
	#[[ "$currentOutParameter" == "-O" ]] && currentOutFile="$currentOutFile"

	#[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && currentOutFile="$currentFile"
	[[ "$currentOutParameter" == "-O" ]] && [[ "$currentOutFile" == "" ]] && ( _messagePlain_bad 'bad: fail: unexpected: unspecified: currentOutFile' >&2 ) > /dev/null && return 1

	if [[ "$currentOutParameter" == "-O" ]]
	then
		shift
		shift
	fi

	[[ "$currentOutFile" != "-" ]] && rm -f "$currentOutFile" > /dev/null 2>&1


	# ATTENTION
	currentFile=$(basename "$currentFile")




	( _messagePlain_probe_safe _wget_githubRelease-fromTag_join "$@" >&2 ) > /dev/null

	_messagePlain_probe_safe _wget_githubRelease-fromTag_join-stdout "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile" "$@" '>' "$currentOutFile" >&2
	_wget_githubRelease-fromTag_join-stdout "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile" "$@" > "$currentOutFile"

	[[ ! -e "$currentOutFile" ]] && _messagePlain_bad 'missing: '"$1"' '"$2"' '"$3" && return 1

	return 0
}




_wget_githubRelease-fromTag_join-stdout() {
	"$scriptAbsoluteLocation" _wget_githubRelease-fromTag_join_sequence-stdout "$@"
}
_wget_githubRelease-fromTag_join_sequence-stdout() {
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/\/ init: _wget_githubRelease-fromTag_join-stdout' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-fromTag_join-stdout "$@" >&2 ) > /dev/null

	local currentAbsoluteRepo="$1"
	local currentReleaseTag="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			#echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi


    _set_wget_githubRelease "$@"


    local currentPart
    local currentSkip
    local currentStream
	local currentStream_wait
	local currentBusyStatus

	# CAUTION: Any greater than 50 is not expected to serve any purpose, may exhaust expected API rate limits, may greatly delay download, and may disrupt subsequent API requests. Any less than 50 may fall below the ~100GB capacity that is both expected necessary for some complete toolchains and at the limit of ~100GB archival quality optical disc (ie. M-Disc) .
	#local maxCurrentPart=50

	# ATTENTION: Graceful degradation to a maximum part count of 49 can be achieved by reducing API calls using the _curl_githubAPI_releases_join-skip function. That single API call can get 100 results, leaving 49 unused API calls remaining to get API_URL addresses to download 49 parts. Files larger than ~200GB are likely rare, specialized.
	#local maxCurrentPart=98

	# ATTENTION: In practice, 128GB storage media - reputable brand BD-XL near-archival quality optical disc, SSDs, etc - is the maximum file size that is convenient.
	# '1997537280' bytes truncate/tail
	# https://en.wikipedia.org/wiki/Blu-ray
	#  '128,001,769,472' ... 'Bytes'
	# https://fy.chalmers.se/~appro/linux/DVD+RW/Blu-ray/
	#  'only inner spare area of 256MB'
	local maxCurrentPart=63


    local currentExitStatus=1



    (( [[ "$FORCE_BUFFER" == "true" ]] && [[ "$FORCE_DIRECT" == "true" ]] ) || ( [[ "$FORCE_BUFFER" == "false" ]] && [[ "$FORCE_DIRECT" == "false" ]] )) && ( _messagePlain_bad 'bad: fail: FORCE_BUFFER , FORCE_DIRECT: conflict' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1

	[[ "$FORCE_PARALLEL" == "1" ]] && ( _messagePlain_bad 'bad: fail: FORCE_PARALLEL: sanity' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
	[[ "$FORCE_PARALLEL" == "0" ]] && ( _messagePlain_bad 'bad: fail: FORCE_PARALLEL: sanity' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
    
    [[ "$FORCE_AXEL" != "" ]] && [[ "$FORCE_DIRECT" == "true" ]] && ( _messagePlain_bad 'bad: fail: FORCE_AXEL is NOT compatible with FORCE_DIRECT==true' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1

    [[ "$FORCE_AXEL" != "" ]] && ( _messagePlain_warn 'warn: WARNING: FORCE_AXEL not empty' >&2 ; echo 'FORCE_AXEL may have similar effects to FORCE_WGET and should not be necessary.' >&2  ) > /dev/null



    _if_buffer() {
        if ( [[ "$FORCE_BUFFER" == "true" ]] || [[ "$FORCE_DIRECT" == "false" ]] ) || [[ "$FORCE_BUFFER" == "" ]]
        then
            true
            return
        else
            false
            return
        fi
        true
        return
    }


    
    # WARNING: FORCE_DIRECT="true" , "FORCE_BUFFER="false" very strongly discouraged. Any retry/continue of any interruption will nevertheless unavoidably result in a corrupted output stream.
    if ! _if_buffer
    then
        #export FORCE_DIRECT="true"

        _set_wget_githubRelease-detect "$@"
        currentSkip="skip"

        currentStream="noBuf"
        #local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	    #local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"

		maxCurrentPart=$(_curl_githubAPI_releases_fromTag_join-skip "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile")

        currentPart=""
        for currentPart in $(seq -f "%02g" 0 "$maxCurrentPart" | sort -r)
        do
            if [[ "$currentSkip" == "skip" ]]
            then
				# ATTENTION: Could expect to use the 'API_URL' function in both cases, since we are not using the resulting URL except to 'skip'/'download' .
				#currentSkip=$(_wget_githubRelease-skip-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part"$currentPart")
				[[ "$GH_TOKEN" != "" ]] && currentSkip=$(_wget_githubRelease-skip-API_URL_fromTag-curl "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part"$currentPart")
				[[ "$GH_TOKEN" == "" ]] && currentSkip=$(_wget_githubRelease-skip-URL_fromTag-curl "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part"$currentPart")
                #[[ "$?" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
                #[[ "$?" != "0" ]] && currentSkip="skip"
                [[ "$?" != "0" ]] && ( _messagePlain_warn 'bad: FAIL: _wget_githubRelease-skip-API_URL_fromTag-curl' >&2 ) > /dev/null
            fi
            
            [[ "$currentSkip" == "skip" ]] && continue

            
            if [[ "$currentExitStatus" == "0" ]] || [[ "$currentSkip" != "skip" ]]
            then
                _set_wget_githubRelease "$@"
                currentSkip="download"
            fi


            _wget_githubRelease-fromTag_procedure "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part"$currentPart" -O - "$@"
            currentExitStatus="$?"
            #[[ "$currentExitStatus" != "0" ]] && break
        done

        return "$currentExitStatus"
    fi





	# ### ATTENTION: _if_buffer (IMPLICIT)

	# NOTICE: Parallel downloads may, if necessary, be adapted to first cache a list of addresses (ie. URLs) to download. API rate limits could then have as much time as possible to recover before subsequent commands (eg. analysis of builds). Such a cache must be filled with addresses BEFORE the download loop.


	export currentAxelTmpFileUID="$(_uid 14)"
	_axelTmp() {
		echo .m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID"
	}
	local currentAxelTmpFile
	#currentAxelTmpFile="$scriptAbsoluteFolder"/$(_axelTmp)

	local currentStream_min=1
	local currentStream_max=3
	[[ "$FORCE_PARALLEL" != "" ]] && currentStream_max="$FORCE_PARALLEL"

	currentStream="$currentStream_min"


	currentPart="$maxCurrentPart"


	_set_wget_githubRelease-detect "$@"
	currentSkip="skip"

	maxCurrentPart=$(_curl_githubAPI_releases_fromTag_join-skip "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile")

	currentPart=""
	for currentPart in $(seq -f "%02g" 0 "$maxCurrentPart" | sort -r)
	do
		if [[ "$currentSkip" == "skip" ]]
		then
			# ATTENTION: EXPERIMENT
			# ATTENTION: Could expect to use the 'API_URL' function in both cases, since we are not using the resulting URL except to 'skip'/'download' .
			#currentSkip=$(_wget_githubRelease-skip-API_URL-curl "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part"$currentPart")
			##currentSkip=$([[ "$currentPart" -gt "17" ]] && echo 'skip' ; true)
			[[ "$GH_TOKEN" != "" ]] && currentSkip=$(_wget_githubRelease-skip-API_URL_fromTag-curl "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part"$currentPart")
			[[ "$GH_TOKEN" == "" ]] && currentSkip=$(_wget_githubRelease-skip-URL_fromTag-curl "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part"$currentPart")
			
			#[[ "$?" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-skip-API_URL-curl' >&2 ) > /dev/null && ( _messageError 'FAIL' >&2 ) > /dev/null && exit 1
			#[[ "$?" != "0" ]] && currentSkip="skip"
			[[ "$?" != "0" ]] && ( _messagePlain_warn 'bad: FAIL: _wget_githubRelease-skip-API_URL_fromTag-curl' >&2 ) > /dev/null
		fi
		
		[[ "$currentSkip" == "skip" ]] && continue

		#[[ "$currentExitStatus" == "0" ]] || 
		if [[ "$currentSkip" != "skip" ]]
		then
			_set_wget_githubRelease "$@"
			currentSkip="download"
			break
		fi
	done

	export currentSkipPart="$currentPart"
	[[ "$currentStream_max" -gt "$currentSkipPart" ]] && currentStream_max=$(( "$currentSkipPart" + 1 ))

	"$scriptAbsoluteLocation" _wget_githubRelease-fromTag_join_sequence-parallel "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile" &


	# Prebuffer .
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  preBUFFER: WAIT  ...  currentPart='"$currentPart" >&2 ) > /dev/null
	if [[ "$currentPart" -ge "01" ]] && [[ "$currentStream_max" -ge "2" ]]
	then
		#currentStream="2"
		for currentStream in $(seq "$currentStream_min" "$currentStream_max" | sort -r)
		do
			( _messagePlain_probe 'prebuffer: currentStream= '"$currentStream" >&2 ) > /dev/null
			while ( ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] )
			do
				sleep 3
			done
		done
	fi
	currentStream="$currentStream_min"


	for currentPart in $(seq -f "%02g" 0 "$currentSkipPart" | sort -r)
	do
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  outputLOOP  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
	#( _messagePlain_probe_var currentPart >&2 ) > /dev/null
	#( _messagePlain_probe_var currentStream >&2 ) > /dev/null

		# Stream must have written PASS/FAIL file .
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  outputLOOP: WAIT: PASS/FAIL ... currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		while ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).busy ]] || ( ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && ! [[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] )
		do
			sleep 1
		done
		
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  outputLOOP: OUTPUT  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		# ATTENTION: EXPERIMENT
		#status=none
		dd if="$scriptAbsoluteFolder"/$(_axelTmp) bs=1M
		#cat "$scriptAbsoluteFolder"/$(_axelTmp)
		#dd if="$scriptAbsoluteFolder"/$(_axelTmp) bs=1M | pv --rate-limit 100M 2>/dev/null
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && currentSkip="download"
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] && [[ "$currentSkip" != "skip" ]] && ( _messageError 'FAIL' >&2 ) > /dev/null && return 1

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  outputLOOP: DELETE  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		rm -f "$scriptAbsoluteFolder"/$(_axelTmp) > /dev/null 2>&1
		rm -f "$scriptAbsoluteFolder"/$(_axelTmp).busy > /dev/null 2>&1

		let currentStream=currentStream+1
		[[ "$currentStream" -gt "$currentStream_max" ]] && currentStream="$currentStream_min"
	done

	true
}
_wget_githubRelease-fromTag_join_sequence-parallel() {
	local currentAbsoluteRepo="$1"
	local currentReleaseTag="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			#echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi


	#export currentAxelTmpFileUID="$(_uid 14)"
	_axelTmp() {
		echo .m_axelTmp_"$currentStream"_"$currentAxelTmpFileUID"
	}
	#local currentAxelTmpFile
	#currentAxelTmpFile="$scriptAbsoluteFolder"/$(_axelTmp)

	# Due to parallelism , only API rate limits, NOT download speeds, are a concern with larger number of retries. 
	_set_wget_githubRelease "$@"
	#_set_wget_githubRelease-detect "$@"
	#_set_wget_githubRelease-detect-parallel "$@"
	local currentSkip="skip"
	
	local currentStream_min=1
	local currentStream_max=3
	[[ "$FORCE_PARALLEL" != "" ]] && currentStream_max="$FORCE_PARALLEL"
	[[ "$currentStream_max" -gt "$currentSkipPart" ]] && currentStream_max=$(( "$currentSkipPart" + 1 ))
	
	currentStream="$currentStream_min"
	for currentPart in $(seq -f "%02g" 0 "$currentSkipPart" | sort -r)
	do
	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  downloadLOOP  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
	#( _messagePlain_probe_var currentPart >&2 ) > /dev/null
	#( _messagePlain_probe_var currentStream >&2 ) > /dev/null

		# Slot in use. Downloaded  "$scriptAbsoluteFolder"/$(_axelTmp)  file will be DELETED after use by calling process.
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BUSY  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		while ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp) > /dev/null 2>&1 ) || ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp).busy > /dev/null 2>&1 )
		do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BUSY  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
			sleep 1
		done

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: detect skip  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).PASS ]] && _set_wget_githubRelease "$@" && currentSkip="download"
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).FAIL ]] && [[ "$currentSkip" != "skip" ]] && ( _messageError 'FAIL' >&2 ) > /dev/null && return 1

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: DELETE  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		rm -f "$scriptAbsoluteFolder"/$(_axelTmp).PASS > /dev/null 2>&1
		rm -f "$scriptAbsoluteFolder"/$(_axelTmp).FAIL > /dev/null 2>&1

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: DELAY: stagger, Inter-Process Communication, _stop  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		# Staggered Delay.
		[[ "$currentPart" == "$currentSkipPart" ]] && sleep 2
		[[ "$currentPart" != "$currentSkipPart" ]] && sleep 6
		# Inter-Process Communication Delay.
		# Prevents new download from starting before previous download process has done  rm -f "$currentAxelTmpFile"*  .
		#  Beware that  rm  is inevitable or at least desirable - called by _stop() through trap, etc.
		sleep 7
		
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: DOWNLOAD  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		export currentAxelTmpFile="$scriptAbsoluteFolder"/$(_axelTmp)
		"$scriptAbsoluteLocation" _wget_githubRelease-fromTag_procedure-join "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile".part$(printf "%02g" "$currentPart") &
		echo "$!" > "$scriptAbsoluteFolder"/$(_axelTmp).pid

		# Stream must have written either in-progress download or PASS/FAIL file .
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BEGIN  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
		while ! ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp)* > /dev/null 2>&1 )
		do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  downloadLOOP: WAIT: BEGIN  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
			sleep 0.6
		done

		let currentStream=currentStream+1
		[[ "$currentStream" -gt "$currentStream_max" ]] && currentStream="$currentStream_min"
	done

	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  download: DELETE' >&2 ) > /dev/null
	for currentStream in $(seq "$currentStream_min" "$currentStream_max")
	do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  download: WAIT: BUSY  ...  currentStream='"$currentStream" >&2 ) > /dev/null
		while ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp) > /dev/null 2>&1 ) || ( ls -1 "$scriptAbsoluteFolder"/$(_axelTmp).busy > /dev/null 2>&1 )
		do
		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  download: WAIT: BUSY  ...  currentStream='"$currentStream" >&2 ) > /dev/null
			sleep 1
		done

		( _messagePlain_nominal '\/\/\/\/\/ \/\/\/  download: DELETE ...  currentStream='"$currentStream" >&2 ) > /dev/null
		rm -f "$scriptAbsoluteFolder"/$(_axelTmp).PASS > /dev/null 2>&1
		rm -f "$scriptAbsoluteFolder"/$(_axelTmp).FAIL > /dev/null 2>&1
	done

	( _messagePlain_nominal '\/\/\/\/\/ \/\/\/\/  download: WAIT PID  ...  currentPart='"$currentPart"' currentStream='"$currentStream" >&2 ) > /dev/null
	for currentStream in $(seq "$currentStream_min" "$currentStream_max")
	do
		[[ -e "$scriptAbsoluteFolder"/$(_axelTmp).pid ]] && _pauseForProcess $(cat "$scriptAbsoluteFolder"/$(_axelTmp).pid) > /dev/null
	done
	wait >&2

	true
}
_wget_githubRelease-fromTag_procedure-join() {
	( _messagePlain_probe_safe _wget_githubRelease-fromTag_procedure-join "$@" >&2 ) > /dev/null

	local currentAbsoluteRepo="$1"
	local currentReleaseTag="$2"
	local currentFile="$3"

	local currentOutParameter="$4"
	local currentOutFile="$5"

	shift
	shift
	shift
	if [[ "$currentOutParameter" == "-O" ]]
	then
		if [[ "$currentOutFile" != "-" ]]
		then
			( _messagePlain_bad 'bad: fail: unexpected: currentOutFile: NOT stdout' >&2 ) > /dev/null
			echo "1" > "$currentAxelTmpFile".FAIL
			return 1
		fi
		shift 
		shift
	fi

	#local currentAxelTmpFileRelative=.m_axelTmp_"$currentStream"_$(_uid 14)
	#local currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"

	local currentExitStatus

	echo -n > "$currentAxelTmpFile".busy

	# ATTENTION: EXPERIMENT
	_wget_githubRelease-fromTag_procedure "$currentAbsoluteRepo" "$currentReleaseTag" "$currentFile" -O "$currentAxelTmpFile" "$@"
    #dd if=/dev/zero bs=1M count=1500 > "$currentAxelTmpFile"
	#echo "$currentFile" >> "$currentAxelTmpFile"
    #dd if=/dev/urandom bs=1M count=1500 | pv --rate-limit 300M 2>/dev/null > "$currentAxelTmpFile"
	currentExitStatus="$?"

	# Inter-Process Communication Delay
	# Essentially a 'minimum download time' .
	sleep 7

	[[ "$currentExitStatus" == "0" ]] && echo "$currentExitStatus" > "$currentAxelTmpFile".PASS
	if [[ "$currentExitStatus" != "0" ]]
	then
		echo -n > "$currentAxelTmpFile"
		echo "$currentExitStatus" > "$currentAxelTmpFile".FAIL
	fi

    while [[ -e "$currentAxelTmpFile" ]] || [[ -e "$currentAxelTmpFile".busy ]] || [[ -e "$currentAxelTmpFile".PASS ]] || [[ -e "$currentAxelTmpFile".FAIL ]]
    do
        sleep 1
    done

    [[ "$currentAxelTmpFile" != "" ]] && rm -f "$currentAxelTmpFile".*

    #unset currentAxelTmpFile

    [[ "$currentExitStatus" == "0" ]] && return 0
    return "$currentExitStatus"
}


































































































































#./ubiquitous_bash.sh _wget_githubRelease-releasesTags soaringDistributions/ubDistBuild 20
#./ubiquitous_bash.sh _wget_githubRelease_procedure-releasesTags-curl soaringDistributions/ubDistBuild 20
#./ubiquitous_bash.sh _wget_githubRelease_procedure-releasesTags-gh soaringDistributions/ubDistBuild 20
_wget_githubRelease_procedure-releasesTags-curl() {
	local currentAbsoluteRepo="$1"
    local currentQuantity="$2"
    [[ "$currentQuantity" == "0" ]] && currentQuantity=20

	#local currentReleaseLabel="$2"
	#local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	#[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	#[[ "$currentFile" == "" ]] && return 1


	local currentExitStatus_tmp=0
	local currentExitStatus=0


    local currentData
    currentData=""
    
    local currentData_page
    currentData_page="doNotMatch"
    
    local currentIteration
    currentIteration=1
    
    # ATTRIBUTION-AI: Many-Chat 2025-03-23
    # Alternative detection of empty array, as suggested by AI LLM .
    #[[ $(jq 'length' <<< "$currentData_page") -gt 0 ]]
    while ( [[ "$currentData_page" != "" ]] && [[ $(_safeEcho_newline "$currentData_page" | tr -dc 'a-zA-Z\[\]' | sed '/^$/d') != $(echo 'WwoKXQo=' | base64 -d | tr -dc 'a-zA-Z\[\]') ]] ) && ( [[ "$currentIteration" -le "1" ]] || ( [[ "$GH_TOKEN" != "" ]] && [[ "$currentIteration" -le "3" ]] ) )
    do
        #currentData_page=$(_curl_githubAPI_releases_page "$currentAbsoluteRepo" "$currentReleaseLabel" "$currentFile" "$currentIteration")
        # ATTENTION: FORCE curl retry , since we will not be doing prebuffering (or downloading any files) directly with 'releasesTags' .
        _set_curl_github_retry
        currentData_page=$(_curl_githubAPI_releases_page "$currentAbsoluteRepo" "doNotMatch" "doNotMatch" "$currentIteration" "$currentFailParam" "${curl_retries_args[@]}")
        unset curl_retries_args
        currentExitStatus_tmp="$?"
        [[ "$currentIteration" == "1" ]] && currentExitStatus="$currentExitStatus_tmp"
        currentData="$currentData"'
'"$currentData_page"
        
        ( _messagePlain_probe "_wget_githubRelease_procedure-releasesTags-curl: ""$currentIteration" >&2 ) > /dev/null
        [[ "$currentIteration" -ge 4 ]] && ( _safeEcho_newline "$currentData_page" >&2 ) > /dev/null

        let currentIteration=currentIteration+1
    done

    #( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_releasesTags "" "$currentReleaseLabel" "$currentFile" | head -n 1 )
    ( set -o pipefail ; _safeEcho_newline "$currentData" | jq -r 'sort_by(.published_at) | reverse | .[].tag_name' | tr -dc 'a-zA-Z0-9\-_.:\n' | sed '/^$/d' | head -n "$currentQuantity" )
    currentExitStatus_tmp="$?"

    [[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-releasesTags-curl: _curl_githubAPI_releases_page: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
    [[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-releasesTags-curl: pipefail: jq: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"
    [[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-releasesTags-curl: empty: currentData' >&2 ) > /dev/null && return 1
    
    return 0
}
_wget_githubRelease-releasesTags-backend-curl() {
	local currentReleasesTags
	currentReleasesTags=""

	local currentExitStatus=1

	local currentIteration=0

	#export githubRelease_retriesMax=2
	#export githubRelease_retriesWait=4
	#[[ "$currentReleasesTags" == "" ]] || 
	while ( [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		currentReleasesTags=""

		if [[ "$currentIteration" != "0" ]]
		then
			( _messagePlain_warn 'warn: BAD: RETRY: _wget_githubRelease-URL-curl: _wget_githubRelease_procedure-releasesTags-curl: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe _wget_githubRelease_procedure-releasesTags-curl >&2 ) > /dev/null
		currentReleasesTags=$(_wget_githubRelease_procedure-releasesTags-curl "$@")
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
    #_set_wget_githubRelease
	
	_safeEcho_newline "$currentReleasesTags"

	[[ "$currentIteration" -ge "$githubRelease_retriesMax" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-URL-curl: maxRetries' >&2 ) > /dev/null && return 1

	return 0
}
_wget_githubRelease-releasesTags-curl() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-URL-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-releasesTags-curl' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-releasesTags-curl "$@" >&2 ) > /dev/null

    _wget_githubRelease-releasesTags-backend-curl "$@"
    return
}

_wget_githubRelease_procedure-releasesTags-gh-awk() {
	awk '
        # Skip a header line if it appears first:
        NR == 1 && $1 == "TITLE" && $2 == "TYPE" {
            # Just move on to the next line and do nothing else
            next
        }

        {
            # If the second column is one of the known “types,” shift fields left so
            # the *real* tag moves into $2. Repeat until no more known types remain.
            while ($2 == "Latest" || $2 == "draft" || $2 == "pre-release" || $2 == "prerelease") {
            for (i=2; i<NF; i++) {
                $i = $(i+1)
            }
            NF--
            }
            # At this point, $2 is guaranteed to be the actual tag.
            print $2
		}
		'
}
# Requires "$GH_TOKEN" .
_wget_githubRelease_procedure-releasesTags-gh() {
	( _messagePlain_nominal "$currentStream"'\/\/\/ init: _wget_githubRelease_procedure-releasesTags-gh' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease_procedure-releasesTags-gh "$@" >&2 ) > /dev/null
    ! _if_gh && return 1
	
	local currentAbsoluteRepo="$1"
    local currentQuantity="$2"
    [[ "$currentQuantity" == "0" ]] && currentQuantity=20
    
	#local currentReleaseLabel="$2"
	#local currentFile="$3"

	[[ "$currentAbsoluteRepo" == "" ]] && return 1
	#[[ "$currentReleaseLabel" == "" ]] && currentReleaseLabel="latest"
	#[[ "$currentFile" == "" ]] && return 1


	local currentExitStatus_tmp=0
	local currentExitStatus=0


    local currentData
    currentData=""
    
    local currentData_page
    currentData_page="doNotMatch"
    
    local currentIteration
    currentIteration=1
    
    while ( [[ "$currentData_page" != "" ]] && ( [[ "$currentIteration" -le "1" ]] || ( [[ "$GH_TOKEN" != "" ]] && [[ "$currentIteration" -le "3" ]] ) ) )
    do
        currentData_page=$(set -o pipefail ; gh release list -L $(( $currentIteration * 100 )) -R "$currentAbsoluteRepo" | _wget_githubRelease_procedure-releasesTags-gh-awk | tr -dc 'a-zA-Z0-9\-_.:\n' | tail -n +$(( $currentIteration * 100 - 100 + 1 )))
        currentExitStatus_tmp="$?"
        [[ "$currentIteration" == "1" ]] && currentExitStatus="$currentExitStatus_tmp"
        currentData="$currentData"'
'"$currentData_page"

        ( _messagePlain_probe "_wget_githubRelease_procedure-releasesTags-gh: ""$currentIteration" >&2 ) > /dev/null
        [[ "$currentIteration" -ge 4 ]] && ( _safeEcho_newline "$currentData_page" >&2 ) > /dev/null

        let currentIteration=currentIteration+1
    done

    #( set -o pipefail ; _safeEcho_newline "$currentData" | _jq_github_browser_download_releasesTags "" "$currentReleaseLabel" "$currentFile" | head -n 1 )
    #( set -o pipefail ; _safeEcho_newline "$currentData" | jq -r 'sort_by(.published_at) | reverse | .[].tag_name' | head -n "$currentQuantity" | tr -dc 'a-zA-Z0-9\-_.:\n' )
    ( set -o pipefail ; _safeEcho_newline "$currentData" | tr -dc 'a-zA-Z0-9\-_.:\n' | sed '/^$/d' | head -n "$currentQuantity" )
    currentExitStatus_tmp="$?"

    [[ "$currentExitStatus" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-releasesTags-gh: gh: currentExitStatus' >&2 ) > /dev/null && return "$currentExitStatus"
    [[ "$currentExitStatus_tmp" != "0" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-releasesTags-gh: pipefail: head: currentExitStatus_tmp' >&2 ) > /dev/null && return "$currentExitStatus_tmp"
    [[ "$currentData" == "" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease_procedure-releasesTags-gh: empty: currentData' >&2 ) > /dev/null && return 1

    return 0
}
_wget_githubRelease-releasesTags-gh() {
	# Similar retry logic for all similar functions: _wget_githubRelease-URL-curl, _wget_githubRelease-releasesTags-gh .
	( _messagePlain_nominal "$currentStream"'\/\/\/\/ init: _wget_githubRelease-releasesTags-gh' >&2 ) > /dev/null
	( _messagePlain_probe_safe _wget_githubRelease-releasesTags-gh "$@" >&2 ) > /dev/null
    ! _if_gh && return 1

	local currentTag
	currentTag=""

	local currentExitStatus=1

	local currentIteration=0

	while ( [[ "$currentTag" == "" ]] || [[ "$currentExitStatus" != "0" ]] ) && [[ "$currentIteration" -lt "$githubRelease_retriesMax" ]]
	do
		currentTag=""

		if [[ "$currentIteration" != "0" ]]
		then 
			( _messagePlain_warn 'warn: BAD: RETRY: _wget_githubRelease-releasesTags-gh: _wget_githubRelease_procedure-releasesTags-gh: currentIteration != 0' >&2 ) > /dev/null
			sleep "$githubRelease_retriesWait"
		fi

		( _messagePlain_probe _wget_githubRelease_procedure-releasesTags-gh >&2 ) > /dev/null
		currentTag=$(_wget_githubRelease_procedure-releasesTags-gh "$@")
		currentExitStatus="$?"

		let currentIteration=currentIteration+1
	done
	
	_safeEcho_newline "$currentTag"

	[[ "$currentIteration" -ge "$githubRelease_retriesMax" ]] && ( _messagePlain_bad 'bad: FAIL: _wget_githubRelease-releasesTags-gh: maxRetries' >&2 ) > /dev/null && return 1

	return 0
}

_wget_githubRelease-releasesTags() {
	( _messagePlain_nominal "$currentStream"'\/\/\/\/\/ init: _wget_githubRelease-releasesTags' >&2 ) > /dev/null
	if _if_gh
	then
		( _messagePlain_probe_safe _wget_githubRelease-releasesTags-gh "$@" >&2 ) > /dev/null
		_wget_githubRelease-releasesTags-gh "$@"
		return
	else
		( _messagePlain_probe_safe _wget_githubRelease-releasesTags-curl "$@" >&2 ) > /dev/null
		_wget_githubRelease-releasesTags-curl "$@"
		return
	fi
}


















# _upgrade-import-assets corpName
_upgrade-import-assets() {
    "$scriptAbsoluteLocation" _upgrade_sequence-import-assets "$@"
}
_upgrade_sequence-import-assets() {
    local corpName="$1"


	_start

	! cd "$safeTmp" && _messageFAIL

    export INPUT_GITHUB_TOKEN="$GH_TOKEN"
	if ! ( type _gitBest > /dev/null 2>&1 && "$scriptAbsoluteLocation" _gitBest clone --depth 1 'git@github.com:soaringDistributions/zImport_corp_'"$corpName"'.git' )
	then
		if ls -1 "$HOME"/.ssh/id_* > /dev/null
		then
			if ! git clone --depth 1 'git@github.com:soaringDistributions/zImport_corp_'"$corpName"'.git'
			then
                export safeToDeleteGit="true"
                _messagePlain_bad 'bad: upgrade-import-assets-'"$corpName"': git: FAIL: fail'
				_messageFAIL
				_stop 1
				exit 1
            fi
		else
            export safeToDeleteGit="true"
			_messagePlain_bad 'bad: upgrade-import-assets-'"$corpName"': git: FAIL: no remote permissions'
			_messageFAIL
			_stop 1
			exit 1
		fi
	fi

	mkdir -p "$scriptLib"/zImport_corp_"$corpName"
	mv -f "$safeTmp"/zImport_corp_"$corpName"/*.sh "$scriptLib"/zImport_corp_"$corpName"/
	mv -f "$safeTmp"/zImport_corp_"$corpName"/*.yml "$scriptLib"/zImport_corp_"$corpName"/
	mv -f "$safeTmp"/zImport_corp_"$corpName"/*.txt "$scriptLib"/zImport_corp_"$corpName"/
	mv -f "$safeTmp"/zImport_corp_"$corpName"/*.md "$scriptLib"/zImport_corp_"$corpName"/

    export safeToDeleteGit="true"
	_stop
}


# ### NOTICE ###
# gitCompendium
# custom/upgrade functions for git repositories and for all git repositories owned by an organization
# Mostly used by ubDistBuild and derivatives to custom/upgrade Operating Systems for organizations with both the tools and development resources to backup (ie. to optical disc), create workstations, create replacement repository servers, etc. Continuous Integration (CI) can keep such a backup/workstation/replacement dist/OS always recent enough to rely on, and small enough to frequently, conveniently, distribute on the coldest of cold storage to vaults, as well as data preservation facilities.
#
# Also sometimes useful to somewhat automatically upgrade an organization's existing workstation, server, etc.



# EXAMPLE
#_ubdistChRoot_backend_begin
#_backend_override _compendium_git-custom-repo installations,infrastructure,c/Corporation_ABBREVIATION GitHub_ORGANIZATION,USER repositoryName --depth 1
#_ubdistChRoot_backend_end

# EXAMPLE
#_repo-GitHub_ORGANIZATION() { _backend_override _compendium_git-custom-repo installations,infrastructure,c/Corporation_ABBREVIATION GitHub_ORGANIZATION,USER repositoryName --depth 1 ; }
#_ubdistChRoot_backend _repo-GitHub_ORGANIZATION



# DANGER: Only use within ephemeral CI, ChRoot, etc.
#_compendium_gitFresh
# |___ _compendium_gitFresh_sequence


#_compendium_git-upgrade-repo
# |___ _compendium_git-custom-repo
#
#     |___ _compendium_git_sequence-custom-repo


#_compendium_git-upgrade-repo-org
# |___ _compendium_git-custom-repo-org
#
#     |___ _compendium_git_sequence_sequence-custom-repo-org *
#         |___ _compendium_git_sequence-custom-repo-org
#
#             |___ _compendium_git-custom-repo


#_compendium_git-upgrade-repo-user
# |___ _compendium_git-custom-repo-user
#
#     |___ _compendium_git_sequence_sequence-custom-repo-user *
#         |___ _compendium_git_sequence-custom-repo-org
#
#             |___ _compendium_git-custom-repo




#_ubdistChRoot _compendium_git-custom-repo installations,infrastructure,c/Corporation_ABBREVIATION GitHub_ORGANIZATION,USER repositoryName --depth 1
_compendium_git_sequence-custom-repo() {
    _messageNormal '\/ \/ \/ _compendium_git-custom-repo: '"$@"

    _start
    local functionEntryPWD
    functionEntryPWD="$PWD"

    local current_coreSubDir="$1"
    local current_GitHubORGANIZATION="$2"
    local current_repositoryName="$3"

    shift ; shift ; shift

    [[ "$GH_TOKEN" == "" ]] && _messagePlain_warn 'warn: missing: GH_TOKEN'

    export INPUT_GITHUB_TOKEN="$GH_TOKEN"

    if [[ -e /home/user/core/"$current_coreSubDir"/"$current_repositoryName" ]]
    then
        [[ "$ub_dryRun" != "true" ]] && mkdir -p /home/user/core/"$current_coreSubDir"/"$current_repositoryName"
        [[ "$ub_dryRun" != "true" ]] && cd /home/user/core/"$current_coreSubDir"/"$current_repositoryName"

        _messagePlain_probe git checkout "HEAD"
        [[ "$ub_dryRun" != "true" ]] && ! git checkout "HEAD" && _messageFAIL
        _messagePlain_probe _gitBest pull
        [[ "$ub_dryRun" != "true" ]] && ! "$scriptAbsoluteLocation" _gitBest pull && _messageFAIL
        _messagePlain_probe _gitBest submodule update --init "$@" --recursive
        [[ "$ub_dryRun" != "true" ]] && ! "$scriptAbsoluteLocation" _gitBest submodule update --init "$@" --recursive && _messageFAIL
    fi

    #else
    if ! [[ -e /home/user/core/"$current_coreSubDir"/"$current_repositoryName" ]]
    then
        [[ "$ub_dryRun" != "true" ]] && mkdir -p /home/user/core/"$current_coreSubDir"
        [[ "$ub_dryRun" != "true" ]] && cd /home/user/core/"$current_coreSubDir"
        
        _messagePlain_probe _gitBest clone --recursive "$@" 'git@github.com:'"$current_GitHubORGANIZATION"'/'"$current_repositoryName"'.git'
        [[ "$ub_dryRun" != "true" ]] && ! "$scriptAbsoluteLocation" _gitBest clone --recursive "$@" 'git@github.com:'"$current_GitHubORGANIZATION"'/'"$current_repositoryName"'.git' && _messageFAIL
    fi
    
    
    [[ "$ub_dryRun" != "true" ]] && ! ls /home/user/core/"$current_coreSubDir"/"$current_repositoryName" && _messageFAIL

    cd "$functionEntryPWD"
    _stop
}
_compendium_git-custom-repo() {
    "$scriptAbsoluteLocation" _compendium_git_sequence-custom-repo "$@"
}
_compendium_git-upgrade-repo() {
    _compendium_git-custom-repo "$@"
}



#_ubdistChRoot _compendium_git-custom-repo-org c/Corporation_ABBREVIATION GitHub_ORGANIZATION --depth 1
_compendium_git_sequence-custom-repo-org() {
    _messageNormal '\/ _compendium_git_sequence-custom-repo-org: '"$@"

    _start
    local functionEntryPWD
    functionEntryPWD="$PWD"

    local current_coreSubDir="$1"
    local current_GitHubORGANIZATION="$2"

    shift ; shift


    export INPUT_GITHUB_TOKEN="$GH_TOKEN"

    [[ "$ub_dryRun" != "true" ]] && mkdir -p /home/user/core/"$current_coreSubDir"
    [[ "$ub_dryRun" != "true" ]] && cd /home/user/core/"$current_coreSubDir"

    local currentPage
    local currentRepository
    local currentRepositoryNumber

    if [[ "$ub_dryRun" == "true" ]]
    then
        currentPage=1
        currentRepository="doNotMatch"
        currentRepositoryNumber=1
        local repositoryCount="99"
        #&& [[ "$repositoryCount" -gt "0" ]]
        while [[ "$currentPage" -le "10" ]] && [[ "$repositoryCount" -gt "0" ]]
        do
            _messagePlain_probe 'repository counts...'
            # get list of repository urls
            repositoryCount=$(curl --no-fail --retry 5 --retry-delay 90 --connect-timeout 45 --max-time 600 -s -H 'Authorization: token '"$GH_TOKEN" 'https://api.github.com/'"$current_API"'/'"$current_GitHubORGANIZATION"'/repos?per_page=30&page='"$currentPage" | grep  "^    \"git_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g' | wc -w)
            
            echo "$repositoryCount"

            let currentPage="$currentPage"+1

            sleep 1
        done
    fi

    currentPage=1
    currentRepository="doNotMatch"
    currentRepositoryNumber=1
    while [[ "$currentPage" -le "10" ]] && [[ "$currentRepository" != "" ]]
    do
        currentRepository=""
        
        # ATTRIBUTION-AI: ChatGPT ...
        # https://platform.openai.com/playground/p/6it5h1B901jvAblUhdbsPHEN?model=text-davinci-003
        #curl -s https://api.github.com/"$current_API"/$current_GitHubORGANIZATION/repos?per_page=30 | jq -r '.[].git_url'
        #for currentRepository in $(curl -s -H 'Authorization: token '"$GH_TOKEN" 'https://api.github.com/'"$current_API"'/'"$current_GitHubORGANIZATION"'/repos?per_page=30&page='"$currentPage" | grep  "^    \"git_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g' | sed 's/git:\/\/github.com\/'"$current_GitHubORGANIZATION"'\//git@github.com:'"$current_GitHubORGANIZATION"'\//g')
        # ATTRIBUTION-AI: claude-37.-sonnet:thinking
        for currentRepository in $(curl --no-fail --retry 5 --retry-delay 90 --connect-timeout 45 --max-time 600 -s -H "Authorization: token $GH_TOKEN" 'https://api.github.com/'"$current_API"'/'"$current_GitHubORGANIZATION"'/repos?per_page=30&page='"$currentPage" | jq -r '.[].name' | tr -dc 'a-zA-Z0-9\-_.:\n')
        do
            sleep 1
            
            _messageNormal '\/ \/' _compendium_git-custom-repo "$current_coreSubDir" "$current_GitHubORGANIZATION" "$currentRepository" "$@"
            #_messagePlain_probe _compendium_git-custom-repo "$current_coreSubDir" "$current_GitHubORGANIZATION" "$currentRepository" "$@"
            _messagePlain_probe_var currentRepositoryNumber
            if ! _compendium_git-custom-repo "$current_coreSubDir" "$current_GitHubORGANIZATION" "$currentRepository" "$@"
            then
                _messageFAIL
            fi

            sleep 1
            let currentRepositoryNumber="$currentRepositoryNumber"+1
        done

        #[[ "$currentRepository" == "doNotMatch" ]] && currentRepository=""

        let currentPage="$currentPage"+1
    done

    cd "$functionEntryPWD"
    _stop
}
_compendium_git_sequence_sequence-custom-repo-user() {
    export current_API="users"
    "$scriptAbsoluteLocation" _compendium_git_sequence-custom-repo-org "$@"
}
_compendium_git-custom-repo-user() {
    "$scriptAbsoluteLocation" _compendium_git_sequence_sequence-custom-repo-user "$@"
}
_compendium_git-upgrade-repo-user() {
    _compendium_git-custom-repo-user "$@"
}
_compendium_git_sequence_sequence-custom-repo-org() {
    export current_API="orgs"
    "$scriptAbsoluteLocation" _compendium_git_sequence-custom-repo-org "$@"
}
_compendium_git-custom-repo-org() {
    "$scriptAbsoluteLocation" _compendium_git_sequence_sequence-custom-repo-org "$@"
}
_compendium_git-upgrade-repo-org() {
    _compendium_git-custom-repo-org "$@"
}







# DANGER: Only use within ephemeral CI, ChRoot, etc.
#_ubdistChRoot _compendium_gitFresh installations,infrastructure,c/Corporation_ABBREVIATION repositoryName --depth 1
_compendium_gitFresh() {
    if [[ "$ub_dryRun" == "true" ]]
    then
        _stop
        exit
        return
    fi

    local current_coreSubDir="$1"
    local current_repositoryName="$2"

    mkdir -p /home/user/core/"$current_coreSubDir"/"$current_repositoryName"
    
    if ! cd /home/user/core/"$current_coreSubDir"/"$current_repositoryName" || ! [[ -e /home/user/core/"$current_coreSubDir"/"$current_repositoryName" ]]
    then 
        _messageError 'bad: FAIL: cd '/home/user/core/"$current_coreSubDir"/"$current_repositoryName"
        _messageFAIL
        exit 1
    fi

    "$scriptAbsoluteLocation" _compendium_gitFresh_sequence "$current_coreSubDir" "$current_repositoryName"
}
_compendium_gitFresh_sequence() {
    if [[ "$ub_dryRun" == "true" ]]
    then
        _stop
        exit
        return
    fi

    _start

    local current_coreSubDir="$1"
    local current_repositoryName="$2"

    mkdir -p /home/user/core/"$current_coreSubDir"/"$current_repositoryName"
    
    if ! cd /home/user/core/"$current_coreSubDir"/"$current_repositoryName" || ! [[ -e /home/user/core/"$current_coreSubDir"/"$current_repositoryName" ]]
    then 
        _messageError 'bad: FAIL: cd '/home/user/core/"$current_coreSubDir"/"$current_repositoryName"
        _messageFAIL
        exit 1
    fi

    # DANGER: Only use within ephemeral CI, ChRoot, etc.
    [[ "$ub_dryRun" != "true" ]] && _gitFresh_enable
    [[ "$ub_dryRun" != "true" ]] && _gitFresh
    unset _gitFresh > /dev/null 2>&1
    unset -f _gitFresh > /dev/null 2>&1

    _stop
}






_test_bup() {
	# Forced removal of 'python2' caused some apparent disruption.
	#! _wantDep bup && echo 'warn: no bup'
	#! _wantGetDep bup && echo 'warn: no bup'
	if [[ -e /etc/issue ]] && cat /etc/issue | grep 'Ubuntu' | grep '20.04' > /dev/null 2>&1
	then
		! _typeDep bup && sudo -n apt-get install --install-recommends -y bup
	else
		_wantGetDep bup
		#_wantGetDep qalculate
	fi
	
	! man tar | grep '\-\-one-file-system' > /dev/null 2>&1 && echo 'warn: tar does not support one-file-system' && return 1
	! man tar | grep '\-\-xattrs' > /dev/null 2>&1 && echo 'warn: tar does not support xattrs'
	! man tar | grep '\-\-acls' > /dev/null 2>&1 && echo 'warn: tar does not support acls'
}

_bupNew() {
	export BUP_DIR="./.bup"
	
	[[ -e "$BUP_DIR" ]] && return 1
	
	bup init
}

_bupLog() {
	export BUP_DIR="./.bup"
	
	[[ ! -e "$BUP_DIR" ]] && return 1
	
	git --git-dir=./.bup log
}

_bupList() {
	export BUP_DIR="./.bup"
	
	[[ ! -e "$BUP_DIR" ]] && return 1
	
	if [[ "$1" == "" ]]
	then
		bup ls "HEAD"
		return
	fi
	[[ "$1" != "" ]] && bup ls "$@"
}

_bupStore() {
	export BUP_DIR="./.bup"
	
	[[ ! -e "$BUP_DIR" ]] && return 1
	
	! man tar | grep '\-\-one-file-system' > /dev/null 2>&1 && return 1
	! man tar | grep '\-\-xattrs' > /dev/null 2>&1 && return 1
	! man tar | grep '\-\-acls' > /dev/null 2>&1 && return 1
	
	if [[ "$1" == "" ]]
	then
		tar --one-file-system --xattrs --acls --exclude "$BUP_DIR" -cvf - . | bup split -n "HEAD" -vv
		return
	fi
	[[ "$1" != "" ]] && tar --one-file-system --xattrs --acls --exclude "$BUP_DIR" -cvf - . | bup split -n "$@" -vv
}

_bupRetrieve() {
	export BUP_DIR="./.bup"
	
	[[ ! -e "$BUP_DIR" ]] && return 1
	
	! man tar | grep '\-\-one-file-system' > /dev/null 2>&1 && return 1
	! man tar | grep '\-\-xattrs' > /dev/null 2>&1 && return 1
	! man tar | grep '\-\-acls' > /dev/null 2>&1 && return 1
	
	if [[ "$1" == "" ]]
	then
		bup join "HEAD" | tar --one-file-system --xattrs --acls -xf -
		return
	fi
	[[ "$1" != "" ]] && bup join "$@" | tar --one-file-system --xattrs --acls -xf -
}


#"$1" == src (file/dir)
#"$2" == dst (torrentName).torrent
#"$3" == CSV Tracker URL List (full announce URL list comma delimited) (' <url>[,<url>]* ')
#"$4" == CSV Web Seed URL List
# ./ubiquitous_bash.sh _mktorrent ./ubiquitous_bash.sh torrentName 'https://example.com/tracker,https://example1.com/tracker' 'https://example.com/ubiquitous_bash.sh,https://example1.com/ubiquitous_bash.sh'
_mktorrent_webseed() {
	if [[ "$1" == "" ]]
	then
		_messagePlain_request '"$1" == src (file/dir)'
		_messagePlain_request '"$2" == dst (torrentName).torrent'
		_messagePlain_request '"$3" == CSV Tracker URL List (full announce URL list comma delimited) ('\'' <url>[,<url>]* '\'')'
		_messagePlain_request '"$4" == CSV Web Seed URL List'
		return 1
	fi
	
	local currentSrc
	currentSrc="$1"
	local currentDst
	currentDst="$2"
	local currentTrackerCSV
	currentTrackerCSV="$3"
	local currentWebSeedCSV
	currentWebSeedCSV="$4"
	shift ; shift ; shift ; shift
	
	mktorrent -w "$currentWebSeedCSV" -a "$currentTrackerCSV" -d "$currentSrc" -n "$currentDst" "$@"
}
_mktorrent() {
	_mktorrent_webseed "$@"
}







_test_mktorrent() {
	# If not Debian, then simply accept these pacakges may not be available.
	[[ -e /etc/issue ]] && ! cat /etc/issue | grep 'Debian' > /dev/null 2>&1 && return 0
	
	_wantGetDep mktorrent
	
	#_getDep mktorrent
}







# DANGER: Of course the 'dd' command can cause severe data loss. Be careful. Maybe use 'type -p' to see function code for reference instead of calling directly.


_dd_user() {
	dd "$@" oflag=direct conv=fdatasync status=progress
}
_dd() {
	sudo -n "$scriptAbsoluteLocation" _dd_user "$@"
}

_dropCache() {
	echo 3 | sudo -n tee /proc/sys/vm/drop_caches
	sync ; echo 3 | sudo -n tee /proc/sys/vm/drop_caches
}









# WARNING: Very conservative functions, for such extraordinary situations as directly streaming from a satellite connection to optical disc using an unreliable optical disc drive, equivalent to operating a laser cutter at sub-micron precision from space.
# NOTICE: EXAMPLE functions intended for reference only. Often appropriate to instead write a custom command with less conservative parameters.
# Usually these functions should be equally applicable to DVD and BD discs, preferably very high quality BD M-Discs. DVD-RAM may also be supported, but is not recommended. Magneto-Optical discs do not need such trickery. CD-ROM and other special legacy disc types will not be needed on any routine basis, not having any of particularly good capacity, durability, or longevity.


# WARNING: May be untested. Example.
# [[ "$1" == currentFile ]]
# [[ "$2" == currentSpeed ]] # (3 is safest)
# [[ "$3" == currentDrive ]]
_growisofs() {
	local currentFile
	currentFile="$1"
	[[ "$currentFile" == "" ]] && _messagePlain_warn 'warn: unspecified: currentFile... assuming urandom'
	#[[ "$currentFile" == "" ]] && _messageFAIL
	[[ "$currentFile" == "" ]] && currentFile=/dev/urandom
	
	local currentSpeed
	currentSpeed="$2"
	[[ "$currentSpeed" == "" ]] && currentSpeed=3
	
	local currentDrive
	currentDrive="$3"
	[[ "$currentDrive" == "" ]] && _messagePlain_bad 'fail: unspecified: currentDrive'
	[[ "$currentDrive" == "" ]] && _messageFAIL
	
	_messagePlain_request 'checksum commands: '
	local current_cksum_size
	current_cksum_size=$(wc -c "$currentFile" | cut -f1 -d\  | tr -dc '0-9')
	echo sudo -n dd if=\""$currentFile"\" bs=1M \| head --bytes=\""$current_cksum_size"\" \| env CMD_ENV=xpg4 cksum
	echo sudo -n dd if=\""$currentDrive"\" bs=1M \| head --bytes=\""$current_cksum_size"\" \| env CMD_ENV=xpg4 cksum
	
	_messagePlain_nominal '_growisofs: growisofs'
	
	# STRONGLY DISCOURAGED.
	# Hash or checksum during writing only verifies downloaded data, which is ONLY useful to diagnose whether the disc drive or download was the point of failure during real-time writing of download. Unlike Magneto-Optical discs, packet writing optical disc devices can suffer buffer underrun errors, necessitating hash of the disc itself anyway.
	# ONLY use case for hash/checksum of streamed data is real-time download, usually only desired either due to near identical download and disc writing speed, or due to creating the disc from a 'live' dist/OS with no persistent storage.
	#tee >(cksum >> /dev/stderr) ; dd if=/dev/zero bs=2048 count=$(bc <<< '1000000000000 / 2048' ) )
	#tee >(openssl dgst -whirlpool -binary | xxd -p -c 256 >> "$scriptLocal"/hash-download.txt) ; dd if=/dev/zero bs=2048 count=$(bc <<< '1000000000000 / 2048' ) )
	
	# ATTENTION: Important command is just this. Writes data from cat "$currentFile" through pipe to /dev/stdin to "$currentDrive" at "$currentSpeed" . Fills remainder of disc with zeros.
	( cat "$currentFile" ; dd if=/dev/zero bs=2048 count=$(bc <<< '1000000000000 / 2048' ) ) | sudo -n growisofs -speed="$currentSpeed" -dvd-compat -Z "$currentDrive"=/dev/stdin -use-the-force-luke=notray -use-the-force-luke=spare:min -use-the-force-luke=bufsize:128m
}






# May transfer large files out of cloud CI services, or may copy files into cloud or CI services for installation.

_set_rclone_limited_file() {
	export rclone_limited_file="$scriptLocal"/rclone_limited/rclone.conf
	! [[ -e "$rclone_limited_file" ]] && export rclone_limited_file=/rclone.conf
}
_prepare_rclone_limited_file() {
	if type RCLONE_LIMITED_CONF_BASE64 > /dev/null 2>&1
	then
		export rclone_limited_conf_base64=$(RCLONE_LIMITED_CONF_BASE64)
	fi
	
	_set_rclone_limited_file
	if ! [[ -e "$rclone_limited_file" ]] && [[ "$rclone_limited_conf_base64" != "" ]]
	then
		if ! [[ -e /rclone.conf ]]
		then
			echo "$rclone_limited_conf_base64" | base64 -d | sudo -n tee /rclone.conf > /dev/null
		fi
		
		if ! [[ -e "$scriptLocal"/rclone_limited/rclone.conf ]]
		then
			mkdir -p "$scriptLocal"/rclone_limited
			echo "$rclone_limited_conf_base64" | base64 -d > "$scriptLocal"/rclone_limited/rclone.conf
		fi
	fi
	_set_rclone_limited_file
	if ! [[ -e "$rclone_limited_file" ]]
	then
		_messageError 'FAIL: missing: rclone_limited_file'
		_stop 1
	fi
	if ! [[ -s "$rclone_limited_file" ]]
	then
		_messageError 'FAIL: empty: rclone_limited_file'
		_stop 1
	fi
	return 0
}

_rclone_limited_sequence() {
	_prepare_rclone_limited_file
	
	export ub_function_override_rclone=''
	unset ub_function_override_rclone
	unset rclone
	env XDG_CONFIG_HOME="$scriptLocal"/rclone_limited rclone --config="$rclone_limited_file" "$@"
}

_rclone_limited() {
	"$scriptAbsoluteLocation" _rclone_limited_sequence "$@"
	[[ "$?" != "0" ]] && _stop 1
	return 0
}

_test_rclone_limited() {
	! _wantGetDep 'rclone' && echo 'missing: rclone'
	return 0
}



_testDistro() {
	_wantGetDep sha256sum
	_wantGetDep sha512sum
	_wantGetDep axel
}

_kernelConfig_list_here() {
	cat << CZXWXcRMTo8EmM8i4d



CZXWXcRMTo8EmM8i4d
}





_kernelConfig_reject-comments() {
	#grep -v '^\#\|\#'
	
	# Preferred for Cygwin.
	grep -v '^#\|#'
}

_kernelConfig_request() {
	local current_kernelConfig_statement
	current_kernelConfig_statement=$(cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "$1"'\=' | tr -dc 'a-zA-Z0-9\=\_')
	
	_messagePlain_request 'hazard: '"$1"': '"$current_kernelConfig_statement"
}


_kernelConfig_require-yes() {
	cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "$1"'\=y' > /dev/null 2>&1 && return 0
	return 1
}

_kernelConfig_require-module-or-yes() {
	cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "$1"'\=m' > /dev/null 2>&1 && return 0
	cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "$1"'\=y' > /dev/null 2>&1 && return 0
	return 1
}

# DANGER: Currently assuming lack of an entry is equivalent to option set as '=n' with make menuconfig or similar.
_kernelConfig_require-no() {
	cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "$1"'\=m' > /dev/null 2>&1 && return 1
	cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "$1"'\=y' > /dev/null 2>&1 && return 1
	return 0
}


_kernelConfig_warn-y__() {
	_kernelConfig_require-yes "$1" && return 0
	_messagePlain_warn 'warn: not:    Y: '"$1"
	export kernelConfig_warn='true'
	return 1
}

_kernelConfig_warn-y_m() {
	_kernelConfig_require-module-or-yes "$1" && return 0
	_messagePlain_warn 'warn: not:  M/Y: '"$1"
	export kernelConfig_warn='true'
	return 1
}

_kernelConfig_warn-n__() {
	_kernelConfig_require-no "$1" && return 0
	_messagePlain_warn 'warn: not:    N: '"$1"
	export kernelConfig_warn='true'
	return 1
}

_kernelConfig_warn-any() {
	_kernelConfig_warn-y_m "$1"
	_kernelConfig_warn-n__ "$1"
}

_kernelConfig__bad-y__() {
	_kernelConfig_require-yes "$1" && return 0
	_messagePlain_bad 'bad: not:     Y: '"$1"
	export kernelConfig_bad='true'
	return 1
}

_kernelConfig__bad-y_m() {
	_kernelConfig_require-module-or-yes "$1" && return 0
	_messagePlain_bad 'bad: not:   M/Y: '"$1"
	export kernelConfig_bad='true'
	return 1
}

_kernelConfig__bad-n__() {
	_kernelConfig_require-no "$1" && return 0
	_messagePlain_bad 'bad: not:     N: '"$1"
	export kernelConfig_bad='true'
	return 1
}

_kernelConfig_require-tradeoff-legacy() {
	_messagePlain_nominal 'kernelConfig: tradeoff-legacy'
	_messagePlain_request 'Carefully evaluate '\''tradeoff-legacy'\'' for specific use cases.'
	export kernelConfig_file="$1"
	
	_kernelConfig__bad-n__ LEGACY_VSYSCALL_EMULATE
}

# WARNING: May be untested .
# WARNING: May not identify drastically performance degrading features from harden-NOTcompatible .
# WARNING: Risk must be evaluated for specific use cases.
# WARNING: Insecure.
# Standalone simulators (eg. flight sim):
# * May have hard real-time frame latency limits within 10% of the fastest avaialble from a commercially avaialble CPU.
# * May be severely single-thread CPU constrained.
# * May have real-time workloads exactly matching those suffering half performance due to security mitigations.
# * May not require real-time security mitigations.
# Disabling hardening may as much as double performance for some workloads.
# https://www.phoronix.com/scan.php?page=article&item=linux-retpoline-benchmarks&num=2
# https://www.phoronix.com/scan.php?page=article&item=linux-416early-spectremelt&num=4
_kernelConfig_require-tradeoff-perform() {
	_messagePlain_nominal 'kernelConfig: tradeoff-perform'
	_messagePlain_request 'Carefully evaluate '\''tradeoff-perform'\'' for specific use cases.'
	export kernelConfig_file="$1"

	_kernelConfig__bad-n__ CONFIG_RETPOLINE
	_kernelConfig__bad-n__ CONFIG_PAGE_TABLE_ISOLATION
	
	# May have been removed from upstream.
	#_kernelConfig__bad-n__ CONFIG_X86_SMAP
	
	_kernelConfig_warn-n__ CONFIG_X86_INTEL_TSX_MODE_OFF
	_kernelConfig_warn-n__ CONFIG_X86_INTEL_TSX_MODE_AUTO
	_kernelConfig__bad-y__ CONFIG_X86_INTEL_TSX_MODE_ON
	
	
	_kernelConfig__bad-n__ CONFIG_SLAB_FREELIST_HARDENED
	
	# Uncertain.
	_kernelConfig__bad-__n CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
	
	
	_kernelConfig__bad-__n CONFIG_RANDOMIZE_BASE
	_kernelConfig__bad-__n CONFIG_RANDOMIZE_MEMORY


	# Special.
	#_kernelConfig_warn-n__ CONFIG_HAVE_INTEL_TXT
	_kernelConfig_warn-n__ CONFIG_INTEL_TXT
	#_kernelConfig_warn-n__ CONFIG_IOMMU_DMA
	#_kernelConfig_warn-n__ CONFIG_INTEL_IOMMU
}

# May become increasing tolerable and preferable for the vast majority of use cases.
# WARNING: Risk must be evaluated for specific use cases.
# WARNING: May BREAK some high-performance real-time applicatons (eg. flight sim, VR, AR).
# Standalone simulators (eg. flight sim):
# * May have hard real-time frame latency limits within 10% of the fastest avaialble from a commercially avaialble CPU.
# * May be severely single-thread CPU constrained.
# * May have real-time workloads exactly matching those suffering half performance due to security mitigations.
# * May not (or may) require real-time security mitigations.
# Disabling hardening may as much as double performance for some workloads.
# https://www.phoronix.com/scan.php?page=article&item=linux-retpoline-benchmarks&num=2
# https://www.phoronix.com/scan.php?page=article&item=linux-416early-spectremelt&num=4
# DANGER: Hardware performance is getting better, while software security issues are getting worse. Think of faster computer processors as security hardware.
_kernelConfig_require-tradeoff-harden() {
	_messagePlain_nominal 'kernelConfig: tradeoff-harden'
	_messagePlain_request 'Carefully evaluate '\''tradeoff-harden'\'' for specific use cases.'
	export kernelConfig_file="$1"
	
	_kernelConfig__bad-y__ CPU_MITIGATIONS
	_kernelConfig__bad-y__ MITIGATION_PAGE_TABLE_ISOLATION
	_kernelConfig__bad-y__ MITIGATION_RETPOLINE
	_kernelConfig__bad-y__ MITIGATION_RETHUNK
	_kernelConfig__bad-y__ MITIGATION_UNRET_ENTRY
	_kernelConfig__bad-y__ MITIGATION_CALL_DEPTH_TRACKING
	_kernelConfig__bad-y__ MITIGATION_IBPB_ENTRY
	_kernelConfig__bad-y__ MITIGATION_IBRS_ENTRY
	_kernelConfig__bad-y__ MITIGATION_SRSO
	_kernelConfig__bad-y__ MITIGATION_GDS
	_kernelConfig__bad-y__ MITIGATION_RFDS
	_kernelConfig__bad-y__ MITIGATION_SPECTRE_BHI
	_kernelConfig__bad-y__ MITIGATION_MDS
	_kernelConfig__bad-y__ MITIGATION_TAA
	_kernelConfig__bad-y__ MITIGATION_MMIO_STALE_DATA
	_kernelConfig__bad-y__ MITIGATION_L1TF
	_kernelConfig__bad-y__ MITIGATION_RETBLEED
	_kernelConfig__bad-y__ MITIGATION_SPECTRE_V1
	_kernelConfig__bad-y__ MITIGATION_SPECTRE_V2
	_kernelConfig__bad-y__ MITIGATION_SRBDS
	_kernelConfig__bad-y__ MITIGATION_SSB

	_kernelConfig__bad-y__ MITIGATION_SLS

	_kernelConfig__bad-y__ CPU_SRSO

	_kernelConfig__bad-y__ CONFIG_RETPOLINE
	_kernelConfig__bad-y__ CONFIG_PAGE_TABLE_ISOLATION
	
	_kernelConfig__bad-y__ CONFIG_RETHUNK
	_kernelConfig__bad-y__ CONFIG_CPU_UNRET_ENTRY
	_kernelConfig__bad-y__ CONFIG_CPU_IBPB_ENTRY
	_kernelConfig__bad-y__ CONFIG_CPU_IBRS_ENTRY
	_kernelConfig__bad-y__ CONFIG_SLS
	
	# May have been removed from upstream.
	#_kernelConfig__bad-y__ CONFIG_X86_SMAP
	
	_kernelConfig_warn-n__ CONFIG_X86_INTEL_TSX_MODE_ON
	_kernelConfig_warn-n__ CONFIG_X86_INTEL_TSX_MODE_AUTO
	_kernelConfig__bad-y__ CONFIG_X86_INTEL_TSX_MODE_OFF
	
	
	_kernelConfig_warn-y__ CONFIG_SLAB_FREELIST_HARDENED
	
	
	_kernelConfig__bad-y__ CONFIG_RANDOMIZE_BASE
	_kernelConfig__bad-y__ CONFIG_RANDOMIZE_MEMORY
	
	
	
	
	
	
	# Special.
	# VM guest should be tested.

	# https://wiki.gentoo.org/wiki/Trusted_Boot
	_kernelConfig__bad-y__ CONFIG_HAVE_INTEL_TXT
	_kernelConfig__bad-y__ CONFIG_INTEL_TXT
	_kernelConfig__bad-y__ CONFIG_IOMMU_DMA
	_kernelConfig__bad-y__ CONFIG_INTEL_IOMMU


	# https://www.qemu.org/docs/master/system/i386/sgx.html
	#grep sgx /proc/cpuinfo
	#dmesg | grep sgx
	# Apparently normal: ' sgx: [Firmware Bug]: Unable to map EPC section to online node. Fallback to the NUMA node 0. '

	# https://www.qemu.org/docs/master/system/i386/sgx.html
	#qemuArgs+=(-cpu host,+sgx-provisionkey -machine accel=kvm -object memory-backend-epc,id=mem1,size=64M,prealloc=on -M sgx-epc.0.memdev=mem1,sgx-epc.0.node=0 )
	#qemuArgs+=(-cpu host,-sgx-provisionkey,-sgx-tokenkey)

	_kernelConfig__bad-y__ CONFIG_X86_SGX
	_kernelConfig__bad-y__ CONFIG_X86_SGX_KVM
	_kernelConfig__bad-y__ CONFIG_INTEL_TDX_GUEST
	_kernelConfig__bad-y__ TDX_GUEST_DRIVER


	# https://libvirt.org/kbase/launch_security_sev.html
	#cat /sys/module/kvm_amd/parameters/sev
	#dmesg | grep -i sev

	# https://www.qemu.org/docs/master/system/i386/amd-memory-encryption.html
	#qemuArgs+=(-machine accel=kvm,confidential-guest-support=sev0 -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 )
	# #,policy=0x5


	# https://libvirt.org/kbase/launch_security_sev.html
	_kernelConfig__bad-y__ CONFIG_KVM_AMD_SEV
	_kernelConfig__bad-y__ AMD_MEM_ENCRYPT
	_kernelConfig__bad-y__ CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT

	_kernelConfig__bad-y__ KVM_SMM


	_kernelConfig__bad-y__ RANDOM_KMALLOC_CACHES
}
_kernelConfig_require-tradeoff-harden-compatible() {
	
	
	# https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings#sysctls
	
	# Worth considering whether indeed 'NOTcompatible' or actually usable as 'harden' .
	# Nevertheless, 'KASAN' is probably most important, and only reasonably efficient on kernel 6.6+, while only kernel 6.1-lts may be itself still 'compatible' (ie. not panicing on 'systemctl stop sddm') as of 2023-12-26 .
	
	# ###
	
	#x bad: not:    -1: CONFIG_PANIC_TIMEOUT 
	
	# bad: not:     Y: CONFIG_DEBUG_CREDENTIALS 
	#+ bad: not:     Y: CONFIG_DEBUG_NOTIFIERS 
	# bad: not:     Y: CONFIG_DEBUG_SG 
	#x bad: not:     Y: CONFIG_DEBUG_VIRTUAL 
	
	#+ bad: not:     Y: CONFIG_INIT_ON_FREE_DEFAULT_ON 
	#+ bad: not:     Y: CONFIG_ZERO_CALL_USED_REGS 
	
	# https://blogs.oracle.com/linux/post/improving-application-security-with-undefinedbehaviorsanitizer-ubsan-and-gcc
	#  'Adding UBSan instrumentation slows down programs by around 2 to 3x, which is a small price to pay for increased security.'
	#x bad: not:     Y: CONFIG_UBSAN 
	#x bad: not:     Y: CONFIG_UBSAN_TRAP 
	#x bad: not:     Y: CONFIG_UBSAN_BOUNDS 
	#x bad: not:     Y: CONFIG_UBSAN_SANITIZE_ALL 
	#x bad: not:     Y: CONFIG_UBSAN_LOCAL_BOUNDS 
	
	#+ bad: not:     N: CONFIG_DEVMEM 
	
	#+_kernelConfig__bad-n__ CONFIG_DEVPORT
	
	#+ bad: not:     N: CONFIG_PROC_KCORE 
	
	#+_kernelConfig__bad-n__ CONFIG_PROC_VMCORE
	
	#+ bad: not:     N: CONFIG_LEGACY_TIOCSTI 
	
	#+ bad: not:     N: CONFIG_LDISC_AUTOLOAD 
	
	#+ bad: not:     N: CONFIG_SECURITY_SELINUX_DEVELOP
	
	# ###
	
	#if ! cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "CONFIG_PANIC_TIMEOUT"'\=-1' > /dev/null 2>&1
	#then
		#_messagePlain_bad 'bad: not:    -1: '"CONFIG_PANIC_TIMEOUT"
		#export kernelConfig_bad='true'
	#fi
	
	_kernelConfig__bad-y__ CONFIG_BUG
	_kernelConfig__bad-y__ CONFIG_BUG_ON_DATA_CORRUPTION
	
	_kernelConfig__bad-y__ CONFIG_DEBUG_NOTIFIERS
	
	_kernelConfig__bad-y__ CONFIG_INIT_ON_FREE_DEFAULT_ON
	_kernelConfig__bad-y__ CONFIG_ZERO_CALL_USED_REGS

	_kernelConfig__bad-y__ CONFIG_INIT_STACK_ALL_ZERO
	
	_kernelConfig__bad-n__ CONFIG_DEVMEM
	_kernelConfig__bad-n__ CONFIG_DEVPORT
	
	_kernelConfig__bad-n__ CONFIG_PROC_KCORE
	_kernelConfig__bad-n__ CONFIG_PROC_VMCORE
	
	_kernelConfig__bad-n__ CONFIG_LEGACY_TIOCSTI
	_kernelConfig__bad-n__ CONFIG_LDISC_AUTOLOAD
	
	_kernelConfig__bad-n__ CONFIG_SECURITY_SELINUX_DEVELOP
	
	
	
	# WARNING: KFENCE is of DUBIOUS usefulness. Enable KASAN instead if possible!
	# https://thomasw.dev/post/kfence/
	#  'In theory, a buffer overflow exploit executed on a KFENCE object might be detected and miss its intended overwrite target as the vulnerable object is located in the KFENCE pool. This is in no way a defense - an attacker can trivially bypass KFENCE by simply executing a no-op allocation or depleting the KFENCE object pool first. Memory exploits often already require precisely setting up the heap to be successful, so this is a very minor obstacle to take care of.'
	# https://openbenchmarking.org/result/2104197-PTS-5900XAMD52
	#  Apparently negligible difference between 100ms and 500ms sample rates. Maybe ~7% .
	# https://www.kernel.org/doc/html/v5.15/dev-tools/kfence.html
	
	#CONFIG_KFENCE=y
	#CONFIG_KFENCE_SAMPLE_INTERVAL=39
	
	#CONFIG_KFENCE_NUM_OBJECTS=639
	
	#CONFIG_KFENCE_DEFERRABLE=y
	
	_kernelConfig__bad-y__ CONFIG_KFENCE
	if ! cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "CONFIG_KFENCE_SAMPLE_INTERVAL"'\=39' > /dev/null 2>&1
	then
		_messagePlain_bad 'bad: not:    39: '"CONFIG_KFENCE_SAMPLE_INTERVAL"
		export kernelConfig_bad='true'
	fi
	if ! cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "CONFIG_KFENCE_NUM_OBJECTS"'\=639' > /dev/null 2>&1
	then
		_messagePlain_bad 'bad: not:    639: '"CONFIG_KFENCE_NUM_OBJECTS"
		export kernelConfig_bad='true'
	fi
	
	#_kernelConfig_warn-any CONFIG_KFENCE_DEFERRABLE
	_kernelConfig_warn-y__ CONFIG_KFENCE_DEFERRABLE


	# DUBIOUS . Seems to require a userspace service setting scheduling attributes for processes, and not supported by default.
	# WARNING: Definitely much better to disable SMT .
	#_kernelConfig__bad-y__ CONFIG_SCHED_CORE
}

# WARNING: ATTENTION: Before moving to tradeoff-harden (compatible), ensure vboxdrv, vboxadd, nvidia, nvidia legacy, kernel modules can be loaded without issues, and also ensure significant performance penalty configuration options are oppositely documented in the tradeoff-perform function .
# WARNING: Disables out-of-tree modules . VirtualBox and NVIDIA drivers WILL NOT be permitted to load .
# NOTICE: The more severe performance costs of KASAN, UBSAN, etc, will, as kernel processing increasingly becomes still more of a minority of the work done by faster CPUs, and as more efficient kernels (ie. 6.6+) become more useful with fewer regressions, be migrated to 'harden' (ie. treated as 'compatible').
_kernelConfig_require-tradeoff-harden-NOTcompatible() {
	# https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings#sysctls
	
	
	# Apparently these are some typical differences from a stock distribution supplied kernel configuration .
	
	# ###
	
	# bad: not:     Y: CONFIG_PANIC_ON_OOPS 
	# bad: not:    -1: CONFIG_PANIC_TIMEOUT 
	# bad: not:     Y: CONFIG_KASAN 
	# bad: not:     Y: CONFIG_KASAN_INLINE 
	# bad: not:     Y: CONFIG_KASAN_VMALLOC 
	# bad: not:     Y: CONFIG_DEBUG_CREDENTIALS 
	# bad: not:     Y: CONFIG_DEBUG_NOTIFIERS 
	# bad: not:     Y: CONFIG_DEBUG_SG 
	# bad: not:     Y: CONFIG_DEBUG_VIRTUAL 
	# bad: not:     Y: CONFIG_INIT_ON_FREE_DEFAULT_ON 
	# bad: not:     Y: CONFIG_ZERO_CALL_USED_REGS 
	# bad: not:     Y: CONFIG_UBSAN 
	# bad: not:     Y: CONFIG_UBSAN_TRAP 
	# bad: not:     Y: CONFIG_UBSAN_BOUNDS 
	# bad: not:     Y: CONFIG_UBSAN_SANITIZE_ALL 
	# bad: not:     Y: CONFIG_UBSAN_LOCAL_BOUNDS 
	# bad: not:     N: CONFIG_DEVMEM 
	# bad: not:     Y: CONFIG_CFI_CLANG 
	# bad: not:     N: CONFIG_PROC_KCORE 
	# bad: not:     N: CONFIG_LEGACY_TIOCSTI 
	# bad: not:     Y: CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY 
	# bad: not:     N: CONFIG_LDISC_AUTOLOAD 
	# bad: not:     Y: CONFIG_GCC_PLUGINS 
	# bad: not:     Y: CONFIG_GCC_PLUGIN_LATENT_ENTROPY 
	# bad: not:     Y: CONFIG_GCC_PLUGIN_STRUCTLEAK 
	# bad: not:     Y: CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL 
	# bad: not:     Y: CONFIG_GCC_PLUGIN_STACKLEAK 
	# bad: not:     Y: CONFIG_GCC_PLUGIN_RANDSTRUCT 
	# bad: not:     N: CONFIG_SECURITY_SELINUX_DEVELOP
	
	# ###
	
	
	
	_kernelConfig__bad-y__ CONFIG_BUG
	_kernelConfig__bad-y__ CONFIG_BUG_ON_DATA_CORRUPTION
	
	_kernelConfig__bad-y__ CONFIG_PANIC_ON_OOPS
	if ! cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "CONFIG_PANIC_TIMEOUT"'\=-1' > /dev/null 2>&1
	then
		_messagePlain_bad 'bad: not:    -1: '"CONFIG_PANIC_TIMEOUT"
		export kernelConfig_bad='true'
	fi
	
	
	
	_kernelConfig__bad-y__ CONFIG_KASAN
	_kernelConfig__bad-y__ CONFIG_KASAN_INLINE
	_kernelConfig__bad-y__ CONFIG_KASAN_VMALLOC
	
	
	# DUBIOUS. KASAN should catch everything KFENCE does, but apparently CONFIG_KASAN_VMALLOCKFENCE may rarely catch errors.
	#_kernelConfig__bad-y__ CONFIG_KFENCE
	
	
	
	
	_kernelConfig__bad-y__ CONFIG_SCHED_STACK_END_CHECK
	_kernelConfig__bad-y__ CONFIG_DEBUG_CREDENTIALS
	_kernelConfig__bad-y__ CONFIG_DEBUG_NOTIFIERS
	_kernelConfig__bad-y__ CONFIG_DEBUG_LIST
	_kernelConfig__bad-y__ CONFIG_DEBUG_SG
	_kernelConfig__bad-y__ CONFIG_DEBUG_VIRTUAL
	
	
	
	_kernelConfig__bad-y__ CONFIG_SLUB_DEBUG
	
	
	_kernelConfig__bad-y__ CONFIG_SLAB_FREELIST_RANDOM
	_kernelConfig__bad-y__ CONFIG_SLAB_FREELIST_HARDENED
	_kernelConfig__bad-y__ CONFIG_SHUFFLE_PAGE_ALLOCATOR
	
	
	_kernelConfig__bad-y__ CONFIG_INIT_ON_ALLOC_DEFAULT_ON
	_kernelConfig__bad-y__ CONFIG_INIT_ON_FREE_DEFAULT_ON
	
	_kernelConfig__bad-y__ CONFIG_ZERO_CALL_USED_REGS
	
	
	_kernelConfig__bad-y__ CONFIG_HARDENED_USERCOPY
	_kernelConfig__bad-n__ CONFIG_HARDENED_USERCOPY_FALLBACK
	_kernelConfig__bad-n__ CONFIG_HARDENED_USERCOPY_PAGESPAN
	
	
	_kernelConfig__bad-y__ CONFIG_UBSAN
	_kernelConfig__bad-y__ CONFIG_UBSAN_TRAP
	_kernelConfig__bad-y__ CONFIG_UBSAN_BOUNDS
	_kernelConfig__bad-y__ CONFIG_UBSAN_SANITIZE_ALL
	_kernelConfig__bad-n__ CONFIG_UBSAN_SHIFT
	_kernelConfig__bad-n__ CONFIG_UBSAN_DIV_ZERO
	_kernelConfig__bad-n__ CONFIG_UBSAN_UNREACHABLE
	_kernelConfig__bad-n__ CONFIG_UBSAN_BOOL
	_kernelConfig__bad-n__ CONFIG_UBSAN_ENUM
	_kernelConfig__bad-n__ CONFIG_UBSAN_ALIGNMENT
	# This is only available on Clang builds, and is likely already enabled if CONFIG_UBSAN_BOUNDS=y is set:
	_kernelConfig__bad-y__ CONFIG_UBSAN_LOCAL_BOUNDS
	
	
	
	_kernelConfig__bad-n__ CONFIG_DEVMEM
	#_kernelConfig__bad-y__ CONFIG_STRICT_DEVMEM
	#_kernelConfig__bad-y__ CONFIG_IO_STRICT_DEVMEM
	
	_kernelConfig__bad-n__ CONFIG_DEVPORT
	
	
	_kernelConfig__bad-y__ CONFIG_CFI_CLANG
	_kernelConfig__bad-n__ CONFIG_CFI_PERMISSIVE
	
	
	
	_kernelConfig__bad-y__ CONFIG_STACKPROTECTOR
	_kernelConfig__bad-y__ CONFIG_STACKPROTECTOR_STRONG
	
	
	_kernelConfig__bad-n__ CONFIG_DEVKMEM
	
	_kernelConfig__bad-n__ CONFIG_COMPAT_BRK
	_kernelConfig__bad-n__ CONFIG_PROC_KCORE
	_kernelConfig__bad-n__ CONFIG_ACPI_CUSTOM_METHOD
	
	_kernelConfig__bad-n__ CONFIG_PROC_VMCORE
	
	_kernelConfig__bad-n__ CONFIG_LEGACY_TIOCSTI
	
	
	
	_kernelConfig__bad-y__ CONFIG_SECURITY_LOCKDOWN_LSM
	_kernelConfig__bad-y__ CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
	_kernelConfig__bad-y__ CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
	
	
	
	_kernelConfig__bad-y__ CONFIG_SECURITY_DMESG_RESTRICT
	
	_kernelConfig__bad-y__ CONFIG_VMAP_STACK
	
	
	_kernelConfig__bad-n__ CONFIG_LDISC_AUTOLOAD
	
	
	
	# Enable GCC Plugins
	_kernelConfig__bad-y__ CONFIG_GCC_PLUGINS

	# Gather additional entropy at boot time for systems that may not have appropriate entropy sources.
	_kernelConfig__bad-y__ CONFIG_GCC_PLUGIN_LATENT_ENTROPY

	# Force all structures to be initialized before they are passed to other functions.
	# When building with GCC:
	_kernelConfig__bad-y__ CONFIG_GCC_PLUGIN_STRUCTLEAK
	_kernelConfig__bad-y__ CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL

	# Wipe stack contents on syscall exit (reduces stale data lifetime in stack)
	_kernelConfig__bad-y__ CONFIG_GCC_PLUGIN_STACKLEAK
	_kernelConfig__bad-n__ CONFIG_STACKLEAK_METRICS
	_kernelConfig__bad-n__ CONFIG_STACKLEAK_RUNTIME_DISABLE

	# Randomize the layout of system structures. This may have dramatic performance impact, so
	# use with caution or also use CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE=y
	_kernelConfig__bad-y__ CONFIG_GCC_PLUGIN_RANDSTRUCT
	_kernelConfig__bad-n__ CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
	
	
	
	
	_kernelConfig__bad-y__ CONFIG_SECURITY
	_kernelConfig__bad-y__ CONFIG_SECURITY_YAMA
	
	_kernelConfig__bad-y__ CONFIG_X86_64
	
	
	_kernelConfig__bad-n__ CONFIG_SECURITY_SELINUX_BOOTPARAM
	_kernelConfig__bad-n__ CONFIG_SECURITY_SELINUX_DEVELOP
	_kernelConfig__bad-n__ CONFIG_SECURITY_WRITABLE_HOOKS
	
	
	
	_kernelConfig_warn-n__ CONFIG_KEXEC
	_kernelConfig_warn-n__ CONFIG_HIBERNATION
	
	
	
	_kernelConfig__bad-y__ CONFIG_RESET_ATTACK_MITIGATION
	
	
	_kernelConfig_warn-y__ CONFIG_EFI_DISABLE_PCI_DMA


	# ATTENTION: In practice, the 'gather_data_sampling=force' command line parameter has been available, through optional  "$globalVirtFS"/etc/default/grub.d/01_hardening_ubdist.cfg  .
	_kernelConfig__bad-y__ CONFIG_GDS_FORCE_MITIGATION
	
	
	
	# WARNING: CAUTION: Now obviously this is really incompatible. Do NOT move this to any other function.
	_kernelConfig_warn-y__ CONFIG_MODULE_SIG_FORCE

	# WARNING: May be untested. Kernel default apparently 'Y'.
	_kernelConfig_warn-y__ MODULE_SIG_ALL
}

# ATTENTION: Override with 'ops.sh' or similar.
_kernelConfig_require-tradeoff() {
	_kernelConfig_require-tradeoff-legacy "$@"
	
	
	[[ "$kernelConfig_tradeoff_perform" == "" ]] && export kernelConfig_tradeoff_perform='false'
	
	if [[ "$kernelConfig_tradeoff_perform" == 'true' ]]
	then
		_kernelConfig_require-tradeoff-perform "$@"
	else
		_kernelConfig_require-tradeoff-harden "$@"
	fi
	
	[[ "$kernelConfig_tradeoff_compatible" == "" ]] && [[ "$kernelConfig_tradeoff_perform" == 'true' ]] && export kernelConfig_tradeoff_compatible='true'
	[[ "$kernelConfig_tradeoff_compatible" == "" ]] && export kernelConfig_tradeoff_compatible='false'
	
	if [[ "$kernelConfig_tradeoff_compatible" != 'true' ]]
	then
		_kernelConfig_require-tradeoff-harden-NOTcompatible "$@"
	else
		_kernelConfig_require-tradeoff-harden-compatible "$@"
	fi
	
	return
}

# Based on kernel config documentation and Debian default config.
_kernelConfig_require-virtualization-accessory() {
	_messagePlain_nominal 'kernelConfig: virtualization-accessory'
	export kernelConfig_file="$1"
	
	_kernelConfig_warn-y_m CONFIG_KVM
	_kernelConfig_warn-y_m CONFIG_KVM_INTEL
	_kernelConfig_warn-y_m CONFIG_KVM_AMD
	
	_kernelConfig_warn-y__ CONFIG_KVM_AMD_SEV
	
	_kernelConfig_warn-y_m CONFIG_VHOST_NET
	_kernelConfig_warn-y_m CONFIG_VHOST_SCSI
	_kernelConfig_warn-y_m CONFIG_VHOST_VSOCK
	
	_kernelConfig__bad-y_m DRM_VMWGFX
	
	_kernelConfig__bad-n__ CONFIG_VBOXGUEST
	_kernelConfig__bad-n__ CONFIG_DRM_VBOXVIDEO
	
	_kernelConfig_warn-y__ VIRTIO_MENU
	_kernelConfig_warn-y__ CONFIG_VIRTIO_PCI
	_kernelConfig_warn-y__ CONFIG_VIRTIO_PCI_LEGACY
	_kernelConfig_warn-y__ CONFIG_VIRTIO_PCI_LIB
	_kernelConfig_warn-y__ CONFIG_VIRTIO_PCI_LIB_LEGACY
	_kernelConfig__bad-y_m CONFIG_VIRTIO_BALLOON
	_kernelConfig__bad-y_m CONFIG_VIRTIO_INPUT
	_kernelConfig__bad-y_m CONFIG_VIRTIO_MMIO
	_kernelConfig_warn-y__ CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES
	
	_kernelConfig_warn-y_m CONFIG_DRM_VIRTIO_GPU
	
	# Uncertain. Apparently new feature.
	_kernelConfig_warn-y_m CONFIG_VIRTIO_FS
	
	_kernelConfig_warn-y_m CONFIG_HYPERV
	_kernelConfig_warn-y_m CONFIG_HYPERV_UTILS
	_kernelConfig_warn-y_m CONFIG_HYPERV_BALLOON
	
	_kernelConfig_warn-y__ CONFIG_XEN_BALLOON
	_kernelConfig_warn-y__ CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
	_kernelConfig_warn-y__ CONFIG_XEN_SCRUB_PAGES_DEFAULT
	_kernelConfig__bad-y_m CONFIG_XEN_DEV_EVTCHN
	_kernelConfig_warn-y__ CONFIG_XEN_BACKEND
	_kernelConfig__bad-y_m CONFIG_XENFS
	_kernelConfig_warn-y__ CONFIG_XEN_COMPAT_XENFS
	_kernelConfig_warn-y__ CONFIG_XEN_SYS_HYPERVISOR
	_kernelConfig__bad-y_m CONFIG_XEN_SYS_HYPERVISOR
	_kernelConfig__bad-y_m CONFIG_XEN_GRANT_DEV_ALLOC
	_kernelConfig__bad-y_m CONFIG_XEN_PCIDEV_BACKEND
	_kernelConfig__bad-y_m CONFIG_XEN_SCSI_BACKEND
	_kernelConfig__bad-y_m CONFIG_XEN_ACPI_PROCESSOR
	_kernelConfig_warn-y__ CONFIG_XEN_MCE_LOG
	_kernelConfig_warn-y__ CONFIG_XEN_SYMS
	
	_kernelConfig_warn-y__ CONFIG_DRM_XEN
	
	# Uncertain.
	#_kernelConfig_warn-n__ CONFIG_XEN_SELFBALLOONING
	#_kernelConfig_warn-n__ CONFIG_IOMMU_DEFAULT_PASSTHROUGH
	#_kernelConfig_warn-n__ CONFIG_INTEL_IOMMU_DEFAULT_ON


	# TODO: Evaluate.
	_kernelConfig_warn-y__ KVM_HYPERV
}

# https://wiki.gentoo.org/wiki/VirtualBox
_kernelConfig_require-virtualbox() {
	_messagePlain_nominal 'kernelConfig: virtualbox'
	export kernelConfig_file="$1"
	
	#_kernelConfig__bad-y__ CONFIG_X86_SYSFB
	_kernelConfig__bad-y__ CONFIG_SYSFB
	
	_kernelConfig__bad-y__ CONFIG_ATA
	_kernelConfig__bad-y__ CONFIG_SATA_AHCI
	_kernelConfig__bad-y__ CONFIG_ATA_SFF
	_kernelConfig__bad-y__ CONFIG_ATA_BMDMA
	_kernelConfig__bad-y__ CONFIG_ATA_PIIX
	
	_kernelConfig__bad-y__ CONFIG_NETDEVICES
	_kernelConfig__bad-y__ CONFIG_ETHERNET
	_kernelConfig__bad-y__ CONFIG_NET_VENDOR_INTEL
	_kernelConfig__bad-y__ CONFIG_E1000
	
	_kernelConfig__bad-y__ CONFIG_INPUT_KEYBOARD
	_kernelConfig__bad-y__ CONFIG_KEYBOARD_ATKBD
	_kernelConfig__bad-y__ CONFIG_INPUT_MOUSE
	_kernelConfig__bad-y__ CONFIG_MOUSE_PS2
	
	_kernelConfig__bad-y__ CONFIG_DRM
	_kernelConfig__bad-y__ CONFIG_DRM_FBDEV_EMULATION
	_kernelConfig__bad-y__ CONFIG_DRM_VIRTIO_GPU
	
	_kernelConfig__bad-y__ CONFIG_FB
	_kernelConfig__bad-y__ CONFIG_FIRMWARE_EDID
	_kernelConfig__bad-y__ CONFIG_FB_SIMPLE
	
	_kernelConfig__bad-y__ CONFIG_FRAMEBUFFER_CONSOLE
	_kernelConfig__bad-y__ CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
	
	_kernelConfig__bad-y__ CONFIG_SOUND
	_kernelConfig__bad-y__ CONFIG_SND
	_kernelConfig__bad-y__ CONFIG_SND_PCI
	_kernelConfig__bad-y__ CONFIG_SND_INTEL8X0
	
	_kernelConfig__bad-y__ CONFIG_USB
	_kernelConfig__bad-y__ CONFIG_USB_SUPPORT
	_kernelConfig__bad-y__ CONFIG_USB_XHCI_HCD
	_kernelConfig__bad-y__ CONFIG_USB_EHCI_HCD
}


# https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation#Activating_required_options
_kernelConfig_require-boot() {
	_messagePlain_nominal 'kernelConfig: boot'
	export kernelConfig_file="$1"
	
	_kernelConfig__bad-y__ CONFIG_FW_LOADER
	#_kernelConfig__bad-y__ CONFIG_FIRMWARE_IN_KERNEL
	
	_kernelConfig__bad-y__ CONFIG_DEVTMPFS
	_kernelConfig__bad-y__ CONFIG_DEVTMPFS_MOUNT
	_kernelConfig__bad-y__ CONFIG_BLK_DEV_SD
	
	
	_kernelConfig__bad-y__ CONFIG_EXT4_FS
	_kernelConfig__bad-y__ CONFIG_EXT4_FS_POSIX_ACL
	_kernelConfig__bad-y__ CONFIG_EXT4_FS_SECURITY
	#_kernelConfig__bad-y__ CONFIG_EXT4_ENCRYPTION
	
	if ! _kernelConfig_warn-y__ CONFIG_EXT4_USE_FOR_EXT2 > /dev/null 2>&1
	then
		_kernelConfig__bad-y__ CONFIG_EXT2_FS
		_kernelConfig__bad-y__ CONFIG_EXT3_FS
		_kernelConfig__bad-y__ CONFIG_EXT3_FS_POSIX_ACL
		_kernelConfig__bad-y__ CONFIG_EXT3_FS_SECURITY
	else
		_kernelConfig_warn-y__ CONFIG_EXT4_USE_FOR_EXT2
	fi
	
	_kernelConfig__bad-y__ CONFIG_BTRFS_FS
	
	_kernelConfig__bad-y__ CONFIG_MSDOS_FS
	_kernelConfig__bad-y__ CONFIG_VFAT_FS
	
	# Precautionary to assure reasonable behavior with any LiveCD/LiveUSB filesystem arrangements that may be used in the future.
	# Module has probably been entirely adequate in the past for LiveCD/LiveUSB as well as mounting such filesystems later.
	_kernelConfig__bad-y__ CONFIG_OVERLAY_FS
	_kernelConfig__bad-y__ CONFIG_ISO9660_FS
	_kernelConfig__bad-y__ CONFIG_UDF_FS
	
	# https://www.kernel.org/doc/html/latest/cdrom/packet-writing.html
	# 'packet support in the block device section'
	# 'pktcdvd driver makes the disc appear as a regular block device with a 2KB block size'
	# Although the module is apparently 'deprecated', it is available with Linux kernel 5.10 , and thus should remain usable at least through ~2026 .
	# https://wiki.archlinux.org/title/Optical_disc_drive
	# Many 'optical discs' apparently can be used directly as block devices by such programs as 'gparted' and 'dd'.
	_kernelConfig__bad-y_m CONFIG_CDROM_PKTCDVD
	
	_kernelConfig__bad-y__ CONFIG_PROC_FS
	_kernelConfig__bad-y__ CONFIG_TMPFS
	
	_kernelConfig__bad-y__ CONFIG_PPP
	_kernelConfig__bad-y__ CONFIG_PPP_ASYNC
	_kernelConfig__bad-y__ CONFIG_PPP_SYNC_TTY
	
	_kernelConfig__bad-y__ CONFIG_SMP
	
	# https://wiki.gentoo.org/wiki/Kernel/Gentoo_Kernel_Configuration_Guide
	# 'Support for Host-side USB'
	_kernelConfig__bad-y__ CONFIG_USB_SUPPORT
	_kernelConfig__bad-y__ CONFIG_USB_XHCI_HCD
	_kernelConfig__bad-y__ CONFIG_USB_EHCI_HCD
	_kernelConfig__bad-y__ CONFIG_USB_OHCI_HCD
	
	_kernelConfig__bad-y__ USB_OHCI_HCD_PCI
	
	_kernelConfig__bad-y__ USB_UHCI_HCD
	
	_kernelConfig__bad-y__ CONFIG_HID
	_kernelConfig__bad-y__ CONFIG_HID_GENERIC
	_kernelConfig__bad-y__ CONFIG_HID_BATTERY_STRENGTH
	_kernelConfig__bad-y__ CONFIG_USB_HID
	
	_kernelConfig__bad-y__ CONFIG_PARTITION_ADVANCED
	_kernelConfig__bad-y__ CONFIG_EFI_PARTITION
	
	_kernelConfig__bad-y__ CONFIG_EFI
	_kernelConfig__bad-y__ CONFIG_EFI_STUB
	_kernelConfig__bad-y__ CONFIG_EFI_MIXED
	
	# Seems 'EFI_VARS' has disappeared from recent kernel versions.
	#_kernelConfig__bad-y__ CONFIG_EFI_VARS
	_kernelConfig__bad-y__ CONFIG_EFIVAR_FS
}


_kernelConfig_require-arch-x64() {
	_messagePlain_nominal 'kernelConfig: arch-x64'
	export kernelConfig_file="$1"
	
	# CRITICAL! Expected to accommodate modern CPUs.
	_messagePlain_request 'request: -march=sandybridge -mtune=skylake'
	_messagePlain_request 'export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"'
	_messagePlain_request 'export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"'
	
	_kernelConfig_warn-n__ CONFIG_GENERIC_CPU
# 	
	_kernelConfig_request MCORE2
	
	_kernelConfig_warn-y__ CONFIG_X86_MCE
	_kernelConfig_warn-y__ CONFIG_X86_MCE_INTEL
	_kernelConfig_warn-y__ CONFIG_X86_MCE_AMD
	
	# Uncertain. May or may not improve performance.
	# Seems missing in newer kernel 'menuconfig' .
	#_kernelConfig_warn-y__ CONFIG_INTEL_RDT
	
	# Maintenance may be easier with this enabled.
	_kernelConfig_warn-y__ CONFIG_EFIVAR_FS
	
	# Presumably mixing entropy may be preferable.
	_kernelConfig__bad-n__ CONFIG_RANDOM_TRUST_CPU
	
	
	# If possible, it may be desirable to check clocksource defaults.
	
	_kernelConfig__bad-y__ X86_TSC
	
	_kernelConfig_warn-y__ HPET
	_kernelConfig_warn-y__ HPET_EMULATE_RTC
	_kernelConfig_warn-y__ HPET_MMAP
	_kernelConfig_warn-y__ HPET_MMAP_DEFAULT
	_kernelConfig_warn-y__ HPET_TIMER
	
	
	_kernelConfig__bad-y__ CONFIG_IA32_EMULATION
	_kernelConfig_warn-n__ IA32_AOUT
	_kernelConfig__bad-y__ CONFIG_X86_X32_ABI
	
	_kernelConfig__bad-y__ CONFIG_BINFMT_ELF
	_kernelConfig__bad-y_m CONFIG_BINFMT_MISC
	
	# May not have been optional under older kernel configurations.
	_kernelConfig__bad-y__ CONFIG_BINFMT_SCRIPT
}

_kernelConfig_require-accessory() {
	_messagePlain_nominal 'kernelConfig: accessory'
	export kernelConfig_file="$1"
	
	# May be critical to 'ss' tool functionality typically expected by Ubiquitous Bash.
	_kernelConfig_warn-y_m CONFIG_PACKET_DIAG
	_kernelConfig_warn-y_m CONFIG_UNIX_DIAG
	_kernelConfig_warn-y_m CONFIG_INET_DIAG
	_kernelConfig_warn-y_m CONFIG_NETLINK_DIAG
	
	# Essential for a wide variety of platforms.
	_kernelConfig_warn-y_m CONFIG_MOUSE_PS2_TRACKPOINT
	
	# Common and useful GPU features.
	_kernelConfig_warn-y_m CONFIG_DRM_RADEON
	_kernelConfig_warn-y_m CONFIG_DRM_AMDGPU
	_kernelConfig_warn-y_m CONFIG_DRM_I915
	_kernelConfig_warn-y_m CONFIG_DRM_NOUVEAU
	
	# Rarely appropriate and reportedly 'dangerous'.
	#_kernelConfig_warn-y_m CONFIG_DRM_VIA
	
	# Uncertain.
	#_kernelConfig_warn-y__ CONFIG_IRQ_REMAP
	
	# TODO: Accessory features which may become interesting.
	#ACPI_HMAT
	#PCIE_BW
	#ACRN_GUEST
	#XILINX SDFEC

	# FB_NVIDIA , FB_RIVA , at best, has not been reccently tested with NOUVEAU or other NVIDIA drivers.
	_kernelConfig_warn-n__ FB_NVIDIA
	_kernelConfig_warn-n__ FB_RIVA



}

_kernelConfig_require-build() {
	_messagePlain_nominal 'kernelConfig: build'
	export kernelConfig_file="$1"
	
	# May cause failure if set incorrectly.
	if ! cat "$kernelConfig_file" | grep 'CONFIG_SYSTEM_TRUSTED_KEYS\=\"\"' > /dev/null 2>&1 && ! cat "$kernelConfig_file" | grep -v 'CONFIG_SYSTEM_TRUSTED_KEYS' > /dev/null 2>&1
	then
		#_messagePlain_bad 'bad: not:    Y: '"$1"
		 _messagePlain_bad 'bad: not:    _: 'CONFIG_SYSTEM_TRUSTED_KEYS
	fi
	
	# May cause failure if set incorrectly.
	#! _kernelConfig__bad-n__ CONFIG_SYSTEM_TRUSTED_KEYRING
	#! _kernelConfig__bad-n__ CONFIG_SYSTEM_TRUSTED_KEYRING && _messagePlain_request ' request: ''scripts/config --set-str SYSTEM_TRUSTED_KEYS ""'
	
	
	# May require a version of 'pahole' not available from Debian Stable.
	_kernelConfig__bad-n__ CONFIG_DEBUG_INFO_BTF
	
	#_messagePlain_request ' request: ''scripts/config --set-str SYSTEM_TRUSTED_KEYS ""'
}

# ATTENTION: As desired, ignore, or override with 'ops.sh' or similar.
# ATTENTION: Dependency of '_kernelConfig_require-latency' .
_kernelConfig_require-latency_frequency() {
	# High HZ rate (ie. HZ 1000) may be preferable for machines directly rendering simulator/VR graphics.
	# Theoretically graphics VSYNC might prefer HZ 300 or similar, as a multiple of common graphics refresh rates.
	# 25,~29.97,30,60=300 60,72=360 60,75=300 60,80=240 32,36,64,72=576
	# Theoretically, a setting of 250 may be beneficial for virtualization where the host kernel may be 1000 .
	# Typically values: 250,300,1000 .
	# https://passthroughpo.st/config_hz-how-does-it-affect-kvm/
	# https://github.com/vmprof/vmprof-python/issues/163
	[[ "$kernelConfig_frequency" == "" ]] && export kernelConfig_frequency=300
	
	
	if ! cat "$kernelConfig_file" | grep 'HZ='"$kernelConfig_frequency" > /dev/null 2>&1
	then
		#_messagePlain_bad  'bad: not:     Y: '"$1"
		#_messagePlain_warn 'warn: not:    Y: '"$1"
		 _messagePlain_bad 'bad: not:   '"$kernelConfig_frequency"': 'HZ
	fi
	_kernelConfig__bad-y__ HZ_"$kernelConfig_frequency"
}

_kernelConfig_require-latency() {
	_messagePlain_nominal 'kernelConfig: latency'
	export kernelConfig_file="$1"
	
	# Uncertain. Default off per Debian config.
	_kernelConfig_warn-n__ CONFIG_X86_GENERIC
	
	# CRITICAL!
	# https://www.reddit.com/r/linux_gaming/comments/mp2eqv/if_you_dont_like_schedutil_and_what_its_doing/
	#  'Ondemand is similar'
	_kernelConfig_warn-y__ CPU_FREQ_DEFAULT_GOV_ONDEMAND
	_kernelConfig__bad-y__ CONFIG_CPU_FREQ_GOV_ONDEMAND
	_kernelConfig__bad-y__ CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
	_kernelConfig__bad-y__ CONFIG_CPU_FREQ_GOV_SCHEDUTIL

	# WARNING: May be untested.
	#X86_AMD_PSTATE_DEFAULT_MODE
	if ! cat "$kernelConfig_file" | _kernelConfig_reject-comments | grep "X86_AMD_PSTATE_DEFAULT_MODE"'\=3' > /dev/null 2>&1
	then
		_messagePlain_bad 'bad: not:      3: '"X86_AMD_PSTATE_DEFAULT_MODE"
		export kernelConfig_bad='true'
	fi
	
	# CRITICAL!
	# CONFIG_PREEMPT is significantly more stable and compatible with third party (eg. VirtualBox) modules.
	# CONFIG_PREEMPT_RT is significantly less likely to incurr noticeable worst-case latency.
	# Lack of both CONFIG_PREEMPT and CONFIG_PREEMPT_RT may incurr noticeable worst-case latency.
	_kernelConfig_request CONFIG_PREEMPT
	_kernelConfig_request CONFIG_PREEMPT_RT
	if ! _kernelConfig__bad-y__ CONFIG_PREEMPT_RT > /dev/null 2>&1 && ! _kernelConfig__bad-y__ CONFIG_PREEMPT > /dev/null 2>&1 
	then
		_kernelConfig__bad-y__ CONFIG_PREEMPT
		_kernelConfig__bad-y__ CONFIG_PREEMPT_RT
	fi
	
	_kernelConfig_require-latency_frequency "$@"
	
	# Dynamic/Tickless kernel *might* be the cause of irregular display updates on some platforms.
	[[ "$kernelConfig_tickless" == "" ]] && export kernelConfig_tickless='false'
	if [[ "$kernelConfig_tickless" == 'true' ]]
	then
		#_kernelConfig__bad-n__ CONFIG_HZ_PERIODIC
		#_kernelConfig__bad-y__ CONFIG_NO_HZ
		#_kernelConfig__bad-y__ CONFIG_NO_HZ_COMMON
		#_kernelConfig__bad-y__ CONFIG_NO_HZ_FULL
		_kernelConfig__bad-y__ CONFIG_NO_HZ_IDLE
		#_kernelConfig__bad-y__ CONFIG_RCU_FAST_NO_HZ
	else
		_kernelConfig__bad-y__ CONFIG_HZ_PERIODIC
		_kernelConfig__bad-n__ CONFIG_NO_HZ
		_kernelConfig__bad-n__ CONFIG_NO_HZ_COMMON
		_kernelConfig__bad-n__ CONFIG_NO_HZ_FULL
		_kernelConfig__bad-n__ CONFIG_NO_HZ_IDLE
		_kernelConfig__bad-n__ CONFIG_RCU_FAST_NO_HZ
		
		_kernelConfig__bad-y__ CPU_IDLE_GOV_MENU
	fi
	
	# Essential.
	_kernelConfig__bad-y__ CONFIG_LATENCYTOP
	
	
	# CRITICAL!
	_kernelConfig__bad-y__ CONFIG_CGROUP_SCHED
	_kernelConfig__bad-y__ FAIR_GROUP_SCHED
	_kernelConfig__bad-y__ CONFIG_CFS_BANDWIDTH
	
	# CRITICAL!
	# Expected to protect single-thread interactive applications from competing multi-thread workloads.
	_kernelConfig__bad-y__ CONFIG_SCHED_AUTOGROUP
	
	
	
	
	# Newer information suggests BFQ may have worst case latency issues.
	# https://bugzilla.redhat.com/show_bug.cgi?id=1851783
	## CRITICAL!
	## Default cannot be set currently.
	#_messagePlain_request 'request: Set '\''bfq'\'' as default IO scheduler (strongly recommended).'
	##_kernelConfig__bad-y__ DEFAULT_IOSCHED
	##_kernelConfig__bad-y__ DEFAULT_BFQ
	
	## CRITICAL!
	## Expected to protect interactive applications from background IO.
	## https://www.youtube.com/watch?v=ANfqNiJVoVE
	#_kernelConfig__bad-y__ CONFIG_IOSCHED_BFQ
	#_kernelConfig__bad-y__ CONFIG_BFQ_GROUP_IOSCHED
	
	
	
	
	
	# Uncertain.
	# https://forum.manjaro.org/t/please-enable-writeback-throttling-by-default-linux-4-10/18135/22
	#_kernelConfig__bad-y__ BLK_WBT
	#_kernelConfig__bad-y__ BLK_WBT_MQ
	#_kernelConfig__bad-y__ BLK_WBT_SQ
	
	
	# https://lwn.net/Articles/789304/
	_kernelConfig__bad-y__ CONFIG_SPARSEMEM
	
	
	_kernelConfig__bad-n__ CONFIG_REFCOUNT_FULL
	_kernelConfig__bad-n__ CONFIG_DEBUG_NOTIFIERS
	_kernelConfig_warn-n__ CONFIG_FTRACE
	
	_kernelConfig__bad-y__ CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	
	# CRITICAL!
	# Lightweight kernel compression theoretically may significantly accelerate startup from slow disks.
	_kernelConfig__bad-y__ CONFIG_KERNEL_LZ4

	# TODO
	#PCP_BATCH_SCALE_MAX
	
}

_kernelConfig_require-memory() {
	_messagePlain_nominal 'kernelConfig: memory'
	export kernelConfig_file="$1"
	
	# Uncertain.
	# https://fa.linux.kernel.narkive.com/CNnVwDlb/hack-bench-regression-with-config-slub-cpu-partial-disabled-info-only
	_kernelConfig_warn-y__ CONFIG_SLUB_CPU_PARTIAL
	
	# Uncertain.
	_kernelConfig_warn-y__ CONFIG_TRANSPARENT_HUGEPAGE
	#_kernelConfig_warn-y__ CONFIG_CLEANCACHE
	_kernelConfig_warn-y__ CONFIG_FRONTSWAP
	_kernelConfig_warn-y__ CONFIG_ZSWAP
	
	
	_kernelConfig__bad-y__ CONFIG_COMPACTION
	_kernelConfig_warn-y__ CONFIG_BALLOON_COMPACTION
	
	# Uncertain.
	_kernelConfig_warn-y__ CONFIG_MEMORY_FAILURE
	
	# CRITICAL!
	_kernelConfig_warn-y__ CONFIG_KSM
}

_kernelConfig_require-integration() {
	_messagePlain_nominal 'kernelConfig: integration'
	export kernelConfig_file="$1"
	
	_kernelConfig__bad-y_m CONFIG_FUSE_FS
	_kernelConfig__bad-y_m CONFIG_CUSE
	_kernelConfig__bad-y__ CONFIG_OVERLAY_FS
	_kernelConfig__bad-y__ CONFIG_ISO9660_FS
	_kernelConfig__bad-y__ CONFIG_UDF_FS
	_kernelConfig__bad-y_m CONFIG_NTFS_FS
	_kernelConfig_request CONFIG_NTFS_RW
	_kernelConfig__bad-y__ CONFIG_MSDOS_FS
	_kernelConfig__bad-y__ CONFIG_VFAT_FS
	_kernelConfig__bad-y__ CONFIG_MSDOS_PARTITION
	
	
	_kernelConfig__bad-y__ CONFIG_BTRFS_FS
	_kernelConfig__bad-y_m CONFIG_NILFS2_FS
	
	# TODO: LiveCD UnionFS or similar boot requirements.
	
	# Gentoo specific. Start with "gentoo-sources" if possible.
	_kernelConfig_warn-y__ CONFIG_GENTOO_LINUX
	_kernelConfig_warn-y__ CONFIG_GENTOO_LINUX_UDEV
	_kernelConfig_warn-y__ CONFIG_GENTOO_LINUX_PORTAGE
	_kernelConfig_warn-y__ CONFIG_GENTOO_LINUX_INIT_SCRIPT
	_kernelConfig_warn-y__ CONFIG_GENTOO_LINUX_INIT_SYSTEMD
}

# Recommended by docker ebuild during installation under Gentoo.
_kernelConfig_require-investigation_docker() {
	_messagePlain_nominal 'kernelConfig: investigation: docker'
	export kernelConfig_file="$1"
	
	# Apparently, 'CONFIG_MEMCG_SWAP_ENABLED' missing from recent 'menuconfig' .
	#_kernelConfig_warn-y__ CONFIG_MEMCG_SWAP_ENABLED
	#_kernelConfig_warn-y__ CONFIG_MEMCG_SWAP
	_kernelConfig_warn-y__ CONFIG_MEMCG
	
	_kernelConfig_warn-y__ CONFIG_CGROUP_HUGETLB
	_kernelConfig_warn-y__ CONFIG_RT_GROUP_SCHED
	
	true
}


# ATTENTION: Insufficiently investigated stuff to think about. Unknown consequences.
_kernelConfig_require-investigation() {
	_messagePlain_nominal 'kernelConfig: investigation'
	export kernelConfig_file="$1"
	
	_kernelConfig_warn-any ACPI_HMAT
	
	# Apparently, 'PCIE_BW' missing from recent 'menuconfig' .
	#_kernelConfig_warn-any PCIE_BW
	
	_kernelConfig_warn-any CONFIG_UCLAMP_TASK
	
	_kernelConfig_warn-any CPU_IDLE_GOV_TEO
	
	_kernelConfig_warn-any LOCK_EVENT_COUNTS
	
	
	_kernelConfig_require-investigation_docker "$@"
	_kernelConfig_require-investigation_prog "$@"
	true
}


_kernelConfig_require-investigation_prog() {
	_messagePlain_nominal 'kernelConfig: investigation: prog'
	export kernelConfig_file="$1"
	
	true
}



_kernelConfig_require-convenience() {
	_messagePlain_nominal 'kernelConfig: convenience'
	export kernelConfig_file="$1"
	
	_kernelConfig__bad-y__ CONFIG_IKCONFIG
	_kernelConfig__bad-y__ CONFIG_IKCONFIG_PROC
	
	true
}

_kernelConfig_require-embedded() {
	_messagePlain_nominal 'kernelConfig: embedded'
	export kernelConfig_file="$1"

	# Inspired by discussion with Chris Lombardi .
	#  https://github.com/clearchris
	# https://github.com/torvalds/linux/commit/24bc41b4558347672a3db61009c339b1f5692169
	_kernelConfig_warn-y_m CAN_GS_USB
	_kernelConfig_warn-y__ CAN_RX_OFFLOAD

	true
}

_kernelConfig_require-special() {
	_messagePlain_nominal 'kernelConfig: special'
	export kernelConfig_file="$1"
	
	_kernelConfig__bad-y__ CONFIG_CRYPTO_JITTERENTROPY
	
	#/dev/hwrng
	_kernelConfig__bad-y__ CONFIG_HW_RANDOM
	_kernelConfig__bad-y__ CONFIG_HW_RANDOM_INTEL
	_kernelConfig__bad-y__ CONFIG_HW_RANDOM_AMD
	_kernelConfig__bad-y__ CONFIG_HW_RANDOM_VIA
	_kernelConfig__bad-y_m HW_RANDOM_VIRTIO
	_kernelConfig__bad-y__ CONFIG_HW_RANDOM_TPM


	# Somewhat unusually, without known loss of performance.
	# Discovered during 'make oldconfig' of 'Linux 6.12.1' from then existing 'mainline' config file.
	_kernelConfig__bad-y__ X86_FRED

	_kernelConfig__bad-y__ SLAB_BUCKETS
	
	

	# TODO: Disabled presently (because this feature is in development and does not yet work), but seems like something to enable eventually.
	# _kernelConfig__bad-y__ KVM_SW_PROTECTED_VM

	
	# Usually a bad idea, since BTRFS filesystem compression, etc, should take care of this better.
	_kernelConfig__bad-n__ MODULE_COMPRESS

	# TODO: Expected unhelpful, but worth considering.
	#ZSWAP_SHRINKER_DEFAULT_ON


	# Unusual tradeoff. Theoretically may cause issues for Gentoo doing fsck on read-only root (due to not necessarily having initramfs).
	_kernelConfig__bad-y__ BLK_DEV_WRITE_MOUNTED
	_kernelConfig_warn-n__ BLK_DEV_WRITE_MOUNTED

	# If there is no compatibility issue, then the more compressible zswap allocator seems more useful.
	#_kernelConfig__warn-y__ ZSWAP_ZPOOL_DEFAULT_ZSMALLOC 


	# DANGER
	# If you honestly believe Meta cares about end-user security...
	# https://studio.youtube.com/video/MeUvSg9zQYc/edit
	# https://studio.youtube.com/video/kXrLujzPm_4/edit
	# There is just NO GOOD REASON to use or support Meta hardware. At all.
	_kernelConfig__bad-n__ NET_VENDOR_META

	# DANGER
	# Although disabling kernel support is NEVER guaranteed to eliminate a 'BadUSB' style vulnerability, reducing this functionality is still very strongly recommended.
	#
	# SDIO . Especially useless, very few very old devices are expected to benefit from SDIO WiFi, etc, peripherials, while SDIO degrades one of the very few otherwise storage exclusive protocols (ie. SD card storage) into a 'BadUSB' input.
	_kernelConfig__bad-n__ ATH10K_SDIO
	_kernelConfig__bad-n__ ATH6KL_SDIO
	_kernelConfig__bad-n__ B43_SDIO
	_kernelConfig__bad-n__ BRCMFMAC_SDIO
	_kernelConfig__bad-n__ BT_HCIBTSDIO
	_kernelConfig__bad-n__ BT_MRVL_SDIO
	_kernelConfig__bad-n__ BT_MTKSDIO
	_kernelConfig__bad-n__ CW1200_WLAN_SDIO
	_kernelConfig__bad-n__ GREYBUS_SDIO
	_kernelConfig__bad-n__ LIBERTAS_SDIO
	#
	_kernelConfig__bad-n__ MMC_MESON_MX_SDIO # Disabled by default apparently.
	_kernelConfig__bad-n__ MMC_MVSDIO # Disabled by default apparently.
	#
	#_kernelConfig__bad-n__ MT7663_USB_SDIO_COMMON
	#_kernelConfig__bad-n__ MT7663U
	#
	_kernelConfig__bad-n__ MT76_SDIO
	_kernelConfig__bad-n__ MWIFIEX_SDIO
	_kernelConfig__bad-n__ RSI_SDIO
	_kernelConfig__bad-n__ RTW88_SDIO
	#
	_kernelConfig__bad-n__ SDIO_UART
	#
	_kernelConfig__bad-n__ SMS_SDIO_DRV
	#
	_kernelConfig__bad-n__ SSB_SDIOHOST
	_kernelConfig__bad-n__ SSB_SDIOHOST_POSSIBLE
	#
	_kernelConfig__bad-n__ WILC1000_SDIO
	_kernelConfig__bad-n__ WL1251_SDIO
	_kernelConfig__bad-n__ WLCORE_SDIO
	#
	_kernelConfig__bad-n__ MMC_USHC
	
	_kernelConfig__bad-n__ RTW88_8822BS
	_kernelConfig__bad-n__ RTW88_8822CS
	_kernelConfig__bad-n__ RTW88_8723DS
	_kernelConfig__bad-n__ RTW88_8723CS
	_kernelConfig__bad-n__ RTW88_8821CS




	# Requires compiling binaries to support this. Future Debian security updates may use this.
	_kernelConfig__bad-y__ X86_USER_SHADOW_STACK



	_kernelConfig__bad-y_m USB_GADGET

	# ATTENTION: Only drivers that are highly likely to cripple the 'out-of-box-experience' to the point of being unable to perform gParted, revert, basic web browsing, etc, for relatively useful laptops/tablets/etc .
	# Essential drivers (eg. iGPU, or at least basic 'VGA', keyboard, USB, etc) are normally included already Debian's default kernel config, if that is used as a starting point.
	# WARNING: Delegating which drivers to enable to upstream default Debian (or other distro) config files may be better for reliability, etc.
	_kernelConfig_warn-y_m ATH12K #WiFi7
	_kernelConfig_warn-y_m MT7996E #WiFi7 Concurrent Tri-Band
	_kernelConfig_warn-y_m RTW88_8822BU #WiFi USB
	_kernelConfig_warn-y_m RTW88_8822CU
	_kernelConfig_warn-y_m RTW88_8723DU
	_kernelConfig_warn-y_m RTW88_8821CE
	_kernelConfig_warn-y_m RTW88_8821CU
	_kernelConfig_warn-y_m RTW89_8851BE
	_kernelConfig_warn-y_m RTW89_8852AE
	_kernelConfig_warn-y_m RTW89_8852BE



	true
}



















_test_kernelConfig() {
	#_getDep pahole
	_wantGetDep pahole
	
	_getDep lz4
	_getDep lz4c
}


_kernelConfig_request_build() {
	_messagePlain_request 'request: make menuconfig'
	
	_messagePlain_request 'request: make -j $(nproc)'
	
	# WARNING: Building debian kernel packages from Gentoo may be complex.
	#https://forums.gentoo.org/viewtopic-t-1096872-start-0.html
	#_messagePlain_request 'emerge dpkg fakeroot bc kmod cpio ; touch /var/lib/dpkg/status'
	
	_messagePlain_request 'request: make deb-pkg -j $(nproc)'
}


# NOTICE: Usually, 'desktop' will be preferable.
# ATTENTION: As desired, ignore, or override with 'ops.sh' or similar.
_kernelConfig_panel() {
	_messageNormal 'kernelConfig: panel'
	
	[[ "$kernelConfig_tradeoff_perform" == "" ]] && export kernelConfig_tradeoff_perform='false'
	[[ "$kernelConfig_tradeoff_compatible" == "" ]] && export kernelConfig_tradeoff_compatible='true'
	[[ "$kernelConfig_frequency" == "" ]] && export kernelConfig_frequency=300
	[[ "$kernelConfig_tickless" == "" ]] && export kernelConfig_tickless='false'
	
	_kernelConfig_require-tradeoff "$@"
	
	_kernelConfig_require-virtualization-accessory "$@"
	
	_kernelConfig_require-virtualbox "$@"
	
	_kernelConfig_require-boot "$@"
	
	_kernelConfig_require-arch-x64 "$@"
	
	_kernelConfig_require-accessory "$@"
	
	_kernelConfig_require-build "$@"
	
	_kernelConfig_require-latency "$@"
	
	_kernelConfig_require-memory "$@"
	
	_kernelConfig_require-integration "$@"
	
	_kernelConfig_require-investigation "$@"
	
	_kernelConfig_require-convenience "$@"

	_kernelConfig_require-embedded "$@"
	
	_kernelConfig_require-special "$@"
	
	
	_kernelConfig_request_build
}

# NOTICE: Usually, 'desktop' will be preferable.
# ATTENTION: As desired, ignore, or override with 'ops.sh' or similar.
_kernelConfig_mobile() {
	_messageNormal 'kernelConfig: mobile'
	
	[[ "$kernelConfig_tradeoff_perform" == "" ]] && export kernelConfig_tradeoff_perform='false'
	[[ "$kernelConfig_tradeoff_compatible" == "" ]] && export kernelConfig_tradeoff_compatible='true'
	[[ "$kernelConfig_frequency" == "" ]] && export kernelConfig_frequency=300
	[[ "$kernelConfig_tickless" == "" ]] && export kernelConfig_tickless='true'
	
	_kernelConfig_require-tradeoff "$@"
	
	_kernelConfig_require-virtualization-accessory "$@"
	
	_kernelConfig_require-virtualbox "$@"
	
	_kernelConfig_require-boot "$@"
	
	_kernelConfig_require-arch-x64 "$@"
	
	_kernelConfig_require-accessory "$@"
	
	_kernelConfig_require-build "$@"
	
	_kernelConfig_require-latency "$@"
	
	_kernelConfig_require-memory "$@"
	
	_kernelConfig_require-integration "$@"
	
	_kernelConfig_require-investigation "$@"
	
	_kernelConfig_require-convenience "$@"

	_kernelConfig_require-embedded "$@"
	
	_kernelConfig_require-special "$@"
	
	
	_kernelConfig_request_build
}

# NOTICE: Recommended! Most 'mobile' and 'panel' use cases will not benefit enough from power efficiency, reduced CPU cycles, or performance.
# WARNING: Security should be favored by tradeoff, as this may be shipped as the 'default' kernel (eg. for 'ubdist') .
# ATTENTION: As desired, ignore, or override with 'ops.sh' or similar.
_kernelConfig_desktop() {
	_messageNormal 'kernelConfig: desktop'
	
	[[ "$kernelConfig_tradeoff_perform" == "" ]] && export kernelConfig_tradeoff_perform='false'
	[[ "$kernelConfig_tradeoff_compatible" == "" ]] && export kernelConfig_tradeoff_compatible='true'
	[[ "$kernelConfig_frequency" == "" ]] && export kernelConfig_frequency=1000
	[[ "$kernelConfig_tickless" == "" ]] && export kernelConfig_tickless='false'
	
	_kernelConfig_require-tradeoff "$@"
	
	_kernelConfig_require-virtualization-accessory "$@"
	
	_kernelConfig_require-virtualbox "$@"
	
	_kernelConfig_require-boot "$@"
	
	_kernelConfig_require-arch-x64 "$@"
	
	_kernelConfig_require-accessory "$@"
	
	_kernelConfig_require-build "$@"
	
	_kernelConfig_require-latency "$@"
	
	_kernelConfig_require-memory "$@"
	
	_kernelConfig_require-integration "$@"
	
	_kernelConfig_require-investigation "$@"
	
	_kernelConfig_require-convenience "$@"

	_kernelConfig_require-embedded "$@"
	
	_kernelConfig_require-special "$@"
	
	
	_kernelConfig_request_build
}

# Forces 'kernelConfig_tradeoff_perform == false' .
_kernelConfig_server() {
	_messageNormal 'kernelConfig: server'

	export kernelConfig_tradeoff_perform='false'
	export kernelConfig_tradeoff_compatible='false'
	_kernelConfig_desktop "$@"
}


# "$1" == alternateRootPrefix
_write_bfq() {
	_messagePlain_nominal 'write_bfq: init'
	
	_mustGetSudo
	
	
	_messagePlain_nominal 'write_bfq: write'
	
	sudo -n cat << 'CZXWXcRMTo8EmM8i4d' | sudo tee "$1"'/etc/modules-load.d/bfq-'"$ubiquitousBashIDshort"'.conf' > /dev/null
bfq

CZXWXcRMTo8EmM8i4d


	cat << 'CZXWXcRMTo8EmM8i4d' | sudo tee "$1"'/etc/udev/rules.d/60-scheduler-'"$ubiquitousBashIDshort"'.rules' > /dev/null
ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*", ATTR{queue/scheduler}="bfq"
ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="bfq"

CZXWXcRMTo8EmM8i4d

	_messagePlain_good 'write_bfq: success'

}





_importShortcuts() {
	_tryExec "_resetFakeHomeEnv"
	
	if ! [[ "$PATH" == *":""$HOME""/bin"* ]] && ! [[ "$PATH" == "$HOME""/bin"* ]] && [[ -e "$HOME"/bin ]] && [[ -d "$HOME"/bin ]]
	then
		#export PATH="$PATH":"$HOME"/bin
		
		# CAUTION: Dubious workaround to prevent '/usr/local/bin/ubiquitous_bash.sh' , or '/usr/local/bin' , from overriding later program versions in '~/bin' .
		if [[ $( ( export PATH="$PATH":"$HOME"/bin ; type -p ubiquitous_bash.sh ) ) == "/usr/local/bin/ubiquitous_bash.sh" ]]
		then
			export PATH="$HOME"/bin:"$PATH"
		else
			export PATH="$PATH":"$HOME"/bin
		fi
	fi
	
	_tryExec "_visualPrompt"
	
	_tryExec "_scopePrompt"
	
	return 0
}


# CAUTION: Compatibility with shells other than bash is apparently important .
# CAUTION: Compatibility with bash shell is important (eg. for '_dropBootdisc' ) .
_setupUbiquitous_accessories_here-plasma_hook() {
	cat << CZXWXcRMTo8EmM8i4d

# sourced by /usr/lib/x86_64-linux-gnu/libexec/plasma-sourceenv.sh

LANG=C
export LANG

CZXWXcRMTo8EmM8i4d

	_setupUbiquitous_accessories_here-nixenv-bashrc

	
}





_setupUbiquitous_accessories_here-vimrc() {
	cat << CZXWXcRMTo8EmM8i4d



" ubcore

" https://stackoverflow.com/questions/27871937/markdown-syntax-coloring-for-less-pager
" https://www.benpickles.com/articles/88-vim-syntax-highlight-markdown-code-blocks
" https://github.com/tpope/vim-markdown
let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'python', 'bash=sh']
let g:markdown_minlines = 1750


CZXWXcRMTo8EmM8i4d
}





# ATTENTION: Override with 'ops.sh' , 'core.sh' , or similar.
_setupUbiquitous_accessories_here-gnuoctave() {
	cat << CZXWXcRMTo8EmM8i4d

%# https://stackoverflow.com/questions/8260619/how-can-i-suppress-the-output-of-a-command-in-octave
%# oldpager = PAGER('/dev/null');
%# oldpso = page_screen_output(1);
%# oldpoi = page_output_immediately(1);


format long g;


deci = 10^-1;
centi = 10^-2;
milli = 10^-3;
micro = 10^-6;
nano =-10^-9;
pico = 10^-12;
femto = 10^-15;
atto = 10^-18;

kilo = 10^3;
mega = kilo * 10^3;
giga = mega * 10^3;
tera = giga * 10^3;


bit = 1;
byte = bit * 8;
Byte = bit * 8;

kilobit = kilo * bit;
megabit = mega * bit;
gigabit = giga * bit;
terabit = tera * bit;

kb = kilobit;
Kb = kilobit;
Mb = megabit;
Gb = gigabit;
Tb = terabit;

kiloByte = kilobit * Byte;
megaByte = megabit * Byte;
gigaByte = gigabit * Byte;
teraByte = terabit * Byte;

kilobyte = kilobit * Byte;
megabyte = megabit * Byte;
gigabyte = gigabit * Byte;
terabyte = terabit * Byte;

kB = kiloByte;
KB = kiloByte;
MB = megaByte;
GB = gigaByte;
TB = teraByte;


kibi = 1024;
mebi = kibi * 1024;
gibi = mebi * 1024;
tebi = gibi * 1024;

kibibit = kibi * bit;
mebibit = mebi * bit;
gibibit = gibi * bit;
tebibit = tebi * bit;

Kib = kibibit;
Mib = mebibit;
Gib = gibibit;
Tib = tebibit;

kibiByte = kibi * Byte;
mebiByte = mebi * Byte;
gibiByte = gibi * Byte;
tebiByte = tebi * Byte;

kibibyte = kibi * Byte;
mebibyte = mebi * Byte;
gibibyte = gibi * Byte;
tebibyte = tebi * Byte;

KiB = kibiByte;
MiB = mebiByte;
GiB = gibiByte;
TiB = tebiByte;



meter = 1;

kilometer = kilo * meter;
megameter = mega * meter;
Megameter = megameter;

decimeter = deci * meter;
centimeter = centi * meter;
millimeter = milli * meter;
micrometer = micro * meter;
nanometer = nano * meter;
picometer = pico * meter;
femtometer = femto * meter;
attometer = atto * meter;



%# 1 * lightsecond ~= 300 * Mega * meter
lightsecond = 299792458 * meter;
lightSecond = lightsecond;

lightyear = lightsecond * 365 * 24 * 3600;
lightYear = lightyear;



hertz = 1;

kilohertz = kilo * hertz;
megahertz = mega * hertz;
gigahertz = giga * hertz;
terahertz = tera * hertz;

kHz = kilohertz;
KHz = kilohertz;
MHz = megahertz;
GHz = gigahertz;
THz = terahertz;



unix("true");
system("true");

cd;

%# Equivalent to Ctrl-L . 
%# https://stackoverflow.com/questions/11269571/how-to-clear-the-command-line-in-octave
clc;


%# PAGER(oldpager);
%# page_screen_output(oldpso);
%# page_output_immediately(oldpoi);

CZXWXcRMTo8EmM8i4d


	! _if_cygwin && cat << CZXWXcRMTo8EmM8i4d

pkg load symbolic;

syms a b c d e f g h i j k l m n o p q r s t u v w x y z;


%# https://octave.sourceforge.io/symbolic/overview.html
nsolve = @vpasolve;

CZXWXcRMTo8EmM8i4d

}


_setupUbiquitous_accessories_here-gnuoctave_hook() {
	cat << CZXWXcRMTo8EmM8i4d

%# oldpager = PAGER('/dev/null');
%# oldpso = page_screen_output(1);
%# oldpoi = page_output_immediately(1);

%# ubcore
run("$ubcore_accessoriesFile_gnuoctave_ubhome");

%# PAGER(oldpager);
%# page_screen_output(oldpso);
%# page_output_immediately(oldpoi);

CZXWXcRMTo8EmM8i4d
}




_setupUbiquitous_accessories_here-cloud_bin() {
	cat << CZXWXcRMTo8EmM8i4d

if [[ "\$PATH" != *'.ebcli-virtual-env/executables'* ]] && [[ -e "$HOME"/.ebcli-virtual-env/executables ]]
then
	# WARNING: Must interpret "$HOME" as is at this point and NOT after any "$HOME" override.
	export PATH="$HOME"/.ebcli-virtual-env/executables:"\$PATH"
fi


if [[ "\$PATH" != *'.gcloud/google-cloud-sdk'* ]] && [[ -e "$HOME"/.gcloud/google-cloud-sdk/completion.bash.inc ]] && [[ -e "$HOME"/.gcloud/google-cloud-sdk/path.bash.inc ]]
then
	. "$HOME"/.gcloud/google-cloud-sdk/completion.bash.inc
	. "$HOME"/.gcloud/google-cloud-sdk/path.bash.inc
fi

CZXWXcRMTo8EmM8i4d
}





_setupUbiquitous_accessories_here-python() {
	
	_generate_lean-lib-python_here "$@"
	
} 

_setupUbiquitous_accessories_here-python_hook() {
	cat << CZXWXcRMTo8EmM8i4d

# ATTENTION: Without either 'exec(exec(open()))' or 'execfile()' , 'from ubcorerc_pythonrc import *' must take effect!
# If 'exec(exec(open()))' is substituted for 'from ubcorerc_pythonrc import *' then copying home directory files independent of '.ubcore' 
import os
if os.path.exists(r"$ubcore_accessoriesFile_python"):
	import sys
	import os
	# https://stackoverflow.com/questions/2349991/how-to-import-other-python-files
	sys.path.append(os.path.abspath(r"$ubcoreDir_accessories_python"))
	from $ubcore_ubcorerc_pythonrc import *





import sys
# https://stackoverflow.com/questions/436198/what-is-an-alternative-to-execfile-in-python-3
if sys.hexversion > 0x03000000:
	exec(r'exec(open( r"$ubcore_accessoriesFile_python_ubhome" ).read() )')
else:
	execfile(r"$ubcore_accessoriesFile_python_ubhome")




CZXWXcRMTo8EmM8i4d
}



_setupUbiquitous_accessories_here-python_bashrc() {
	cat << CZXWXcRMTo8EmM8i4d

# Interactive bash shell will default to calling 'python3' while scripts invoking '#! /usr/bin/env python' or similar may still be given 'python2' equivalent.
[[ "\$_PATH_pythonDir" == "" ]] && alias python=python3

[[ "\$_PATH_pythonDir" == "" ]] && [[ "\$_PYTHONSTARTUP" == "" ]] && export PYTHONSTARTUP="$HOME"/.pythonrc

[[ "\$_PATH_pythonDir" != "" ]] && _set_msw_python_procedure

CZXWXcRMTo8EmM8i4d
}




_setupUbiquitous_accessories_here-nixenv-bashrc() {
	cat << CZXWXcRMTo8EmM8i4d

[[ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME"/.nix-profile/etc/profile.d/nix.sh

# WARNING: Binaries from Nix should not be prepended to Debian PATH, as they may be incompatible with other Debian software (eg. incorrect Python version).
# Scripts that need to rely preferentially on Nix binaries should detect this situation, defining and calling an appropriate wrapper function.
# CAUTION: SEVERE - Issue unresolved. PATH written out to log file matches ' [[ "\$PATH" == *"nix-profile/bin"* ]] ' when run through interactive shell, but, with the exact same PATH value, not when called through some script contexts (eg. 'plasma-workspace/env' ) . Yet grep does match .
#  Hidden or invalid characters in "\$PATH" would seem a sensible cause, but how grep would disregard this while bash would not, seems difficult to explain.
#  Expected cause is interpretation by a shell other than bash .
#   CAUTION: Compatability with shells other than bash may be important .
# CAUTION: Compatibility with bash shell is important (eg. for '_dropBootdisc' ) .
if echo "\$PATH" | grep 'nix-profile/bin' > /dev/null 2>&1 || [[ "\$PATH" == *"nix-profile/bin"* ]]
then
	PATH=\$(echo "\$PATH" | sed 's|:'"$HOME"'/.nix-profile/bin||g;s|'"$HOME"'/.nix-profile/bin:||g')
	export PATH
	PATH="\$PATH":"$HOME"/.nix-profile/bin
	export PATH
fi

CZXWXcRMTo8EmM8i4d
}









_setupUbiquitous_accessories_here-coreoracle_bashrc() {
	
	if _if_cygwin
	then
		cat << CZXWXcRMTo8EmM8i4d

if [[ -e /cygdrive/c/core/infrastructure/coreoracle ]]
then
	export shortcutsPath_coreoracle=/cygdrive/c/"core/infrastructure/coreoracle"
	. /cygdrive/c/core/infrastructure/coreoracle/_shortcuts-cygwin.sh
elif [[ -e /cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle-msw ]]
then
	export shortcutsPath_coreoracle=/cygdrive/c/"core/infrastructure/extendedInterface/_lib/coreoracle-msw"
	. /cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle-msw/_shortcuts-cygwin.sh
#elif [[ -e /cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle ]]
#then
	#export shortcutsPath_coreoracle=/cygdrive/c/"core/infrastructure/extendedInterface/_lib/coreoracle"
	#. /cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle/_shortcuts-cygwin.sh
fi


if [[ -e /cygdrive/c/core/infrastructure/quickWriter ]]
then
	export shortcutsPath_quickWriter=/cygdrive/c/"core/infrastructure/quickWriter"
	. /cygdrive/c/core/infrastructure/quickWriter/_shortcuts-cygwin.sh
elif [[ -e /cygdrive/c/core/infrastructure/extendedInterface/_lib/quickWriter-msw ]]
then
	export shortcutsPath_quickWriter=/cygdrive/c/"core/infrastructure/extendedInterface/_lib/quickWriter-msw"
	. /cygdrive/c/core/infrastructure/extendedInterface/_lib/quickWriter-msw/_shortcuts-cygwin.sh
elif [[ -e /cygdrive/c/core/infrastructure/extendedInterface/_lib/quickWriter ]]
then
	export shortcutsPath_quickWriter=/cygdrive/c/"core/infrastructure/extendedInterface/_lib/quickWriter"
	. /cygdrive/c/core/infrastructure/extendedInterface/_lib/quickWriter/_shortcuts-cygwin.sh
fi

CZXWXcRMTo8EmM8i4d
	else
		cat << CZXWXcRMTo8EmM8i4d

if type sudo > /dev/null 2>&1 && groups | grep -E 'wheel|sudo' > /dev/null 2>&1 && ! uname -a | grep -i cygwin > /dev/null 2>&1
then
	# Greater or equal, '_priority_critical_pid_root' .
	sudo -n renice -n -15 -p \$\$ > /dev/null 2>&1
	sudo -n ionice -c 2 -n 2 -p \$\$ > /dev/null 2>&1
fi



if [[ -e "$HOME"/core/infrastructure/coreoracle ]]
then
	export shortcutsPath_coreoracle="$HOME"/core/infrastructure/coreoracle/
	. "$HOME"/core/infrastructure/coreoracle/_shortcuts.sh
fi


if [[ -e "$HOME"/core/infrastructure/quickWriter ]]
then
	export shortcutsPath_quickWriter="$HOME"/core/infrastructure/quickWriter/
	. "$HOME"/core/infrastructure/quickWriter/_shortcuts.sh
fi



# Returns priority to normal.
# Greater or equal, '_priority_app_pid_root' .
#ionice -c 2 -n 3 -p \$\$
#renice -n -5 -p \$\$ > /dev/null 2>&1

# Returns priority to normal.
# Greater or equal, '_priority_app_pid' .
ionice -c 2 -n 4 -p \$\$
renice -n 0 -p \$\$ > /dev/null 2>&1


CZXWXcRMTo8EmM8i4d
	fi
}





_setupUbiquitous_accessories_here-convenience() {
		cat << CZXWXcRMTo8EmM8i4d

# Equivalence to Dockerfile .
#alias RUN=_bin
alias RUN=""
#  #RUN ( echo test )

CZXWXcRMTo8EmM8i4d

}





_setupUbiquitous_accessories_here-user_bashrc() {
	
	# Calls   "$HOME"/_bashrc   as a place for user defined functions, environment varialbes, etc, which should NOT follow dist/OS updates (eg. extendedInterface reinstallation) and should be copied after dist/OS reinstallation (ie. placed on an SDCard or similar before '_revert-fromLive /dev/sda' .
	#  WARNING: Nevertheless, bashrc is very bad practice . Instead, functionality should be pushed upstream (eg. to 'ubiquitous bash', etc) .
	#   The exception may be very specialized infrastructure (ie. conveniently calling specialized Virtual Machines).
	
	cat << CZXWXcRMTo8EmM8i4d

if [[ -e "$HOME"/_bashrc ]]
then
	. "$HOME"/_bashrc
fi

CZXWXcRMTo8EmM8i4d

}


_setupUbiquitous_accessories_here-container_environment() {
	
	cat << CZXWXcRMTo8EmM8i4d

# Coordinator/Worker, SSH Authorized
if [[ "\$SSH_pub_Coordinator_01" != "" ]] || [[ "\$PUBLIC_KEY" != "" ]]
then
	_ubcore_add_authorized_SSH() {
		[[ "\$1" == "" ]] && return 0

		mkdir -p "$HOME"/.ssh
		chmod 700 "$HOME"/.ssh 2> /dev/null
		
		local currentString=\$(printf '%s' "\$1" | awk '{print \$2}' | tr -dc 'a-zA-Z0-9')

		[[ ! -e "$HOME"/.ssh/authorized_keys ]] && echo -n > "$HOME"/.ssh/authorized_keys && chmod 600 "$HOME"/.ssh/authorized_keys
		if cat "$HOME"/.ssh/authorized_keys | tr -dc 'a-zA-Z0-9' | grep "\$currentString" > /dev/null 2>&1
		then
			return 0
		else
			echo "\$1" >> "$HOME"/.ssh/authorized_keys
			chmod 600 "$HOME"/.ssh/authorized_keys
			return 0
		fi
		return 1
	}

	_ubcore_add_authorized_SSH "\$PUBLIC_KEY"
	
	_ubcore_add_authorized_SSH "\$SSH_pub_Coordinator_01"
	_ubcore_add_authorized_SSH "\$SSH_pub_Coordinator_02"
	_ubcore_add_authorized_SSH "\$SSH_pub_Coordinator_03"

	unset _ubcore_add_authorized_SSH
fi

[[ -e /.dockerenv ]] && git config --global --add safe.directory '*' > /dev/null 2>&1

CZXWXcRMTo8EmM8i4d

}

















_setupUbiquitous_accessories-plasma() {
	_messagePlain_nominal 'init: _setupUbiquitous_accessories-plasma'
	
	mkdir -p "$HOME"/.config/plasma-workspace/env

	_setupUbiquitous_accessories_here-plasma_hook > "$HOME"/.config/plasma-workspace/env/profile.sh
	chmod u+x "$HOME"/.config/plasma-workspace/env/profile.sh
	
	
	return 0
}

_setupUbiquitous_accessories-vim() {
	_messagePlain_nominal 'init: _setupUbiquitous_accessories-gnuoctave'
	
	if ! grep ubcore "$ubHome"/.vimrc > /dev/null 2>&1 && _messagePlain_probe 'vimrc'
	then
		_setupUbiquitous_accessories_here-vimrc >> "$ubHome"/.vimrc
	fi

	return 0
}

_setupUbiquitous_accessories-gnuoctave() {
	_messagePlain_nominal 'init: _setupUbiquitous_accessories-gnuoctave'
	
	mkdir -p "$ubcoreDir_accessories"/gnuoctave
	
	export ubcore_accessoriesFile_gnuoctave="$ubcoreDir_accessories"/gnuoctave/ubcorerc.m
	export ubcore_accessoriesFile_gnuoctave_ubhome="$ubHome"/.ubcorerc-gnuoctave.m
	
	rm -f "$ubcore_accessoriesFile_gnuoctave"
	rm -f "$ubcore_accessoriesFile_gnuoctave_ubhome"
	ln -s "$ubcore_accessoriesFile_gnuoctave_ubhome" "$ubcore_accessoriesFile_gnuoctave"
	
	_setupUbiquitous_accessories_here-gnuoctave > "$ubcore_accessoriesFile_gnuoctave_ubhome"
	
	
	if ! grep ubcore "$ubHome"/.octaverc > /dev/null 2>&1 && _messagePlain_probe 'octaverc'
	then
		# https://www.mathworks.com/matlabcentral/answers/194868-what-about-the-character
		#echo '%# ubcore' >> "$ubHome"/.octaverc
		#_safeEcho_newline run'("'"$ubcore_accessoriesFile_gnuoctave_ubhome"'")' >> "$ubHome"/.octaverc
		_setupUbiquitous_accessories_here-gnuoctave_hook >> "$ubHome"/.octaverc
	fi
	
	return 0
}


_setupUbiquitous_accessories_bashrc-cloud_bin() {
	
	_setupUbiquitous_accessories_here-cloud_bin
	
	echo 'true'
	
	return 0
}



_setupUbiquitous_accessories-python() {
	_messagePlain_nominal 'init: _setupUbiquitous_accessories-python'
	
	mkdir -p "$ubcoreDir_accessories"/python
	
	export ubcore_accessoriesFile_python="$ubcoreDir_accessories"/python/ubcorerc_pythonrc.py
	export ubcore_accessoriesFile_python_ubhome="$ubHome"/.ubcorerc_pythonrc.py
	
	rm -f "$ubcore_accessoriesFile_python"
	rm -f "$ubcore_accessoriesFile_python_ubhome"
	ln -s "$ubcore_accessoriesFile_python_ubhome" "$ubcore_accessoriesFile_python"
	
	_setupUbiquitous_accessories_here-python > "$ubcore_accessoriesFile_python_ubhome"
	
	export ubcore_ubcorerc_pythonrc="ubcorerc_pythonrc"
	
	if ! grep ubcore "$ubHome"/.pythonrc > /dev/null 2>&1 && _messagePlain_probe 'pythonrc'
	then
		# https://www.mathworks.com/matlabcentral/answers/194868-what-about-the-character
		#echo '%# ubcore' >> "$ubHome"/.pythonrc
		#_safeEcho_newline run'("'"$ubcore_accessoriesFile_python_ubhome"'")' >> "$ubHome"/.pythonrc
		_setupUbiquitous_accessories_here-python_hook >> "$ubHome"/.pythonrc
	fi
	
	return 0
}



_setupUbiquitous_accessories-git() {
	git config --global checkout.workers -1
	
	git config --global pull.rebase false

	git config --global core.autocrlf input
	git config --global core.eol lf

	git config --global init.defaultBranch main
}




_setupUbiquitous_accessories() {

	_setupUbiquitous_accessories-plasma "$@"


	_setupUbiquitous_accessories-vim "$@"

	
	_setupUbiquitous_accessories-gnuoctave "$@"
	
	_setupUbiquitous_accessories-python "$@"

	_setupUbiquitous_accessories-git "$@"
	
	return 0
}

_setupUbiquitous_accessories_bashrc() {
	#_messagePlain_nominal 'init: _setupUbiquitous_accessories_bashrc'
	
	_setupUbiquitous_accessories_bashrc-cloud_bin "$@"
	
	_setupUbiquitous_accessories_here-nixenv-bashrc "$@"
	
	#echo true
	
	
	_setupUbiquitous_accessories_here-coreoracle_bashrc "$@"


	_setupUbiquitous_accessories_here-convenience "$@"
	
	
	# WARNING: Python should remain last if possible. Failure to hook python is a failure that must show as an error exit status from the users profile (a red "1" on the first line of first visual prompt command prompt).
	#  WARNING: Do NOT use 'currentExitStatus_python_bashrc' or similar varaibles unless this exit status is really necessary. Performance cost will be significant. Do not attempt to use a 'return' statement, rather if attempting to implement this, instead run 'true' or 'false' at the end of the 'ubcorerc' script depending on the exit status. Discouraged.
	_setupUbiquitous_accessories_here-python_bashrc "$@"
	
	
	_setupUbiquitous_accessories_here-user_bashrc "$@"

	_setupUbiquitous_accessories_here-container_environment "$@"
	
	#echo true
}


_setupUbiquitous_accessories_requests() {
	
	# EXAMPLE .
	#_messagePlain_request 'request: request'
	
	return 0
}





_setupUbiquitous_safe_bashrc() {

cat << CZXWXcRMTo8EmM8i4d
#Generates semi-random alphanumeric characters, default length 18.
#_uid() {
	#local currentLengthUID
	#currentLengthUID="\$1"
	#[[ "\$currentLengthUID" == "" ]] && currentLengthUID=18
	#cat /dev/random 2> /dev/null | base64 2> /dev/null | tr -dc 'a-zA-Z0-9' 2> /dev/null | tr -d 'acdefhilmnopqrsuvACDEFHILMNOPQRSU14580' | head -c "\$currentLengthUID" 2> /dev/null
	#return
#}
_safe_declare_uid
CZXWXcRMTo8EmM8i4d

}

_setupUbiquitous_here() {
	! uname -a | grep -i cygwin > /dev/null 2>&1 && cat << CZXWXcRMTo8EmM8i4d

if type sudo > /dev/null 2>&1 && groups | grep -E 'wheel|sudo' > /dev/null 2>&1 && ! uname -a | grep -i cygwin > /dev/null 2>&1
then
	# Greater or equal, '_priority_critical_pid_root' .
	sudo -n renice -n -15 -p \$\$ > /dev/null 2>&1
	sudo -n ionice -c 2 -n 2 -p \$\$ > /dev/null 2>&1
fi

# ^
# Ensures admin user shell startup, including Ubiquitous Bash, is relatively quick under heavy system load.
# Near-realtime priority may be acceptable, due to reliability of relevant Ubiquitous Bash functions.
# WARNING: Do NOT prioritize highly enough to interfere with embedded hard realtime processes.

# WARNING: Do NOT use 'ubKeep_LANG' unless necessary!
# nix-shell --run "locale -a" -p bash
#  C   C.utf8   POSIX
[[ "\$ubKeep_LANG" != "true" ]] && [[ "\$LANG" != "C" ]] && export LANG="C"

# Not known or expected to cause significant issues. Not known to affect 'ubiquitous_bash' bash scripts, may affect the separate python 'lean.py' script.
if [[ "\$USER" == "" ]]
then
	[[ "\$UID" == "0" ]] && export USER="root"
	[[ "\$USER" == "" ]] && export USER=\$(id -u -n 2>/dev/null)
fi

CZXWXcRMTo8EmM8i4d


	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	_if_cygwin && cat << CZXWXcRMTo8EmM8i4d

[[ -e '/cygdrive' ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && echo -n '_'

[[ "\$profileScriptLocation" == "" ]] && export profileScriptLocation_new='true'

#[[ -e "/etc/ssl/openssl_legacy.cnf" ]] && export OPENSSL_CONF="/etc/ssl/openssl_legacy.cnf"
[[ -e "/etc/ssl/openssl.cnf" ]] && export OPENSSL_CONF="/etc/ssl/openssl.cnf"

CZXWXcRMTo8EmM8i4d

	# WARNING: CAUTION: Precautionary. No known issues, may be unnecessary. Unusual.
	#However, theoretically nix package manager could otherwise override default programs (eg. python , gschem , pcb) before 'ubiquitous_bash' , causing severely incompatible shell environment configuration .
	_setupUbiquitous_accessories_here-nixenv-bashrc


	cat << CZXWXcRMTo8EmM8i4d
PS1_lineNumber=""


# WARNING: Importing complete 'ubiquitous_bash.sh' may cause other scripts to call functions inappropriate for their needs during "_test" and "_setup" .
# This may be acceptable if the user has already run "_setup" from the imported script .
ubDEBUG_current="\$ubDEBUG"
export ubDEBUG="false"
#export profileScriptLocation="$ubcoreUBdir"/ubiquitous_bash.sh
export profileScriptLocation="$ubcoreUBdir"/ubcore.sh
#export profileScriptLocation="$ubcoreUBdir"/lean.sh
export profileScriptFolder="$ubcoreUBdir"
if [[ "\$force_profileScriptLocation" == "" ]]
then
	[[ "\$scriptAbsoluteLocation" != "" ]] && . "\$scriptAbsoluteLocation" --parent _importShortcuts
	[[ "\$scriptAbsoluteLocation" == "" ]] && . "\$profileScriptLocation" --profile _importShortcuts
else
	export profileScriptLocation="\$force_profileScriptLocation"
	export profileScriptFolder="\$force_profileScriptFolder"
	[[ "\$force_profileScriptLocation" != "" ]] && . "\$force_profileScriptLocation" --profile _importShortcuts
fi
[[ "\$ub_setScriptChecksum_disable" == 'true' ]] && export ub_setScriptChecksum_disable="" && unset ub_setScriptChecksum_disable
export ubDEBUG="\$ubDEBUG_current"

# Returns priority to normal.
# Greater or equal, '_priority_app_pid_root' .
#ionice -c 2 -n 3 -p \$\$
#renice -n -5 -p \$\$ > /dev/null 2>&1

# Returns priority to normal.
# Greater or equal, '_priority_app_pid' .
ionice -c 2 -n 4 -p \$\$
renice -n 0 -p \$\$ > /dev/null 2>&1

[[ -e "$ubcoreDir"/cloudrc ]] && . "$ubcoreDir"/cloudrc

true

CZXWXcRMTo8EmM8i4d


	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	_if_cygwin && cat << CZXWXcRMTo8EmM8i4d

if [[ "\$HOME" == "/home/root" ]] && [[ ! -e /home/"\$USER" ]]
then
	ln -s --no-target-directory "/home/root" /home/"\$USER" > /dev/null 2>&1
fi

if [[ -e '/cygdrive' ]] && uname -a | grep -i cygwin > /dev/null 2>&1
then
	#echo -n '.'
	#clear
	
	# https://stackoverflow.com/questions/238073/how-to-add-a-progress-bar-to-a-shell-script
	echo -e -n '.\r'
	
	if [[ "\$profileScriptLocation_new" == 'true' ]]
	then
		export profileScriptLocation_new=''
		unset profileScriptLocation_new
		
		# May have prevented issues from services (eg. ssh-pageant) that now do not continue to cause such issues, have been disabled, or have been removed, etc. Uncomment 'sleep 0.1' commands, replacing the other true/noop/sleep, if necessary or desired.
		#sleep 0.1
		true
		echo '_'
		#sleep 0.1
		true
		echo '_'
		#sleep 0.1
		true
		
		clear
	fi
fi

true

CZXWXcRMTo8EmM8i4d


	cat << CZXWXcRMTo8EmM8i4d

if [[ "\$runDelete" != "" ]] && [[ "\$runDelete" == '/workspace/project'* ]]
then
	#/workspace/project/._run-factory_openai
	rm -f "\$runDelete"
	unset runDelete
fi

[[ -e /info_factoryMOTD.txt ]] && cat /info_factoryMOTD.txt
#[[ -e /info_factoryMOTD.sh ]] && . /info_factoryMOTD.sh

true

CZXWXcRMTo8EmM8i4d

}


_setupUbiquitous_bashProfile_here() {
	! uname -a | grep -i cygwin > /dev/null 2>&1 && cat << CZXWXcRMTo8EmM8i4d

if [[ -e "$HOME"/.bashrc ]] && [[ "\$ubiquitousBashID" == "" ]]
then
	source "$HOME"/.bashrc
fi

CZXWXcRMTo8EmM8i4d
}



_setupUbiquitous_resize() {
	echo "# Hardware serial terminals connected through screen require explicit resize to change number of columns/lines. Usually doing this once will at least increase the usable 'screen real estate' from the very small defaults."
	echo "# Ignored by Cygwin/MSW, etc."
	echo "type -p resize > /dev/null 2>&1 && resize > /dev/null 2>&1"
	echo "true"
	
}



_install_certs() {
    _messageNormal 'install: certs'
    if [[ $(id -u 2> /dev/null) == "0" ]] || [[ "$USER" == "root" ]] || _if_cygwin
    then
    
        # Editing the Cygwin root filesystem itself, root permissions granted within Cygwin environment itself are effective.
        sudo() {
            [[ "$1" == "-n" ]] && shift
            "$@"
        }
    fi

    #"$HOME"/core/data/certs/
    #/usr/local/share/ca-certificates/
    #/etc/pki/ca-trust/source/anchors/

    #update-ca-certificates
    #update-ca-trust

    _install_certs_cp_procedure() {
        _messagePlain_nominal '_install_certs: install: '"$2"
        [[ -e "$2" ]] && sudo -n cp -f "$1"/*.crt "$2"
    }
    _install_certs_cp() {
        [[ -e /cygdrive/c/core ]] && mkdir -p /cygdrive/c/core/data/certs/
        _install_certs_cp_procedure "$1" /cygdrive/c/core/data/certs/

        mkdir -p "$HOME"/core/data/certs/
        _install_certs_cp_procedure "$1" "$HOME"/core/data/certs/

        _install_certs_cp_procedure "$1" /usr/local/share/ca-certificates/

        _if_cygwin && _install_certs_cp_procedure "$1" /etc/pki/ca-trust/source/anchors/

        return 0
    }
    _install_certs_write() {
        if [[ -e "$scriptAbsoluteFolder"/_lib/kit/app/researchEngine/kit/certs ]]
        then
            _install_certs_cp "$scriptAbsoluteFolder"/_lib/kit/app/researchEngine/kit/certs
            return
        fi
        if [[ -e "$scriptAbsoluteFolder"/_lib/ubiquitous_bash/_lib/kit/app/researchEngine/kit/certs ]]
        then
            _install_certs_cp "$scriptAbsoluteFolder"/_lib/ubiquitous_bash/_lib/kit/app/researchEngine/kit/certs
            return
        fi
        if [[ -e "$scriptAbsoluteFolder"/_lib/ubDistBuild/_lib/ubiquitous_bash/_lib/kit/app/researchEngine/kit/certs ]]
        then
            _install_certs_cp "$scriptAbsoluteFolder"/_lib/ubDistBuild/_lib/ubiquitous_bash/_lib/kit/app/researchEngine/kit/certs
            return
        fi
        return 1
    }


    _if_cygwin && sudo -n rm -f /etc/pki/tls/certs/*.0

    _install_certs_write

    # Setup scripts in constrained repetitive environments (ie. OpenAI Codex setup script) may multi-thread concurrent _setupUbiquitous with apt-get . This detects that, and prevents dpkg collision.
    while pgrep '^dpkg$' > /dev/null 2>&1
    do
        sleep 1
    done

    local currentExitStatus="1"
    ! _if_cygwin && sudo -n update-ca-certificates
    [[ "$?" == "0" ]] && currentExitStatus="0"
    _if_cygwin && sudo -n update-ca-trust
    [[ "$?" == "0" ]] && currentExitStatus="0"

    return "$currentExitStatus"
}







_configureLocal() {
	_configureFile "$1" "_local"
}

_configureFile() {
	cp "$scriptAbsoluteFolder"/"$1" "$scriptAbsoluteFolder"/"$2"
}

_configureOps() {
	echo "$@" >> "$scriptAbsoluteFolder"/ops
}

_resetOps() {
	rm "$scriptAbsoluteFolder"/ops
}

_gitPull_ubiquitous() {
	local currentExitStatus_gitBest_pull="0"
	local currentExitStatus_gitBest_submodule_update="0"
	#git pull
	_gitBest pull
	currentExitStatus_gitBest_pull="$?"
	_gitBest submodule update --recursive
	currentExitStatus_gitBest_submodule_update="$?"
	[[ "$currentExitStatus_gitBest_pull" != "0" ]] && return "$currentExitStatus_gitBest_pull"
	[[ "$currentExitStatus_gitBest_submodule_update" != "0" ]] && return "$currentExitStatus_gitBest_submodule_update"
	return 0
}

_gitClone_ubiquitous() {
	local functionEntryPWD="$PWD"

	local currentExitStatus_gitBest_clone="0"
	local currentExitStatus_gitBest_submodule_update="0"
	#git clone --depth 1 git@github.com:mirage335/ubiquitous_bash.git
	_gitBest clone --recursive --depth 1 git@github.com:mirage335/ubiquitous_bash.git
	currentExitStatus_gitBest_clone="$?"

	! cd ubiquitous_bash && _messagePlain_bad 'bad: cd ubiquitous_bash' && return 1
	_gitBest submodule update --recursive
	currentExitStatus_gitBest_submodule_update="$?"
	! cd "$functionEntryPWD" && _messagePlain_bad 'bad: cd '"$functionEntryPWD" && return 1

	[[ "$currentExitStatus_gitBest_clone" != "0" ]] && return "$currentExitStatus_gitBest_clone"
	[[ "$currentExitStatus_gitBest_submodule_update" != "0" ]] && return "$currentExitStatus_gitBest_submodule_update"
	return 0
}

_selfCloneUbiquitous() {
	local currentExitStatus
	currentExitStatus="0"

	"$scriptBin"/.ubrgbin.sh _ubrgbin_cpA "$scriptBin" "$ubcoreUBdir"/ > /dev/null 2>&1
	cp -a "$scriptAbsoluteLocation" "$ubcoreUBdir"/lean.sh
	cp -a "$scriptAbsoluteLocation" "$ubcoreUBdir"/ubcore.sh
	cp -a "$scriptAbsoluteFolder"/lean.sh "$ubcoreUBdir"/lean.sh > /dev/null 2>&1
	cp -a "$scriptAbsoluteFolder"/lean.sh "$ubcoreUBdir"/ubcore.sh > /dev/null 2>&1
	cp -a "$scriptAbsoluteFolder"/ubcore.sh "$ubcoreUBdir"/ubcore.sh > /dev/null 2>&1
	cp -a "$scriptAbsoluteLocation" "$ubcoreUBdir"/ubiquitous_bash.sh
	
	cp -a "$scriptAbsoluteFolder"/lean.py "$ubcoreUBdir"/lean.py > /dev/null 2>&1
	[[ "$?" != "0" ]] && currentExitStatus="1"

	mkdir -p "$ubcoreUBdir"/_lib/kit/app/researchEngine/kit/certs
	if [[ -e "$scriptAbsoluteFolder"/_lib/kit/app/researchEngine/kit/certs ]]
	then
		cp -a "$scriptAbsoluteFolder"/_lib/kit/app/researchEngine/kit/certs/* "$ubcoreUBdir"/_lib/kit/app/researchEngine/kit/certs/
	fi

	return "$currentExitStatus"
}

_installUbiquitous() {
	local localFunctionEntryPWD
	localFunctionEntryPWD="$PWD"
	
	! cd "$ubcoreDir" && _messagePlain_bad 'bad: cd $ubcoreUBdir' && return 1
	
	! cd "$ubcoreUBdir" && _messagePlain_bad 'bad: cd $ubcoreUBdir' && return 1
	_messagePlain_nominal 'attempt: git pull: '"$PWD"
	if [[ "$nonet" != "true" ]] && type git > /dev/null 2>&1
	then
		_gitBest_detect
		
		# CAUTION: After calling 'ubcp-cygwin-portable-installer' during 'build_ubcp' job of GitHub Actions 'build.yml', or similar devops/CI, etc, '/home/root/.ubcore/ubiquitous_bash' is a subdirectory at 'C:\...\ubiquitous_bash\_local\ubcp\cygwin\home\root\.ubcore\ubiquitous_bash' or similar.
		#  DANGER: This causes MSWindows native 'git' binaries to perceive a git repository '.git' subdirectory already exists at the parent directory 'C:\...\ubiquitous_bash' , catastrophically causing 'git pull' to succeed, without populating the '/home/root/.ubcore/ubiquitous_bash' directory with 'ubiquitous_bash.sh' .
		# Preventing that scenario, detect whether a '.git' subdirectory exists at "$ubcoreUBdir"/.git , which should also be the same as './.git' .
		if [[ -e "$ubcoreUBdir"/.git ]] && [[ -e ./.git ]]
		then
			local ub_gitPullStatus
			#git pull
			_gitBest pull
			ub_gitPullStatus="$?"
			_gitBest submodule update --recursive
			[[ "$?" != "0" ]] && ub_gitPullStatus="1"
			#[[ "$ub_gitPullStatus" != 0 ]] && git pull && ub_gitPullStatus="$?"
			if [[ "$ub_gitPullStatus" != 0 ]]
			then
				_gitBest pull
				ub_gitPullStatus="$?"
				_gitBest submodule update --recursive
				[[ "$?" != "0" ]] && ub_gitPullStatus="1"
			fi
			! cd "$localFunctionEntryPWD" && return 1

		[[ "$ub_gitPullStatus" == "0" ]] && _messagePlain_good 'pass: git pull' && cd "$localFunctionEntryPWD" && return 0
		fi
	fi
	_messagePlain_warn 'fail: git pull: '"$PWD"
	
	! cd "$ubcoreDir" && _messagePlain_bad 'bad: cd $ubcoreDir' && return 1
	_messagePlain_nominal 'attempt: git clone'
	[[ "$nonet" != "true" ]] && type git > /dev/null 2>&1 && [[ ! -e ".git" ]] && [[ ! -e "$ubcoreUBdir"/.git ]] && _gitClone_ubiquitous && _messagePlain_good 'pass: git clone' && return 0
	[[ "$nonet" != "true" ]] && type git > /dev/null 2>&1 && [[ ! -e ".git" ]] && [[ ! -e "$ubcoreUBdir"/.git ]] && _gitClone_ubiquitous && _messagePlain_good 'pass: git clone' && return 0
	_messagePlain_warn 'fail: git clone'
	
	cd "$ubcoreUBdir"
	_messagePlain_nominal 'attempt: self git pull'
	# WARNING: Not attempted if 'nonet' has been set 'true', due to possible conflicts with scripts intending only to copy one file (ie. by SSH transfer).
	if [[ "$nonet" != "true" ]] && type git > /dev/null 2>&1 && [[ -e "$scriptAbsoluteFolder"/.git ]] && [[ -e "$scriptAbsoluteFolder"/.git ]]
	then
		
		local ub_gitPullStatus
		#git reset --hard
		[[ -e "$scriptAbsoluteFolder"/lean.sh ]] && rm -f "$ubcoreUBdir"/lean.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubcore.sh ]] && rm -f "$ubcoreUBdir"/ubcore.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubiquitous_bash.sh ]] && rm -f "$ubcoreUBdir"/ubiquitous_bash.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/lean_compressed.sh ]] && rm -f "$ubcoreUBdir"/lean_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/core_compressed.sh ]] && rm -f "$ubcoreUBdir"/core_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubcore_compressed.sh ]] && rm -f "$ubcoreUBdir"/ubcore_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubiquitous_bash_compressed.sh ]] && rm -f "$ubcoreUBdir"/ubiquitous_bash_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/lean.py ]] && rm -f "$ubcoreUBdir"/lean.py > /dev/null 2>&1
		#[[ -e "$scriptAbsoluteFolder"/_lib/kit/app/researchEngine/kit/certs/* ]] && rm -f "$ubcoreUBdir"/_lib/kit/app/researchEngine/kit/certs/* > /dev/null 2>&1
		#git reset --hard
		#git pull "$scriptAbsoluteFolder"
		_gitBest pull "$scriptAbsoluteFolder"
		_gitBest reset --hard
		ub_gitPullStatus="$?"
		_gitBest submodule update --recursive
		[[ "$?" != "0" ]] && ub_gitPullStatus="1"
		! cd "$localFunctionEntryPWD" && return 1
		
		[[ "$ub_gitPullStatus" == "0" ]] && _messagePlain_good 'pass: self git pull' && cd "$localFunctionEntryPWD" && return 0
	fi
	_messagePlain_warn 'fail: self git pull'
	
	cd "$ubcoreDir"
	_messagePlain_nominal 'attempt: self clone'
	[[ -e ".git" ]] && _messagePlain_bad 'fail: self clone' && return 1
	_selfCloneUbiquitous && return 0
	_messagePlain_bad 'fail: self clone' && return 1
	
	return 0
	
	cd "$localFunctionEntryPWD"
}




_setupUbiquitous() {
	_messageNormal "init: setupUbiquitous"
	export ub_under_setupUbiquitous="true"
	
	if _if_cygwin
	then
		echo 'detected: cygwin'
		_messagePlain_probe_cmd _setupUbiquitous_accessories-git
	fi
	
	_force_cygwin_symlinks
	_if_cygwin && _setup_ubiquitousBash_cygwin_procedure
	
	
	local ubHome
	ubHome="$HOME"
	[[ "$1" != "" ]] && ubHome="$1"
	
	export ubcoreDir="$ubHome"/.ubcore
	export ubcoreFile="$ubcoreDir"/.ubcorerc
	
	export ubcoreDir_accessories="$ubHome"/.ubcore/accessories
	export ubcoreDir_accessories_python="$ubcoreDir_accessories"/python
	
	# WARNING: Despite the name, do NOT point this to 'ubcore.sh' or similar. Full set of functions are expected from this file by some use cases!
	export ubcoreUBdir="$ubcoreDir"/ubiquitous_bash
	export ubcoreUBfile="$ubcoreDir"/ubiquitous_bash/ubiquitous_bash.sh
	
	_messagePlain_probe 'ubHome= '"$ubHome"
	_messagePlain_probe 'ubcoreDir= '"$ubcoreDir"
	_messagePlain_probe 'ubcoreFile= '"$ubcoreFile"
	
	_messagePlain_probe 'ubcoreUBdir= '"$ubcoreUBdir"
	_messagePlain_probe 'ubcoreUBfile= '"$ubcoreUBfile"
	
	mkdir -p "$ubcoreUBdir"
	! [[ -e "$ubcoreUBdir" ]] && _messagePlain_bad 'missing: ubcoreUBdir= '"$ubcoreUBdir" && _messageFAIL && return 1
	
	mkdir -p "$ubcoreDir_accessories"
	! [[ -e "$ubcoreDir_accessories" ]] && _messagePlain_bad 'missing: ubcoreUBdir_accessories= '"$ubcoreDir_accessories" && _messageFAIL && return 1
	
	
	_messageNormal "install: setupUbiquitous"
	! _installUbiquitous && _messageFAIL && return 1
	! [[ -e "$ubcoreUBfile" ]] && _messagePlain_bad 'missing: ubcoreUBfile= '"$ubcoreUBfile" && _messageFAIL && return 1
	
	
	_messageNormal "hook: setupUbiquitous"
	if ! _permissions_ubiquitous_repo "$ubcoreUBdir" && _messagePlain_bad 'permissions: ubcoreUBdir = '"$ubcoreUBdir"
	then
		if ! _if_cygwin
		then
			_messageFAIL
			return 1
		else
			echo 'warn: accepted: cygwin: permissions'
		fi
	fi
	
	mkdir -p "$ubHome"/bin/
	rm -f "$ubHome"/bin/ubiquitous_bash.sh
	ln -sf "$ubcoreUBfile" "$ubHome"/bin/ubiquitous_bash.sh
	rm -f "$ubHome"/bin/_winehere
	ln -sf "$ubcoreUBfile" "$ubHome"/bin/_winehere
	rm -f "$ubHome"/bin/_winecfghere
	ln -sf "$ubcoreUBfile" "$ubHome"/bin/_winecfghere
	
	echo '#!/bin/bash
"$HOME"/bin/ubiquitous_bash.sh _vncf "$@"' > "$ubHome"/bin/vncf
	chmod u+x "$ubHome"/bin/vncf
	
	echo '#!/bin/bash
"$HOME"/bin/ubiquitous_bash.sh _sshf "$@"' > "$ubHome"/bin/sshf
	chmod u+x "$ubHome"/bin/vncf
	
	
	
	_setupUbiquitous_here > "$ubcoreFile"
	_setupUbiquitous_accessories_bashrc >> "$ubcoreFile"
	_setupUbiquitous_safe_bashrc >> "$ubcoreFile"
	! [[ -e "$ubcoreFile" ]] && _messagePlain_bad 'missing: ubcoreFile= '"$ubcoreFile" && _messageFAIL && return 1
	
	
	! grep ubcore "$ubHome"/.bashrc > /dev/null 2>&1 && _messagePlain_probe "$ubcoreFile"' >> '"$ubHome"/.bashrc && echo ". ""$ubcoreFile" >> "$ubHome"/.bashrc
	! grep ubcore "$ubHome"/.bashrc > /dev/null 2>&1 && _messagePlain_bad 'missing: bashrc hook' && _messageFAIL && return 1
	
	
	if [[ ! -e "$HOME"/.bash_profile ]] || ! grep '\.bashrc' "$HOME"/.bash_profile > /dev/null 2>&1
	then
		_setupUbiquitous_bashProfile_here >> "$HOME"/.bash_profile
	fi
	
	_setupUbiquitous_resize >> "$ubcoreFile"
	
	
	_messageNormal "install: setupUbiquitous_accessories"
	
	_setupUbiquitous_accessories "$@"


	_install_certs "$@"
	
	
	_messageNormal "request: setupUbiquitous_accessories , setupUbiquitous"
	
	_setupUbiquitous_accessories_requests "$@"
	
	if ! _if_cygwin
	then
		# WARNING: End user file association. Do NOT call within scripts.
		# WARNING: Necessarily relies on a 'deprecated' 'field code' with the 'Exec key' of a 'Desktop Entry' file association.
		# https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html
		_messagePlain_request 'association: *.bat'
		echo 'konsole --workdir %d -e /bin/bash %f (open in graphical terminal emulator from file manager) (preferred)'
		echo "bash ('Advanced Options -> Run in terminal')"
	fi
	
	_messagePlain_request "Now import new functionality into current shell if not in current shell."
	if [[ "$profileScriptLocation" != "" ]] && [[ "$profileScriptFolder" != "" ]]
	then
		_messagePlain_request ". "'"'"$scriptAbsoluteLocation"'"' --profile _importShortcuts
	else
		_request_visualPrompt
	fi
	
	sleep 3
	return 0
}

_setupUbiquitous_nonet() {
	local oldNoNet
	oldNoNet="$nonet"
	export nonet="true"
	_setupUbiquitous "$@"
	[[ "$oldNoNet" != "true" ]] && export nonet="$oldNoNet"
}

_upgradeUbiquitous() {
	_setupUbiquitous
}

_resetUbiquitous_sequence() {
	_start scriptLocal_mkdir_disable
	
	[[ ! -e "$HOME"/.bashrc ]] && return 0
	cp "$HOME"/.bashrc "$HOME"/.bashrc.bak
	cp "$HOME"/.bashrc "$safeTmp"/.bashrc
	grep -v 'ubcore' "$safeTmp"/.bashrc > "$safeTmp"/.bashrc.tmp
	mv "$safeTmp"/.bashrc.tmp "$HOME"/.bashrc
	
	[[ ! -e "$HOME"/.ubcore ]] && return 0
	rm "$HOME"/.ubcorerc
	
	_stop
}

_resetUbiquitous() {
	"$scriptAbsoluteLocation" _resetUbiquitous_sequence
}

_refresh_anchors_ubiquitous() {
	#cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_ubide
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_ubdb
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_test
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_true
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_false
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_test.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_true.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_false.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bin.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bash.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setup_ubcp.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setup_ubiquitousBash_cygwin.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setupUbiquitous.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setupUbiquitous_nonet.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_demand_broadcastPipe_page.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_terminate_broadcastPipe_page.bat
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_packetDriveDevice.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_packetDriveDevice_remove.bat
}


_refresh_anchors_cautossh() {
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_test
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_setup
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_bash
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_bin
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_grsync
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_test.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setup.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bash.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bin.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_grsync.bat
}


# EXAMPLE ONLY.
# _refresh_anchors() {
# 	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_true
# }


# CAUTION: Anchor scripts MUST include code to ignore '--' suffix specific software name convention!
# CAUTION: ONLY intended to be used either with generic software, or anchors following '--' suffix specific software name convention!
# WARNING: DO NOT enable in "core.sh". Intended to be enabled by "_local/ops.sh".
# ATTENTION: Set "$ub_anchor_specificSoftwareName" or similar in "ops.sh".
# ATTENTION: Set ub_anchor_user='true' or similar in "ops.sh".
#export ub_anchor_specificSoftwareName='experimental'
#export ub_anchor_user="true"
_set_refresh_anchors_specific() {
	export ub_anchor_suffix=
	export ub_anchor_suffix
	
	[[ "$ub_anchor_specificSoftwareName" == "" ]] && return 0
	
	export ub_anchor_suffix='--'"$ub_anchor_specificSoftwareName"
	
	return 0
}

_refresh_anchors_specific_single_procedure() {
	[[ "$ub_anchor_specificSoftwareName" == "" ]] && return 1
	
	_set_refresh_anchors_specific
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/"$1""$ub_anchor_suffix"
	
	return 0
}
# Assumes user has included "$HOME"/bin in their "$PATH".
_refresh_anchors_user_single_procedure() {
	[[ "$ub_anchor_user" != 'true' ]] && return 1
	
	_set_refresh_anchors_specific
	! mkdir -p "$HOME"/bin && return 1
	
	
	# WARNING: Default to replacement. Rare case considered acceptable for several reasons.
	# Negligible damage potential - all replaced files are symlinks or anchors.
	# Limited to specifically named anchor symlinks, defined in "_associate_anchors_request", typically overloaded with 'core.sh' or similar.
	# Usually requested 'manually' through "_setup" or "_anchor", even if called through a multi-installation request.
	# Incorrectly calling a moved, uninstalled, or otherwise incorrect previous version, of linked software, is anticipated to be a more commonly impose greater risk.
	rm -f "$HOME"/bin/"$1""$ub_anchor_suffix"
	#ln -s "$scriptAbsoluteFolder"/"$1""$ub_anchor_suffix" "$HOME"/bin/ > /dev/null 2>&1
	ln -sf "$scriptAbsoluteFolder"/"$1""$ub_anchor_suffix" "$HOME"/bin/
	
	return 0
}

# ATTENTION: Overload with 'core.sh' or similar.
# # EXAMPLE ONLY.
# _refresh_anchors_specific() {
# 	_refresh_anchors_specific_single_procedure _true
# }
# # EXAMPLE ONLY.
# _refresh_anchors_user() {
# 	_refresh_anchors_user_single_procedure _true
# }


# ATTENTION: Overload with 'core'sh' or similar.
# _associate_anchors_request() {
# 	if type "_refresh_anchors_user" > /dev/null 2>&1
# 	then
# 		_tryExec "_refresh_anchors_user"
# 		#return
# 	fi
# 	
# 	_messagePlain_request 'association: dir'
# 	echo _scope_konsole"$ub_anchor_suffix"
# 	
# 	_messagePlain_request 'association: dir'
# 	echo _scope_designer_designeride"$ub_anchor_suffix"
# 	
# 	_messagePlain_request 'association: dir, *.ino'
# 	echo _designer_generate"$ub_anchor_suffix"
# }



# ATTENTION: Overload with 'core.sh' or similar.
# WARNING: May become default behavior.
_anchor_autoupgrade() {
	local currentScriptBaseName
	currentScriptBaseName=$(basename $scriptAbsoluteLocation)
	[[ "$currentScriptBaseName" != "ubiquitous_bash.sh" ]] && return 1
	
	[[ "$ub_anchor_autoupgrade" != 'true' ]] && return 0
	
	_findUbiquitous
	
	[[ -e "$ubiquitousLibDir"/_anchor ]] && cp -a "$ubiquitousLibDir"/_anchor "$scriptAbsoluteFolder"/_anchor
}

_anchor_configure() {
	export ubAnchorTemplateCurrent="$scriptAbsoluteFolder"/_anchor
	[[ "$1" != "" ]] && export ubAnchorTemplateCurrent="$1"
	
	! [[ -e "$ubAnchorTemplateCurrent" ]] && return 1
	
	#https://superuser.com/questions/450868/what-is-the-simplest-scriptable-way-to-check-whether-a-shell-variable-is-exporte
	! [ "$(bash -c 'echo ${objectName}')" ] && return 1
	
	
	rm -f "$scriptAbsoluteFolder"/_anchor.tmp "$scriptAbsoluteFolder"/_anchor.tmp1 "$scriptAbsoluteFolder"/_anchor.tmp2 > /dev/null 2>&1
	cp "$ubAnchorTemplateCurrent" "$scriptAbsoluteFolder"/_anchor.tmp
	cp "$ubAnchorTemplateCurrent" "$scriptAbsoluteFolder"/_anchor.tmp1
	cp "$ubAnchorTemplateCurrent" "$scriptAbsoluteFolder"/_anchor.tmp2
	
	cat "$scriptAbsoluteFolder"/_anchor.tmp  | sed 's/^export anchorSourceDir\=.*$/export anchorSourceDir\=\"'"$objectName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp1
	#perl -p -e 's/export anchorSourceDir=.*/export anchorSourceDir="$ENV{objectName}"/g' "$scriptAbsoluteFolder"/_anchor.tmp > "$scriptAbsoluteFolder"/_anchor.tmp1
	
	cat "$scriptAbsoluteFolder"/_anchor.tmp1 | sed 's/^SET \"MSWanchorSourceDir\=.*$/SET \"MSWanchorSourceDir\='"$objectName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp2
	#perl -p -e 's/SET "MSWanchorSourceDir=.*/SET "MSWanchorSourceDir=$ENV{objectName}"/g' "$scriptAbsoluteFolder"/_anchor.tmp1 > "$scriptAbsoluteFolder"/_anchor.tmp2
	
	local currentScriptBaseName
	currentScriptBaseName=$(basename $scriptAbsoluteLocation)
	
	# ATTENTION: Configure with 'ops.sh' , 'core.sh' , or similar.
	if [[ "$scriptAbsoluteLocation" == *"cautossh" ]] || [[ "$scriptAbsoluteLocation" != *"ubiquitous_bash.sh" ]]
	then
		cat "$scriptAbsoluteFolder"/_anchor.tmp2  | sed 's/^export anchorSource\=.*$/export anchorSource\=\"'"$currentScriptBaseName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp3
		#perl -p -e 's/export anchorSource=.*/export anchorSource="cautossh"/g' "$scriptAbsoluteFolder"/_anchor.tmp2 > "$scriptAbsoluteFolder"/_anchor.tmp3
		
		cat "$scriptAbsoluteFolder"/_anchor.tmp3 | sed 's/^SET \"MSWanchorSource\=.*$/SET \"MSWanchorSource\='"$currentScriptBaseName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp4
		#perl -p -e 's/SET "MSWanchorSource=.*/SET "MSWanchorSource=cautossh"/g' "$scriptAbsoluteFolder"/_anchor.tmp3 > "$scriptAbsoluteFolder"/_anchor.tmp4
	else
		cat "$scriptAbsoluteFolder"/_anchor.tmp2 > "$scriptAbsoluteFolder"/_anchor.tmp4
	fi
	
	mv "$scriptAbsoluteFolder"/_anchor.tmp4 "$ubAnchorTemplateCurrent"
	chmod u+x "$ubAnchorTemplateCurrent"
	rm -f "$scriptAbsoluteFolder"/_anchor.tmp "$scriptAbsoluteFolder"/_anchor.tmp1 "$scriptAbsoluteFolder"/_anchor.tmp2 "$scriptAbsoluteFolder"/_anchor.tmp3 "$scriptAbsoluteFolder"/_anchor.tmp4 > /dev/null 2>&1
}


_anchor() {
	_anchor_autoupgrade
	
	_anchor_configure
	_anchor_configure "$scriptAbsoluteFolder"/_anchor.bat

	_tryExec "_anchor_special"
	
	! [[ -e "$scriptAbsoluteFolder"/_anchor ]] && ! [[ -e "$scriptAbsoluteFolder"/_anchor.bat ]] && return 1
	
	[[ "$scriptAbsoluteFolder" == *"ubiquitous_bash" ]] && _refresh_anchors_ubiquitous
	
	if type "_refresh_anchors_cautossh" > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" == *"cautossh" ]]
	then
		_tryExec "_refresh_anchors_cautossh"
		#return
	fi
	
	
	if type "_refresh_anchors" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors"
		#return
	fi
	
	# CAUTION: Anchor scripts MUST include code to ignore '--' suffix specific software name convention!
	# WARNING: DO NOT enable in "core.sh". Intended to be enabled by "_local/ops.sh".
	if type "_refresh_anchors_specific" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors_specific"
		#return
	fi
	
	# CAUTION: ONLY intended to be used either with generic software, or anchors following '--' suffix specific software name convention!
	# WARNING: DO NOT enable in "core.sh". Intended to be enabled by "_local/ops.sh".
	if type "_refresh_anchors_user" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors_user"
		#return
	fi
	
	# WARNING: Calls _refresh_anchors_user . Same variables required to enable, intended to be set by "_local/ops.sh".
	#if type "_associate_anchors_request" > /dev/null 2>&1
	#then
		#_tryExec "_associate_anchors_request"
		##return
	#fi
	
	
	
	return 0
}




_setup_renice() {
	_messageNormal '_setup_renice'
	
	if [[ "$scriptAbsoluteFolder" == *'ubiquitous_bash' ]] && [[ "$1" != '--force' ]]
	then
		_messagePlain_bad 'bad: generic ubiquitous_bash installation detected'
		_messageFAIL
		_stop 1
	fi
	
	
	_messagePlain_nominal '_setup_renice: hook: ubcore'
	local ubHome
	ubHome="$HOME"
	export ubcoreDir="$ubHome"/.ubcore
	export ubcoreFile="$ubcoreDir"/.ubcorerc
	
	if ! [[ -e "$ubcoreFile" ]]
	then
		_messagePlain_warn 'fail: hook: missing: .ubcorerc'
		return 1
	fi
	
	if grep 'token_ub_renice' "$ubcoreFile" > /dev/null 2>&1
	then
		_messagePlain_good 'good: hook: present: .ubcorerc'
		return 0
	fi
	
	#echo '# token_ub_renice' >> "$ubcoreFile"
	cat << CZXWXcRMTo8EmM8i4d >> "$ubcoreFile"

# token_ub_renice
if [[ "\$__overrideRecursionGuard_make" != 'true' ]] && [[ "\$__overrideKeepPriority_make" != 'true' ]] && type type > /dev/null 2>&1 && type -p make > /dev/null 2>&1
then
	__overrideRecursionGuard_make='true'
	__override_make=$(type -p make 2>/dev/null)
	make() {
		#Greater or equal, _priority_idle_pid
		
 		ionice -c 2 -n 5 -p \$\$ > /dev/null 2>&1
		renice -n 3 -p \$\$ > /dev/null 2>&1
		
		"\$__override_make" "\$@"
	}
fi

CZXWXcRMTo8EmM8i4d
	
	if grep 'token_ub_renice' "$ubcoreFile" > /dev/null 2>&1
	then
		_messagePlain_good 'good: hook: present: .ubcorerc'
		#return 0
	else
		_messagePlain_bad 'fail: hook: missing: token: .ubcorerc'
		_messageFAIL
		return 1
	fi
	
	
	
	_messagePlain_nominal '_setup_renice: hook: cron'
	#echo '@reboot '"$scriptAbsoluteLocation"' _unix_renice_execDaemon' | crontab -
	( crontab -l ; echo '@reboot '"$scriptAbsoluteLocation"' _unix_renice_execDaemon > /var/log/_unix_renice_execDaemon.log' ) | crontab -
	
	#echo '*/7 * * * * '"$scriptAbsoluteLocation"' _unix_renice'
	#echo '*/1 * * * * '"$scriptAbsoluteLocation"' _unix_renice_app'
}

# WARNING: Recommend, using an independent installation (ie. not '~/core/infrastructure/ubiquitous_bash').
_unix_renice_execDaemon() {
	_cmdDaemon "$scriptAbsoluteLocation" _unix_renice_repeat
}

_unix_renice_daemon() {
	_priority_idle_pid "$$" > /dev/null 2>&1
	
	_start
	
	_killDaemon
	
	
	_unix_renice_execDaemon
	while _daemonStatus
	do
		sleep 5
	done
	
	_stop
}

_unix_renice_repeat() {
	# sleep 0.7
	_unix_renice_app
	_unix_renice
	
	sleep 3
	_unix_renice_app
	_unix_renice
	
	sleep 9
	_unix_renice_app
	_unix_renice
	
	sleep 27
	_unix_renice_app
	_unix_renice
	
	sleep 27
	_unix_renice_app
	_unix_renice
	
	local currentIteration
	while true
	do
		currentIteration=0
		while [[ "$currentIteration" -lt "4" ]]
		do
			sleep 120
			[[ "$matchingEMBEDDED" != 'false' ]] && sleep 120
			_unix_renice_app > /dev/null 2>&1
			let currentIteration="$currentIteration"+1
		done
		
		_unix_renice
	done
}

_unix_renice() {
	_priority_idle_pid "$$" > /dev/null 2>&1
	
	_unix_renice_critical > /dev/null 2>&1
	_unix_renice_interactive > /dev/null 2>&1
	_unix_renice_app > /dev/null 2>&1
	_unix_renice_idle > /dev/null 2>&1
}

_unix_renice_critical() {
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	_priority_enumerate_pattern ^ksysguard$ >> "$processListFile"
	_priority_enumerate_pattern ^ksysguardd$ >> "$processListFile"
	_priority_enumerate_pattern ^top$ >> "$processListFile"
	_priority_enumerate_pattern ^iotop$ >> "$processListFile"
	_priority_enumerate_pattern ^latencytop$ >> "$processListFile"
	
	_priority_enumerate_pattern ^Xorg$ >> "$processListFile"
	_priority_enumerate_pattern ^modeset$ >> "$processListFile"
	
	_priority_enumerate_pattern ^smbd$ >> "$processListFile"
	_priority_enumerate_pattern ^nmbd$ >> "$processListFile"
	
	_priority_enumerate_pattern ^ssh$ >> "$processListFile"
	_priority_enumerate_pattern ^sshd$ >> "$processListFile"
	_priority_enumerate_pattern ^ssh-agent$ >> "$processListFile"
	
	_priority_enumerate_pattern ^sshfs$ >> "$processListFile"
	
	_priority_enumerate_pattern ^socat$ >> "$processListFile"
	
	#_priority_enumerate_pattern ^cron$ >> "$processListFile"
	
	local currentPID
	
	while read -r currentPID
	do
		_priority_critical_pid "$currentPID"
	done < "$processListFile"
	
	rm "$processListFile"
}

_unix_renice_interactive() {
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	_priority_enumerate_pattern ^kwin$ >> "$processListFile"
	_priority_enumerate_pattern ^pager$ >> "$processListFile"
	
	_priority_enumerate_pattern ^pulseaudio$ >> "$processListFile"
	
	_priority_enumerate_pattern ^synergy$ >> "$processListFile"
	_priority_enumerate_pattern ^synergys$ >> "$processListFile"
	
	_priority_enumerate_pattern ^kactivitymanagerd$ >> "$processListFile"
	
	_priority_enumerate_pattern ^dbus >> "$processListFile"
	
	local currentPID
	
	while read -r currentPID
	do
		_priority_interactive_pid "$currentPID"
	done < "$processListFile"
	
	rm "$processListFile"
}

_unix_renice_app() {
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	_priority_enumerate_pattern ^plasmashell$ >> "$processListFile"
	
	_priority_enumerate_pattern ^audacious$ >> "$processListFile"
	_priority_enumerate_pattern ^vlc$ >> "$processListFile"
	
	_priority_enumerate_pattern ^firefox$ >> "$processListFile"
	
	_priority_enumerate_pattern ^dolphin$ >> "$processListFile"
	
	_priority_enumerate_pattern ^kwrite$ >> "$processListFile"
	
	_priority_enumerate_pattern ^konsole$ >> "$processListFile"
	
	
	_priority_enumerate_pattern ^okular$ >> "$processListFile"
	
	_priority_enumerate_pattern ^xournal$ >> "$processListFile"
	
	_priority_enumerate_pattern ^soffice.bin$ >> "$processListFile"
	
	
	_priority_enumerate_pattern ^pavucontrol$ >> "$processListFile"
	
	local currentPID
	
	while read -r currentPID
	do
		_priority_app_pid "$currentPID"
	done < "$processListFile"
	
	rm "$processListFile"
}

_unix_renice_idle() {
	local processListFile
	processListFile="$tmpSelf"/.pidlist_$(_uid)
	
	_priority_enumerate_pattern ^packagekitd$ >> "$processListFile"
	
	_priority_enumerate_pattern ^apt-config$ >> "$processListFile"
	
	#_priority_enumerate_pattern ^ModemManager$ >> "$processListFile"
	
	#_priority_enumerate_pattern ^sddm$ >> "$processListFile"
	
	#_priority_enumerate_pattern ^lpqd$ >> "$processListFile"
	#_priority_enumerate_pattern ^cupsd$ >> "$processListFile"
	#_priority_enumerate_pattern ^cups-browsed$ >> "$processListFile"
	
	_priority_enumerate_pattern ^akonadi >> "$processListFile"
	_priority_enumerate_pattern ^akonadi_indexing_agent$ >> "$processListFile"
	
	#_priority_enumerate_pattern ^kdeconnectd$ >> "$processListFile"
	#_priority_enumerate_pattern ^kacceessibleapp$ >> "$processListFile"
	#_priority_enumerate_pattern ^kglobalaccel5$ >> "$processListFile"
	
	#_priority_enumerate_pattern ^kded4$ >> "$processListFile"
	#_priority_enumerate_pattern ^ksmserver$ >> "$processListFile"
	
	_priority_enumerate_pattern ^sleep$ >> "$processListFile"
	
	_priority_enumerate_pattern ^exim4$ >> "$processListFile"
	_priority_enumerate_pattern ^apache2$ >> "$processListFile"
	_priority_enumerate_pattern ^mysqld$ >> "$processListFile"
	_priority_enumerate_pattern ^ntpd$ >> "$processListFile"
	#_priority_enumerate_pattern ^avahi-daemon$ >> "$processListFile"
	
	
	# WARNING: Probably unnecessary and counterproductive. May risk halting important compile jobs.
	#_priority_enumerate_pattern ^cc1$ >> "$processListFile"
	#_priority_enumerate_pattern ^cc1plus$ >> "$processListFile"
	
	#_priority_enumerate_pattern ^tar$ >> "$processListFile"
	#_priority_enumerate_pattern ^xz$ >> "$processListFile"
	#_priority_enumerate_pattern ^kcompactd0$ >> "$processListFile"
	
	
	local currentPID
	
	while read -r currentPID
	do
		_priority_idle_pid "$currentPID"
	done < "$processListFile"
	
	rm "$processListFile"
}



# WARNING: End user function. Do NOT call within scripts.
# No production use.
# DANGER: Removes all 'service' files with the correct number of characters. In practice, no non-temporary service is known to meet this criteria.
_systemd_cleanup() {
	# DANGER: Obsolete, more likely to cause unintended deletion. Will be disabled eventually.
	sudo -n rm -f /etc/systemd/system/??????????????????.service
	
	# WARNING: Relies on a >72char filename.
	sudo -n rm -f /etc/systemd/system/????????????????????????????????????????????????????????????????????????.service
}

#####Basic Variable Management

#Reset prefixes.
export tmpPrefix=""
export tmpSelf=""

# ATTENTION: CAUTION: Should only be used by a single unusual Cygwin override. Must be reset if used for any other purpose.
#export descriptiveSelf=""

#####Global variables.
#Fixed unique identifier for ubiquitous bash created global resources, such as bootdisc images to be automaticaly mounted by guests. Should NEVER be changed.
export ubiquitiousBashIDnano=uk4u
export ubiquitiousBashIDshort="$ubiquitiousBashIDnano"PhB6
export ubiquitiousBashID="$ubiquitiousBashIDshort"63kVcygT0q
export ubiquitousBashIDnano=uk4u
export ubiquitousBashIDshort="$ubiquitousBashIDnano"PhB6
export ubiquitousBashID="$ubiquitousBashIDshort"63kVcygT0q

##Parameters
#"--shell", ""
#"--profile"
#"--parent", "--return", "--devenv"
#"--call", "--script" "--bypass"
if [[ "$ub_import_param" == "--profile" ]]
then
	ub_import=true
	export scriptAbsoluteLocation="$profileScriptLocation"
	export scriptAbsoluteFolder="$profileScriptFolder"
	export sessionid=$(_uid)
	_messagePlain_probe_expr 'profile: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''profile: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''profile: sessionid= '"$sessionid" | _user_log-ub
elif ( [[ "$ub_import_param" == "--parent" ]] || [[ "$ub_import_param" == "--embed" ]] || [[ "$ub_import_param" == "--return" ]] || [[ "$ub_import_param" == "--devenv" ]] ) && [[ "$scriptAbsoluteLocation" != "" ]] && [[ "$scriptAbsoluteFolder" != "" ]] && [[ "$sessionid" != "" ]]
then
	ub_import=true
	true #Do not override.
	_messagePlain_probe_expr 'parent: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''parent: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''parent: sessionid= '"$sessionid" | _user_log-ub
elif [[ "$ub_import_param" == "--call" ]] || [[ "$ub_import_param" == "--script" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--shell" ]] || [[ "$ub_import_param" == "--compressed" ]] || ( [[ "$ub_import" == "true" ]] && [[ "$ub_import_param" == "" ]] )
then
	ub_import=true
	export scriptAbsoluteLocation="$importScriptLocation"
	export scriptAbsoluteFolder="$importScriptFolder"
	export sessionid=$(_uid)
	_messagePlain_probe_expr 'call: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''call: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''call: sessionid= '"$sessionid" | _user_log-ub
elif [[ "$ub_import" != "true" ]]	#"--shell", ""
then
	export scriptAbsoluteLocation=$(_getScriptAbsoluteLocation)
	export scriptAbsoluteFolder=$(_getScriptAbsoluteFolder)
	export sessionid=$(_uid)
	_messagePlain_probe_expr 'default: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''default: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''default: sessionid= '"$sessionid" | _user_log-ub
else	#FAIL, implies [[ "$ub_import" == "true" ]]
	_messagePlain_bad 'import: fall: fail' | _user_log-ub
	return 1 >/dev/null 2>&1
	exit 1
fi
[[ "$importScriptLocation" != "" ]] && export importScriptLocation=
[[ "$importScriptFolder" != "" ]] && export importScriptFolder=

[[ ! -e "$scriptAbsoluteLocation" ]] && _messagePlain_bad 'missing: scriptAbsoluteLocation= '"$scriptAbsoluteLocation" | _user_log-ub && exit 1
[[ "$sessionid" == "" ]] && _messagePlain_bad 'missing: sessionid' | _user_log-ub && exit 1

#Current directory for preservation.
export outerPWD=$(_getAbsoluteLocation "$PWD")

export initPWD="$PWD"
intInitPWD="$PWD"


# DANGER: CAUTION: Undefined removal of (at least temporary) directories may be possible. Do NOT use without thorough consideration!
# Only known use is setting the temporary directory of a subsequent background process through "$scriptAbsoluteLocation" .
# EXAMPLE: _interactive_pipe() { ... }
if [[ "$ub_force_sessionid" != "" ]]
then
	sessionid="$ub_force_sessionid"
	[[ "$ub_force_sessionid_repeat" != 'true' ]] && export ub_force_sessionid=""
fi


_get_ub_globalVars_sessionDerived() {

export lowsessionid=$(echo -n "$sessionid" | tr A-Z a-z )

if [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]]
then
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	if [[ "$tmpSelf" == "" ]]
	then
		
		export tmpMSW=$( cd "$LOCALAPPDATA" 2>/dev/null ; pwd )"/Temp"
		[[ ! -e "$tmpMSW" ]] && export tmpMSW=$( cd "$LOCALAPPDATA" 2>/dev/null ; pwd )"/faketemp"
		
		if [[ "$tmpMSW" != "" ]]
		then
			export descriptiveSelf="$sessionid"
			type md5sum > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" != '/bin/'* ]] && [[ "$scriptAbsoluteLocation" != '/usr/'* ]] && export descriptiveSelf=$(_getScriptAbsoluteLocation | md5sum | head -c 2)$(echo "$sessionid" | head -c 16)
			export tmpSelf="$tmpMSW"/"$descriptiveSelf"
			
			[[ "$descriptiveSelf" == "" ]] && export tmpSelf="$tmpMSW"/"$sessionid"
			true
		fi
		
		( [[ "$tmpSelf" == "" ]] || [[ "$tmpMSW" == "" ]] ) && export tmpSelf=/tmp/"$sessionid"
		true
		
	fi

	#_override_msw_git
	type _override_msw_git_CEILING > /dev/null 2>&1 && _override_msw_git_CEILING
	#if [[ "$1" != "_setupUbiquitous" ]] && [[ "$ub_under_setupUbiquitous" != "true" ]] && type _write_configure_git_safe_directory_if_admin_owned > /dev/null 2>&1
	#then
		_write_configure_git_safe_directory_if_admin_owned "$scriptAbsoluteFolder"
	#fi
elif ( uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1 ) || [[ -e /.dockerenv ]]
then
	if [[ "$tmpSelf" == "" ]]
	then
		export tmpWSL="$HOME"/.ubtmp
		[[ "$realHome" != "" ]] && export tmpWSL="$realHome"/.ubtmp
		[[ ! -e "$tmpWSL" ]] && mkdir -p "$tmpWSL"
		
		if [[ "$tmpWSL" != "" ]]
		then
			export descriptiveSelf="$sessionid"
			type md5sum > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" != '/bin/'* ]] && [[ "$scriptAbsoluteLocation" != '/usr/'* ]] && export descriptiveSelf=$(_getScriptAbsoluteLocation | md5sum | head -c 2)$(echo "$sessionid" | head -c 16)
			export tmpSelf="$tmpWSL"/"$descriptiveSelf"

			[[ "$descriptiveSelf" == "" ]] && export tmpSelf="$tmpWSL"/"$sessionid"
			true
		fi

		( [[ "$tmpSelf" == "" ]] || [[ "$tmpWSL" == "" ]] ) && export tmpSelf=/tmp/"$sessionid"
		true
	fi
fi


# CAUTION: 'Proper' UNIX platforms are expected to use "$scriptAbsoluteFolder" as "$tmpSelf" . Only by necessity may these variables be different.
# CAUTION: If not blank, '$tmpSelf' must include first 16 digits of "$sessionid". Failure to do so may cause 'rmdir' collisions and prevent '_safeRMR' from allowing appropriate removal.
# Virtualization and OS image modification functions in particular are not guaranteed to have been otherwise tested.
[[ "$tmpSelf" == "" ]] && export tmpSelf="$scriptAbsoluteFolder"

#Temporary directories.
export safeTmp="$tmpSelf""$tmpPrefix"/w_"$sessionid"
export scopeTmp="$tmpSelf""$tmpPrefix"/s_"$sessionid"
export queryTmp="$tmpSelf""$tmpPrefix"/q_"$sessionid"
export logTmp="$safeTmp"/log
#Solely for misbehaved applications called upon.
export shortTmp=/tmp/w_"$sessionid"
[[ "$tmpMSW" != "" ]] && export shortTmp="$tmpMSW"/w_"$sessionid"

}
_get_ub_globalVars_sessionDerived "$@"






export scriptBin="$scriptAbsoluteFolder"/_bin
export scriptBundle="$scriptAbsoluteFolder"/_bundle
export scriptLib="$scriptAbsoluteFolder"/_lib
#For trivial installations and virtualized guests. Exclusively intended to support _setupUbiquitous and _drop* hooks.
[[ ! -e "$scriptBin" ]] && export scriptBin="$scriptAbsoluteFolder"
[[ ! -e "$scriptBundle" ]] && export scriptBundle="$scriptAbsoluteFolder"
[[ ! -e "$scriptLib" ]] && export scriptLib="$scriptAbsoluteFolder"


# WARNING: Standard relied upon by other standalone scripts (eg. MSW compatible _anchor.bat )
export scriptLocal="$scriptAbsoluteFolder"/_local

#For system installations (exclusively intended to support _setupUbiquitous and _drop* hooks).
if [[ "$scriptAbsoluteLocation" == "/usr/local/bin"* ]] || [[ "$scriptAbsoluteLocation" == "/usr/bin"* ]]
then
	[[ "$scriptAbsoluteLocation" == "/usr/bin"* ]] && export scriptBin="/usr/share/ubcore/bin"
	[[ "$scriptAbsoluteLocation" == "/usr/local/bin"* ]] && export scriptBin="/usr/local/share/ubcore/bin"
	
	if [[ -d "$HOME" ]]
	then
		export scriptLocal="$HOME"/".ubcore"/_sys
	fi
fi

export scriptCall_bash="$scriptAbsoluteFolder"'/_bash.bat'
export scriptCall_bin="$scriptAbsoluteFolder"/_bin.bat
if type cygpath > /dev/null 2>&1
then
    export scriptAbsoluteLocation_msw=$(cygpath -w "$scriptAbsoluteLocation")
    export scriptAbsoluteFolder_msw=$(cygpath -w "$scriptAbsoluteFolder")

	export scriptLocal_msw=$(cygpath -w "$scriptLocal")
    export scriptLib_msw=$(cygpath -w "$scriptLib")
    
    export scriptCall_bash_msw="$scriptAbsoluteFolder_msw"'\_bash.bat'
    export scriptCall_bin_msw="$scriptAbsoluteFolder_msw"'\_bin.bat'
fi

#Essentially temporary tokens which may need to be reused.
# No, NOT AI tokens, predates widespread usage of that term.
export scriptTokens="$scriptLocal"/.tokens

#Reboot Detection Token Storage
# WARNING WIP. Not tested on all platforms. Requires a directory to be tmp/ram fs mounted. Worst case result is to preserve tokens across reboots.
# WARNING: Does NOT work on Cygwin, files written to either '/tmp' or '/dev/shm' are persistent.
#Fail-Safe
export bootTmp="$scriptLocal"
#Typical BSD
[[ -d /tmp ]] && export bootTmp='/tmp'
#Typical Linux
[[ -d /dev/shm ]] && export bootTmp='/dev/shm'
#Typical MSW - WARNING: Persistent!
[[ "$tmpMSW" != "" ]] && export bootTmp="$tmpMSW"

#Specialized temporary directories.

#MetaEngine/Engine Tmp Defaults (example, no production use)
#export metaTmp="$tmpSelf""$tmpPrefix"/.m_"$sessionid"
#export engineTmp="$tmpSelf""$tmpPrefix"/.e_"$sessionid"

# WARNING: Only one user per (virtual) machine. Requires _prepare_abstract . Not default.
# DANGER: Mandatory strict directory 8.3 compliance for this variable! Long subdirectory/filenames permitted thereafter.
# DANGER: Permitting multi-user access to this directory may cause unexpected behavior, including inconsitent file ownership.
#Consistent absolute path abstraction.
export abstractfs_root=/tmp/"$ubiquitousBashIDnano"
( [[ "$bootTmp" == '/dev/shm' ]] || [[ "$bootTmp" == '/tmp' ]] || [[ "$tmpMSW" != "" ]] ) && export abstractfs_root="$bootTmp"/"$ubiquitousBashIDnano"
export abstractfs_lock="$bootTmp"/"$ubiquitousBashID"/afslock

# Unusually, safeTmpSSH must not be interpreted by client, and therefore is single quoted.
# TODO Test safeTmpSSH variants including spaces in path.
export safeTmpSSH='~/.sshtmp/.s_'"$sessionid"

#Process control.
export pidFile="$safeTmp"/.pid
#Invalid do-not-match default.
export uPID="cwrxuk6wqzbzV6p8kPS8J4APYGX"

export daemonPidFile="$scriptLocal"/.bgpid

#export varStore="$scriptAbsoluteFolder"/var

export vncPasswdFile="$safeTmp"/.vncpasswd

#Network Defaults
[[ "$netTimeout" == "" ]] && export netTimeout=18

export AUTOSSH_FIRST_POLL=45
export AUTOSSH_POLL=45
#export AUTOSSH_GATETIME=0
export AUTOSSH_GATETIME=15

#export AUTOSSH_PORT=0

#export AUTOSSH_DEBUG=1
#export AUTOSSH_LOGLEVEL=7

#Monolithic shared files.
export lock_pathlock="$scriptLocal"/l_path
#Used to make locking operations atomic as possible.
export lock_quicktmp="$scriptLocal"/l_qt
export lock_emergency="$scriptLocal"/l_em
export lock_open="$scriptLocal"/l_o
export lock_opening="$scriptLocal"/l_opening
export lock_closed="$scriptLocal"/l_closed
export lock_closing="$scriptLocal"/l_closing
export lock_instance="$scriptLocal"/l_instance
export lock_instancing="$scriptLocal"/l_instancing

#Specialized lock files. Recommend five character or less suffix. Not all of these may yet be implemented.
export specialLocks
specialLocks=""

export lock_open_image="$lock_open"-img
specialLocks+=("$lock_open_image")

export lock_loop_image="$lock_open"-loop
specialLocks+=("$lock_loop_image")

export lock_open_chroot="$lock_open"-chrt
specialLocks+=("$lock_open_chroot")
export lock_open_docker="$lock_open"-dock
specialLocks+=("$lock_open_docker")
export lock_open_vbox="$lock_open"-vbox
specialLocks+=("$lock_open_vbox")
export lock_open_qemu="$lock_open"-qemu
specialLocks+=("$lock_open_qemu")

export specialLock=""
export specialLocks

export ubVirtImageLocal="true"

#Monolithic shared log files.
export importLog="$scriptLocal"/import.log

#Resource directories.
#export guidanceDir="$scriptAbsoluteFolder"/guidance

#Object Dir
export objectDir="$scriptAbsoluteFolder"

#Object Name
export objectName=$(basename "$objectDir")

#Modify PATH to include own directories.
if ! [[ "$PATH" == *":""$scriptAbsoluteFolder"* ]] && ! [[ "$PATH" == "$scriptAbsoluteFolder"* ]]
then
	export PATH="$PATH":"$scriptAbsoluteFolder":"$scriptBin":"$scriptBundle"
fi

export permaLog="$scriptLocal"

export HOST_USER_ID=$(id -u)
export HOST_GROUP_ID=$(id -g)

export globalArcDir="$scriptLocal"/a
export globalArcFS="$globalArcDir"/fs
export globalArcTmp="$globalArcDir"/tmp

export globalBuildDir="$scriptLocal"/b
export globalBuildFS="$globalBuildDir"/fs
export globalBuildTmp="$globalBuildDir"/tmp


export ub_anchor_specificSoftwareName=""
export ub_anchor_specificSoftwareName

export ub_anchor_user=""
export ub_anchor_user

export ub_anchor_autoupgrade=""
export ub_anchor_autoupgrade





_set_msw_qt5ct() {
    [[ "$QT_QPA_PLATFORMTHEME" != "qt5ct" ]] && export QT_QPA_PLATFORMTHEME=qt5ct
    if [[ "$WSLENV" != "QT_QPA_PLATFORMTHEME" ]] && [[ "$WSLENV" != "QT_QPA_PLATFORMTHEME"* ]] && [[ "$WSLENV" != *"QT_QPA_PLATFORMTHEME" ]] && [[ "$WSLENV" != *"QT_QPA_PLATFORMTHEME"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="QT_QPA_PLATFORMTHEME"
        else
            export WSLENV="$WSLENV:QT_QPA_PLATFORMTHEME"
        fi
    fi
    return 0
}

# wsl printenv | grep QT_QPA_PLATFORMTHEME
# ATTENTION: Will also unset QT_QPA_PLATFORMTHEME if appropriate (and for this reason absolutely should be hooked by 'Linux' shells).
# Strongly recommend writing the ' export QT_QPA_PLATFORMTHEME=qt5ct ' or equivalent statement to ' /etc/environment.d/ub_wsl2_qt5ct.sh ' , '/etc/environment.d/90ub_wsl2_qt5ct.conf' , or similarly effective non-login non-interactive shell startup script.
#  Unfortunately, '/etc/environment.d' is usually ignored by (eg. Debian) Linux distributions, to the point that variables declared by files provided by installed packages are not exported to any apparent environment.
#  Alternatives attempted include:
#  /etc/security/pam_env.conf
#  ~/.bashrc
#  ~/.bash_profile
#  ~/.profile
_set_qt5ct() {
    if [[ "$DISPLAY" == ":0" ]]
    then
        export QT_QPA_PLATFORMTHEME=qt5ct
    else
        export QT_QPA_PLATFORMTHEME=
        unset QT_QPA_PLATFORMTHEME
    fi
    
    _write_wsl_qt5ct_conf "$@"

    return 0
}


_set_msw_lang() {
    [[ "$LANG" != "C" ]] && export LANG=C
    if [[ "$WSLENV" != "LANG" ]] && [[ "$WSLENV" != "LANG"* ]] && [[ "$WSLENV" != *"LANG" ]] && [[ "$WSLENV" != *"LANG"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="LANG"
        else
            export WSLENV="$WSLENV:LANG"
        fi
    fi
    return 0
}

_set_lang-forWSL() {
    [[ "$LANG" != "C" ]] && export LANG="C"
    return 0
}


_set_discreteGPU-forWSL() {
    [[ "$MESA_D3D12_DEFAULT_ADAPTER_NAME" != "" ]] && return 0
    
    # https://github.com/microsoft/wslg/wiki/GPU-selection-in-WSLg
    if type -p glxinfo > /dev/null 2>&1
    then
        glxinfo -B | grep -i intel > /dev/null 2>&1 && export MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA
        return
    fi
}

_set_msw_ghToken() {
    if [[ "$WSLENV" != "GH_TOKEN" ]] && [[ "$WSLENV" != "GH_TOKEN"* ]] && [[ "$WSLENV" != *"GH_TOKEN" ]] && [[ "$WSLENV" != *"GH_TOKEN"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="GH_TOKEN"
        else
            export WSLENV="$WSLENV:GH_TOKEN"
        fi
    fi
    return 0
}

_set_msw_apiToken() {
    if [[ "$WSLENV" != "OPENAI_API_KEY" ]] && [[ "$WSLENV" != "OPENAI_API_KEY"* ]] && [[ "$WSLENV" != *"OPENAI_API_KEY" ]] && [[ "$WSLENV" != *"OPENAI_API_KEY"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="OPENAI_API_KEY"
        else
            export WSLENV="$WSLENV:OPENAI_API_KEY"
        fi
    fi
    if [[ "$WSLENV" != "OPENROUTER_API_KEY" ]] && [[ "$WSLENV" != "OPENROUTER_API_KEY"* ]] && [[ "$WSLENV" != *"OPENROUTER_API_KEY" ]] && [[ "$WSLENV" != *"OPENROUTER_API_KEY"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="OPENROUTER_API_KEY"
        else
            export WSLENV="$WSLENV:OPENROUTER_API_KEY"
        fi
    fi
    if [[ "$WSLENV" != "HF_AKI_KEY" ]] && [[ "$WSLENV" != "HF_AKI_KEY"* ]] && [[ "$WSLENV" != *"HF_AKI_KEY" ]] && [[ "$WSLENV" != *"HF_AKI_KEY"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="HF_AKI_KEY"
        else
            export WSLENV="$WSLENV:HF_AKI_KEY"
        fi
    fi
    if [[ "$WSLENV" != "HF_TOKEN" ]] && [[ "$WSLENV" != "HF_TOKEN"* ]] && [[ "$WSLENV" != *"HF_TOKEN" ]] && [[ "$WSLENV" != *"HF_TOKEN"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="HF_TOKEN"
        else
            export WSLENV="$WSLENV:HF_TOKEN"
        fi
    fi
    if [[ "$WSLENV" != "PUBLIC_KEY" ]] && [[ "$WSLENV" != "PUBLIC_KEY"* ]] && [[ "$WSLENV" != *"PUBLIC_KEY" ]] && [[ "$WSLENV" != *"PUBLIC_KEY"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="PUBLIC_KEY"
        else
            export WSLENV="$WSLENV:PUBLIC_KEY"
        fi
    fi
    if [[ "$WSLENV" != "JUPYTER_PASSWORD" ]] && [[ "$WSLENV" != "JUPYTER_PASSWORD"* ]] && [[ "$WSLENV" != *"JUPYTER_PASSWORD" ]] && [[ "$WSLENV" != *"JUPYTER_PASSWORD"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="JUPYTER_PASSWORD"
        else
            export WSLENV="$WSLENV:JUPYTER_PASSWORD"
        fi
    fi
    if [[ "$WSLENV" != "ai_safety" ]] && [[ "$WSLENV" != "ai_safety"* ]] && [[ "$WSLENV" != *"ai_safety" ]] && [[ "$WSLENV" != *"ai_safety"* ]]
    then
        if [[ "$WSLENV" == "" ]]
        then
            export WSLENV="ai_safety"
        else
            export WSLENV="$WSLENV:ai_safety"
        fi
    fi
    return 0
}


_set_msw_wsl() {
    ! _if_cygwin && return 1

    _set_msw_lang
    _set_msw_qt5ct

    _set_msw_ghToken
    _set_msw_apiToken

    return 0
}

_set_wsl() {
    ! uname -a | grep -i 'microsoft' > /dev/null 2>&1 && return 1
    ! uname -a | grep -i 'WSL2' > /dev/null 2>&1 && return 1

    _set_lang-forWSL
    _set_qt5ct

    [[ "$LIBVA_DRIVER_NAME" != "d3d12" ]] && export LIBVA_DRIVER_NAME=d3d12

    _set_discreteGPU-forWSL

    return 0
}



! _set_msw_wsl && _set_wsl








#_set_GH_TOKEN() {
	#[[ "$GH_TOKEN" != "" ]] && export GH_TOKEN=$(_safeEcho "$GH_TOKEN" | tr -dc 'a-zA-Z0-9_')
	#[[ "$INPUT_GITHUB_TOKEN" != "" ]] && export INPUT_GITHUB_TOKEN=$(_safeEcho "$INPUT_GITHUB_TOKEN" | tr -dc 'a-zA-Z0-9_')
#}
#_set_GH_TOKEN



_queue_descriptiveSelf() {
	[[ ! -e "$scriptAbsoluteFolder" ]] && exit 1
	[[ ! -d "$scriptAbsoluteFolder" ]] && exit 1
	
	if type -p md5sum > /dev/null 2>&1
	then
		_safeEcho "$scriptAbsoluteFolder" | md5sum | head -c 18
		return 0
	fi
	if type -p sha512sum > /dev/null 2>&1
	then
		_safeEcho "$scriptAbsoluteFolder" | sha512sum | head -c 18
		return 0
	fi
	
	
	_stop 1
}

_prepare_demand_dir_queue() {
	mkdir -p "$scriptLocal"/_queue
}

# ATTENTION: Override with 'ops' or similar.
_demand_dir_broadcastPipe_page() {
	_prepare_demand_dir_queue "$@"
	
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	local currentLink
	currentLink="$scriptLocal"/_queue/broadcastPipe_page_lnk
	
	local currentValue
	currentValue="$scriptLocal"/_queue/broadcastPipe_page_dir
	
	if [[ "$1" != "" ]]
	then
		mkdir -p "$currentValue"
		_safeEcho "$currentValue"
		return 0
	fi
	
	if [[ -e '/dev/shm' ]] && ! _if_cygwin && type -p mount > /dev/null 2>&1 && mount | grep '/dev/shm' > /dev/null 2>&1
	then
		currentValue=/dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_dir
		mkdir -p "$currentValue"
		_relink "$currentValue" "$currentLink" > /dev/null 2>&1
		_safeEcho "$currentValue"
		return 0
	fi
	
	mkdir -p "$currentValue"
	_relink "$currentValue" "$currentLink" > /dev/null 2>&1
	_safeEcho "$currentValue"
	
	return 0
}


_rm_dir_broadcastPipe_page() {
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	rm -f "$scriptLocal"/_queue/broadcastPipe_page_lnk > /dev/null 2>&1
	
	rmdir "$scriptLocal"/_queue/broadcastPipe_page_dir > /dev/null 2>&1
	rmdir "$scriptLocal"/_queue > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_dir/inputBufferDir > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_dir/outputBufferDir > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_dir > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf" > /dev/null 2>&1
	
	return 0
}





# ATTENTION: Override with 'ops' or similar.
_demand_dir_broadcastPipe_aggregatorStatic() {
	_prepare_demand_dir_queue "$@"
	
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	local currentLink
	currentLink="$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_lnk
	
	local currentValue
	currentValue="$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_dir
	
	if [[ "$1" != "" ]]
	then
		mkdir -p "$currentValue"
		_safeEcho "$currentValue"
		return 0
	fi
	
	# Pipe/Socket backends (eg. 'aggregatorStatic' , 'aggregatorDynamic' ) should NOT be expected to benefit from 'shared memory'.
	#if [[ -e '/dev/shm' ]] && ! _if_cygwin && type -p mount > /dev/null 2>&1 && mount | grep '/dev/shm' > /dev/null 2>&1
	#then
		#currentValue=/dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir
		#mkdir -p "$currentValue"
		#_relink "$currentValue" "$currentLink" > /dev/null 2>&1
		#_safeEcho "$currentValue"
		#return 0
	#fi
	
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	# DANGER: Assumption: If possibility of script running from network drive excluded, "$tmpMSW" == "" .
	if _if_cygwin && [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]] && [[ "$tmpMSW" != "" ]] && [[ "$LOCALAPPDATA" != "" ]] && [[ -e "$LOCALAPPDATA" ]] && [[ -d "$LOCALAPPDATA" ]]
	then
		currentValue="$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir
		mkdir -p "$currentValue"
		
		#_relink "$currentValue" "$currentLink" > /dev/null 2>&1
		rm -f "$currentLink" > /dev/null 2>&1
		_safeEcho "$currentValue" > "$currentLink"
		
		_safeEcho "$currentValue"
		return 0
	fi
	
	mkdir -p "$currentValue"
	_relink "$currentValue" "$currentLink" > /dev/null 2>&1
	_safeEcho "$currentValue"
	
	return 0
}


_rm_dir_broadcastPipe_aggregatorStatic() {
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	rm -f "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_lnk > /dev/null 2>&1
	
	rmdir "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_dir > /dev/null 2>&1
	rmdir "$scriptLocal"/_queue > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir/inputBufferDir > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir/outputBufferDir > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf" > /dev/null 2>&1
	
	return 0
}




_demand_socket_broadcastPipe_page_unixAddress() {
	_prepare_demand_dir_queue "$@"
	
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	local currentLink
	currentLink="$scriptLocal"/_queue/broadcastPipe_page_socketUNIX_lnk
	
	local currentValue
	currentValue="$scriptLocal"/_queue/broadcastPipe_page_socketUNIX_dir
	
	if [[ "$1" != "" ]]
	then
		mkdir -p "$currentValue"
		_safeEcho "$currentValue"/unix.sock
		return 0
	fi
	
	# Pipe/Socket backends (eg. 'aggregatorStatic' , 'aggregatorDynamic' ) should NOT be expected to benefit from 'shared memory'.
	#if [[ -e '/dev/shm' ]] && ! _if_cygwin && type -p mount > /dev/null 2>&1 && mount | grep '/dev/shm' > /dev/null 2>&1
	#then
	#	currentValue=/dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_socketUNIX_dir
	#	mkdir -p "$currentValue"
	#	_relink "$currentValue" "$currentLink" > /dev/null 2>&1
	#	_safeEcho "$currentValue"/unix.sock
	#	return 0
	#fi
	
	# WARNING: At best, no benefit is expected from using a 'unix domain socket' through Cygwin .
	# https://stackoverflow.com/questions/23086038/what-mechanism-is-used-by-msys-cygwin-to-emulate-unix-domain-sockets
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	# DANGER: Assumption: If possibility of script running from network drive excluded, "$tmpMSW" == "" .
	#if _if_cygwin && [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]] && [[ "$tmpMSW" != "" ]] && [[ "$LOCALAPPDATA" != "" ]] && [[ -e "$LOCALAPPDATA" ]] && [[ -d "$LOCALAPPDATA" ]]
	#then
		#currentValue="$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_socketUNIX_dir
		#mkdir -p "$currentValue"
		
		##_relink "$currentValue" "$currentLink" > /dev/null 2>&1
		#rm -f "$currentLink" > /dev/null 2>&1
		#_safeEcho "$currentValue" > "$currentLink"
		
		#_safeEcho "$currentValue"/unix.sock
		#return 0
	#fi
	
	# WARNING: UNIX domain socket apparently requires short address.
	# 'E unix socket address 111 characters long, max length is 108'
	if [[ -e '/tmp' ]]
	then
		#currentValue=/tmp/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_socketUNIX_dir
		currentValue=/tmp/que_skt_"$currentDescriptiveSelf"/bP_p_sktU_d
		mkdir -p "$currentValue"
		
		#_relink "$currentValue" "$currentLink" > /dev/null 2>&1
		rm -f "$currentLink" > /dev/null 2>&1
		_safeEcho "$currentValue" > "$currentLink"
		
		_safeEcho "$currentValue"/unix.sock
		return 0
	fi
	
	
	mkdir -p "$currentValue"
	_relink "$currentValue" "$currentLink" > /dev/null 2>&1
	_safeEcho "$currentValue"/unix.sock
	
	return 0
}


_rm_socket_broadcastPipe_page_unixAddress() {
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	rm -f "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_lnk > /dev/null 2>&1
	
	
	
	
	rm -f "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_dir/unix.sock > /dev/null 2>&1
	
	rmdir "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_dir > /dev/null 2>&1
	rmdir "$scriptLocal"/_queue > /dev/null 2>&1
	
	
	
	rm -f rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir/unix.sock > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf" > /dev/null 2>&1
	
	
	
	rm -f "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_socketUNIX_dir/unix.sock > /dev/null 2>&1
	
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_socketUNIX_dir > /dev/null 2>&1
	
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_page_socketUNIX_dir > /dev/null 2>&1
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue > /dev/null 2>&1
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local > /dev/null 2>&1
	
	
	
	rm -f /tmp/que_skt_"$currentDescriptiveSelf"/bP_p_sktU_d/unix.sock > /dev/null 2>&1
	rmdir /tmp/que_skt_"$currentDescriptiveSelf"/bP_p_sktU_d > /dev/null 2>&1
	rmdir /tmp/que_skt_"$currentDescriptiveSelf" > /dev/null 2>&1
	
	
	return 0
}













_demand_socket_broadcastPipe_aggregatorStatic_unixAddress() {
	_prepare_demand_dir_queue "$@"
	
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	local currentLink
	currentLink="$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_socketUNIX_lnk
	
	local currentValue
	currentValue="$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_socketUNIX_dir
	
	if [[ "$1" != "" ]]
	then
		mkdir -p "$currentValue"
		_safeEcho "$currentValue"/unix.sock
		return 0
	fi
	
	# Pipe/Socket backends (eg. 'aggregatorStatic' , 'aggregatorDynamic' ) should NOT be expected to benefit from 'shared memory'.
	#if [[ -e '/dev/shm' ]] && ! _if_cygwin && type -p mount > /dev/null 2>&1 && mount | grep '/dev/shm' > /dev/null 2>&1
	#then
	#	currentValue=/dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_socketUNIX_dir
	#	mkdir -p "$currentValue"
	#	_relink "$currentValue" "$currentLink" > /dev/null 2>&1
	#	_safeEcho "$currentValue"/unix.sock
	#	return 0
	#fi
	
	# WARNING: At best, no benefit is expected from using a 'unix domain socket' through Cygwin .
	# https://stackoverflow.com/questions/23086038/what-mechanism-is-used-by-msys-cygwin-to-emulate-unix-domain-sockets
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	# DANGER: Assumption: If possibility of script running from network drive excluded, "$tmpMSW" == "" .
	#if _if_cygwin && [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]] && [[ "$tmpMSW" != "" ]] && [[ "$LOCALAPPDATA" != "" ]] && [[ -e "$LOCALAPPDATA" ]] && [[ -d "$LOCALAPPDATA" ]]
	#then
		#currentValue="$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_socketUNIX_dir
		#mkdir -p "$currentValue"
		
		##_relink "$currentValue" "$currentLink" > /dev/null 2>&1
		#rm -f "$currentLink" > /dev/null 2>&1
		#_safeEcho "$currentValue" > "$currentLink"
		
		#_safeEcho "$currentValue"/unix.sock
		#return 0
	#fi
	
	# WARNING: UNIX domain socket apparently requires short address.
	# 'E unix socket address 111 characters long, max length is 108'
	if [[ -e '/tmp' ]]
	then
		#currentValue=/tmp/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_socketUNIX_dir
		currentValue=/tmp/que_skt_"$currentDescriptiveSelf"/bP_aS_sktU_d
		mkdir -p "$currentValue"
		
		#_relink "$currentValue" "$currentLink" > /dev/null 2>&1
		rm -f "$currentLink" > /dev/null 2>&1
		_safeEcho "$currentValue" > "$currentLink"
		
		_safeEcho "$currentValue"/unix.sock
		return 0
	fi
	
	
	mkdir -p "$currentValue"
	_relink "$currentValue" "$currentLink" > /dev/null 2>&1
	_safeEcho "$currentValue"/unix.sock
	
	return 0
}


_rm_socket_broadcastPipe_aggregatorStatic_unixAddress() {
	local currentDescriptiveSelf
	currentDescriptiveSelf=$(_queue_descriptiveSelf)
	[[ "$currentDescriptiveSelf" == "" ]] && _stop 1
	
	rm -f "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_lnk > /dev/null 2>&1
	
	
	
	
	rm -f "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_dir/unix.sock > /dev/null 2>&1
	
	rmdir "$scriptLocal"/_queue/broadcastPipe_aggregatorStatic_dir > /dev/null 2>&1
	rmdir "$scriptLocal"/_queue > /dev/null 2>&1
	
	
	
	rm -f rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir/unix.sock > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_dir > /dev/null 2>&1
	
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local/_queue > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf"/_local > /dev/null 2>&1
	rmdir /dev/shm/queue_"$currentDescriptiveSelf" > /dev/null 2>&1
	
	
	
	rm -f "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_socketUNIX_dir/unix.sock > /dev/null 2>&1
	
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_socketUNIX_dir > /dev/null 2>&1
	
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue/broadcastPipe_aggregatorStatic_socketUNIX_dir > /dev/null 2>&1
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local/_queue > /dev/null 2>&1
	rmdir "$tmpMSW"/queue_"$currentDescriptiveSelf"/_local > /dev/null 2>&1
	
	
	
	rm -f /tmp/que_skt_"$currentDescriptiveSelf"/bP_aS_sktU_d/unix.sock > /dev/null 2>&1
	rmdir /tmp/que_skt_"$currentDescriptiveSelf"/bP_aS_sktU_d > /dev/null 2>&1
	rmdir /tmp/que_skt_"$currentDescriptiveSelf" > /dev/null 2>&1
	
	
	return 0
}




















_default_page_write_maxTime() {
	local currentValue
	currentValue=725
	_if_cygwin && currentValue=4475
	echo "$currentValue"
}

_default_page_write_maxBytes() {
	local currentValue
	currentValue=86400
	#_if_cygwin && currentValue=864000
	echo "$currentValue"
}



_default_page_read_maxTime() {
	local currentValue
	currentValue=100
	_if_cygwin && currentValue=575
	echo "$currentValue"
}





_broadcastPipe_page_read_maxTime() {
	local currentValue
	currentValue=100
	_if_cygwin && currentValue=975
	echo "$currentValue"
}















# ATTENTION: Only the test procedures are disabled if the 'queue' dependency is not declared. Due to the lengthy timing required to reliabily test the inherently unpredictability of any InterProcess-Communication with non-dedicated non-realtime software.
unset _test_queue
unset _test_selfTime
unset _test_bashTime
unset _test_filemtime
unset _test_timeoutRead
#unset _timetest
unset _test_broadcastPipe_page
unset _test_broadcastPipe_aggregatorStatic






# "$1" == inputBufferDir
# "$2" == inputFilesPrefix
# "$3" == maxTime (approximately how many milliseconds buffer should be checked for new data)
# "$4" == maxBytes (IGNORED)
# "$ub_force_limit_page_rate"
#	'' == Write new pages as fast as buffers fill up. Readers may miss some pages. (Default. Strongly recommended.)
#	'true' == Write only one page per "$maxTime" interval. WARNING: Writes may backlog indefinitely, breaking real-time messaging. (IGNORED by '_page_read')
#	'false' == Write and read new pages continiously. WARNING: Read processes will consume 100% CPU. Readers may still miss some pages, although reads may happen faster than writes.
_page_read() {
	local inputBufferDir="$1"
	local inputFilesPrefix="$2"
	local service_inputBufferDir
	if [[ "$inputBufferDir" == "" ]] || [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/outputBufferDir
		! mkdir -p "$inputBufferDir" && return 1
		
		service_inputBufferDir="$current_demand_dir"/inputBufferDir
		
		[[ "$inputFilesPrefix" == "" ]] && inputFilesPrefix='out-'
	fi
	
	
	! mkdir -p "$inputBufferDir" && return 1
	! [[ -e "$inputBufferDir" ]] && return 1
	! [[ -d "$inputBufferDir" ]] && return 1
	
	local currentMaxTime
	currentMaxTime="$3"
	# 6/60Hz == 100ms , loop time ~ 35ms
	# 0.1s desired minimum sleep
	#[[ "$currentMaxTime" == "" ]] && currentMaxTime=175
	[[ "$currentMaxTime" == "" ]] && currentMaxTime=$(_default_page_read_maxTime)
	
	local currentMaxTime_seconds
	currentMaxTime_seconds=$(bc <<< "$currentMaxTime * 0.001")
	
	
	local measureTickA
	local measureTickB
	
	while true
	do
		if [[ "$service_inputBufferDir" != "" ]]
		then
			#[[ ! -d "$service_inputBufferDir" ]] && return 0
			[[ -e "$service_inputBufferDir"/terminate ]] && return 0
		fi
		
		[[ "$ub_force_limit_page_rate" != 'false' ]] && sleep "$currentMaxTime_seconds"
		
		[[ -e "$inputBufferDir"/"$inputFilesPrefix"tick ]] && measureTickA=$(head -n 1 "$inputBufferDir"/"$inputFilesPrefix"tick 2>/dev/null)
		[[ "$measureTickA" != '0' ]] && [[ "$measureTickA" != '1' ]] && [[ "$measureTickA" != '2' ]] && continue
		
		[[ "$measureTickB" == '' ]] && measureTickB='doNotMatch'
		[[ "$measureTickA" == "$measureTickB" ]] && continue
		
		cat "$inputBufferDir"/"$inputFilesPrefix""$measureTickA" 2>/dev/null
		
		measureTickB="$measureTickA"
	done
}





# "$1" == "$inputTickFile"
# "$2" == "$inputFilesPrefix"
# "$3" == "sessionid" (optional)
_page_read_single() {
	local inputTickFile="$1"
	local inputFilesPrefix="$2"
	local currentSession="$3"
	if [[ "$inputTickFile" == "" ]] && [[ "$inputFilesPrefix" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputTickFile="$current_demand_dir"/outputBufferDir/out-tick
		
		[[ "$currentSession" == "" ]] && currentSession="single"
		[[ "$currentSession" == "" ]] && currentSession="false"
	fi
	[[ "$currentSession" == "" ]] && currentSession="$sessionid"
	
	
	measureTickA=$(head -n 1 "$inputTickFile" 2>/dev/null)
	[[ "$measureTickA" != '0' ]] && [[ "$measureTickA" != '1' ]] && [[ "$measureTickA" != '2' ]] && return 0
	
	if [[ "$currentSession" != 'false' ]]
	then
		measureTickB=$(head -n 1  "$inputTickFile"-prev-"$currentSession" 2>/dev/null)
		
		[[ "$measureTickB" == '' ]] && measureTickB='doNotMatch'
		[[ "$measureTickA" == "$measureTickB" ]] && return 0
	fi
	
	currentExitStatus='0'
	
	cat ${inputTickFile/-tick/}-"$measureTickA" 2>/dev/null
	[[ "$?" != '0' ]] && currentExitStatus='1'
	
	if [[ "$currentSession" != 'false' ]]
	then
		cp "$inputTickFile" "$inputTickFile"-prev-"$currentSession" 2>/dev/null
		[[ "$?" != '0' ]] && currentExitStatus='1'
	fi
	
	if [[ "$currentExitStatus" != '0' ]]
	then
		rm -f "$inputTickFile" > /dev/null 2>&1
		return "$currentExitStatus"
	fi
	
	return 0
}




# Intended to be called by users and programs which are only able to call one other program which must accept both standard input/output connections.
# Specifically intended to be compatible with 'socat' .
# "$1" == inputBufferDir (inverted - typically output of broadcastPipe)
# "$2" == outputBufferDir (inverted - typically input of broadcastPipe)
# "$4" == inputFilesPrefix
# "$4" == outputFilesPrefix
_page_converse() {
	local inputBufferDir="$1"
	local outputBufferDir="$2"
	if [[ "$inputBufferDir" == "" ]] || [[ "$outputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/outputBufferDir
		outputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	local inputFilesPrefix="$3"
	[[ "$inputFilesPrefix" == "" ]] && inputFilesPrefix='out-'
	
	local outputFilesPrefix="$4"
	#[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix='converse-'
	#[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix=$(_uid 14)'-'
	[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix=$(_uid 18)'-'
	
	
	# DANGER: Without this hook, temporary buffers may persist indefinitely!
	export current_page_write_sessionid="$sessionid"
	export current_broadcastPipe_inputBufferDir="$inputBufferDir"
	export current_broadcastPipe_outputBufferDir="$outputBufferDir"
	export current_broadcastPipe_outputFilesPrefix="$outputFilesPrefix"
	_stop_queue_page() {
		rm -f "$current_broadcastPipe_outputBufferDir"/t_"$current_page_write_sessionid" > /dev/null 2>&1
		rm -f "$current_broadcastPipe_outputBufferDir"/"$current_broadcastPipe_outputFilesPrefix"-tick > /dev/null 2>&1
		_sleep_spinlock
		rm -f "$current_broadcastPipe_outputBufferDir"/"$current_broadcastPipe_outputFilesPrefix"-tick > /dev/null 2>&1
		rm -f "$current_broadcastPipe_outputBufferDir"/"$current_broadcastPipe_outputFilesPrefix"* > /dev/null 2>&1
	}
	export ub_nohook_current_page_write_stop_queue_page='true'
	
	#echo "$current_broadcastPipe_outputBufferDir"/"$current_broadcastPipe_outputFilesPrefix"
	
	_page_read "$inputBufferDir" "$inputFilesPrefix" &
	_page_write "$outputBufferDir" "$outputFilesPrefix"
}



_reset_page_write() {
	rm -f "$1"/temp > /dev/null 2>&1
	rm -f "$1"/"$2"tick > /dev/null 2>&1
	rm -f "$1"/"$2"0 > /dev/null 2>&1
	rm -f "$1"/"$2"1 > /dev/null 2>&1
	rm -f "$1"/"$2"2 > /dev/null 2>&1
}

# "$1" == outputBufferDir
# "$2" == outputFilesPrefix
# "$3" == maxTime (approximately how many milliseconds new data should be allowed to 'remain' in the buffer before writing out a new tick)
# "$4" == maxBytes (how many bytes should be allowed to 'accumulate' in the buffer before writing out a new tick) (MAY BE IGNORED)
# "$ub_force_limit_page_rate"
#	'' == Write new pages as fast as buffers fill up. Readers may miss some pages. (Default. Strongly recommended.)
#	'true' == Write only one page per "$maxTime" interval. WARNING: Writes may backlog indefinitely, breaking real-time messaging.
#	'false' == Write and read new pages continiously. WARNING: Read processes will consume 100% CPU. Readers may still miss some pages, although reads may happen faster than writes. (IGNORED by '_page_write')
_page_write() {
	local outputBufferDir="$1"
	local outputFilesPrefix="$2"
	if [[ "$outputBufferDir" == "" ]] || [[ "$outputFilesPrefix" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		outputBufferDir="$current_demand_dir"/inputBufferDir
		! mkdir -p "$outputBufferDir" && return 1
		
		[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix='stream-'
	fi
	
	
	! mkdir -p "$outputBufferDir" && return 1
	! [[ -e "$outputBufferDir" ]] && return 1
	! [[ -d "$outputBufferDir" ]] && return 1
	
	if [[ "$ub_nohook_current_page_write_stop_queue_page" != 'true' ]] && ! [[ -e "$safeTmp" ]]
	then
		export current_page_write_outputBufferDir="$outputBufferDir"
		export current_page_write_sessionid="$sessionid"
		_stop_queue_page() {
			rm -f "$current_page_write_outputBufferDir"/t_"$current_page_write_sessionid" > /dev/null 2>&1
		}
	fi
	
	
	# https://stackoverflow.com/questions/13889659/read-a-file-by-bytes-in-bash
	# https://www.cyberciti.biz/faq/linux-unix-read-one-character-atatime-while-loop/
		# 'The way using `read -r -n1` for reading every character is wrong, it can't handle multi-byte characters.'
	#echo test | while IFS= read -r -n2 car;do [ "$car" ] && echo -n "$car" || echo ; sleep 1 ; done
	
	# Inaccurate. Tests with random data ('/dev/urandom') seem to show errors.
# 	local currentString
# 	export IFS=
# 	export LANG=C
# 	export LC_ALL=C
# 	#LANG=C IFS= read -r -d '' -n 1 currentString
# 	while read -r -d '' -n 1 currentString
# 	do
# 		#[ "$currentString" ] && echo -n "$currentString" || echo
# 		[ "$currentString" ] && printf '%b' "$currentString" || echo
# 	done
	
# 	# Accurate, albeit extremely slow.
# 	while head --bytes=1
# 	do
# 		true
# 	done
	
	
	local currentMaxTime
	local currentMaxBytes
	currentMaxTime="$3"
	currentMaxBytes="$4"
	
	
	[[ "$currentMaxTime" == "" ]] && currentMaxTime=$(_default_page_write_maxTime)
	[[ "$currentMaxBytes" == "" ]] && currentMaxBytes=$(_default_page_write_maxBytes)
	
	local currentMaxTime_seconds
	currentMaxTime_seconds=$(bc <<< "$currentMaxTime * 0.001")
	
	
	
	local measureDateA
	local measureDateB
	local measureDateDifference
	
	measureDateA=$(date +%s%N | cut -b1-13)
	
	local currentTick
	currentTick=
	[[ -e "$outputBufferDir"/"$outputFilesPrefix"tick ]] && currentTick=$(head -c 1 "$outputBufferDir"/"$outputFilesPrefix"tick)
	( [[ "$currentTick" == '0' ]] || [[ "$currentTick" == '1' ]] || [[ "$currentTick" == '2' ]] ) && let currentTick="$currentTick"+1
	[[ "$currentTick" != '0' ]] && [[ "$currentTick" != '1' ]] && [[ "$currentTick" != '2' ]] && [[ "$currentTick" != '3' ]] && currentTick='0'
	[[ "$currentTick" -ge '3' ]] && currentTick=0
	local currentTempSize
	currentTempSize='0'
	rm -f "$outputBufferDir"/t_"$sessionid" > /dev/null 2>&1
	rm -f "$outputBufferDir"/"$outputFilesPrefix"tick > /dev/null 2>&1
	rm -f "$outputBufferDir"/"$outputFilesPrefix"0 > /dev/null 2>&1
	rm -f "$outputBufferDir"/"$outputFilesPrefix"1 > /dev/null 2>&1
	rm -f "$outputBufferDir"/"$outputFilesPrefix"2 > /dev/null 2>&1
	#while _timeout "$currentMaxTime_seconds" head --bytes="$currentMaxBytes" 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	#while _timeout "$currentMaxTime_seconds" cat 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	#while "$scriptAbsoluteLocation" _bin cat | _timeout "$currentMaxTime_seconds" dd bs="$currentMaxBytes" count=1 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	#while _timeout "$currentMaxTime_seconds" ( ! dd bs="$currentMaxBytes" count=1 2>/dev/null >> "$outputBufferDir"/t_"$sessionid" && rm -f "$outputBufferDir"/t_"$sessionid" > /dev/null 2>&1 )
	#while cat 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	#while _timeout "$currentMaxTime_seconds" head --bytes="2" 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	#while _timeout "$currentMaxTime_seconds" dd bs="$currentMaxBytes" count=1 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	
	#while cat 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	while _timeout "$currentMaxTime_seconds" dd bs="$currentMaxBytes" count=1 2>/dev/null >> "$outputBufferDir"/t_"$sessionid"
	do
		#[[ ! -d "$outputBufferDir" ]] && return 0
		[[ -e "$outputBufferDir"/terminate ]] && return 0
		
		#true | cat "$outputBufferDir"/t_"$sessionid" > /dev/tty
		measureDateB=$(true | date +%s%N | cut -b1-13)
		measureDateDifference=$(bc <<< "$measureDateB - $measureDateA")
		
		currentTempSize='0'
		[[ -s "$outputBufferDir"/t_"$sessionid" ]] && currentTempSize=$(true | stat -c%s "$outputBufferDir"/t_"$sessionid" 2>/dev/null)
		[[ "$currentTempSize" == "" ]] && currentTempSize='0'
		#[[ -s "$outputBufferDir"/t_"$sessionid" ]] && true | stat -c%s "$outputBufferDir"/t_"$sessionid" > /dev/tty
		#[[ "$rewrite" == 'true' ]] && [[ -s "$outputBufferDir"/t_"$sessionid" ]] && true | stat -c%s "$outputBufferDir"/t_"$sessionid" > /dev/tty
		
		#[[ "$currentTempSize" -gt "0" ]] && true | echo "$measureDateDifference" "$currentMaxTime" > /dev/tty
		if [[ "$currentTempSize" -gt "0" ]] && ( [[ "$measureDateDifference" -ge "$currentMaxTime" ]] || [[ "$currentTempSize" -ge "$currentMaxBytes" ]] )
		then
			# ATTENTION: Optional 'page rate' limiting.
			# If buffer was completely filled, then ' _timeout "$currentMaxTime_seconds" ' may not have completed. A delay may ensure '_page_read' has enough time to notice a tick, before new pages are written.
			# No production use. Expected to be set only for benchmarking, diagnostics, etc.
			# WARNING: Beware this is bad for real-time messaging. Much better to discard some flood data.
			[[ "$ub_force_limit_page_rate" == 'true' ]] && [[ "$currentTempSize" -ge "$currentMaxBytes" ]] && sleep "$currentMaxTime_seconds"
			
			#rm -f "$outputBufferDir"/"$outputFilesPrefix""$currentTick" > /dev/null 2>&1
			true | mv "$outputBufferDir"/t_"$sessionid" "$outputBufferDir"/"$outputFilesPrefix""$currentTick"
			true | echo -n "$currentTick" > "$outputBufferDir"/"$outputFilesPrefix"tick-temp
			true | mv "$outputBufferDir"/"$outputFilesPrefix"tick-temp "$outputBufferDir"/"$outputFilesPrefix"tick
			
			measureDateA=$(true | date +%s%N | cut -b1-13)
			#echo "$currentTick" > /dev/tty
			let currentTick="$currentTick"+1
		fi
		
		[[ "$currentTick" -ge '3' ]] && currentTick=0
	done
	
	return 0
}




# "$1" == outputBufferDir
# "$2" == outputFilesPrefix
# "$3" == maxTime (approximately how many milliseconds new data should be allowed to 'remain' in the buffer before writing out a new tick)
# DANGER: Any changes may unexpectedly break '_broadcastPipe' ! Takes standard input from 'script' run by 'find' 'exec' .
_page_write_single() {
	local outputBufferDir="$1"
	local outputFilesPrefix="$2"
	if [[ "$outputBufferDir" == "" ]] || [[ "$outputFilesPrefix" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		outputBufferDir="$current_demand_dir"/inputBufferDir
		! mkdir -p "$outputBufferDir" && return 1
		
		[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix='single-'
	fi
	
	local currentTmpUID
	currentTmpUID=$(_uid)
	cat 2>/dev/null >> "$outputBufferDir"/t_"$currentTmpUID"
	
	
	if ! [[ -s "$outputBufferDir"/t_"$currentTmpUID" ]] || ! _moveconfirm "$outputBufferDir"/t_"$currentTmpUID" "$outputBufferDir"/temp 2>/dev/null
	then
		rm -f "$outputBufferDir"/t_"$currentTmpUID" > /dev/null 2>&1
		return 1
	fi
	
	local currentTick
	currentTick=
	[[ -e "$outputBufferDir"/"$outputFilesPrefix"tick ]] && currentTick=$(head -c 1 "$outputBufferDir"/"$outputFilesPrefix"tick)
	( [[ "$currentTick" == '0' ]] || [[ "$currentTick" == '1' ]] || [[ "$currentTick" == '2' ]] ) && let currentTick="$currentTick"+1
	[[ "$currentTick" != '0' ]] && [[ "$currentTick" != '1' ]] && [[ "$currentTick" != '2' ]] && [[ "$currentTick" != '3' ]] && currentTick='0'
	[[ "$currentTick" -ge '3' ]] && currentTick=0
	
	mv "$outputBufferDir"/temp "$outputBufferDir"/"$outputFilesPrefix""$currentTick"
	echo -n "$currentTick" > "$outputBufferDir"/"$outputFilesPrefix"tick-temp
	mv "$outputBufferDir"/"$outputFilesPrefix"tick-temp "$outputBufferDir"/"$outputFilesPrefix"tick
	
	
	#rm -f "$outputBufferDir"/temp > /dev/null 2>&1
	#rm -f "$outputBufferDir"/"$outputFilesPrefix"tick-temp > /dev/null 2>&1
	return 0
}

_here_broadcastPipe_page_read_single() {
	cat << CZXWXcRMTo8EmM8i4d
#!/usr/bin/env bash

CZXWXcRMTo8EmM8i4d
	
	declare -f _page_read_single
	declare -f _broadcastPipe_page_read_single
	
	cat << CZXWXcRMTo8EmM8i4d
_broadcastPipe_page_read_single "\$@"

CZXWXcRMTo8EmM8i4d

}




# "$1" == inputBufferDir
# "$2" == outputBufferDir
# "$3" == maxTime (approximately how many milliseconds buffer should be checked for new data)
# "$4" == maxBytes (how many bytes should be allowed to 'accumulate' in the buffer before writing out a new tick) (MAY BE IGNORED)
# "$5" == maxTime (approximately how many milliseconds new data should be allowed to 'remain' in the buffer before writing out a new tick) (MAY BE IGNORED)
_broadcastPipe_page_write() {
	#true | _reset_page_write "$2" "out-" "$5" "$4"
	
	#export rewrite=true
	# DANGER: Continiously piping through '_page_write' may be inherently less reliable than '_page_write_single' .
	#_page_write "$2" "out-" "$5" "$4"
	
	_page_write_single "$2" "out-" "$5" "$4"
	
}


_broadcastPipe_page_read_single() {
	_page_read_single "$@"
}


# ATTENTION: Override with 'ops' or similar.
_rm_broadcastPipe_page() {
	
	#[[ -e "$1" ]] && [[ "$1" != "" ]] && rm -f "$1"/* > /dev/null 2>&1
	[[ -e "$1" ]] && [[ "$1" != "" ]] && find "$1" -mindepth 1 -maxdepth 1 -type f ! -name 'terminate' -delete > /dev/null 2>&1
	[[ -e "$2" ]] && [[ "$2" != "" ]] && rm -f "$2"/* > /dev/null 2>&1
	
	[[ -e "$1" ]] && [[ "$1" != "" ]] && rm -f "$1"/*-tick-prev* > /dev/null 2>&1
	
	
	return 0
}




# Reduce environment to perhaps improve performance.
_env_broadcastPipe_page() {
	env -i HOME="$HOME" TERM="${TERM}" SHELL="${SHELL}" PATH="${PATH}" PWD="$PWD" scriptAbsoluteLocation="$scriptAbsoluteLocation" scriptAbsoluteFolder="$scriptAbsoluteFolder" sessionid="$sessionid" LD_PRELOAD="$LD_PRELOAD" USER="$USER" ub_force_limit_page_rate="$ub_force_limit_page_rate" "$@"
}


# WARNING: May delete all existing files (to 'clear the buffers').
# WARNING: Must be running before any desired data is written to buffer - existing buffers are always discarded.
# "$1" == inputBufferDir
# "$2" == outputBufferDir
# "$3" == maxTime (approximately how many milliseconds buffer should be checked for new data) (MAY ALSO PARTIALLY OR FULLY DISPLACE VALUE OF "$5")
# "$4" == maxBytes (how many bytes should be allowed to 'accumulate' in the buffer before writing out a new tick) (MAY BE IGNORED)
# "$5" == maxTime (approximately how many milliseconds new data should be allowed to 'remain' in the buffer before writing out a new tick) (MAY BE IGNORED)
_broadcastPipe_page_read() {
	_start
	
	[[ "$1" == "" ]] && _stop 1
	[[ "$1" == "/" ]] && _stop 1
	[[ "$2" == "/" ]] && _stop 1
	
	local current_demand_dir
	current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
	
	local currentMaxTime
	currentMaxTime="$3"
	[[ "$currentMaxTime" == "" ]] && currentMaxTime="$(_broadcastPipe_page_read_maxTime)"
	
	local currentMaxTime_seconds
	currentMaxTime_seconds=$(bc <<< "$currentMaxTime * 0.001")
	
	# May perhaps take effect when SIGTERM is received directly (eg. when SIGTERM may be sent to all processes) .
	export current_broadcastPipe_inputBufferDir="$1"
	export current_broadcastPipe_outputBufferDir="$2"
	export current_broadcastPipe_current_demand_dir="$current_demand_dir"
	_stop_queue_page() {
		#_terminate_broadcastPipe_page "$current_broadcastPipe_inputBufferDir" 2> /dev/null
		_terminate_broadcastPipe_page_fast "$current_broadcastPipe_inputBufferDir" 2> /dev/null
		sleep 1
		_rm_broadcastPipe_page "$current_broadcastPipe_inputBufferDir" "$current_broadcastPipe_outputBufferDir"
		[[ "$current_broadcastPipe_inputBufferDir" == "$current_broadcastPipe_current_demand_dir"* ]] && [[ "$current_broadcastPipe_current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_page
		
		_sleep_spinlock
		rm -f "$current_broadcastPipe_inputBufferDir"/reset > /dev/null 2>&1
		rm -f "$current_broadcastPipe_inputBufferDir"/terminate > /dev/null 2>&1
		[[ "$current_broadcastPipe_inputBufferDir" == "$current_broadcastPipe_current_demand_dir"* ]] && [[ "$current_broadcastPipe_current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_page
	}
	
	rm -f "$1"/reset > /dev/null 2>&1
	rm -f "$1"/terminate > /dev/null 2>&1
	#_rm_broadcastPipe_page "$@"
	
	_here_broadcastPipe_page_read_single "$@" > "$safeTmp"/broadcastPipe_page_read.sh
	chmod u+x "$safeTmp"/broadcastPipe_page_read.sh
	
	echo > "$1"/listen
	
	while [[ ! -e "$1"/terminate ]]
	do
		# WARNING: Although sequential throughput may be important in some cases, a 'pair of wires' is fundamentally not a parallel device. Simultaneous writing to aggregator should only occur during (usually undesirable) collisions. Nevertheless, processing these collisions out of order is entirely reasonable.
		# WARNING: Imposing limits on the number of inputs (eg. due to command line argument length limitations), below a few thousand, is strongly discouraged.
		# https://serverfault.com/questions/193319/a-better-unix-find-with-parallel-processing
		_env_broadcastPipe_page find "$1" -mindepth 1 -maxdepth 1 -mmin -0.4 -type f -name '*-tick' -exec "$safeTmp"/broadcastPipe_page_read.sh '{}' \; 2> /dev/null | _broadcastPipe_page_write "" "$2" "$3" "$4" "$5" 2>/dev/null
		
		# DANGER: Allowing this bus to run without any idle time may result in an immediately overwhelming processor load, if find loop is allowed to 'fork' new processes.
		[[ "$ub_force_limit_page_rate" != 'false' ]] && sleep "$currentMaxTime_seconds"
		#sleep "$currentMaxTime_seconds"
	done
	
	# WARNING: Since only one program may successfully remove a single file, that mechanism should allow only one 'broadcastPipe' process to remain in the unlikely case multiple were somehow started.
	[[ -e "$1"/terminate ]] && [[ -e "$1"/reset ]] && rm "$1"/reset > /dev/null 2>&1 && _broadcastPipe_page_read "$@"
	rm -f "$1"/reset > /dev/null 2>&1
	
	_rm_broadcastPipe_page "$@"
	rm -f "$1"/terminate > /dev/null 2>&1
	[[ "$1" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_page
	
	_sleep_spinlock
	rm -f "$1"/terminate > /dev/null 2>&1
	[[ "$1" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_page
	
	_stop
}








_here_rmloop_broadcastPipe_page() {
	_here_header_bash_or_dash "$@"
	
	declare -f _rmloop_broadcastPipe_page
	
	cat << CZXWXcRMTo8EmM8i4d
_rmloop_broadcastPipe_page "\$@"

CZXWXcRMTo8EmM8i4d

}


_rmloop_broadcastPipe_page() {
	while true
	do
		rm -f "$1"/rmloop > /dev/null 2>&1
		
		#sleep 1
		sleep 0.1
	done
	
}


_safePath_demand_broadcastPipe_page() {
	if [[ "$1" == "$scriptLocal"* ]] && ! _if_cygwin
	then
		return 0
	fi
	if [[ "$1" == '/dev/shm/'* ]] && ! _if_cygwin
	then
		return 0
	fi
	
	
	! _safePath "$1" && _stop 1
	return 0
}

# WARNING: Deletes all existing files (to 'clear the buffers').
# "$1" == inputBufferDir
# "$2" == outputBufferDir
# "$3" == maxTime (approximately how many milliseconds new data should be allowed to 'remain' in the buffer before writing out a new tick)
# "$4" == maxBytes (how many bytes should be allowed to 'accumulate' in the buffer before writing out a new tick)
_demand_broadcastPipe_page_sequence() {
	_start
	
	! mkdir -p "$1" && _stop 1
	! mkdir -p "$2" && _stop 1
	[[ "$1" == "" ]] && _stop 1
	[[ "$1" == "/" ]] && _stop 1
	[[ "$2" == "/" ]] && _stop 1
	if ! _safePath_demand_broadcastPipe_page "$@"
	then
		_terminate_broadcastPipe_page "$1"
		_stop 1
	fi
	
	_here_rmloop_broadcastPipe_page "$@" > "$safeTmp"/_rmloop_broadcastPipe_page
	chmod u+x "$safeTmp"/_rmloop_broadcastPipe_page
	
	echo > "$1"/rmloop
	
	
	_sleep_spinlock
	
	
	! [[ -e "$1"/rmloop ]] && return 0
	! mv "$1"/rmloop "$1"/rmloop.rm > /dev/null 2>&1 && return 0
	if ! rm "$1"/rmloop.rm > /dev/null 2>&1
	then
		rm -f "$1"/rmloop.rm > /dev/null 2>&1
		return 0
	fi
	
	
	_rm_broadcastPipe_page "$@"
	"$safeTmp"/_rmloop_broadcastPipe_page "$@" &
	#"$scriptAbsoluteLocation" _rmloop_broadcastPipe_page "$@" &
	
	
	#"$scriptAbsoluteLocation" _broadcastPipe_page_read "$@" | _broadcastPipe_page_write "$@"
	"$scriptAbsoluteLocation" _broadcastPipe_page_read "$@"
	
	# May not be necessary. Theoretically redundant.
	local currentStopJobs
	currentStopJobs=$(jobs -p -r 2> /dev/null)
	[[ "$currentStopJobs" != "" ]] && kill "$currentStopJobs" > /dev/null 2>&1
	
	
	_sleep_spinlock
	rm -f "$1"/terminate > /dev/null 2>&1
	[[ "$1" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_page
	
	_stop
}

_demand_broadcastPipe_page() {
	local inputBufferDir="$1"
	local outputBufferDir="$2"
	shift
	shift
	
	if [[ "$inputBufferDir" == "" ]] || [[ "$outputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
		outputBufferDir="$current_demand_dir"/outputBufferDir
	elif [[ -e "$safeTmp" ]]
	then
		# DANGER: Without this hook, temporary "$safeTmp" directories may persist indefinitely!
		# Only hook '_stop_queue_page' if called from within another 'sequence' (to cause termination of service when that 'sequence' terminates for any reason).
		export current_broadcastPipe_inputBufferDir="$inputBufferDir"
		export current_broadcastPipe_outputBufferDir="$outputBufferDir"
		_stop_queue_page() {
			_terminate_broadcastPipe_page "$current_broadcastPipe_inputBufferDir" 2> /dev/null
			#_terminate_broadcastPipe_page_fast "$current_broadcastPipe_inputBufferDir" 2> /dev/null
			#sleep 1
			_rm_broadcastPipe_page "$current_broadcastPipe_inputBufferDir" "$current_broadcastPipe_outputBufferDir"
			[[ "$inputBufferDir" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_page
		}
	fi
	
	
	"$scriptAbsoluteLocation" _demand_broadcastPipe_page_sequence "$inputBufferDir" "$outputBufferDir" "$@" &
	while [[ -e "$inputBufferDir"/rmloop ]]
	do
		sleep 0.1
	done
	[[ ! -e "$inputBufferDir"/listen ]] && _sleep_spinlock
	[[ ! -e "$inputBufferDir"/listen ]] && _sleep_spinlock
	[[ ! -e "$inputBufferDir"/listen ]] && return 1
	
	[[ "$ub_force_limit_page_rate" == 'true' ]] && _sleep_spinlock
	#[[ "$ub_force_limit_page_rate" == 'false' ]] && _sleep_spinlock
	
	disown -a -h -r
	disown -a -r
	
	return 0
}


_terminate_broadcastPipe_page_fast() {
	local inputBufferDir="$1"
	
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	[[ "$inputBufferDir" == "" ]] && return 1
	[[ "$inputBufferDir" == "/" ]] && return 1
	[[ ! -e "$inputBufferDir" ]] && return 1
	
	echo > "$inputBufferDir"/terminate
}

_terminate_broadcastPipe_page() {
	local inputBufferDir="$1"
	
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	mkdir -p "$inputBufferDir"
	
	_terminate_broadcastPipe_page_fast "$@"
	_sleep_spinlock
	
	rm -f "$inputBufferDir"/terminate > /dev/null 2>&1
	[[ "$inputBufferDir" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_page
	
	_sleep_spinlock
	
	return 0
}

# WARNING: No production use. Intended for end-user (interactive) only.
# WARNING: Untested.
# One possible benefit - a reset should happen much more quickly than a '_terminate ..." "_demand ..." cycle due to lack of spinlock sleep.
_reset_broadcastPipe_page() {
	local inputBufferDir="$1"
	
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_page "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	mkdir -p "$inputBufferDir"
	
	[[ "$inputBufferDir" == "" ]] && return 1
	[[ "$inputBufferDir" == "/" ]] && return 1
	[[ ! -e "$inputBufferDir" ]] && return 1
	
	echo > "$inputBufferDir"/reset
	echo > "$inputBufferDir"/terminate
}


# Under ideal conditions, small quantities of data may be continiously copied completely or identically (<10M).
#./ubiquitous_bash.sh _page_read ./outputBufferDir 'testfill-' "175" > ./rewrite
#cat ./testfill | pv | ./ubiquitous_bash.sh _page_write ./outputBufferDir 'testfill-' "725" "86400"
_benchmark_page() {
	_start
	
	export ub_force_limit_page_rate='false'
	local current_Write_MaxBytes=864000
	
	
	#dd if=/dev/urandom of="$safeTmp"/testfill bs=1k count=2048 > /dev/null 2>&1
	dd if=/dev/urandom of="$safeTmp"/testfill bs=1M count=4 > /dev/null 2>&1
	
	
	#>&2 echo "read"
	#_messagePlain_probe "$scriptAbsoluteLocation" _page_read "$safeTmp"/outputBufferDir 'testfill-' "$current_Read_MaxTime" \> "$safeTmp"/rewrite
	"$scriptAbsoluteLocation" _page_read "$safeTmp"/outputBufferDir 'testfill-' "$current_Read_MaxTime" > "$safeTmp"/rewrite &
	sleep 1
	
	#>&2 echo "write"
	#_messagePlain_probe _timeout 150 cat "$safeTmp"/testfill \| pv \| _timeout 15 "$scriptAbsoluteLocation" _page_write "$safeTmp"/outputBufferDir 'testfill-' "$current_Write_MaxTime" "$current_Write_MaxBytes"
	_timeout 150 cat "$safeTmp"/testfill | pv | _timeout 30 "$scriptAbsoluteLocation" _page_write "$safeTmp"/outputBufferDir 'testfill-' "$current_Write_MaxTime" "$current_Write_MaxBytes"
	
	(
	cd "$safeTmp"
	du -sh ./testfill ./rewrite
	md5sum ./testfill ./rewrite
	)
	
	_stop
}



# Modify as required for MSW/Cygwin compatibility.
_aggregator_fifo() {
	mkfifo "$@"
}



# "$1" == inputBufferDir
# "$2" == inputFilesPrefix (MUST adhere to strictly blank or 18 alphanumeric characters!)
_aggregator_read_procedure() {
	local inputBufferDir="$1"
	local inputFilesPrefix="$2"
	local service_inputBufferDir
	#if [[ "$inputBufferDir" == "" ]] || [[ "$inputBufferDir" == "" ]]
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/outputBufferDir
		! mkdir -p "$inputBufferDir" && return 1
		
		service_inputBufferDir="$current_demand_dir"/inputBufferDir
		
		#[[ "$inputFilesPrefix" == "" ]] && inputFilesPrefix='out-'
	fi
	
	[[ "$inputFilesPrefix" == "" ]] && inputFilesPrefix=$(_uid 18)
	
	
	! mkdir -p "$inputBufferDir" && return 1
	! [[ -e "$inputBufferDir" ]] && return 1
	! [[ -d "$inputBufferDir" ]] && return 1
	
	
	
	
	local currentFifo
	currentFifo="$inputBufferDir"/"$inputFilesPrefix"
	_aggregator_fifo "$currentFifo"
	
	
	#if ! [[ -e "$safeTmp" ]]
	#then
		if [[ "$ub_nohook_current_aggregator_write_stop_queue_aggregator" != 'true' ]]
		then
			export current_aggregator_read_fifo="$currentFifo"
			_stop_queue_aggregator() {
				rm -f "$current_aggregator_read_fifo" > /dev/null 2>&1
			}
		fi
	#fi
	
	# WARNING: Removal of FIFO may not occur while not connected to both input and output. Apparently 'trap' does not work here.
	# WARNING: May be incompatible with '_timeout' .
	cat "$currentFifo"
	
	rm -f "$currentFifo" > /dev/null 2>&1
	
	return 0
}



_aggregator_read_sequence() {
	_start
	
	_aggregator_read_procedure "$@"
	
	_stop
}

_aggregator_read() {
	"$scriptAbsoluteLocation" _aggregator_read_sequence "$@"
}


# "$1" == inputBufferDir (inverted, client input, service output)
# "$2" == outputBufferDir (OPTIONAL. inverted)
_aggregatorStatic_read() {
	if ! _aggregatorStatic_delayIPC_EmptyOrWaitOrReset "$2" "$1"
	then
		return 1
	fi
	_aggregator_read_procedure "$1"
	#"$scriptAbsoluteLocation" _aggregator_read_sequence "$2"
	#"$scriptAbsoluteLocation" _aggregator_read_sequence "$@"
}





_aggregator_delayIPC_isEmpty() {
	# Although this may seem inefficient, the alternatives of calling external programs, filling variables, or setting 'shopt', may also be undesirable.
	# https://www.cyberciti.biz/faq/linux-unix-shell-check-if-directory-empty/
	currentIsEmptyOut='true'
	for currentFile in "$1"/??????????????????
	do
		[[ "$currentFile" != *'??????????????????' ]] && currentIsEmptyOut='false' && break
	done
	
	[[ "$currentIsEmptyOut" == 'true' ]] && return 0
	return 1
}

_aggregator_delayIPC_isReset() {
	#&& [[ ! -e "$1"/reset ]] && [[ ! -e "$1"/terminate ]] && [[ ! -e "$1"/rmloop ]]
	# && ! _aggregator_delayIPC_isEmpty "$2"
	#[[ ! -e "$1"/attempt ]]
	
	if [[ -e "$1"/vaccancy ]] && _aggregator_delayIPC_isEmpty "$1" && _aggregator_delayIPC_isEmpty "$2"
	then
		return 0
	fi
	return 1
}


# May allow a new set of 'connections' to replace an existing (presumably broken) set of 'connections'.
# May require >>24seconds delay to allow previous (invalid) 'delay: Inter-Process Communications' to expire.
# WARNING: May not be compatible with '_skip_broadcastPipe_aggregatorStatic' .
# "$1" == inputBufferDir
# "$2" == outputBufferDir
# ATTENTION: EXAMPLE
#./lean.sh _aggregatorStatic_delayIPC_EmptyOrWaitOrReset && echo done && ./lean.sh _aggregator_write
#/lean.sh _aggregatorStatic_delayIPC_EmptyOrWaitOrReset && echo done && ./lean.sh _aggregator_read
_aggregator_delayIPC_EmptyOrWaitOrReset() {
	local inputBufferDir="$1"
	local outputBufferDir="$2"
	
	if [[ "$inputBufferDir" == "" ]] || [[ "$outputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregator_delayIPC_EmptyOrWaitOrReset "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		# Not inverted. After all, this function will typically be called by other functions, and so uses the service convention.
		inputBufferDir="$current_demand_dir"/inputBufferDir
		outputBufferDir="$current_demand_dir"/outputBufferDir
	fi
	
	
	local currentIterations
	
	local currentFile
	local currentIsEmptyBuffer
	
	
	
	# DANGER: CAUTION: Relies on several relatively marginal assumptions regarding '_broadcastPipe_aggregatorStatic_read_procedure' algorithm and OS/kernel latency.
	
	
	# Expect 18seconds total sleep after all iterations and one attempt.
	currentIterations='0'
	currentAttempts='0'
	while [[ "$currentIterations" -lt 6 ]] && [[ "$currentAttempts" -lt 3 ]] && ! _aggregator_delayIPC_isReset "$inputBufferDir" "$outputBufferDir"
	do
		sleep 3
		let currentIterations="$currentIterations"+1
		
		if ! [[ "$currentIterations" -lt 6 ]]
		then
			if ! _aggregator_delayIPC_isReset "$inputBufferDir" "$outputBufferDir"
			then
				echo > "$inputBufferDir"/attempt.tmp
				_moveconfirm "$inputBufferDir"/attempt.tmp "$inputBufferDir"/attempt && _reset_broadcastPipe_aggregatorStatic "$inputBufferDir"
			fi
			#sleep 3
			currentIterations='0'
			let currentAttempts="$currentAttempts"+1
		fi
	done
	! _aggregator_delayIPC_isReset "$inputBufferDir" "$outputBufferDir" && return 1
	
	# WARNING: Delay must be <<24seconds .
	# Must be long enough to allow all waiting clients to 'see' the 'vaccancy' and 'empty' conditions, but not long enough to overrun the 'vaccancy' delay.
	# Delaying an entire '_sleep_spinlock' cycle may be undesirable in practice. Multiple clients will be connecting simultaneously, and external (or 'user') latencies may be much more likely than an extreme ~7seconds spinlock event from the kernel.
	#sleep 3
	#sleep 5
	sleep 7
	#_sleep_spinlock
	
	#if _aggregator_delayIPC_isReset "$inputBufferDir" "$outputBufferDir"
	#then
		rm -f "$inputBufferDir"/attempt.tmp > /dev/null 2>&1
		rm -f "$inputBufferDir"/attempt > /dev/null 2>&1
	#fi
	
	return 0
}

_aggregatorStatic_delayIPC_EmptyOrWaitOrReset() {
	_demand_dir_broadcastPipe_aggregator_delayIPC_EmptyOrWaitOrReset() {
		_demand_dir_broadcastPipe_aggregatorStatic "$@"
	}
	if ! true | _aggregator_delayIPC_EmptyOrWaitOrReset "$@"
	then
		return 1
	fi
	return 0
}





# Intended to be called by users and programs which are only able to call one other program which must accept both standard input/output connections.
# Specifically intended to be compatible with 'socat' .
# "$1" == inputBufferDir (inverted - typically output of broadcastPipe)
# "$2" == outputBufferDir (inverted - typically input of broadcastPipe)
# "$4" == inputFilesPrefix (MUST adhere to strictly blank or 18 alphanumeric characters!)
# "$4" == outputFilesPrefix (MUST adhere to strictly blank or 18 alphanumeric characters!)
_aggregator_converse_procedure() {
	local inputBufferDir="$1"
	local outputBufferDir="$2"
	if [[ "$inputBufferDir" == "" ]] || [[ "$outputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregator_converse "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/outputBufferDir
		outputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	local inputFilesPrefix="$3"
	[[ "$inputFilesPrefix" == "" ]] && inputFilesPrefix=$(_uid 18)
	
	local outputFilesPrefix="$4"
	[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix=$(_uid 18)
	
	# DANGER: Without this hook, temporary buffers may persist indefinitely!
	# CAUTION: Reset may be necessitated - testing suggests this hook does not work.
	export current_broadcastPipe_inputBufferDir="$inputBufferDir"
	export current_broadcastPipe_outputBufferDir="$outputBufferDir"
	export current_broadcastPipe_inputFilesPrefix="$inputFilesPrefix"
	export current_broadcastPipe_outputFilesPrefix="$outputFilesPrefix"
	_stop_queue_aggregator() {
		rm -f "$current_broadcastPipe_inputBufferDir"/"$current_broadcastPipe_inputFilesPrefix" > /dev/null 2>&1
		rm -f "$current_broadcastPipe_outputBufferDir"/"$current_broadcastPipe_outputFilesPrefix" > /dev/null 2>&1
		_sleep_spinlock
		rm -f "$current_broadcastPipe_inputBufferDir"/"$current_broadcastPipe_inputFilesPrefix" > /dev/null 2>&1
		rm -f "$current_broadcastPipe_outputBufferDir"/"$current_broadcastPipe_outputFilesPrefix" > /dev/null 2>&1
	}
	export ub_nohook_current_aggregator_write_stop_queue_aggregator='true'
	
	#echo "$current_broadcastPipe_outputBufferDir"/"$current_broadcastPipe_outputFilesPrefix"
	
	_aggregator_read_procedure "$inputBufferDir" "$inputFilesPrefix" &
	_aggregator_write_procedure "$outputBufferDir" "$outputFilesPrefix"
}

_aggregatorStatic_converse_noEmptyOrWaitOrReset() {
	_demand_dir_broadcastPipe_aggregator_converse() {
		_demand_dir_broadcastPipe_aggregatorStatic "$@"
	}
	_aggregator_converse_procedure "$@" 2> /dev/null
}

_aggregatorStatic_converse_EmptyOrWaitOrReset() {
	if ! _aggregatorStatic_delayIPC_EmptyOrWaitOrReset "$2" "$1" 2> /dev/null
	then
		return 1
	fi
	_aggregatorStatic_converse_noEmptyOrWaitOrReset "$@" 2> /dev/null
}

_aggregatorStatic_converse() {
	_aggregatorStatic_converse_EmptyOrWaitOrReset "$@" 2> /dev/null
}


# "$1" == outputBufferDir
# "$2" == outputFilesPrefix (MUST adhere to strictly blank or 18 alphanumeric characters!)
_aggregator_write_procedure() {
	local outputBufferDir="$1"
	local outputFilesPrefix="$2"
	#if [[ "$outputBufferDir" == "" ]] || [[ "$outputFilesPrefix" == "" ]]
	if [[ "$outputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		outputBufferDir="$current_demand_dir"/inputBufferDir
		! mkdir -p "$outputBufferDir" && return 1
		
		#[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix='stream-'
	fi
	
	[[ "$outputFilesPrefix" == "" ]] && outputFilesPrefix=$(_uid 18)
	
	
	! mkdir -p "$outputBufferDir" && return 1
	! [[ -e "$outputBufferDir" ]] && return 1
	! [[ -d "$outputBufferDir" ]] && return 1
	
	
	
	
	local currentFifo
	currentFifo="$outputBufferDir"/"$outputFilesPrefix"
	_aggregator_fifo "$currentFifo"
	
	#if ! [[ -e "$safeTmp" ]]
	#then
		if [[ "$ub_nohook_current_aggregator_write_stop_queue_aggregator" != 'true' ]]
		then
			export current_aggregator_write_fifo="$currentFifo"
			_stop_queue_aggregator() {
				rm -f "$current_aggregator_write_fifo" > /dev/null 2>&1
			}
		fi
	#fi
	
	# WARNING: Removal of FIFO may not occur while not connected to both input and output. Apparently 'trap' does not work here.
	# WARNING: May be incompatible with '_timeout' .
	cat > "$currentFifo"
	
	rm -f "$currentFifo" > /dev/null 2>&1
	
	return 0
}



_aggregator_write_sequence() {
	_start
	
	_aggregator_write_procedure "$@" 2> /dev/null
	
	_stop
}

_aggregator_write() {
	"$scriptAbsoluteLocation" _aggregator_write_sequence "$@" 2> /dev/null
}


# "$1" == outputBufferDir (inverted, client output, service input)
# "$2" == inputBufferDir (OPTIONAL. inverted)
_aggregatorStatic_write() {
	if ! _aggregatorStatic_delayIPC_EmptyOrWaitOrReset "$1" "$2"
	then
		return 1
	fi
	_aggregator_write_procedure "$1" 2> /dev/null
	#"$scriptAbsoluteLocation" _aggregator_write_sequence "$1" 2> /dev/null
	#"$scriptAbsoluteLocation" _aggregator_write_sequence "$@" 2> /dev/null
}





# ATTENTION: Override with 'ops' or similar.
_rm_broadcastPipe_aggregatorStatic() {
	! _safePath_demand_broadcastPipe_aggregatorStatic "$1" && return 1
	! _safePath_demand_broadcastPipe_aggregatorStatic "$2" && return 1
	
	#[[ -e "$1" ]] && [[ "$1" != "" ]] && rm -f "$1"/* > /dev/null 2>&1
	[[ -e "$1" ]] && [[ "$1" != "" ]] && find "$1" -mindepth 1 -maxdepth 1 \( -type f -o -type p -o -type l \) ! -name 'terminate' ! -name 'reset' ! -name 'attempt' -delete > /dev/null 2>&1
	[[ -e "$2" ]] && [[ "$2" != "" ]] && rm -f "$2"/* > /dev/null 2>&1
	
	
	return 0
}

# ATTENTION: Override with 'ops' or similar.
_rm_broadcastPipe_aggregatorStatic_keepListen() {
	! _safePath_demand_broadcastPipe_aggregatorStatic "$1" && return 1
	! _safePath_demand_broadcastPipe_aggregatorStatic "$2" && return 1
	
	#[[ -e "$1" ]] && [[ "$1" != "" ]] && rm -f "$1"/* > /dev/null 2>&1
	[[ -e "$1" ]] && [[ "$1" != "" ]] && find "$1" -mindepth 1 -maxdepth 1 \( -type f -o -type p -o -type l \) ! -name 'terminate' ! -name 'listen' ! -name 'attempt' -delete > /dev/null 2>&1
	[[ -e "$2" ]] && [[ "$2" != "" ]] && rm -f "$2"/* > /dev/null 2>&1
	
	
	return 0
}



_jobs_terminate_aggregatorStatic_procedure() {
	currentStopJobs=$(jobs -p -r 2> /dev/null)
	# WARNING: Although usually bad practice, it is useful for the spaces between PIDs to be interpreted in this case.
	# DANGER: Apparently, it is possible for some not running background jobs to be included in the PID list.
	[[ "$currentStopJobs" != "" ]] && kill $currentStopJobs > /dev/null 2>&1
	kill "$1" > /dev/null 2>&1
	
	currentIterations='0'
	while [[ $(jobs -p -r) != "" ]] && [[ "$currentIterations" -lt '3' ]]
	do
		sleep 0.6
		let currentIterations="$currentIterations"+1
	done
	currentStopJobs=$(jobs -p -r 2> /dev/null)
	kill -KILL $currentStopJobs > /dev/null 2>&1
	kill -KILL "$1" > /dev/null 2>&1
	
	currentIterations='0'
	while [[ $(jobs -p -r) != "" ]] && [[ "$currentIterations" -lt '16' ]]
	do
		sleep 1
		let currentIterations="$currentIterations"+1
	done
}



_broadcastPipe_aggregatorStatic_read_procedure() {
	_messageNormal 'init: _broadcastPipe_aggregatorStatic_read_procedure'
	[[ "$1" == "" ]] && _stop 1
	[[ "$1" == "/" ]] && _stop 1
	[[ "$2" == "/" ]] && _stop 1
	
	local current_demand_dir
	current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
	
	# May perhaps take effect when SIGTERM is received directly (eg. when SIGTERM may be sent to all processes) .
	export current_broadcastPipe_inputBufferDir="$1"
	export current_broadcastPipe_outputBufferDir="$2"
	export current_broadcastPipe_current_demand_dir="$current_demand_dir"
	_stop_queue_aggregatorStatic() {
		#_terminate_broadcastPipe_aggregatorStatic "$current_broadcastPipe_inputBufferDir" 2> /dev/null
		_terminate_broadcastPipe_fast "$current_broadcastPipe_inputBufferDir" 2> /dev/null
		sleep 1
		_rm_broadcastPipe_aggregatorStatic "$current_broadcastPipe_inputBufferDir" "$current_broadcastPipe_outputBufferDir"
		[[ "$current_broadcastPipe_inputBufferDir" == "$current_broadcastPipe_current_demand_dir"* ]] && [[ "$current_broadcastPipe_current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_aggregatorStatic
		
		_sleep_spinlock
		rm -f "$current_broadcastPipe_inputBufferDir"/reset > /dev/null 2>&1
		rm -f "$current_broadcastPipe_inputBufferDir"/terminate > /dev/null 2>&1
		[[ "$current_broadcastPipe_inputBufferDir" == "$current_broadcastPipe_current_demand_dir"* ]] && [[ "$current_broadcastPipe_current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_aggregatorStatic
	}
	
	
	local currentTerminate='false'
	
	while [[ ! -e "$1"/terminate ]] && [[ -d "$1" ]] && [[ "$currentTerminate" == 'false' ]]
	do
		
		
		
		local currentIterations
		
		
		_rm_broadcastPipe_aggregatorStatic "$@"
		rm -f "$1"/reset > /dev/null 2>&1
		rm -f "$1"/terminate > /dev/null 2>&1
		
		echo > "$1"/listen
		echo > "$1"/vaccancy
		echo > "$2"/vaccancy
		
		local currentInputBufferCount='0'
		local currentInputBufferCount_prev='0'
		local currentOutputBufferCount='0'
		local currentOutputBufferCount_prev='0'
		
		local currentFile
		
		
		local currentStopJobs
		
		local currentIsEmptyOut
		
		local currentPID
		
		local noJobsTwice
		
		_messagePlain_nominal ' 0 : reached loop'
		_messagePlain_probe "$1"
		_messagePlain_probe "$2"
		while [[ ! -e "$1"/terminate ]] && [[ -d "$1" ]]
		do
			_messagePlain_nominal ' 1 : loop'
			
			#rm -f "$1"/skip > /dev/null 2>&1
			
			currentInputBufferCount_prev="$currentInputBufferCount"
			currentOutputBufferCount_prev="$currentOutputBufferCount"
			#[[ $(jobs -p -r) != "" ]] && 
			while [[ "$currentInputBufferCount" == "$currentInputBufferCount_prev" ]] && [[ "$currentOutputBufferCount" == "$currentOutputBufferCount_prev" ]] && [[ ! -e "$1"/terminate ]] && [[ -d "$1" ]]
			do
				_messagePlain_nominal ' 2 : wait for change'
				
				currentInputBufferCount=0
				for currentFile in "$1"/??????????????????
				do
					_messagePlain_nominal '11 : count: currentInputBufferCount= '"$currentInputBufferCount"
					[[ "$currentFile" != *'??????????????????' ]] && let currentInputBufferCount="$currentInputBufferCount"+1
				done
				
				currentOutputBufferCount=0
				for currentFile in "$2"/??????????????????
				do
					_messagePlain_nominal '11 : count: currentOutputBufferCount= '"$currentOutputBufferCount"
					[[ "$currentFile" != *'??????????????????' ]] && let currentOutputBufferCount="$currentOutputBufferCount"+1
				done
				
				_messagePlain_probe_var currentInputBufferCount_prev
				_messagePlain_probe_var currentOutputBufferCount_prev
				_messagePlain_probe_var currentInputBufferCount
				_messagePlain_probe_var currentOutputBufferCount
				
				if ( [[ "$currentInputBufferCount" -gt 0 ]] || [[ "$currentOutputBufferCount" -gt 0 ]] ) && [[ $(jobs -p -r) == "" ]] && [[ "$currentInputBufferCount" == "$currentInputBufferCount_prev" ]] && [[ "$currentOutputBufferCount" == "$currentOutputBufferCount_prev" ]] && [[ "$noJobsTwice" == 'true' ]]
				then
					_messagePlain_warn 'obscure: 2.1: change: no jobs 2x: remove: unused pipe files'
					_rm_broadcastPipe_aggregatorStatic_keepListen "$@"
					#rm -f "$1"/skip > /dev/null 2>&1
					noJobsTwice='false'
				elif ( [[ "$currentInputBufferCount" -gt 0 ]] || [[ "$currentOutputBufferCount" -gt 0 ]] ) && [[ $(jobs -p -r) == "" ]] && [[ "$currentInputBufferCount" == "$currentInputBufferCount_prev" ]] && [[ "$currentOutputBufferCount" == "$currentOutputBufferCount_prev" ]] && [[ "$noJobsTwice" != 'true' ]]
				then
					_messagePlain_warn 'obscure: 2.1: change: no jobs 1x: set: noJobsTwice'
					noJobsTwice='true'
				fi
				
				
				# DANGER: Delay time > ~24seconds may result in unused/blocking FIFO pipes remaining (additional delay in remainder of loop is tolerable).
				# Iterations >1 may reduce CPU consumption with Cygwin/MSW , assuming file exists check is reasonably efficient.
				currentIterations='0'
				while [[ "$currentIterations" -lt '3' ]] && [[ "$currentInputBufferCount" == "$currentInputBufferCount_prev" ]] && [[ "$currentOutputBufferCount" == "$currentOutputBufferCount_prev" ]] && [[ ! -e "$1"/terminate ]] && [[ -d "$1" ]]
				do
					# If pipes are already connected, maybe delay a while longer to reduce CPU consumption.
					if [[ $(jobs -p -r) != "" ]]
					then
						_messagePlain_nominal '12 : idle: jobs: long delay'
						sleep 6
					fi
					
					# If pipes are not already connected, maybe delay a less, to improve interactivity.
					if [[ $(jobs -p -r) == "" ]]
					then
						# DANGER: CAUTION: Any 'sleep' > 3seconds (9seconds total) may break '_aggregator_delayIPC_'... .
						_messagePlain_nominal '12 : idle: no jobs: short delay'
						sleep 3
					fi
					
					let currentIterations="$currentIterations"+1
				done
			done
			#_messagePlain_warn 'obscure:  3 : done: loop: detected: new pipe files: complicated procedure: suspected failability'
			_messagePlain_good ' 3 : done: loop: detected: new pipe files'
			
			
			# ATTENTION: delay: InterProcess-Communication
			# CAUTION: Before reducing the delay (24 seconds recommended), consider that remote/peripherial may have latencies independent of any OS 'kernel', 'real-time' or otherwise!
			echo -e '\E[1;33;47m ''13 : delay: InterProcess-Communication: 24 seconds'' \E[0m'
			currentIterations='0'
			while [[ "$currentIterations" -lt 4 ]] && [[ ! -e "$1"/skip ]] && [[ ! -e "$1"/terminate ]] && [[ -d "$1" ]] && [[ "$currentOutputBufferCount" -gt 0 ]]
			#( [[ "$currentInputBufferCount" -gt 0 ]] || [[ "$currentOutputBufferCount" -gt 0 ]] )
			do
				if [[ "$currentIterations" == '0' ]]
				then
					echo > "$1"/vaccancy
					echo > "$2"/vaccancy
				fi
				
				#_messageDELAYipc
				_messagePlain_probe '13 : delay: InterProcess-Communication: 6 second iteration'
				#_messagePlain_probe '13 : delay: InterProcess-Communication: 6 second iteration: 24 seconds'
				#_messagePlain_nominal '13 : delay: InterProcess-Communication: 6 second iteration: 24 seconds'
				#echo -e '\E[1;33;47m ''13 : delay: InterProcess-Communication: 6 second iteration: 24 seconds'' \E[0m'
				sleep 6
				let currentIterations="$currentIterations"+1
			done
			if [[ ! -e "$1"/terminate ]] && [[ -d "$1" ]] && [[ "$currentOutputBufferCount" -gt 0 ]]
			then
				rm -f "$1"/vaccancy
				rm -f "$2"/vaccancy
				rm -f "$1"/attempt
				rm -f "$2"/attempt
			fi
			rm "$1"/skip > /dev/null 2>&1 && _messagePlain_good 'good: skip'
			rm -f "$1"/skip > /dev/null 2>&1
			
			currentInputBufferCount=0
			for currentFile in "$1"/??????????????????
			do
				_messagePlain_nominal '14 : count: currentInputBufferCount= '"$currentInputBufferCount"
				[[ "$currentFile" != *'??????????????????' ]] && let currentInputBufferCount="$currentInputBufferCount"+1
			done
			
			currentOutputBufferCount=0
			for currentFile in "$2"/??????????????????
			do
				_messagePlain_nominal '15 : count: currentOutputBufferCount= '"$currentOutputBufferCount"
				[[ "$currentFile" != *'??????????????????' ]] && let currentOutputBufferCount="$currentOutputBufferCount"+1
			done
			
			
			# https://stackoverflow.com/questions/25906020/are-pid-files-still-flawed-when-doing-it-right/25933330
			# https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
			
			_messagePlain_nominal ' 4 : _jobs_terminate_aggregatorStatic_procedure'
			_jobs_terminate_aggregatorStatic_procedure "$currentPID"
			
			_messagePlain_nominal ' 5 : detect: currentIsEmptyOut'
			#currentIsEmptyOut='false'
			# Although this may seem inefficient, the alternatives of calling external programs, filling variables, or setting 'shopt', may also be undesirable.
			# https://www.cyberciti.biz/faq/linux-unix-shell-check-if-directory-empty/
			currentIsEmptyOut='true'
			for currentFile in "$2"/??????????????????
			do
				if [[ "$currentFile" != *'??????????????????' ]]
				then
					_messagePlain_good '16 : detected: output pipe file'
					currentIsEmptyOut='false'
					break
				fi
			done
			_messagePlain_nominal ' 6 : decision'
			_messagePlain_probe_var currentInputBufferCount
			_messagePlain_probe_var currentOutputBufferCount
			[[ ! -e "$1"/terminate ]] && _messagePlain_probe ' 7.1: flag: missing: terminate'
			[[ -d "$1" ]] && _messagePlain_probe ' 7.2: detect: present: input directory'
			[[ "$currentIsEmptyOut" == 'false' ]] && _messagePlain_good ' 7.3: flag: detect: output pipe files'
			if [[ ! -e "$1"/terminate ]] && [[ -d "$1" ]] && [[ "$currentIsEmptyOut" == 'false' ]] && [[ "$currentInputBufferCount" -gt 0 ]] && [[ "$currentOutputBufferCount" -gt 0 ]]
			then
				_messagePlain_nominal ' 7 : ##### connect pipes #####'
				#https://unix.stackexchange.com/questions/139490/continuous-reading-from-named-pipe-cat-or-tail-f
				#https://stackoverflow.com/questions/11185771/bash-script-to-iterate-files-in-directory-and-pattern-match-filenames
				(
				for currentFile in "$1"/??????????????????
				do
					[[ "$currentFile" != *'??????????????????' ]] && cat "$currentFile" 2>/dev/null &
				done
				) | tee "$2"/?????????????????? > /dev/null 2>&1 &
				currentPID="$!"
				
				#rm -f "$1"/skip > /dev/null 2>&1
			fi
			
			_messagePlain_nominal ' 8 : repeat'
			
			# WARNING: Some processes within the subshell (ie. 'sleep' ) may allow the subshell to terminate rather than maintain a 'jobs' PID.
			_messagePlain_probe 'jobs: '$(jobs -p -r)
		done
		
		_messagePlain_nominal ' 9 : ##### terminate or reset #####'
		
		_jobs_terminate_aggregatorStatic_procedure "$currentPID"
		
		
		# WARNING: Since only one program may successfully remove a single file, that mechanism should allow only one 'broadcastPipe' process to remain in the unlikely case multiple were somehow started.
		currentTerminate='true'
		[[ -e "$1"/terminate ]] && [[ -e "$1"/reset ]] && rm "$1"/reset > /dev/null 2>&1 && rm "$1"/terminate > /dev/null 2>&1 && rm -f "$1"/listen > /dev/null 2>&1 && currentTerminate='false'
		rm -f "$1"/reset > /dev/null 2>&1
		
		# Recursive reset. Abandoned due to possibility of practical 'limit of recursion' with "bash" shell (and presumably similar as well) .
		# https://rosettacode.org/wiki/Find_limit_of_recursion
		# 'The Bash reference manual says No limit is placed on the number of recursive calls, nonetheless a segmentation fault occurs at 13777 (Bash v3.2.19 on 32bit GNU/Linux) '
		#[[ -e "$1"/terminate ]] && [[ -e "$1"/reset ]] && rm "$1"/reset > /dev/null 2>&1 && _broadcastPipe_aggregatorStatic_read_procedure "$@"
		#rm -f "$1"/reset > /dev/null 2>&1
		
	done
	
	
	rm -f "$1"/reset > /dev/null 2>&1
	rm -f "$1"/terminate > /dev/null 2>&1
	
	_rm_broadcastPipe_aggregatorStatic "$@"
	rm -f "$1"/reset > /dev/null 2>&1
	rm -f "$1"/terminate > /dev/null 2>&1
	[[ "$1" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_aggregatorStatic
	
	_sleep_spinlock
	rm -f "$1"/terminate > /dev/null 2>&1
	[[ "$1" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_aggregatorStatic
	
	return 0
}



# WARNING: Any unconnected pipe will block all pipes.
# WARNING: Any disconnection or new pipe will cause 'reset' of all pipes.
# "$1" == inputBufferDir
# "$2" == outputBufferDir
_broadcastPipe_aggregatorStatic_read() {
	_start
	
	_broadcastPipe_aggregatorStatic_read_procedure "$@"
	
	_stop
}










_here_rmloop_broadcastPipe_aggregatorStatic() {
	_here_header_bash_or_dash "$@"
	
	declare -f _rmloop_broadcastPipe_aggregatorStatic
	
	cat << CZXWXcRMTo8EmM8i4d
_rmloop_broadcastPipe_aggregatorStatic "\$@"

CZXWXcRMTo8EmM8i4d

}


_rmloop_broadcastPipe_aggregatorStatic() {
	while true
	do
		rm -f "$1"/rmloop > /dev/null 2>&1
		
		#sleep 1
		sleep 0.1
	done
	
}


_safePath_demand_broadcastPipe_aggregatorStatic() {
	if [[ "$1" == "$scriptLocal"* ]] && ! _if_cygwin
	then
		return 0
	fi
	if [[ "$1" == '/dev/shm/'* ]] && ! _if_cygwin
	then
		return 0
	fi
	
	
	! _safePath "$1" && _stop 1
	return 0
}

# WARNING: Deletes all existing files (to 'clear the buffers').
# "$1" == inputBufferDir
# "$2" == outputBufferDir
_demand_broadcastPipe_aggregatorStatic_sequence() {
	_start
	
	! mkdir -p "$1" && _stop 1
	! mkdir -p "$2" && _stop 1
	[[ "$1" == "" ]] && _stop 1
	[[ "$1" == "/" ]] && _stop 1
	[[ "$2" == "/" ]] && _stop 1
	if ! _safePath_demand_broadcastPipe_aggregatorStatic "$@"
	then
		_terminate_broadcastPipe_aggregatorStatic "$1"
		_stop 1
	fi
	
	_here_rmloop_broadcastPipe_aggregatorStatic "$@" > "$safeTmp"/_rmloop_broadcastPipe_aggregatorStatic
	chmod u+x "$safeTmp"/_rmloop_broadcastPipe_aggregatorStatic
	
	echo > "$1"/rmloop
	
	
	_sleep_spinlock
	
	
	! [[ -e "$1"/rmloop ]] && return 0
	! mv "$1"/rmloop "$1"/rmloop.rm > /dev/null 2>&1 && return 0
	if ! rm "$1"/rmloop.rm > /dev/null 2>&1
	then
		rm -f "$1"/rmloop.rm > /dev/null 2>&1
		return 0
	fi
	
	
	_rm_broadcastPipe_aggregatorStatic "$@"
	"$safeTmp"/_rmloop_broadcastPipe_aggregatorStatic "$@" &
	#"$scriptAbsoluteLocation" _rmloop_broadcastPipe_aggregatorStatic "$@" &
	
	
	#"$scriptAbsoluteLocation" _broadcastPipe_aggregatorStatic_read "$@" | _broadcastPipe_aggregatorStatic_write "$@"
	"$scriptAbsoluteLocation" _broadcastPipe_aggregatorStatic_read "$@"
	
	# May not be necessary. Theoretically redundant.
	local currentStopJobs
	currentStopJobs=$(jobs -p -r 2> /dev/null)
	[[ "$currentStopJobs" != "" ]] && kill "$currentStopJobs" > /dev/null 2>&1
	
	
	_sleep_spinlock
	rm -f "$1"/terminate > /dev/null 2>&1
	[[ "$1" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_aggregatorStatic
	
	_stop
}

_demand_broadcastPipe_aggregatorStatic() {
	local inputBufferDir="$1"
	local outputBufferDir="$2"
	shift
	shift
	
	if [[ "$inputBufferDir" == "" ]] || [[ "$outputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
		outputBufferDir="$current_demand_dir"/outputBufferDir
	elif [[ -e "$safeTmp" ]]
	then
		# DANGER: Without this hook, temporary "$safeTmp" directories may persist indefinitely!
		# Only hook '_stop_queue_aggregatorStatic' if called from within another 'sequence' (to cause termination of service when that 'sequence' terminates for any reason).
		export current_broadcastPipe_inputBufferDir="$inputBufferDir"
		export current_broadcastPipe_outputBufferDir="$outputBufferDir"
		_stop_queue_aggregatorStatic() {
			_terminate_broadcastPipe_aggregatorStatic "$current_broadcastPipe_inputBufferDir" 2> /dev/null
			#_terminate_broadcastPipe_fast "$current_broadcastPipe_inputBufferDir" 2> /dev/null
			#sleep 1
			_rm_broadcastPipe_aggregatorStatic "$current_broadcastPipe_inputBufferDir" "$current_broadcastPipe_outputBufferDir"
			[[ "$inputBufferDir" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_aggregatorStatic
		}
	fi
	
	
	"$scriptAbsoluteLocation" _demand_broadcastPipe_aggregatorStatic_sequence "$inputBufferDir" "$outputBufferDir" "$@" &
	while [[ -e "$inputBufferDir"/rmloop ]]
	do
		sleep 0.1
	done
	[[ ! -e "$inputBufferDir"/listen ]] && _sleep_spinlock
	[[ ! -e "$inputBufferDir"/listen ]] && _sleep_spinlock
	[[ ! -e "$inputBufferDir"/listen ]] && return 1
	
	[[ "$ub_force_limit_aggregatorStatic_rate" == 'true' ]] && _sleep_spinlock
	#[[ "$ub_force_limit_aggregatorStatic_rate" == 'false' ]] && _sleep_spinlock
	
	disown -a -h -r
	disown -a -r
	
	return 0
}


_terminate_broadcastPipe_aggregatorStatic_fast() {
	local inputBufferDir="$1"
	
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	[[ "$inputBufferDir" == "" ]] && return 1
	[[ "$inputBufferDir" == "/" ]] && return 1
	[[ ! -e "$inputBufferDir" ]] && return 1
	
	echo > "$inputBufferDir"/terminate
}

_terminate_broadcastPipe_aggregatorStatic() {
	local inputBufferDir="$1"
	
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	mkdir -p "$inputBufferDir"
	
	_terminate_broadcastPipe_aggregatorStatic_fast "$@"
	_sleep_spinlock
	
	rm -f "$inputBufferDir"/terminate > /dev/null 2>&1
	[[ "$inputBufferDir" == "$current_demand_dir"* ]] && [[ "$current_demand_dir" != "" ]] && _rm_dir_broadcastPipe_aggregatorStatic
	
	_sleep_spinlock
	
	return 0
}


_reset_broadcastPipe_aggregatorStatic() {
	local inputBufferDir="$1"
	
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	mkdir -p "$inputBufferDir"
	
	[[ "$inputBufferDir" == "" ]] && return 1
	[[ "$inputBufferDir" == "/" ]] && return 1
	[[ ! -e "$inputBufferDir" ]] && return 1
	
	echo > "$inputBufferDir"/reset
	echo > "$inputBufferDir"/terminate
}


_skip_broadcastPipe_aggregatorStatic() {
	local inputBufferDir="$1"
	
	if [[ "$inputBufferDir" == "" ]]
	then
		local current_demand_dir
		current_demand_dir=$(_demand_dir_broadcastPipe_aggregatorStatic "$1")
		[[ "$current_demand_dir" == "" ]] && _stop 1
		
		inputBufferDir="$current_demand_dir"/inputBufferDir
	fi
	
	mkdir -p "$inputBufferDir"
	
	[[ "$inputBufferDir" == "" ]] && return 1
	[[ "$inputBufferDir" == "/" ]] && return 1
	[[ ! -e "$inputBufferDir" ]] && return 1
	
	echo > "$inputBufferDir"/skip
}




# ATTENTION: Override with 'ops' or similar.
# Lock (if at all) the socket, not the buffers.
# Ports 6391 or alternatively 24671 preferred for one-per-machine IPC service with high-latency no-reset (ie. 'tripleBuffer' ) backend.
# Consider the limited availability of TCP/UDP port numbers not occupied by some other known purpose.
# TCP server intended for compatibility with platforms (ie. MSW/Cygwin) which may not have sufficient performance or flexibility to read/write (ie. 'tripleBuffer' ) backend directly.
# https://blog.travismclarke.com/post/socat-tutorial/
# https://fub2.github.io/powerful-socat/
# https://jdimpson.livejournal.com/tag/socat
# https://stackoverflow.com/questions/57299019/make-socat-open-port-only-on-localhost-interface
_page_socket_tcp_server() {
	_messagePlain_nominal '_page_socket_tcp_server: init: _demand_broadcastPipe_page'
	_demand_broadcastPipe_page
	
	_messagePlain_nominal '_page_socket_tcp_server: socat'
	#socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 EXEC:"$scriptAbsoluteLocation"' '"_page_converse"
	#socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 SYSTEM:'echo $HOME; ls -la'
	#socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 SYSTEM:\'\""$scriptAbsoluteLocation"\"\'' _page_converse'
	socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 EXEC:\'\""$scriptAbsoluteLocation"\"\'' _page_converse'
	
	#_messagePlain_nominal '_page_socket_tcp_server: _terminate_broadcastPipe_page'
	#_terminate_broadcastPipe_page
}

_page_socket_tcp_client() {
	socat TCP:localhost:6391 -
}









# ATTENTION: Override with 'ops' or similar.
# Lock (if at all) the socket, not the buffers.
# Ports 6391 or alternatively 24671 preferred for one-per-machine IPC service with high-latency no-reset (ie. 'tripleBuffer' ) backend.
# Consider the limited availability of TCP/UDP port numbers not occupied by some other known purpose.
# TCP server intended for compatibility with platforms (ie. MSW/Cygwin) which may not have sufficient performance or flexibility to read/write (ie. 'tripleBuffer' ) backend directly.
# 'UNIX domain socket' server not specifically intended for any known purpose and not necessarily recommended for any purpose.
# https://blog.travismclarke.com/post/socat-tutorial/
# https://fub2.github.io/powerful-socat/
# https://jdimpson.livejournal.com/tag/socat
# https://stackoverflow.com/questions/57299019/make-socat-open-port-only-on-localhost-interface
# https://en.wikipedia.org/wiki/Unix_domain_socket
_page_socket_unix_server() {
	_messagePlain_nominal '_page_socket_unix_server: _init'
	
	local current_unixAddress
	current_unixAddress=$(_demand_socket_broadcastPipe_page_unixAddress)
	
	export current_broadcastPipe_address="$current_unixAddress"
	export current_broadcastPipe_dir=$(dirname "$current_unixAddress" 2> /dev/null)
	[[ ! -e "$current_broadcastPipe_dir" ]] && return 1
	[[ ! -d "$current_broadcastPipe_dir" ]] && return 1
	_stop_queue_page() {
		rm -f "$current_broadcastPipe_address" > /dev/null 2>&1
		#rmdir "$current_broadcastPipe_dir" > /dev/null 2>&1
		#_sleep_spinlock
		rm -f "$current_broadcastPipe_address" > /dev/null 2>&1
		rmdir "$current_broadcastPipe_dir" > /dev/null 2>&1
		_rm_socket_broadcastPipe_page_unixAddress
	}
	
	
	_messagePlain_nominal '_page_socket_unix_server: _demand_broadcastPipe_page'
	_demand_broadcastPipe_page
	
	_messagePlain_nominal '_page_socket_unix_server: socat'
	#socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 EXEC:"$scriptAbsoluteLocation"' '"_page_converse"
	#socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 SYSTEM:'echo $HOME; ls -la'
	#socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 SYSTEM:\'\""$scriptAbsoluteLocation"\"\'' _page_converse'
	#socat TCP-LISTEN:6391,reuseaddr,pf=ip4,fork,bind=127.0.0.1 EXEC:\'\""$scriptAbsoluteLocation"\"\'' _page_converse'
	
	socat UNIX-LISTEN:"$current_broadcastPipe_dir"/unix.sock,fork EXEC:\'\""$scriptAbsoluteLocation"\"\'' _page_converse'
	
	
	#_messagePlain_nominal '_page_socket_unix_server: _terminate_broadcastPipe_page'
	#_terminate_broadcastPipe_page
	
	return 0
}

_page_socket_unix_client() {
	local current_unixAddress
	current_unixAddress=$(_demand_socket_broadcastPipe_page_unixAddress)
	
	#socat TCP:localhost:6391 -
	socat UNIX-CONNECT:"$current_unixAddress" -
	
	return 0
}










# ATTENTION: Override with 'ops' or similar.
# Lock (if at all) the socket, not the buffers.
# Ports 6392 or alternatively 24672 preferred for one-per-machine IPC service with low-latency frequent-reset (ie. 'aggregatorStatic' ) backend.
# Consider the limited availability of TCP/UDP port numbers not occupied by some other known purpose.
# TCP server intended for compatibility with platforms (ie. MSW/Cygwin) which may not have sufficient performance or flexibility to frequent-reset (ie. 'aggregatorStatic' ) backend directly.
# https://blog.travismclarke.com/post/socat-tutorial/
# https://fub2.github.io/powerful-socat/
# https://jdimpson.livejournal.com/tag/socat
# https://stackoverflow.com/questions/57299019/make-socat-open-port-only-on-localhost-interface
_aggregatorStatic_socket_tcp_server() {
	_messagePlain_nominal '_aggregatorStatic_socket_tcp_server: init: _demand_broadcastPipe_aggregatorStatic'
	_demand_broadcastPipe_aggregatorStatic
	
	_messagePlain_nominal '_aggregatorStatic_socket_tcp_server: socat'
	socat TCP-LISTEN:6392,reuseaddr,pf=ip4,fork,bind=127.0.0.1 EXEC:\'\""$scriptAbsoluteLocation"\"\'' _aggregatorStatic_converse'
	
	#_messagePlain_nominal '_aggregatorStatic_socket_tcp_server: _terminate_broadcastPipe_aggregatorStatic'
	#_terminate_broadcastPipe_aggregatorStatic
}

_aggregatorStatic_socket_tcp_client() {
	socat TCP:localhost:6392 -
}









# ATTENTION: Override with 'ops' or similar.
# Lock (if at all) the socket, not the buffers.
# Ports 6392 or alternatively 24672 preferred for one-per-machine IPC service with low-latency frequent-reset (ie. 'aggregatorStatic' ) backend.
# Consider the limited availability of TCP/UDP port numbers not occupied by some other known purpose.
# TCP server intended for compatibility with platforms (ie. MSW/Cygwin) which may not have sufficient performance or flexibility to frequent-reset (ie. # 'UNIX domain socket' server not specifically intended for any known purpose and not necessarily recommended for any purpose.
# https://blog.travismclarke.com/post/socat-tutorial/
# https://fub2.github.io/powerful-socat/
# https://jdimpson.livejournal.com/tag/socat
# https://stackoverflow.com/questions/57299019/make-socat-open-port-only-on-localhost-interface
# https://en.wikipedia.org/wiki/Unix_domain_socket
_aggregatorStatic_socket_unix_server() {
	_messagePlain_nominal '_aggregatorStatic_socket_unix_server: _init'
	
	local current_unixAddress
	current_unixAddress=$(_demand_socket_broadcastPipe_aggregatorStatic_unixAddress)
	
	export current_broadcastPipe_address="$current_unixAddress"
	export current_broadcastPipe_dir=$(dirname "$current_unixAddress" 2> /dev/null)
	[[ ! -e "$current_broadcastPipe_dir" ]] && return 1
	[[ ! -d "$current_broadcastPipe_dir" ]] && return 1
	_stop_queue_aggregatorStatic() {
		rm -f "$current_broadcastPipe_address" > /dev/null 2>&1
		#rmdir "$current_broadcastPipe_dir" > /dev/null 2>&1
		#_sleep_spinlock
		rm -f "$current_broadcastPipe_address" > /dev/null 2>&1
		rmdir "$current_broadcastPipe_dir" > /dev/null 2>&1
		_rm_socket_broadcastPipe_aggregatorStatic_unixAddress
	}
	
	
	_messagePlain_nominal '_aggregatorStatic_socket_unix_server: _demand_broadcastPipe_aggregatorStatic'
	_demand_broadcastPipe_aggregatorStatic
	
	_messagePlain_nominal '_aggregatorStatic_socket_unix_server: socat'
	socat UNIX-LISTEN:"$current_broadcastPipe_dir"/unix.sock,fork EXEC:\'\""$scriptAbsoluteLocation"\"\'' _aggregatorStatic_converse'
	
	
	#_messagePlain_nominal '_aggregatorStatic_socket_unix_server: _terminate_broadcastPipe_aggregatorStatic'
	#_terminate_broadcastPipe_aggregatorStatic
	
	return 0
}

_aggregatorStatic_socket_unix_client() {
	local current_unixAddress
	current_unixAddress=$(_demand_socket_broadcastPipe_aggregatorStatic_unixAddress)
	
	socat UNIX-CONNECT:"$current_unixAddress" -
	
	return 0
}











# Create Read Update Delete
# "$scriptLocal"/ops-ubdb.sh

# Reads a file or directory.
# Writes a file.


_db_list_var() {
	( set -o posix ; set )
	return
	
	#if type -p printenv > /dev/null 2>&1
	#then
		#printenv "$@"
		#return
	#elif type -p env > /dev/null 2>&1
	#then
		#env "$@"
		#return
	#fi
	#return 1
}

_db_filter_characters() {
	tr -d '(){}<>$:;&|#?!@%^*,`\t\\'
}

# "$1" == grepPattern
_db_filter_identifier() {
	grep '^ubdb_'"$ubiquitousBashID"'_'"$1" | _db_filter_characters
}

_db_reinit() {
	# https://stackoverflow.com/questions/13823706/capture-multiline-output-as-array-in-bash
	local currentVarList
	currentVarList=($(_db_list_var | cut -f1 -d\= | _db_filter_identifier "$1"))
	
	#local currentLine
	#_db_list_var | cut -f1 -d\= | _db_filter_identifier "$1" | while IFS='' read -r currentLine || [[ -n "$currentLine" ]]; do
		#_messagePlain_probe_var "$currentLine"
		
		
		#_messagePlain_probe_cmd declare -x -g "$currentLine"=''
		
		#eval export "$currentLine"=''
		#eval unset "$currentLine"
		
		#_messagePlain_probe_var "$currentLine"
		
		
		
		
	#done | _db_filter_characters
	
	currentVarList+=("$currentLine")
	for currentLine in "${currentVarList[@]}"
	do
		if ! [[ "$currentLine" == "" ]] && ! [[ "$currentLine" == "\$" ]]
		then
			#_messagePlain_probe "$currentLine"
			
			#_messagePlain_probe_var "$currentLine"
			
			declare -x -g "$currentLine"=''
			eval export "$currentLine"=''
			eval unset "$currentLine"
			
			#_messagePlain_probe_var "$currentLine"
		fi
	done
	
}


# Internal use intended - called by '_db_write' .
_demand_db() {
	local current_db="$scriptLocal"/ops-db.sh
	[[ "$ub_db_file" != "" ]] && current_db="$ub_db_file"
	
	! [[ -e "$current_db" ]] && echo -e -n '' >> "$current_db"
	
	# NOT VALID. Create directories (and files within) directly using mkdir/echo .
	[[ -d "$current_db" ]] && return 1
	
	
	
	! [[ -e "$current_db" ]] && return 1
	return 0
}




_db_importSource() {
	# https://stackoverflow.com/questions/28783509/override-a-builtin-command-with-an-alias
	
	declare() {
		builtin declare -g "$@"
	}
	
	
	# https://unix.stackexchange.com/questions/160256/can-you-source-a-here-document
	source <( cat "$1" | _db_filter_characters )
	#. "$1"
	
	unset -f declare > /dev/null 2>&1
	
	return 0
}




_db_source() {
	local current_db="$scriptLocal"/ops-db.sh
	[[ "$ub_db_file" != "" ]] && current_db="$ub_db_file"
	! [[ -e "$current_db" ]] && return 1
	
	if [[ -d "$current_db" ]]
	then
		# Not yet implemented.
		return 1
	else
		_db_importSource "$current_db"
	fi
}

# "$1" == grepPattern
# "$ub_db_file"
_db_enumerate() {
	local currentLine
	#local processedLine
	#local currentVarName
	#local processedVarName
	
	local currentLineValue
	
	_db_list_var | cut -f1 -d\= | _db_filter_identifier "$1" | while IFS='' read -r currentLine || [[ -n "$currentLine" ]]; do
		currentLineValue=$(eval _safeEcho "\$"$currentLine"")
		[[ "$currentLineValue" == "" ]] && continue
		
		#processedLine=$(declare -p "$currentLine")
		
		# ATTENTION: OPTIONAL - always export variables (recommended)
		# 'declare -x' apparently causes value of variable to be dropped
		export "$currentLine"
		#declare -x "$currentLine"
		
		declare -p "$currentLine"
	done | _db_filter_characters
}





_db_read() {
	_db_reinit
	_db_source
	#_db_enumerate ""
}


_db_show() {
	_db_read
	_db_enumerate "$1"
}



_db_write_sequence() {
	_start
	
	local current_db="$scriptLocal"/ops-db.sh
	[[ "$ub_db_file" != "" ]] && current_db="$ub_db_file"
	#! [[ -e "$current_db" ]] && return 1
	
	# INVALID.
	[[ -d "$current_db" ]] && return 1
	
	
	local currentEmptyUID=$(_uid)
	
	echo -e -n '' >> "$current_db"."$currentEmptyUID"
	if ! _moveconfirm "$current_db"."$currentEmptyUID" "$current_db".lock
	then
		! rm "$current_db"."$currentEmptyUID" > /dev/null 2>&1 && _stop 255
		rm -f "$current_db"."$currentEmptyUID" > /dev/null 2>&1
		_stop 1
	fi
	
	# Read in a list of variables.
	_demand_db
	_db_read
	_db_importSource "$1"
	
	_db_enumerate | cat - > "$safeTmp"/db_input_replacement_tmp
	
	! _moveconfirm "$current_db" "$current_db".obsolete && _stop 1
	! _moveconfirm "$safeTmp"/db_input_replacement_tmp "$current_db" && _stop 1
	! rm "$current_db".obsolete && _stop 255
	! rm "$current_db".lock > /dev/null 2>&1 && _stop 255
	
	_stop 0
}


# "$1" == db_input_file (recommended: "$safeTmp"/db_input )
_db_write() {
	# More than 50 repeats/recursions is extremely unreasonable under expected loads.
	[[ "$ub_db_write_currentRecursive" -gt 50 ]] && return 1
	[[ "$ub_db_write_currentRecursive" == "" ]] && export ub_db_write_currentRecursive='0'
	
	
	if ! "$scriptAbsoluteLocation" _db_write_sequence "$1"
	then
		let ub_db_write_currentRecursive="$ub_db_write_currentRecursive"+1
		local currentDelay
		local currentDelayTenths
		let currentDelay="$RANDOM"%3
		let currentDelayTenths="$RANDOM"%10
		#echo "$currentDelay"."$currentDelayTenths"
		sleep "$currentDelay"."$currentDelayTenths"
		
		_db_write "$@"
		
		return 0
	fi
	
	return 0
}


_db_rm() {
	local current_db="$scriptLocal"/ops-db.sh
	[[ "$ub_db_file" != "" ]] && current_db="$ub_db_file"
	! [[ -e "$current_db" ]] && return 1
	
	if [[ -d "$current_db" ]]
	then
		# NOT VALID. Remove directories (and files within) directly using rmdir/_safeRMR/rm .
		return 1
	else
		rm -f "$current_db" > /dev/null 2>&1
		[[ -e "$current_db" ]] && return 1
		return 0
	fi
	return 1
}









_interactive_pipe_procedure() {
	[[ ! -e "$1" ]] && return 1
	[[ ! -d "$1" ]] && return 1
	
	local currentExitStatus=1
	
	_aggregator_fifo "$1"/p0
	_aggregator_fifo "$1"/p1
	_aggregator_fifo "$1"/p2
	
	
	bash -s -l -i 0<"$1"/p0 1>"$1"/p1 2>"$1"/p2
	currentExitStatus="$?"
	
	
	rm -f "$1"/p0 > /dev/null 2>&1
	rm -f "$1"/p1 > /dev/null 2>&1
	rm -f "$1"/p2 > /dev/null 2>&1
	rmdir "$1" > /dev/null 2>&1
	
	return "$currentExitStatus"
}

_interactive_pipe_sequence() {
	local currentPipeUID=$(_uid)
	[[ "$ub_force_interactive_pipe_id" != "" ]] && currentPipeUID="$ub_force_interactive_pipe_id"
	local currentPipeDir="$safeTmp"/interactive_pipe_"$currentPipeUID"
	#[[ "$ub_force_interactive_pipe_id" != "" ]] && currentPipeDir="$currentSub_safeTmp"/interactive_pipe_"$currentPipeUID"
	_safeEcho_newline "$currentPipeDir"
	
	_start
	
	[[ ! -e "$safeTmp" ]] && return 1
	[[ ! -d "$safeTmp" ]] && return 1
	mkdir -p "$currentPipeDir"
	[[ ! -e "$currentPipeDir" ]] && return 1
	[[ ! -d "$currentPipeDir" ]] && return 1
	
	_interactive_pipe_procedure "$currentPipeDir"
	
	_stop
}

# CAUTION: Requires calling 'sequence' not to run "_stop" until terminal is no longer needed.
# WARNING: Untested.
_demand_interactive_pipe_procedure() {
	true | "$scriptAbsoluteLocation" --devenv _interactive_pipe_sequence "$currentPipeDir" &
	
	disown -h "$!"
	
	sleep 7
}

# Intended to allow lower-latency access to internal commands, as well as their responses, such as through a 'physical' 'terminal emulator' . Especially including access to other 'queue' InterProcess-Communication procedures, and to procedures which communicate through such a bus.
# In practice, this approach has limitations.
# An error message will be displayed if the pipes are connected to after the 'parent' process has exited .
# Keyboard interactive programs (eg. vim) are unusable.
# Much 'noise' is present, likely requiring specialized text parsing of commands and responses, as would be expected of a more elaborate protocol.
_demand_interactive_pipe() {
	true | "$scriptAbsoluteLocation" _interactive_pipe_sequence &
	
	disown -h "$!"
	
	sleep 7
}


# ./ubiquitous_bash.sh _interactive_client_pipe ./w_*/interactive_pipe_??????????????????
_interactive_client_pipe() {
	[[ ! -e "$1"/p0 ]] && return 1
	[[ ! -e "$1"/p1 ]] && return 1
	#[[ ! -e "$1"/p2 ]] && return 1
	cat "$1"/p1 & [[ -e "$1"/p2 ]] && cat "$1"/p2 >&2 & cat > "$1"/p0
}


_interactive_pipe_konsole() {
	# Force 'known' sessionid and safeTmp of next "$scriptAbsoluteLocation" .
	export ub_force_sessionid=$(_uid)
	export ub_force_interactive_pipe_id=$(_uid)
	local currentSub_safeTmp=$(
		export sessionid="$ub_force_sessionid"
		_get_ub_globalVars_sessionDerived
		_safeEcho "$safeTmp"
	)
	
	local currentPipeUID=$(_uid)
	[[ "$ub_force_interactive_pipe_id" != "" ]] && currentPipeUID="$ub_force_interactive_pipe_id"
	local currentPipeDir="$safeTmp"/interactive_pipe_"$currentPipeUID"
	[[ "$ub_force_interactive_pipe_id" != "" ]] && currentPipeDir="$currentSub_safeTmp"/interactive_pipe_"$currentPipeUID"
	_safeEcho_newline "$currentPipeDir" > /dev/null 2>&1
	
	
	# demand ...
	_demand_interactive_pipe > /dev/null 2>&1
	
	
	# Connect to known pipe location.
	set +m
	konsole -e "$scriptAbsoluteLocation" _interactive_client_pipe "$currentPipeDir" > /dev/null 2>&1
	#sleep 7
	set -m
}








# TODO: An implementation using 'tmux' or 'GNU Screen' may be more capable.


_test_interactive_tmux() {
	_getDep tmux
}

_test_interactive_screen() {
	_getDep screen
}











#####Local Environment Management (Resources)

#_prepare_prog() {
#	true
#}

_extra() {
	true
}

_prepare_abstract() {
	! mkdir -p "$abstractfs_root" && exit 1
	chmod 0700 "$abstractfs_root" > /dev/null 2>&1
	! chmod 700 "$abstractfs_root" && exit 1
	
	if [[ "$CI" != "" ]] && ! type chown > /dev/null 2>&1
	then
		chown() {
			true
		}
	fi
	
	if _if_cygwin
	then
		if ! chown "$USER":None "$abstractfs_root" > /dev/null 2>&1
		then
			! chown "$USER" "$abstractfs_root" && exit 1
		fi
	else
		if ! chown "$USER":"$USER" "$abstractfs_root" > /dev/null 2>&1
		then
			if [[ -e /sbin/chown ]]
			then
				! /sbin/chown "$USER" "$abstractfs_root" && exit 1
			else
				! /usr/bin/chown "$USER" "$abstractfs_root" && exit 1
			fi
		fi
	fi
	
	
	
	
	! mkdir -p "$abstractfs_lock" && exit 1
	chmod 0700 "$abstractfs_lock" > /dev/null 2>&1
	! chmod 700 "$abstractfs_lock" && exit 1
	
	if _if_cygwin
	then
		if ! chown "$USER":None "$abstractfs_lock" > /dev/null 2>&1
		then
			! chown "$USER" "$abstractfs_lock" && exit 1
		fi
	else
		if ! chown "$USER":"$USER" "$abstractfs_lock" > /dev/null 2>&1
		then
			if [[ -e /sbin/chown ]]
			then
				! /sbin/chown "$USER" "$abstractfs_lock" && exit 1
			else
				! /usr/bin/chown "$USER" "$abstractfs_lock" && exit 1
			fi
		fi
	fi
}

_prepare() {
	
	! mkdir -p "$safeTmp" && exit 1
	
	! mkdir -p "$shortTmp" && exit 1
	
	! mkdir -p "$logTmp" && exit 1
	
	[[ "$*" != *scriptLocal_mkdir_disable* ]] && ! mkdir -p "$scriptLocal" && exit 1
	
	! mkdir -p "$bootTmp" && exit 1
	
	# WARNING: No production use. Not guaranteed to be machine readable.
	[[ "$tmpSelf" != "$scriptAbsoluteFolder" ]] && echo "$tmpSelf" 2> /dev/null > "$scriptAbsoluteFolder"/__d_$(echo "$sessionid" | head -c 16)
	
	#_prepare_abstract
	
	_extra
	_tryExec "_prepare_prog"
}

#####Local Environment Management (Instancing)

#_start_prog() {
#	true
#}

# ATTENTION: Consider carefully, override with "ops".
# WARNING: Unfortunate, but apparently necessary, workaround for script termintaing while "sleep" or similar run under background.
_start_stty_echo() {
	#true
	
	#stty echo --file=/dev/tty > /dev/null 2>&1
	
	export ubFoundEchoStatus=$(stty --file=/dev/tty -g 2>/dev/null)
}

_start() {
	_start_stty_echo
	
	_prepare "$@"
	
	#touch "$varStore"
	#. "$varStore"
	
	echo $$ > "$safeTmp"/.pid
	echo "$sessionid" > "$safeTmp"/.sessionid
	_embed_here > "$safeTmp"/.embed.sh
	chmod 755 "$safeTmp"/.embed.sh
	
	_tryExec "_start_prog"
}

#_saveVar_prog() {
#	true
#}

_saveVar() {
	true
	#declare -p varName > "$varStore"
	
	_tryExec "_saveVar_prog"
}

#_stop_prog() {
#	true
#}

# ATTENTION: Consider carefully, override with "ops".
# WARNING: Unfortunate, but apparently necessary, workaround for script termintaing while "sleep" or similar run under background.
_stop_stty_echo() {
	#true
	
	#stty echo --file=/dev/tty > /dev/null 2>&1
	
	[[ "$ubFoundEchoStatus" != "" ]] && stty --file=/dev/tty "$ubFoundEchoStatus" 2> /dev/null

	return 0
}

# DANGER: Use of "_stop" must NOT require successful "_start". Do NOT include actions which would not be safe if "_start" was not used or unsuccessful.
_stop() {
	if [[ "$ubDEBUG" == "true" ]] ; then set +x ; set +E ; set +o functrace ; set +o errtrace ; export -n SHELLOPTS 2>/dev/null || true ; trap '' RETURN ; trap - RETURN ; fi
	
	_stop_stty_echo
	
	_tryExec "_stop_prog"
	
	_tryExec "_stop_queue_page"
	_tryExec "_stop_queue_aggregatorStatic"
	
	_preserveLog
	
	#Kill process responsible for initiating session. Not expected to be used normally, but an important fallback.
	local ub_stop_pid
	if [[ -e "$safeTmp"/.pid ]]
	then
		ub_stop_pid=$(cat "$safeTmp"/.pid 2> /dev/null)
		if [[ $$ != "$ub_stop_pid" ]]
		then
			pkill -P "$ub_stop_pid" > /dev/null 2>&1
			kill "$ub_stop_pid" > /dev/null 2>&1
		fi
	fi
	#Redundant, as this usually resides in "$safeTmp".
	rm -f "$pidFile" > /dev/null 2>&1
	
	
	# https://stackoverflow.com/questions/25906020/are-pid-files-still-flawed-when-doing-it-right/25933330
	# https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
	local currentStopJobs
	currentStopJobs=$(jobs -p -r 2> /dev/null)
	# WARNING: Although usually bad practice, it is useful for the spaces between PIDs to be interpreted in this case.
	# DANGER: Apparently, it is possible for some not running background jobs to be included in the PID list.
	[[ "$currentStopJobs" != "" ]] && kill $currentStopJobs > /dev/null 2>&1
	
	
	if [[ -e "$scopeTmp" ]] && [[ -e "$scopeTmp"/.pid ]] && [[ "$$" == $(cat "$scopeTmp"/.pid 2>/dev/null) ]]
	then
		#Symlink, or nonexistent.
		rm -f "$ub_scope" > /dev/null 2>&1
		#Only created if needed by scope.
		[[ -e "$scopeTmp" ]] && _safeRMR "$scopeTmp"
	fi
	
	#Only created if needed by query.
	[[ -e "$queryTmp" ]] && _safeRMR "$queryTmp"
	
	#Only created if needed by engine.
	[[ -e "$engineTmp" ]] && _safeRMR "$engineTmp"
	
	_tryExec _rm_instance_metaengine
	_tryExec _rm_instance_channel
	
	_safeRMR "$shortTmp"
	_safeRMR "$safeTmp"
	[[ "$fastTmp" != "" ]] && _safeRMR "$fastTmp"
	
	[[ -e "$safeTmp" ]] && sleep 0.1 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 0.3 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 1 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 3 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 3 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 3 && _safeRMR "$safeTmp"
	
	_tryExec _rm_instance_fakeHome
	
	#Optionally always try to remove any systemd shutdown hook.
	#_tryExec _unhook_systemd_shutdown
	
	[[ "$tmpSelf" != "$scriptAbsoluteFolder" ]] && [[ "$tmpSelf" != "/" ]] && [[ -e "$tmpSelf" ]] && rmdir "$tmpSelf" > /dev/null 2>&1
	rm -f "$scriptAbsoluteFolder"/__d_$(echo "$sessionid" | head -c 16) > /dev/null 2>&1

	#currentAxelTmpFile="$scriptAbsoluteFolder"/.m_axelTmp_$(_uid 14)
	if [[ "$currentAxelTmpFile" != "" ]]
	then
		rm -f "$currentAxelTmpFile" > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".st > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp.st > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp.aria2 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp1 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp1.st > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp1.aria2 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp2 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp2.st > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp2.aria2 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp3 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp3.st > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp3.aria2 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp4 > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp4.st > /dev/null 2>&1
		#rm -f "$currentAxelTmpFile".tmp4.aria2 > /dev/null 2>&1
			
		rm -f "$currentAxelTmpFile"* > /dev/null 2>&1
	fi

	[[ -e "$scriptLocal"/python_nix.lock ]] && [[ $(head -c $(echo -n "$sessionid" | wc -c | tr -dc '0-9') "$scriptLocal"/python_nix.lock 2> /dev/null ) == "$sessionid" ]] && rm -f "$scriptLocal"/python_nix.lock > /dev/null 2>&1
	[[ -e "$scriptLocal"/python_msw.lock ]] && [[ $(head -c $(echo -n "$sessionid" | wc -c | tr -dc '0-9') "$scriptLocal"/python_msw.lock 2> /dev/null ) == "$sessionid" ]] && rm -f "$scriptLocal"/python_msw.lock > /dev/null 2>&1
	[[ -e "$scriptLocal"/python_cygwin.lock ]] && [[ $(head -c $(echo -n "$sessionid" | wc -c | tr -dc '0-9') "$scriptLocal"/python_cygwin.lock 2> /dev/null ) == "$sessionid" ]] && rm -f "$scriptLocal"/python_cygwin.lock > /dev/null 2>&1
	
	_stop_stty_echo

	# WARNING: CAUTION: Do NOT cause EXIT trap unset until 'exit' command cannot be called (eg. by user in an interactive shell).
	# Unset the 'exit' trap before calling 'exit' command properly , hopefully prevent incorrect exit status in some unusual situations (eg. CI environment, 'set -e -o pipefail' , etc) .
	trap - EXIT

	if [[ "$1" != "" ]]
	then
		exit "$1"
	else
		exit 0
	fi
}

#Do not overload this unless you know why you need it instead of _stop_prog.
#_stop_emergency_prog() {
#	true
#}

#Called upon SIGTERM or similar signal.
_stop_emergency() {
	[[ "$noEmergency" == true ]] && _stop "$1"
	
	export EMERGENCYSHUTDOWN=true
	
	#Not yet using _tryExec since this function would typically result from user intervention, or system shutdown, both emergency situations in which an error message would be ignored if not useful. Higher priority is guaranteeing execution if needed and available.
	_tryExec "_closeChRoot_emergency"
	
	#Daemon uses a separate instance, and will not be affected by previous actions, possibly even if running in the foreground.
	#jobs -p >> "$daemonPidFile" #Could derrange the correct order of descendent job termination.
	_tryExec _killDaemon
	
	_tryExec _stop_virtLocal
	
	_tryExec "_stop_emergency_prog"
	
	_stop "$1"
	
}

_waitFile() {
	
	[[ -e "$1" ]] && sleep 1
	[[ -e "$1" ]] && sleep 9
	[[ -e "$1" ]] && sleep 27
	[[ -e "$1" ]] && sleep 81
	[[ -e "$1" ]] && _return 1
	
	return 0
}

#Wrapper. If lock file is present, waits for unlocking operation to complete successfully, then reports status.
#"$1" == checkFile
#"$@" == wait command and parameters
_waitFileCommands() {
	local waitCheckFile
	waitCheckFile="$1"
	shift
	
	if [[ -e "$waitCheckFile" ]]
	then
		local waitFileCommandStatus
		
		"$@"
		
		waitFileCommandStatus="$?"
		
		if [[ "$waitFileCommandStatus" != "0" ]]
		then
			return "$waitFileCommandStatus"
		fi
		
		[[ -e "$waitCheckFile" ]] && return 1
		
	fi
	
	return 0
}

#$1 == command to execute if scriptLocal path has changed, typically remove another lock file
_pathLocked() {
	[[ ! -e "$lock_pathlock" ]] && echo "k3riC28hQRLnjgkwjI" > "$lock_pathlock"
	[[ ! -e "$lock_pathlock" ]] && return 1
	
	local lockedPath
	lockedPath=$(cat "$lock_pathlock")
	
	if [[ "$lockedPath" != "$scriptLocal" ]]
	then
		rm -f "$lock_pathlock" > /dev/null 2>&1
		[[ -e "$lock_pathlock" ]] && return 1
		
		echo "$scriptLocal" > "$lock_pathlock"
		[[ ! -e "$lock_pathlock" ]] && return 1
		
		if [[ "$1" != "" ]]
		then
			"$@"
			[[ "$?" != "0" ]] && return 1
		fi
		
	fi
	
	return 0
}

_readLocked() {
	mkdir -p "$bootTmp"
	
	local rebootToken
	rebootToken=$(cat "$1" 2> /dev/null)
	
	#Remove miscellaneous files if appropriate.
	if [[ -d "$bootTmp" ]] && ! [[ -e "$bootTmp"/"$rebootToken" ]]
	then
		rm -f "$scriptLocal"/*.log && rm -f "$scriptLocal"/imagedev && rm -f "$scriptLocal"/WARNING
		
		[[ -e "$lock_quicktmp" ]] && sleep 0.1 && [[ -e "$lock_quicktmp" ]] && rm -f "$lock_quicktmp"
	fi
	
	! [[ -e "$1" ]] && return 1
	##Lock file exists.
	
	if [[ -d "$bootTmp" ]]
	then
		if ! [[ -e "$bootTmp"/"$rebootToken" ]]
		then
			##Lock file obsolete.
			
			#Remove old lock.
			rm -f "$1" > /dev/null 2>&1
			return 1
		fi
		
		##Lock file and token exists.
		return 0
	fi
	
	##Lock file exists, token cannot be found.
	return 0
	
	
	
}

#Using _readLocked before any _createLocked operation is strongly recommended to remove any lock from prior UNIX session (ie. before latest reboot).
_createLocked() {
	[[ "$ubDEBUG" == true ]] && caller 0 >> "$scriptLocal"/lock.log
	[[ "$ubDEBUG" == true ]] && echo -e '\t'"$sessionid"'\t'"$1" >> "$scriptLocal"/lock.log
	
	mkdir -p "$bootTmp"
	
	! [[ -e "$bootTmp"/"$sessionid" ]] && echo > "$bootTmp"/"$sessionid"
	
	# WARNING Recommend setting this to a permanent value when testing critical subsystems, such as with _userChRoot related operations.
	local lockUID="$(_uid)"
	
	echo "$sessionid" > "$lock_quicktmp"_"$lockUID"
	
	mv -n "$lock_quicktmp"_"$lockUID" "$1" > /dev/null 2>&1
	
	if [[ -e "$lock_quicktmp"_"$lockUID" ]]
	then
		[[ "$ubDEBUG" == true ]] && echo -e '\t'FAIL >> "$scriptLocal"/lock.log
		rm -f "$lock_quicktmp"_"$lockUID" > /dev/null 2>&1
		return 1
	fi
	
	rm -f "$lock_quicktmp"_"$lockUID" > /dev/null 2>&1
	return 0
}

_resetLocks() {
	
	_readLocked "$lock_open"
	_readLocked "$lock_opening"
	_readLocked "$lock_closed"
	_readLocked "$lock_closing"
	_readLocked "$lock_instance"
	_readLocked "$lock_instancing"
	
}

_checkSpecialLocks() {
	local localSpecialLock
	
	localSpecialLock="$specialLock"
	[[ "$1" != "" ]] && localSpecialLock="$1"
	
	local currentLock
	
	for currentLock in "${specialLocks[@]}"
	do
		[[ "$currentLock" == "$localSpecialLock" ]] && continue
		_readLocked "$currentLock" && return 0
	done
	
	return 1
}

#Wrapper. Operates lock file for mounting shared resources (eg. persistent virtual machine image). Avoid if possible.
#"$1" == waitOpen function && shift
#"$@" == wrapped function and parameters
#"$specialLock" == additional lockfile to write
_open_procedure() {
	mkdir -p "$scriptLocal"
	
	if _readLocked "$lock_open"
	then
		_checkSpecialLocks && return 1
		return 0
	fi
	
	_readLocked "$lock_closing" && return 1
	
	if _readLocked "$lock_opening"
	then
		if _waitFileCommands "$lock_opening" "$1"
		then
			_readLocked "$lock_open" || return 1
			return 0
		else
			return 1
		fi
	fi
	
	_createLocked "$lock_opening" || return 1
	
	shift
	
	echo "LOCKED" > "$scriptLocal"/WARNING
	
	"$@"
	
	if [[ "$?" == "0" ]]
	then
		_createLocked "$lock_open" || return 1
		
		if [[ "$specialLock" != "" ]]
		then
			_createLocked "$specialLock" || return 1
		fi
		
		rm -f "$lock_opening"
		return 0
	fi
	
	return 1
}

_open() {
	local returnStatus
	
	_open_procedure "$@"
	returnStatus="$?"
	
	export specialLock
	specialLock=""
	export specialLock
	
	return "$returnStatus"
}

#Wrapper. Operates lock file for shared resources (eg. persistent virtual machine image). Avoid if possible.
#"$1" == <"--force"> && shift
#"$1" == waitClose function && shift
#"$@" == wrapped function and parameters
#"$specialLock" == additional lockfile to remove
_close_procedure() {
	local closeForceEnable
	closeForceEnable=false
	
	if [[ "$1" == "--force" ]]
	then
		closeForceEnable=true
		shift
	fi
	
	if ! _readLocked "$lock_open" && [[ "$closeForceEnable" != "true" ]]
	then
		return 0
	fi
	
	if [[ "$specialLock" != "" ]] && [[ -e "$specialLock" ]] && ! _readLocked "$specialLock" && [[ "$closeForceEnable" != "true" ]]
	then
		return 1
	fi
	
	_checkSpecialLocks && return 1
	
	if _readLocked "$lock_closing" && [[ "$closeForceEnable" != "true" ]]
	then
		if _waitFileCommands "$lock_closing" "$1"
		then
			return 0
		else
			return 1
		fi
	fi
	
	if [[ "$closeForceEnable" != "true" ]]
	then
		_createLocked "$lock_closing" || return 1
	fi
	! _readLocked "$lock_closing" && _createLocked "$lock_closing"
	
	shift
	
	"$@"
	
	if [[ "$?" == "0" ]]
	then
		#rm -f "$lock_open" || return 1
		rm -f "$lock_open"
		[[ -e "$lock_open" ]] && return 1
		
		if [[ "$specialLock" != "" ]] && [[ -e "$specialLock" ]]
		then
			#rm -f "$specialLock" || return 1
			rm -f "$specialLock"
			[[ -e "$specialLock" ]] && return 1
		fi
		
		rm -f "$lock_closing"
		rm -f "$scriptLocal"/WARNING
		return 0
	fi
	
	return 1
}

_close() {
	local returnStatus
	
	_close_procedure "$@"
	returnStatus="$?"
	
	export specialLock
	specialLock=""
	export specialLock
	
	return "$returnStatus"
}

#"$1" == variable name to preserve
#shift
#"$1" == variable data to preserve
#shift
#"$@" == function to prepare other variables
_preserveVar() {
	local varNameToPreserve
	varNameToPreserve="$1"
	shift
	
	local varDataToPreserve
	varDataToPreserve="$1"
	shift
	
	"$@"
	
	[[ "$varNameToPreserve" == "" ]] && return
	[[ "$varDataToPreserve" == "" ]] && return
	
	export "$varNameToPreserve"="$varDataToPreserve"
	
	return
}


#####Installation

_installation_nonet_default() {
	if [[ "$nonet" != 'false' ]]
	then
		[[ "$scriptAbsoluteFolder" == /media/"$USER"* ]] && [[ -e /media/"$USER" ]] && export nonet='true'
		[[ "$scriptAbsoluteFolder" == /mnt/"$USER"* ]] && [[ -e /mnt/"$USER" ]] && export nonet='true'
		[[ "$scriptAbsoluteFolder" == /var/run/media/"$USER"* ]] && [[ -e /var/run/media/"$USER" ]] && export nonet='true'
		[[ "$scriptAbsoluteFolder" == /run/"$USER"* ]] && [[ -e /run/"$USER" ]] && currentParameter=/run/"$USER" && export nonet='true'
		[[ "$scriptAbsoluteFolder" == "/cygdrive"* ]] && [[ -e /cygdrive ]] && export nonet='true'
	fi
	
	return 0
}

_vector_line_cksum() {
	[[ $(echo test | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '935282863' ]] && echo 'broken cksum' && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n +2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '2409981071' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n +2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '9' ]] && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n 2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '763220757' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n 2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '2' ]] && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n 2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '1864731933' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n 2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '2' ]] && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n -2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '3336706933' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n -2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '8' ]] && _messageFAIL && _stop 1
	
	return 0
}

_vector() {
	_tryExec "_vector_line_cksum"
	
	
	_tryExec "_vector_virtUser"


	_tryExec "_vector_wget_githubRelease-URL-gh"
	
	
	_tryExec "_vector_ollama"
}




#Verifies the timeout and sleep commands work properly, with subsecond specifications.
_timetest() {
	local iterations
	local dateA
	local dateB
	local dateDelta
	
	local nsDateA
	local nsDateB
	local nsDateDelta
	
	iterations=0
	#while false && [[ "$iterations" -lt 3 ]]
	while [[ "$iterations" -lt 3 ]]
	do
		dateA=$(date +%s)
		nsDateA=$(date +%s%N)
		
		sleep 0.1
		sleep 0.1
		sleep 0.1
		sleep 0.1
		sleep 0.1
		sleep 0.1
		
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		
		dateB=$(date +%s)
		nsDateB=$(date +%s%N)
		
		dateDelta=$(bc <<< "$dateB - $dateA")
		nsDateDelta=$(bc <<< "$nsDateB - $nsDateA")
		
		if [[ "$dateDelta" -lt "1" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$dateDelta" -gt "5" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | wc -c) != '10' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$nsDateDelta" -lt '1000000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt 1000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '50000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt 5000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		
		
		
		
		dateA=$(date +%s)
		nsDateA=$(date +%s%N)
		
		sleep 0.123
		sleep 0.123
		sleep 0.123
		sleep 0.123
		sleep 0.123
		sleep 0.123
		
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		
		dateB=$(date +%s)
		nsDateB=$(date +%s%N)
		
		dateDelta=$(bc <<< "$dateB - $dateA")
		nsDateDelta=$(bc <<< "$nsDateB - $nsDateA")
		
		if [[ "$dateDelta" -lt "1" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$dateDelta" -gt "5" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | wc -c) != '10' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$nsDateDelta" -lt '1000000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt 1000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '50000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt 5000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		
		
		
		dateA=$(date +%s)
		nsDateA=$(date +%s%N)
		
		sleep .123
		sleep .123
		sleep .123
		sleep .123
		sleep .123
		sleep .123
		
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		
		dateB=$(date +%s)
		nsDateB=$(date +%s%N)
		
		dateDelta=$(bc <<< "$dateB - $dateA")
		nsDateDelta=$(bc <<< "$nsDateB - $nsDateA")
		
		if [[ "$dateDelta" -lt "1" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$dateDelta" -gt "5" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | wc -c) != '10' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$nsDateDelta" -lt '1000000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt 1000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '50000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt 5000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		
		
		
		let iterations="$iterations + 1"
	done
	
	
	local nsDateC
	local nsDateD
	local nsDateDeltaA
	local nsDateDeltaB
	local msIterations
	
	if uname -a | grep -i 'cygwin' > /dev/null 2>&1
	then
		nsDateA=$(date +%s%N)
		for msIterations in {1..100}
		do
			sleep 0.011
		done
		nsDateB=$(date +%s%N)
		
		#nsDateC=$(date +%s%N)
		nsDateC="$nsDateB"
		for msIterations in {1..100}
		do
			sleep 0.091
		done
		nsDateD=$(date +%s%N)
		
		nsDateDeltaA=$(bc <<< "$nsDateB - $nsDateA")
		nsDateDeltaB=$(bc <<< "$nsDateD - $nsDateC")
		nsDateDelta=$(bc <<< "$nsDateDeltaB - $nsDateDeltaA")
		
		#echo "$nsDateDelta"
		
		
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -lt '10000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '640000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt '1000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt '64000' ]]
		then
			_messageFAIL
			_stop 1
		fi
	else
		nsDateA=$(date +%s%N)
		for msIterations in {1..100}
		do
			sleep 0.001
		done
		nsDateB=$(date +%s%N)
		
		#nsDateC=$(date +%s%N)
		nsDateC="$nsDateB"
		for msIterations in {1..100}
		do
			sleep 0.009
		done
		nsDateD=$(date +%s%N)
		
		nsDateDeltaA=$(bc <<< "$nsDateB - $nsDateA")
		nsDateDeltaB=$(bc <<< "$nsDateD - $nsDateC")
		nsDateDelta=$(bc <<< "$nsDateDeltaB - $nsDateDeltaA")
		
		#echo "$nsDateDelta"
		
		
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -lt '10000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '640000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt '1000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt '64000' ]]
		then
			_messageFAIL
			_stop 1
		fi
	fi
	
	
	
	
	_messagePASS
	return 0
}


_testarglength() {
	local testArgLength
	
	! testArgLength=$(getconf ARG_MAX) && _messageFAIL && _stop 1
	
	
	# Typical UNIX.
	# && [[ "$testArgLength" != "" ]]
	if [[ "$testArgLength" -lt 131071 ]] && [[ "$testArgLength" != "-1" ]] && [[ "$testArgLength" != "undefined" ]]
	then

		# Typical Cygwin. Marginal result at best.
		[[ "$testArgLength" -ge 32000 ]] && uname -a | grep -i 'cygwin' > /dev/null 2>&1 && _messagePASS && return 0
		if _if_cygwin
		then
			# Fortunately, as of 2023-09-08 , from questions to the Cygwin mailing list, reportedly the undefined 'ARG_MAX' is a standards compliant delimiter of no limit except system resource limit.
			# Unfortunately, as of 2023-09-07 , apparently Cygwin has removed the 'ARG_MAX' definition from the provided 'getconf' .
			# Due to the narrower use case of Cygwin/MSW (as opposed to GNU/Linux) - not expecting to compile gEDA for Cygwin anytime soon - it will be more of a concern if other binaries in 'ubcp' cease to exist because newer versions of Cygwin packages upstream were failing to compile as a result. Hopefully, Cygwin itself has adequate testing to prevent release of such breakage.
			#echo "$testArgLength"
			return 0
		fi
		
		_messageFAIL && _stop 1
	fi
	
	_messagePASS
}



_variableLocalTestA_procedure() {
	local currentLocalA
	currentLocalA='false'
	[[ "$currentGlobalA" != 'true' ]] && _stop 1
	[[ "$currentLocalA" == '' ]] && _stop 1
	[[ "$currentLocalA" != 'false' ]] && _stop 1
	
	local currentLocalB
	currentLocalB='true'
	
	currentNotLocalA='true'
	
	
	return 0
}

_variableLocalTestB_procedure() {
	[[ "$currentGlobalA" != 'true' ]] && return 1
	[[ "$currentLocalA" != '' ]] && return 1
	[[ "$currentLocalA" == 'true' ]] && return 1
	
	return 0
}

_variableLocalTestC_procedure() {
	[[ "$currentGlobalA" != '' ]] && _stop 1
	[[ "$currentGlobalA" == 'true' ]] && _stop 1
	
	return 0
}

_variableLocalTest_sequence() {
	_start scriptLocal_mkdir_disable
	
	variableLocalTest_currentSubFunction() {
		if ! [[ "$currentSubFunctionTest" == "true" ]] || ! [[ $(echo "$currentSubFunctionTest") == "true" ]]
		then
			_stop 1
			return 1
		fi
		return 0
	}
	local currentSubFunctionTest
	currentSubFunctionTest='true'
	! variableLocalTest_currentSubFunction && _stop 1
	
	
	local currentSubshellTest1=$(
		echo x
	)
	[[ "$currentSubshellTest1" != 'x' ]] && _stop 1
	
	local currentSubshellTest2
	currentSubshellTest2=$(
		echo x
	)
	[[ "$currentSubshellTest2" != 'x' ]] && _stop 1
	
	
	echo $(
		echo 1
		echo 2
	) | grep '1 2' > /dev/null || _stop 1
	
	! echo $(
		echo 1
		echo 2
	) | grep '1 2' > /dev/null && _stop 1
	
	
	export currentGlobalA='true'
	
	local currentLocalA
	currentLocalA='true'
	
	( export currentSubshellTestA='true' )
	[[ ! -z "$currentSubshellTestA" ]] && _stop 1
	[[ "$currentSubshellTestA" != "" ]] && _stop 1
	[[ "$currentSubshellTestA" != '' ]] && _stop 1
	[[ "$currentSubshellTestA" == 'true' ]] && _stop 1
	
	( currentSubshellTestB='true' )
	[[ "$currentSubshellTestB" != "" ]] && _stop 1
	[[ "$currentSubshellTestB" == 'true' ]] && _stop 1
	
	( local currentSubshellTestC='true' )
	[[ "$currentSubshellTestC" != "" ]] && _stop 1
	[[ "$currentSubshellTestC" == 'true' ]] && _stop 1
	
	
	export currentGlobalSubshellTest="true"
	if [[ $( ( echo "$currentGlobalSubshellTest" ) ) != "true" ]]
	then
		_stop 1
	fi
	if [[ $( ( export currentGlobalSubshellTest="false" ; echo "$currentGlobalSubshellTest" ) ) != "false" ]]
	then
		_stop 1
	else
		true
	fi
	if [[ $( ( echo "$currentGlobalSubshellTest" ) ) != "true" ]]
	then
		_stop 1
	fi
	if [[ "$currentGlobalSubshellTest" != "true" ]]
	then
		_stop 1
	fi
	
	
	! ( echo true ) | grep 'true' > /dev/null && _stop 1
	! ( echo "$currentGlobalA" ) | grep 'true' > /dev/null && _stop 1
	! ( echo "$currentLocalA" ) | grep 'true' > /dev/null && _stop 1
	( echo "$currentLocalB" ) | grep 'true' > /dev/null && _stop 1
	
	[[ "$currentLocalA" != 'true' ]] && _stop 1
	! _variableLocalTestA_procedure && _stop 1
	[[ "$currentLocalA" != 'true' ]] && _stop 1
	[[ "$currentLocalB" != '' ]] && _stop 1
	[[ "$currentLocalB" == 'true' ]] && _stop 1
	[[ "$currentNotLocalA" != 'true' ]] && _stop 1
	
	_variableLocalTestB_procedure && _stop 1
	! "$scriptAbsoluteLocation" _variableLocalTestB_procedure && _stop 1
	
	local currentGlobalA
	! _variableLocalTestC_procedure && _stop 1
	
	export currentGlobalB='false'
	local currentGlobalB='true'
	[[ "$currentGlobalB" != 'true' ]] && _stop 1
	
	local currentLocalB='true'
	! ( echo "$currentLocalB" ) | grep 'true' > /dev/null && _stop 1
	[[ "$currentLocalB" != 'true' ]] && _stop 1
	
	local currentLocalC='true'
	[[ "$currentLocalC" != 'true' ]] && _stop 1
	
	! env -i  HOME="$HOME" TERM="${TERM}" SHELL="${SHELL}" PATH="${PATH}" PWD="$PWD" scriptAbsoluteLocation="$scriptAbsoluteLocation" scriptAbsoluteFolder="$scriptAbsoluteFolder" sessionid="$sessionid" LD_PRELOAD="$LD_PRELOAD" USER="$USER" "bash" -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i  HOME="$HOME" TERM="${TERM}" SHELL="${SHELL}" PATH="${PATH}" PWD="$PWD" scriptAbsoluteLocation="$scriptAbsoluteLocation" scriptAbsoluteFolder="$scriptAbsoluteFolder" sessionid="" LD_PRELOAD="$LD_PRELOAD" USER="$USER" "bash" -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i HOME="$HOME" TERM="${TERM}" SHELL="${SHELL}" PATH="${PATH}" PWD="$PWD" scriptAbsoluteLocation="$scriptAbsoluteLocation" scriptAbsoluteFolder="$scriptAbsoluteFolder" LD_PRELOAD="$LD_PRELOAD" USER="$USER" "bash" -c '[[ "$sessionid" != "" ]]' && _stop 1
	
	local currentBashBinLocation
	currentBashBinLocation=$(type -p bash)
	[[ "$sessionid" == '' ]] &&  _stop 1
	! env -i sessionid="$sessionid" "$currentBashBinLocation" -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i sessionid="" "$currentBashBinLocation" --norc -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i "$currentBashBinLocation" --norc -c '[[ "$sessionid" != "" ]]' && _stop 1
	
	
	
	local currentVariableFunctionText
	
	export UB_TEST_VARIABLE_FUNCTION_COMMAND='_variableFunction_variableLocalTest() { echo true; }'' ; _variableFunction_variableLocalTest'
	currentVariableFunctionText=$(bash -c "$UB_TEST_VARIABLE_FUNCTION_COMMAND")
	#currentVariableFunctionText=$($UB_TEST_VARIABLE_FUNCTION_COMMAND)
	[[ "$currentVariableFunctionText" != "true" ]] && _messageFAIL && _stop 1
	export UB_TEST_VARIABLE_FUNCTION_COMMAND=
	unset UB_TEST_VARIABLE_FUNCTION_COMMAND
	
	_exportFunction_variableLocalTest() {
		echo true
	}
	currentVariableFunctionText=$(bash -c '_exportFunction_variableLocalTest' 2>/dev/null)
	[[ "$currentVariableFunctionText" != "" ]] && _messageFAIL && _stop 1
	export -f _exportFunction_variableLocalTest
	currentVariableFunctionText=$(bash -c '_exportFunction_variableLocalTest' 2>/dev/null)
	[[ "$currentVariableFunctionText" != "true" ]] && _messageFAIL && _stop 1
	unset _exportFunction_variableLocalTest
	
	
	_currentFunctionDefinitionTest() { echo false; }
	true && _currentFunctionDefinitionTest() { echo true; }
	false && _currentFunctionDefinitionTest() { echo false; }
	[[ $(_currentFunctionDefinitionTest) != "true" ]] && _messageFAIL && _stop 1
	unset _currentFunctionDefinitionTest
	
	
	local doubleLocalDefinitionA
	doubleLocalDefinitionA=1
	local doubleLocalDefinitionA
	doubleLocalDefinitionA=2
	[[ "$doubleLocalDefinitionA" != "2" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA=3
	[[ "$doubleLocalDefinitionA" != "3" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA
	doubleLocalDefinitionA=4
	[[ "$doubleLocalDefinitionA" != "4" ]] && _messageFAIL && _stop 1
	export doubleLocalDefinitionA=5
	[[ "$doubleLocalDefinitionA" != "5" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA=6
	[[ "$doubleLocalDefinitionA" != "6" ]] && _messageFAIL && _stop 1
	doubleLocalDefinitionA=7
	[[ "$doubleLocalDefinitionA" != "7" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA=8
	[[ "$doubleLocalDefinitionA" != "8" ]] && _messageFAIL && _stop 1
	unset doubleLocalDefinitionA
	[[ "$doubleLocalDefinitionA" != "" ]] && _messageFAIL && _stop 1
	

	variableLocalTest_evalTest() { local currentVariableNum=1 ; eval local currentVariable_${currentVariableNum}_currentData=PASS ; ( eval "[[ \$currentVariable_${currentVariableNum}_currentData == PASS ]]" && eval "[[ \$currentVariable_${currentVariableNum}_currentData != '' ]]" && eval "echo \$currentVariable_${currentVariableNum}_currentData" ) ;} ; variableLocalTest_evalTest > /dev/null ; [[ $(variableLocalTest_evalTest) != "PASS" ]] && _messageFAIL && _stop 1


	! [[ $(currentVariable=currentValue /bin/bash --norc -c 'echoVariableTest() { echo $currentVariable ; } ; echoVariableTest') == "currentValue" ]] && _messageFAIL && _stop 1
	! [[ $(currentVariable=currentValue currentVariable=currentValue /bin/bash --norc -c 'echoVariableTest() { echo $currentVariable ; } ; echoVariableTest') == "currentValue" ]] && _messageFAIL && _stop 1
	! [[ $(currentVariable=currentValueA currentVariable=currentValueB /bin/bash --norc -c 'echoVariableTest() { echo $currentVariable ; } ; echoVariableTest') == "currentValueB" ]] && _messageFAIL && _stop 1

	_stop
}


_variableLocalTest() {
	if "$scriptAbsoluteLocation" _variableLocalTest_sequence "$@"
	then
		return 0
	fi
	return 1
}


_uid_test() {
	local current_uid_1
	local current_uid_2
	local current_uid_3
	
	current_uid_1=$(_uid)
	current_uid_2=$(_uid)
	current_uid_3_char=$(_uid 8 | wc -c)
	
	if [[ "$current_uid_1" == "" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ "$current_uid_2" == "" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ "$current_uid_1" == "$current_uid_2" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ "$current_uid_3_char" != "8" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	return 0
}


# Creating a function from within a function may be relied upon for some overrides.
# Enumerating a function's text with 'declare -f' may be relied upon by some 'here document' functions.
_define_function_test() {
	local current_uid_1
	current_uid_1=$(_uid)
	
	local current_uid_2
	current_uid_2=$(_uid)
	
	# https://stackoverflow.com/questions/7145337/bash-how-do-i-create-function-from-variable
	eval "__$current_uid_1() { __$current_uid_2() { echo $ubiquitousBashID; }; }"
	
	if [[ $(declare -f __$current_uid_1 | wc -c) -lt 50 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ $(declare -f __$current_uid_2 | wc -c) -gt 0 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	__$current_uid_1
	
	if [[ $(declare -f __$current_uid_2 | wc -c) -lt 15 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	# https://superuser.com/questions/154332/how-do-i-unset-or-get-rid-of-a-bash-function
	unset -f __$current_uid_2
	
	if [[ $(declare -f __$current_uid_2 | wc -c) -gt 0 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ $(declare -f __$current_uid_1 | wc -c) -lt 50 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	unset -f __$current_uid_1
	
	if [[ $(declare -f __$current_uid_1 | wc -c) -gt 0 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	
	return 0
}

#_test_prog() {
#	true
#}

_test_embed_procedure-embed() {
	#echo $ub_import
	#echo $ub_import_param
	
	[[ "$ub_import" != 'true' ]] && return 1
	[[ "$ub_import" == '' ]] && return 1
	[[ "$ub_import_param" != '--embed' ]] && return 1
	
	#_stop 0
	#return 0
	true
}

_test_embed_sequence() {
	_start scriptLocal_mkdir_disable
	
	#echo $ub_import
	#echo $ub_import_param
	
	# CAUTION: Profoundly unexpected to have called '_test' or similar functions after importing into a current shell in any way.
	if ( [[ "$current_internal_CompressedScript" == "" ]] && [[ "$current_internal_CompressedScript_cksum" == "" ]] && [[ "$current_internal_CompressedScript_bytes" == "" ]] ) || ( ( [[ "$ub_import_param" != "--embed" ]] ) && [[ "$ub_import_param" != "--bypass" ]] && [[ "$ub_import_param" != "--call" ]] && [[ "$ub_import_param" != "--script" ]] && [[ "$ub_import_param" != "--compressed" ]] )
	then
		[[ "$ub_import" == 'true' ]] && _messageFAIL && _stop 1
		[[ "$ub_import" != '' ]] && _messageFAIL && _stop 1
		[[ "$ub_import_param" != '' ]] && _messageFAIL && _stop 1
	fi
	
	! "$safeTmp"/.embed.sh _true && _stop 1
	
	"$safeTmp"/.embed.sh _false && _stop 1
	
	! "$safeTmp"/.embed.sh _test_embed_procedure-embed && _stop 1
	
	! . "$safeTmp"/.embed.sh _test_embed_procedure-embed && _stop 1
	
	_stop
}

_test_embed() {
	"$scriptAbsoluteLocation" _test_embed_sequence "$@"
}

_test_parallelFifo_procedure() {
	mkfifo "$safeTmp"/parallel_fifo
	cat "$safeTmp"/parallel_fifo > "$safeTmp"/parallel_fifo_out &
	
	local currentIterationsA
	currentIterationsA=0
	local currentIterationsB
	currentIterationsB=0
	
	while [[ "$currentIterationsA" -lt "2" ]]
	do
		echo a
		sleep 1
		let currentIterationsA="$currentIterationsA"" + 1"
	done | cat > "$safeTmp"/parallel_fifo &
	
	sleep 0.4
	
	while [[ "$currentIterationsB" -lt "2" ]]
	do
		echo b
		sleep 1
		let currentIterationsB="$currentIterationsB"" + 1"
	done | cat > "$safeTmp"/parallel_fifo
	
	sleep 1
	sleep 7
	
	
	#echo $(cat "$safeTmp"/parallel_fifo_out | tr -dc 'a-zA-Z0-9' 2> /dev/null)
	
	# WARNING: Strongly discouraged! Strict test highly dependent on unpredictable InterProcess-Communication timing requiring >7s latency margins at each 'step'!
	if _if_cygwin
	then
		[[ $(cat "$safeTmp"/parallel_fifo_out | tr -dc 'a-zA-Z0-9' 2> /dev/null) != "abab" ]] && _messageFAIL && return 1
	fi
	
	[[ $(cat "$safeTmp"/parallel_fifo_out | tr -dc 'a-zA-Z0-9' | wc -c) != "4" ]] && _messageFAIL && return 1
	
	
	rm -f "$safeTmp"/parallel_fifo
	rm -f "$safeTmp"/parallel_fifo_out
}

# No production use.
_test_parallelFifo_sequence() {
	_start scriptLocal_mkdir_disable
	
	_test_parallelFifo_procedure "$@"
	
	_stop
}

_test_pipe_true() {
	true | tee /dev/null 2>&1
}

# Apparently, shell script functions and conditions default to pipefail or pipestatus, although "$scriptAbsoluteLocation" is able to use the exit status instead.
_test_pipe_false() {
	false | tee /dev/null 2>&1
}
_test_pipe_false_condition() {
	#false | tee /dev/null 2>&1 && return 0
	false | echo stuff | grep stuff > /dev/null 2>&1 && return 0
	return 1
}
_test_pipe_false_condition_special() {
	false | tee /dev/null
	[[ "$?" == "0" ]] && return 0
	return 1
}

# Expect return true (ie. 0).
_test_pipefail_forcePlus_true_sequence() {
	set +o pipefail
	true | tee /dev/null 2>&1
}
_test_pipefail_forcePlus_true() {
	"$scriptAbsoluteLocation" _test_pipefail_forcePlus_true_sequence "$@"
}

# Expect return true (ie. 0).
_test_pipefail_forcePlus_false_sequence() {
	set +o pipefail
	false | tee /dev/null 2>&1
}
_test_pipefail_forcePlus_false() {
	"$scriptAbsoluteLocation" _test_pipefail_forcePlus_false_sequence "$@"
}

# Expect return true (ie. 0).
_test_pipefail_forceMinus_true_sequence() {
	set -o pipefail
	true | tee /dev/null 2>&1
}
_test_pipefail_forceMinus_true() {
	"$scriptAbsoluteLocation" _test_pipefail_forceMinus_true_sequence "$@"
}

# Expect return false (ie. 1).
_test_pipefail_forceMinus_false_sequence() {
	set -o pipefail
	false | tee /dev/null 2>&1
}
_test_pipefail_forceMinus_false() {
	"$scriptAbsoluteLocation" _test_pipefail_forceMinus_false_sequence "$@"
}

# https://stackoverflow.com/questions/6871859/piping-command-output-to-tee-but-also-save-exit-code-of-command
_test_pipestatus_true() {
	true | tee /dev/null 2>&1
	return ${PIPESTATUS[0]}
}

_test_pipestatus_false() {
	false | tee /dev/null 2>&1
	return ${PIPESTATUS[0]}
}

# ATTENTION: NOTICE: Regard this as a relatively definitive specification of known bash pipe 'exit status', 'pipestatus', 'pipefail', defaults and inheritance.
# WARNING: If 'bash' software interpreter uses same code paths (eg. for shell functions and subshells) do not assume this will always remain the case. Test and consider specifically and explicitly.
_test_pipefail_sequence_sequence() {
	if ! _test_pipefail_forcePlus_true || ! _test_pipefail_forcePlus_false || ! _test_pipefail_forceMinus_true_sequence || _test_pipefail_forceMinus_false_sequence
	then
		echo 'fail: pipefail'
		_stop 1
		return 1
	fi
	
	# NOTICE: Will FAIL if 'set -o pipefail' applies to script commands !
	if ! _test_pipestatus_true || _test_pipestatus_false || ! "$scriptAbsoluteLocation" _test_pipestatus_true || "$scriptAbsoluteLocation" _test_pipestatus_false
	then
		echo 'fail: pipestatus'
		_stop 1
		return 1
	fi
	
	
	
	# ATTENTION: Apparently, "$scriptAbsoluteLocation" is able to correctly retrieve the expected (ie. 0, true) exit status of both '_test_pipe_true' and '_test_pipe_false', although calling these functions directly results in the unexpected use of pipestatus, pipefail, or similar, etc.
	# CAUTION: While such defaults may seem slightly undesirable for shell scripts, there may be some benefit to command prompt use (especailly when functions are called from an interactive shell through such as ubiquitous_bash.sh _true , etc), UNIX pipe input programs (eg. cat /file) rarely if ever fail when a grep match would occur, and best practice of using a condition (ie. [[ -e /file ]]) before such pipes already avoids severe issues in shell script usage.
	# CAUTION: Ensure all pipe exit status, pipe status, and pipe fail, default behavior remains *strictly* as-is.
	
	
	
	# ATTENTION: ! _test_pipe_false ... would return true if consistent with behavior when called by "$scriptAbsoluteLocation"
	_test_pipe_false
	[[ "$?" == "0" ]] && echo 'fail: _test_pipe_false' && _stop 1 && return 1
	if _test_pipe_false
	then
		echo 'fail: _test_pipe_false'
		_stop 1
		return 1
	fi
	
	# ATTENTION: ! _test_pipe_false ... does return true if called by "$scriptAbsoluteLocation"
	! "$scriptAbsoluteLocation" _test_pipe_false
	[[ "$?" == "0" ]] && echo 'fail: ! "$scriptAbsoluteLocation" _test_pipe_false' && _stop 1 && return 1
	if ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: ! "$scriptAbsoluteLocation" _test_pipe_false'
		_stop 1
		return 1
	fi
	
	_test_pipe_false_condition
	[[ "$?" == "0" ]] && echo 'fail: _test_pipe_false_condition' && _stop 1 && return 1
	if _test_pipe_false_condition
	then
		echo 'fail: if: _test_pipe_false_condition'
		_stop 1
		return 1
	fi
	
	! "$scriptAbsoluteLocation" _test_pipe_false_condition
	[[ "$?" == "0" ]] && echo 'fail: ! "$scriptAbsoluteLocation" _test_pipe_false_condition' && _stop 1 && return 1
	if _test_pipe_false_condition
	then
		echo 'fail: if: ! "$scriptAbsoluteLocation" _test_pipe_false_condition'
		_stop 1
		return 1
	fi
	
	
	_test_pipe_false_condition_special
	[[ "$?" == "0" ]] && echo 'fail: _test_pipe_false_condition_special' && _stop 1 && return 1
	if _test_pipe_false_condition_special
	then
		echo 'fail: if: _test_pipe_false_condition_special'
		_stop 1
		return 1
	fi
	
	! "$scriptAbsoluteLocation" _test_pipe_false_condition_special
	[[ "$?" == "0" ]] && echo 'fail: ! "$scriptAbsoluteLocation" _test_pipe_false_condition_special' && _stop 1 && return 1
	if ! "$scriptAbsoluteLocation" _test_pipe_false_condition_special
	then
		echo 'fail: if: ! "$scriptAbsoluteLocation" _test_pipe_false_condition_special'
		_stop 1
		return 1
	fi
	
	"$scriptAbsoluteLocation" _test_pipe_false_condition_special
	[[ "$?" != "0" ]] && echo 'fail: "$scriptAbsoluteLocation" _test_pipe_false_condition_special' && _stop 1 && return 1
	if "$scriptAbsoluteLocation" _test_pipe_false_condition_special
	then
		true
	else
		echo 'fail: if: "$scriptAbsoluteLocation" _test_pipe_false_condition_special'
		_stop 1
		return 1
	fi
	
	
	#! _test_pipe_true || ! _test_pipe_false || ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	#! _test_pipe_false
	if ! _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: pipe: value'
		_stop 1
		return 1
	fi
	
	set +o pipefail
	# NOTICE: Will FAIL if 'set -o pipefail' applies to script commands !
	if ! _test_pipestatus_true || _test_pipestatus_false || ! "$scriptAbsoluteLocation" _test_pipestatus_true || "$scriptAbsoluteLocation" _test_pipestatus_false
	then
		echo 'fail: pipestatus'
		_stop 1
		return 1
	fi
	if ( true | tee /dev/null 2>&1 )
	then
		true
	else
		echo 'fail: if: pipe: pipefail: plus: subshell: true'
		_stop 1
		return 1
	fi
	if ( false | tee /dev/null 2>&1 )
	then
		true
	else
		echo 'fail: if: pipe: pipefail: plus: subshell: false'
		_stop 1
		return 1
	fi
	if ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: pipe: pipefail: plus'
		_stop 1
		return 1
	fi
	
	set -o pipefail
	# NOTICE: Will FAIL if 'set -o pipefail' applies to script commands !
	if ! _test_pipestatus_true || _test_pipestatus_false || ! "$scriptAbsoluteLocation" _test_pipestatus_true || "$scriptAbsoluteLocation" _test_pipestatus_false
	then
		echo 'fail: pipestatus'
		_stop 1
		return 1
	fi
	if ( true | tee /dev/null 2>&1 )
	then
		true
	else
		echo 'fail: if: pipe: pipefail: minus: subshell: true'
		_stop 1
		return 1
	fi
	# ATTENTION: Seems this actually is sensitive to 'set -o pipefail' .
	if ( false | tee /dev/null 2>&1 )
	then
		echo 'fail: if: pipe: pipefail: minus: subshell: false'
		_stop 1
		return 1
	else
		true
	fi
	if ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: pipe: pipefail: minus'
		_stop 1
		return 1
	fi
	return 0
}
_test_pipefail_sequence() {
	! "$scriptAbsoluteLocation" _test_pipefail_sequence_sequence "$@" && return 1
	
	set +o pipefail
	! "$scriptAbsoluteLocation" _test_pipefail_sequence_sequence "$@" && return 1
	
	set -o pipefail
	! "$scriptAbsoluteLocation" _test_pipefail_sequence_sequence "$@" && return 1
	
	return 0
}
_test_pipefail() {
	if ! "$scriptAbsoluteLocation" _test_pipefail_sequence "$@"
	then
		_messageFAIL
		_stop 1
		return 1
	fi
	"$scriptAbsoluteLocation" _test_pipefail_sequence "$@"
	if [[ "$?" != "0" ]]
	then
		_messageFAIL
		_stop 1
		return 1
	fi
}

# WARNING: Not necessarily tested by default, due to lack of use except where faults are tolerable, and slim possibility of useful embedded systems not able to pass.
_test_grep() {
	# If not known distribution/OS, do NOT test. Some embedded systems not able to pass may be nevertheless useful.
	! ( [[ -e /etc/issue ]] && cat /etc/issue | grep 'Debian\|Raspbian\|Ubuntu' > /dev/null 2>&1 ) && ! _if_cygwin && return 0
	
	
	
	! echo \$123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo \.123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	
	! echo 'qwerty.*123' | grep -xF 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty.*123' | grep -F 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty123' | grep -x 'q.*3' > /dev/null 2>&1 && _messageFAIL && return 1
	
	echo 'qwerty123' | grep -xF 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty.*123' | grep -xF 'qwerty123' > /dev/null 2>&1 && _messageFAIL && return 1
	
	echo 'qwerty123' | grep -xF 'qwerty' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -xF '123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -xF 'werty12' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	! echo 'qwerty123' | grep -x 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty.*123' | grep -x 'qwerty123' > /dev/null 2>&1 && _messageFAIL && return 1
	
	echo 'qwerty123' | grep -x 'qwerty' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -x '123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -x 'werty12' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	echo 'qwerty123' | grep -F 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty.*123' | grep -F 'qwerty123' > /dev/null 2>&1 && _messageFAIL && return 1
	
	! echo 'qwerty123' | grep -F 'qwerty' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty123' | grep -F '123' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty123' | grep -F 'werty12' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	
	return 0
}

_test_sanity() {
	if (exit 0)
	then
		true
	else
		_messageFAIL && return 1
	fi
	if ! (exit 0)
	then
		_messageFAIL && return 1
	fi
	if (exit 1)
	then
		_messageFAIL && return 1
	fi
	if (exit 2)
	then
		_messageFAIL && return 1
	fi
	if (exit 3)
	then
		_messageFAIL && return 1
	fi
	if (exit 126)
	then
		_messageFAIL && return 1
	fi
	if (exit 127)
	then
		_messageFAIL && return 1
	fi
	if (exit 128)
	then
		_messageFAIL && return 1
	fi
	if (exit 129)
	then
		_messageFAIL && return 1
	fi
	if (exit 130)
	then
		_messageFAIL && return 1
	fi
	if (exit 131)
	then
		_messageFAIL && return 1
	fi
	if (exit 132)
	then
		_messageFAIL && return 1
	fi
	if (exit 255)
	then
		_messageFAIL && return 1
	fi
	
	local currentSubReturnStatus
	(exit 0)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '0' ]] && _messageFAIL && return 1
	(exit 1)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '1' ]] && _messageFAIL && return 1
	(exit 2)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '2' ]] && _messageFAIL && return 1
	(exit 3)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '3' ]] && _messageFAIL && return 1
	
	
	# Do NOT allow 'rm' to be a shell function alias to 'rm -i' or similar.
	[[ $(type -p rm) == "" ]] && _messageFAIL && return 1
	
	
	! _test_pipefail && _messageFAIL && return 1
	
	
	
	
	#! [[ -2147483648 -lt 2147483647 ]] && _messageFAIL && return 1
	#! [[ -2000000000 -lt 2000000000 ]] && _messageFAIL && return 1
	
	! [[ -1234567890 -le -1234567890 ]] && _messageFAIL && return 1
	! [[ 1234567890 -le 1234567890 ]] && _messageFAIL && return 1
	! [[ -1234567890 -lt 1234567890 ]] && _messageFAIL && return 1
	! [[ -1234567890 -ge -1234567890 ]] && _messageFAIL && return 1
	! [[ 1234567890 -ge 1234567890 ]] && _messageFAIL && return 1
	! [[ 1234567890 -gt -1234567890 ]] && _messageFAIL && return 1
	! [[ -1234567890 -lt -0 ]] && _messageFAIL && return 1
	! [[ -1234567890 -lt 0 ]] && _messageFAIL && return 1
	! [[ 0 -lt 1234567890 ]] && _messageFAIL && return 1
	! [[ -0 -gt -1234567890 ]] && _messageFAIL && return 1
	! [[ 0 -gt -1234567890 ]] && _messageFAIL && return 1
	! [[ 0 -gt -1234567890 ]] && _messageFAIL && return 1
	
	! [[ -900000000 -le -900000000 ]] && _messageFAIL && return 1
	! [[ 900000000 -le 900000000 ]] && _messageFAIL && return 1
	! [[ -900000000 -lt 900000000 ]] && _messageFAIL && return 1
	! [[ -900000000 -ge -900000000 ]] && _messageFAIL && return 1
	! [[ 900000000 -ge 900000000 ]] && _messageFAIL && return 1
	! [[ 900000000 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ -900000000 -lt -0 ]] && _messageFAIL && return 1
	! [[ -900000000 -lt 0 ]] && _messageFAIL && return 1
	! [[ 0 -lt 900000000 ]] && _messageFAIL && return 1
	! [[ -0 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ 0 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ 0 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ 0 -le -0 ]] && _messageFAIL && return 1
	! [[ -0 -le 0 ]] && _messageFAIL && return 1
	! [[ 0 -ge -0 ]] && _messageFAIL && return 1
	! [[ -0 -ge 0 ]] && _messageFAIL && return 1
	
	
	
	! "$scriptAbsoluteLocation" _true && _messageFAIL && return 1
	"$scriptAbsoluteLocation" _false && _messageFAIL && return 1
	
	# CAUTION: Profoundly unexpected to have called '_test' or similar functions after importing into a current shell in any way.
	if ( [[ "$current_internal_CompressedScript" == "" ]] && [[ "$current_internal_CompressedScript_cksum" == "" ]] && [[ "$current_internal_CompressedScript_bytes" == "" ]] ) || ( ( [[ "$ub_import_param" != "--embed" ]] ) && [[ "$ub_import_param" != "--bypass" ]] && [[ "$ub_import_param" != "--call" ]] && [[ "$ub_import_param" != "--script" ]] && [[ "$ub_import_param" != "--compressed" ]] )
	then
		[[ "$ub_import" == 'true' ]] && _messageFAIL && _stop 1
		[[ "$ub_import" != '' ]] && _messageFAIL && _stop 1
		[[ "$ub_import_param" != '' ]] && _messageFAIL && _stop 1
	fi
	
	local santiySessionID_length
	santiySessionID_length=$(echo -n "$sessionid" | wc -c | tr -dc '0-9')
	
	[[ "$santiySessionID_length" -lt "18" ]] && _messageFAIL && return 1
	[[ "$uidLengthPrefix" != "" ]] && [[ "$santiySessionID_length" -lt "$uidLengthPrefix" ]] && _messageFAIL && return 1
	
	[[ -e "$safeTmp" ]] && _messageFAIL && return 1
	
	_start scriptLocal_mkdir_disable
	
	
	[[ ! -e "$safeTmp" ]] && _messageFAIL && return 1
	
	[[ $( cd "$safeTmp" 2>/dev/null ; ls *doNotMatch* 2>/dev/null | wc -c) != "0" ]] && _messageFAIL && return 1
	[[ $( cd "$safeTmp" 2>/dev/null ; ls -A *doNotMatch* 2>/dev/null | wc -c) != "0" ]] && _messageFAIL && return 1
	
	echo -e -n >> "$safeTmp"/empty
	[[ ! -e "$safeTmp"/empty ]] && _messageFAIL && return 1
	[[ $(cat "$safeTmp"/empty | wc -c) != '0' ]] && _messageFAIL && return 1
	
	[[ $( cd "$safeTmp" 2>/dev/null ; ls *empty* 2>/dev/null | wc -c) == "0" ]] && _messageFAIL && return 1
	[[ $( cd "$safeTmp" 2>/dev/null ; ls -A *empty* 2>/dev/null | wc -c) == "0" ]] && _messageFAIL && return 1
	
	rm -f "$safeTmp"/empty > /dev/null 2>&1
	
	
	! _test_moveconfirm_procedure && _messageFAIL && return 1
	
	
	local currentTestUID=$(_uid 245)
	mkdir -p "$safeTmp"/"$currentTestUID"
	echo > "$safeTmp"/"$currentTestUID"/"$currentTestUID"
	
	[[ ! -e "$safeTmp"/"$currentTestUID"/"$currentTestUID" ]] && _messageFAIL && return 1
	
	rm -f "$safeTmp"/"$currentTestUID"/"$currentTestUID"
	rmdir "$safeTmp"/"$currentTestUID"
	
	[[ -e "$safeTmp"/"$currentTestUID" ]] && _messageFAIL && return 1
	
	echo 'true' > "$safeTmp"/shouldNotOverwrite
	mv "$safeTmp"/doesNotExist "$safeTmp"/shouldNotOverwrite > /dev/null 2>&1 && _messageFAIL && return 1
	echo > "$safeTmp"/replacement
	mv -n "$safeTmp"/replacement "$safeTmp"/shouldNotOverwrite > /dev/null 2>&1
	[[ $(cat "$safeTmp"/shouldNotOverwrite) != "true" ]] && _messageFAIL && return 1
	rm -f "$safeTmp"/replacement > /dev/null 2>&1
	rm -f "$safeTmp"/shouldNotOverwrite > /dev/null 2>&1
	
	
	_uid_test
	
	[[ $(_getUUID | wc -c) != '37' ]] && _messageFAIL && return 1
	
	[[ $(_getUUID | cut -f1 -d\- | wc -c) != '9' ]] &&  _messageFAIL && return 1
	
	
	! env | grep 'PATH' > /dev/null 2>&1 && _messageFAIL && return 1
	! printenv | grep 'PATH' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	_define_function_test
	
	! _variableLocalTest && _messageFAIL && return 1
	
	
	
	mkdir -p "$safeTmp"/maydeletethisfolder
	[[ ! -d "$safeTmp"/maydeletethisfolder ]] && return 1
	echo > "$safeTmp"/maydeletethisfolder/maydeletethisfile
	[[ ! -e "$safeTmp"/maydeletethisfolder/maydeletethisfile ]] && return 1
	_safeRMR "$safeTmp"/maydeletethisfolder
	[[ -e "$safeTmp"/maydeletethisfolder/maydeletethisfile ]] && return 1
	[[ -e "$safeTmp"/maydeletethisfolder ]] && return 1
	
	
	
	_test_grep
	
	
	local currentJobsList
	currentJobsList=$(jobs -p -r)
	
	[[ "$currentJobsList" != "" ]] && return 1
	
	sleep 7 &
	currentJobsList=$(jobs -p -r)
	[[ "$currentJobsList" == "" ]] && return 1
	
	wait
	currentJobsList=$(jobs -p -r)
	[[ "$currentJobsList" != "" ]] && return 1
	
	
	echo -e -n "b" > "$safeTmp"/a
	[[ $(echo -e -n "c" | cat "$safeTmp"/a -) != "bc" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | cat "$safeTmp"/a /dev/stdin) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | cat "$safeTmp"/a /proc/self/fd/0) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | cat - "$safeTmp"/a) != "cb" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | cat /dev/stdin "$safeTmp"/a) != "cb" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | cat /proc/self/fd/0 "$safeTmp"/a) != "cb" ]] && _messageFAIL && _stop 1
	rm -f "$safeTmp"/a
	
	
	echo -e -n "b" > "$safeTmp"/a
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat "$safeTmp"/a - | tail -c 2) != "bc" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat "$safeTmp"/a /dev/stdin | tail -c 2) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat "$safeTmp"/a /proc/self/fd/0 | tail -c 2) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat - "$safeTmp"/a | tail -c 2) != "cb" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat /dev/stdin "$safeTmp"/a | tail -c 2) != "cb" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat /proc/self/fd/0 "$safeTmp"/a | tail -c 2) != "cb" ]] && _messageFAIL && _stop 1
	rm -f "$safeTmp"/a




	! (set -o pipefail; true | echo x | cat) > /dev/null 2>&1 && _messageFAIL && return 1
	(set -o pipefail; false | echo x | cat) > /dev/null 2>&1 && _messageFAIL && return 1

	[[ $(set -o pipefail; true | echo x | cat) != "x" ]] && _messageFAIL && return 1
	[[ $(set -o pipefail; false | echo x | cat) != "x" ]] && _messageFAIL && return 1

	! false | true && _messageFAIL && return 1
	false | true || _messageFAIL
	false | true || return 1
	true | false && _messageFAIL && return 1
	
	
	
	
	if ! _test_embed
	then
		_messageFAIL && _stop 1
		#! uname -a | grep -i cygwin > /dev/null 2>&1 && _messageFAIL && _stop 1
		#echo 'warn: broken (cygwin): _test_embed - cygwin detected'
	fi
	
	
	
	
	_getDep flock
	
	( flock 200; echo > "$safeTmp"/ready ; sleep 3 ) 200>"$safeTmp"/flock &
	sleep 1
	if ( flock 200; ! [[ -e "$safeTmp"/ready ]] ) 200>"$safeTmp"/flock
	then
		! uname -a | grep -i cygwin > /dev/null 2>&1 && _messageFAIL && _stop 1
		echo 'warn: broken (cygwin): flock - cygwin may not be able to use flock through MSW network drive'
		return 1
	fi
	rm -f "$safeTmp"/flock > /dev/null 2>&1
	rm -f "$safeTmp"/ready > /dev/null 2>&1
	
	ln -s /dev/null "$safeTmp"/working
	ln -s /dev/null/broken "$safeTmp"/broken
	if ! [[ -h "$safeTmp"/broken ]] || ! [[ -h "$safeTmp"/working ]] || [[ -e "$safeTmp"/broken ]] || ! [[ -e "$safeTmp"/working ]]
	then
		! uname -a | grep -i cygwin > /dev/null 2>&1 && _messageFAIL && _stop 1
		echo 'warn: broken (cygwin): flock - cygwin may not be able to use flock through MSW network drive'
		return 1
	fi
	rm -f "$safeTmp"/working
	rm -f "$safeTmp"/broken
	
	
	
	_tryExec _test_parallelFifo_procedure
	
	
	return 0
}



_test-shell-cygwin() {
	_messageNormal "Cygwin detected... MSW configuration issues..."
	
	
	local currentScriptTime
	if type _stopwatch > /dev/null 2>&1
	then
		if [[ -e "$scriptAbsoluteFolder"/ubiquitous_bash.sh ]]
		then
			currentScriptTime=$(_timeout 45 _stopwatch "$scriptAbsoluteFolder"/ubiquitous_bash.sh _true 2>/dev/null | tr -dc '0-9')
		else
			currentScriptTime=$(_timeout 45 _stopwatch "$scriptAbsoluteLocation" _true 2>/dev/null | tr -dc '0-9')
		fi
	else
		# If '_stopwatch' is not available, assume this is not an issue.
		currentScriptTime="2000"
	fi
	
	# Unusual, broken, non-desktop, etc user/login/account/etc configuration in MSW, might cause prohibitively long Cygwin delays.
	# MSW has a fragile track record, and cannot be used for combining complex applications (eg. flight sim) with 'enterprise' user/login/account/etc and/or deployment. Unless extensive testing conclusively shows a long track record otherwise, or unless MS has a direct commitment under a valuable contract to specifically ensure compatibility with such a use case, it would be obviously gross negligence to put a business at risk of unacceptable downtime from such a fragile stack. Any 'bonus' compensation so earned should incur liability for the disproportionate risk.
	# Enterprise must either use GNU/Linux, or similar, or maybe swap single-user preinstalled physical laptops/desktops.
	if [[ "$currentScriptTime" == "" ]]
	then
		echo 'fail: blank: currentScriptTime'
		_messageFAIL
	fi
	if ( [[ "$currentScriptTime" -gt '9500' ]] && [[ "$CI" == "" ]] ) || [[ "$currentScriptTime" -gt '20000' ]]
	then
		echo 'fail: slow: currentScriptTime: '"$currentScriptTime"
		_messageFAIL
	fi
	if [[ "$currentScriptTime" -gt '4500' ]]
	then
		echo 'warn: slow: currentScriptTime: '"$currentScriptTime"
		_messagePlain_request 'request: obtain a CPU with better single-thread performance, disable HyperThreading, disable EfficiencyCores, and/or reduce MSW OS installed functionality'
	fi
	
	
	local currentPathCount
	currentPathCount=$(echo "$PATH" | grep -o ':' | wc -l | tr -dc '0-9')
	#if [[ "$currentPathCount" -gt 50 ]]
	#if [[ "$currentPathCount" -gt 66 ]]
	if [[ "$currentPathCount" -gt 99 ]]
	then
		echo 'fail: count: PATH: '"$currentPathCount"
		_messageFAIL
	fi
	#if [[ "$currentPathCount" -gt 66 ]]
	if [[ "$currentPathCount" -gt 80 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH may be ignored'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	#if [[ "$currentPathCount" -gt 44 ]]
	if [[ "$currentPathCount" -gt 60 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH may be ignored'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	
	if [[ "$currentPathCount" -gt 48 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 48'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	if [[ "$currentPathCount" -gt 44 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 44'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	if [[ "$currentPathCount" -gt 32 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 32'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	if [[ "$currentPathCount" -gt 34 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 34'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	


	# Discouraged. NOT guaranteed, may be removed if unmaintainable.
	# Inheritance of variables as a means of communicating or passing parameters is not the point. Inheritance is tested to ensure an entirely different 'ubcp' environment, script, '$safeTmp', etc, is NOT used.
	export ub_sanity_special="mustInherit"
	if _if_cygwin
	then
		local currentResult
		currentResult=""

		local current_bin_bash
		current_bin_bash=$(cygpath -w /bin/bash)

		currentResult=$(cmd /C "$current_bin_bash" '-c' 'echo $ub_sanity_special')
		[[ "$currentResult" != "mustInherit" ]] && echo 'fail: cmd /bin/bash: mustInherit' && _messageFAIL && return 1

		currentResult=$(cmd /C "$current_bin_bash" '-c' 'echo "$safeTmp"')
		[[ "$currentResult" != "$safeTmp" ]] && echo 'fail: cmd /bin/bash: inherit: safeTmp' && _messageFAIL && return 1


		current_bin_bash=$(cygpath -w /bin/bash | sed 's/\\/\\\\/g')

		currentResult=$(_powershell -Command "$current_bin_bash"" -c 'echo "'"$ub_sanity_special"'"'")
		[[ "$currentResult" != "mustInherit" ]] && echo 'fail: powershell /bin/bash: mustInherit' && _messageFAIL && return 1

		currentResult=$(_powershell -Command "$current_bin_bash"" -c 'echo "'"$safeTmp"'"'")
		[[ "$currentResult" != "$safeTmp" ]] && echo 'fail: powershell /bin/bash: inherit: safeTmp' && _messageFAIL && return 1
	fi
	unset ub_sanity_special

	
	
	# Although use case specific (eg. flight sim with usual desktop applications installed) test cases may be necessary for MSW, to avoid ambiguity in expectations that every test includes an explicit PASS statement, a call to '_messagePASS' is still given.
	# Self-hosted 'runners' may be able to implement these test cases, with the resulting fragility reduced somewhat by another computer pulling frequent backups and artifacts.
	# Unusually, MSW may have use case specific issues due to a track record for configuration changes to the MSW OS causing prohibitive performance issues (eg. Cygwin being delayed more than tens of seconds possibly due to a program adding some kind of user account, some programs known to drastically increase frame dropping in intense applications, etc).
	_messagePASS
	
	
	return 0
}
_test-shell() {
	_installation_nonet_default
	
	# ATTENTION: As part of sanity test, "$safeTmp" must not exist until '_start scriptLocal_mkdir_disable' is called from within '_test_sanity' .
	#_start scriptLocal_mkdir_disable
	_messageNormal "Sanity..."
	_test_sanity && _messagePASS
	
	
	
	_messageNormal "Permissions..."
	! _test_permissions_ubiquitous && _messageFAIL
	_messagePASS
	
	#Environment generated by ubiquitous bash is typically 10000 characters.
	#echo -n -e '\E[1;32;46m Argument length...	\E[0m'
	_messageNormal 'Argument length...'
	_testarglength
	
	_messageNormal "Absolute pathfinding..."
	#if ! uname -a | grep -i cygwin > /dev/null 2>&1
	#then
		_tryExec "_test_getAbsoluteLocation"
	#fi
	_messagePASS
	
	
	if _if_cygwin
	then
		! _test-shell-cygwin && _messageFAIL
	fi
	
	
	return 0
}

_test() {
	_test-shell "$@"
	_installation_nonet_default
	
	if ! _typeDep sudo && [[ "$UID" == "0" ]]
	then
		if _typeDep 'apt-get'
		then
			apt-get -y update
			apt-get -y install sudo
		fi
	fi
	#! _typeDep sudo && _stop 1
	
	if ! _typeDep bc
	then
		if _typeDep 'apt-get'
		then
			sudo -n apt-get -y update
			sudo -n apt-get -y install bc
		fi
	fi
	! _typeDep bc && _stop 1
	
	if type _timetest > /dev/null 2>&1 && [[ "$devfast" != 'true' ]]
	then
		echo -n -e '\E[1;32;46m Timing...		\E[0m'
		echo
		
		# DANGER: Even under MSW/Cygwin, should ONLY fail IF extremely slow storage is attached.
		if type _test_selfTime > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_selfTime \E[0m'
			if ! _test_selfTime
			then
				if _if_cygwin
				then
					echo 'warn: accepted: cygwin: _test_selfTime broken'
				else
					echo '_test_selfTime broken'
					_stop 1
				fi
			fi
		fi
		
		if type _test_bashTime > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_bashTime \E[0m'
			! _test_bashTime && echo '_test_selfTime broken' && _stop 1
		fi
		
		if type _test_filemtime > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_filemtime \E[0m'
			! _test_filemtime && echo '_test_selfTime broken' && _stop 1
		fi
		
		if type _test_timeoutRead > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_timeoutRead \E[0m'
			! _test_timeoutRead && echo '_test_timeoutRead broken' && _stop 1
		fi

		echo -e '\E[0;36m Timing: true/false \E[0m'
		! _timeout 10 true && echo '! _timeout 10 true  broken' && _stop 1
		_timeout 10 false && echo '_timeout 10 false  broken' && _stop 1
		if type _stopwatch > /dev/null 2>&1
		then
    		! _stopwatch _timeout 10 true > /dev/null 2>&1 && echo '! _stopwatch _timeout 10 true  broken' && _stop 1
    		_stopwatch _timeout 10 false > /dev/null 2>&1 && echo '_stopwatch _timeout 10 false  broken' && _stop 1
		fi
		
		
		echo -e '\E[0;36m Timing: _timetest \E[0m'
		! _timetest && echo '_timetest broken' && _stop 1
	fi
	
	
	_messageNormal "Dependency checking..."
	
	## Check dependencies
	
	# WARNING: Although '#!/usr/bin/env bash' is used as header when possible, some high-speed 'heredoc' scripts may instead rely on '#!/bin/bash' or '#!/bin/dash' to ensure performance. For these important use cases, the typical '/bin/bash' and '/bin/dash' binary locations are required.
	_getDep /bin/bash
	! [[ -e /bin/bash ]] && echo '/bin/bash missing' && _stop 1
	! [[ -x /bin/bash ]] && echo '/bin/bash nonexecutable' && _stop 1
	_getDep /bin/dash
	! [[ -e /bin/dash ]] && echo '/bin/dash missing' && _stop 1
	! [[ -x /bin/dash ]] && echo '/bin/dash nonexecutable' && _stop 1
	
	#"generic/filesystem"/permissions.sh
	_checkDep stat
	
	_getDep cksum
	
	_getDep wget
	_getDep curl
	_wantGetDep aria2c
	_wantGetDep axel
	_getDep grep
	_getDep fgrep
	_getDep sed
	_getDep awk
	_getDep cut
	_getDep head
	_getDep tail
	
	_getDep seq
	
	_getDep wc
	
	_getDep fold
	
	
	! _compat_realpath && ! _wantGetDep realpath && echo 'realpath missing'
	_getDep readlink
	_getDep dirname
	_getDep basename
	
	_getDep sleep
	_getDep wait
	_getDep kill
	_getDep jobs
	_getDep ps
	_getDep exit
	
	_getDep env
	_getDep printenv
	_getDep bash
	_getDep echo
	_getDep cat
	_getDep tac
	_getDep type
	_getDep mkdir
	_getDep trap
	_getDep return
	_getDep set
	
	# WARNING: Deprecated. Migrate to 'type -p' instead when possible.
	# WARNING: No known production use.
	#https://unix.stackexchange.com/questions/85249/why-not-use-which-what-to-use-then
	_getDep which
	
	_getDep printf
	
	_getDep stat
	_getDep touch
	
	_getDep dd
	_wantGetDep blockdev
	_wantGetDep lsblk
	
	_getDep rm
	
	_getDep find
	_getDep ln
	_getDep ls
	
	_getDep id
	
	_getDep test
	
	_getDep true
	_getDep false
	
	_getDep diff
	
	_getDep uuidgen
	
	_getDep bc
	_getDep xxd
	_getDep od
	
	_getDep yes
	
	
	_getDep xargs
	
	
	
	_getDep perl
	
	
	# WARNING: Avoid if possible.
	# Not needed by 'ubiquitous_bash' itself up to at least commit 51ba42ed50b24a0e6eca749e8db7bee5c52cce47 .
	_wantGetDep expect
	
	
	_tryExec "_test_python"
	_tryExec "_test_haskell"
	
	
	
	_test_readlink_f
	
	_tryExec "_test_package"
	
	_tryExec "_test_daemon"
	
	_tryExec "_testFindPort"
	_tryExec "_test_waitport"
	
	
	_tryExec "_test_gitBest"
	
	_tryExec "_test_fw"
	_tryExec "_test_hosts"
	
	_tryExec "_testProxySSH"
	
	_tryExec "_testAutoSSH"
	
	_tryExec "_testTor"
	
	_tryExec "_testProxyRouter"
	
	#_tryExec "_test_build"
	
	_tryExec "_testGosu"
	
	_tryExec "_testMountChecks"
	_tryExec "_testBindMountManager"
	_tryExec "_testDistro"
	_tryExec "_test_fetchDebian"
	
	_tryExec "_test_image"
	_tryExec "_test_transferimage"
	
	_tryExec "_testCreatePartition"
	_tryExec "_testCreateFS"
	
	_tryExec "_test_mkboot"
	
	_tryExec "_test_abstractfs"
	_tryExec "_test_fakehome"
	_tryExec "_testChRoot"
	_tryExec "_testQEMU"
	_tryExec "_testQEMU_x64-x64"
	_tryExec "_testQEMU_x64-raspi"
	_tryExec "_testQEMU_raspi-raspi"
	_tryExec "_testVBox"
	
	_tryExec "_test_vboxconvert"
	
	_tryExec "_test_dosbox"
	
	_tryExec "_testWINE"
	
	_tryExec "_test_docker"
	
	_tryExec "_test_docker_mkimage"
	
	_tryExec "_testVirtBootdisc"
	
	_tryExec "_test_live"
	
	_tryExec "_testExtra"
	
	_tryExec "_testGit"
	
	_tryExec "_test_bup"
	
	_tryExec "_testX11"
	
	_tryExec "_test_virtLocal_X11"
	
	_tryExec "_test_search"
	
	_tryExec "_test_packetDriveDevice"
	_tryExec "_test_gparted"


	_tryExec "_test_wsl2_internal"

	
	# WARNING: Disabled by default. Newer FLOSS (ie. 'barrier'), seems to have displaced the older 'synergy' software.
	# ATTENTION: Override with 'ops' or similar.
	# More portable computing (ie. better laptops) and hardware (eg. mechanical) USB switches are also displacing the usefulness of such keyboard/mouse sharing software.
	#_tryExec "_test_synergy"
	
	
	
	_tryExec "_test_ollama"
	
	
	
	_tryExec "_test_devqalculate"
	_tryExec "_test_devgnuoctave"
	
	
	
	_tryExec "_test_devatom"
	_tryExec "_test_devemacs"
	_tryExec "_test_deveclipse"
	
	
	_tryExec "_test_h1060p"
	
	
	_tryExec "_test_ethereum"
	_tryExec "_test_ethereum_parity"
	
	
	
	_tryExec "_test_mktorrent"
	
	
	_tryExec "_test_cloud"
	
	_tryExec "_test_rclone"
	_tryExec "_test_croc"
	
	_tryExec "_test_terraform"
	
	
	_tryExec "_test_vagrant_build"
	
	
	
	_tryExec "_test_rclone_limited"
	
	
	
	_tryExec "_test_kernelConfig"
	
	
	_tryExec "_test_clog"
	
	_tryExec "_test_metaengine"
	
	_tryExec "_test_channel"
	
	_tryExec "_test_nix-env"
	
	
	! [[ -e /dev/urandom ]] && echo /dev/urandom missing && _stop 1
	[[ $(_timeout 3 cat /dev/urandom 2> /dev/null | _timeout 3 base64 2> /dev/null | _timeout 3 tr -dc 'a-zA-Z0-9' 2> /dev/null | _timeout 3 head -c 18 2> /dev/null) == "" ]] && echo /dev/urandom fail && _stop 1
	
	_messagePASS
	
	if type _test_queue > /dev/null 2>&1 && [[ "$devfast" != 'true' ]]
	then
		_messageNormal "Queue..."
		
		_tryExec '_test_queue'
		
		# DANGER: Even under MSW/Cygwin, should ONLY fail IF extremely slow storage is attached.
		echo -e '\E[0;36m Queue: _test_broadcastPipe_page \E[0m'
		if ! _test_broadcastPipe_page
		then
			if _if_cygwin
			then
				echo 'warn: accepted: cygwin: _test_broadcastPipe_page broken'
			else
				echo '_test_broadcastPipe_page broken'
				_stop 1
			fi
		fi
		
		# DANGER: Even under MSW/Cygwin, should ONLY fail IF extremely slow storage is attached.
		echo -e '\E[0;36m Queue: _test_broadcastPipe_aggregatorStatic \E[0m'
		if ! _test_broadcastPipe_aggregatorStatic
		then
			if _if_cygwin
			then
				#echo 'warn: accepted: cygwin: _test_broadcastPipe_aggregatorStatic broken'
				echo '_test_broadcastPipe_aggregatorStatic broken'
				_stop 1
			else
				echo '_test_broadcastPipe_aggregatorStatic broken'
				_stop 1
			fi
		fi
		
		_messagePASS
	fi
	
	_messageNormal 'Vector...'
	_vector
	_messagePASS
	
	_tryExec "_test_prog"
	
	
	_stop
}

#_testBuilt_prog() {
#	true
#}

_testBuilt() {
	_start scriptLocal_mkdir_disable
	
	_messageProcess "Binary checking"
	
	_tryExec "_testBuiltIdle"
	_tryExec "_testBuiltGosu"	#Note, requires sudo, not necessary for docker .
	
	_tryExec "_test_ethereum_built"
	_tryExec "_test_ethereum_parity_built"
	
	_tryExec "_testBuiltChRoot"
	_tryExec "_testBuiltQEMU"
	
	_tryExec "_testBuiltExtra"
	
	_tryExec "_testBuilt_prog"
	
	_messagePASS
	
	_stop
}

#Creates symlink in "$HOME"/bin, to the executable at "$1", named according to its residing directory and file name.
_setupCommand() {
	mkdir -p "$HOME"/bin
	! [[ -e "$HOME"/bin ]] && return 1
	
	local clientScriptLocation
	clientScriptLocation=$(_getAbsoluteLocation "$1")
	
	local clientScriptFolder
	clientScriptFolder=$(_getAbsoluteFolder "$1")
	
	local commandName
	commandName=$(basename "$1")
	
	local clientName
	clientName=$(basename "$clientScriptFolder")
	
	_relink_relative "$clientScriptLocation" "$HOME"/bin/"$commandName""-""$clientName"
	
	
}

_setupCommand_meta() {
	mkdir -p "$HOME"/bin
	! [[ -e "$HOME"/bin ]] && return 1
	
	local clientScriptLocation
	clientScriptLocation=$(_getAbsoluteLocation "$1")
	
	local clientScriptFolder
	clientScriptFolder=$(_getAbsoluteFolder "$1")
	
	local clientScriptFolderResidence
	clientScriptFolderResidence=$(_getAbsoluteFolder "$clientScriptFolder")
	
	local commandName
	commandName=$(basename "$1")
	
	local clientName
	clientName=$(basename "$clientScriptFolderResidence")
	
	_relink_relative "$clientScriptLocation" "$HOME"/bin/"$commandName""-""$clientName"
	
	
}

_find_setupCommands() {
	find -L "$scriptAbsoluteFolder" -not \( -path \*_arc\* -prune \) -not \( -path \*__disk\* -prune \) -not \( -path \*/_local/h/\* -prune \) -not \( -path \*/_local/fs/\* -prune \) -not \( -path \*/_local/ubcp/\* -prune \) "$@"
}

#Consider placing files like ' _vnc-machine-"$netName" ' in an "_index" folder for automatic installation.
_setupCommands() {
	#_find_setupCommands -name '_command' -exec "$scriptAbsoluteLocation" _setupCommand '{}' \;
	
	_tryExec "_setup_ssh_commands"
	_tryExec "_setup_command_commands"
}

#_setup_pre() {
#	true
#}

#_setup_prog() {
#	true
#}


_setup_anchor() {
	if ! _if_cygwin && [[ "$objectName" == "ubiquitous_bash" ]]
	then
		# WARNING: End user file association. Do NOT call within scripts.
		# WARNING: Necessarily relies on a 'deprecated' 'field code' with the 'Exec key' of a 'Desktop Entry' file association.
		# https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html
		_messagePlain_request 'association: *.bat'
		echo 'konsole --workdir %d -e /bin/bash %f (open in graphical terminal emulator from file manager)'
		echo 'bash'
	fi
	
	if type "_associate_anchors_request" > /dev/null 2>&1
	then
		_tryExec "_associate_anchors_request"
		return
	fi
}

_setup() {
	_installation_nonet_default
	
	_start scriptLocal_mkdir_disable
	
	"$scriptAbsoluteLocation" _test || _stop 1
	
	#Only attempt build procedures if their functions have been defined from "build.sh" . Pure shell script projects (eg. CoreAutoSSH), and projects using only statically compiled binaries, need NOT include such procedures.
	local buildSupported
	type _build > /dev/null 2>&1 && type _test_build > /dev/null 2>&1 && buildSupported="true"
	
	[[ "$buildSupported" == "true" ]] && ! "$scriptAbsoluteLocation" _test_build && _stop 1
	
	if ! "$scriptAbsoluteLocation" _testBuilt
	then
		! [[ "$buildSupported" == "true" ]] && _stop 1
		[[ "$buildSupported" == "true" ]] && ! "$scriptAbsoluteLocation" _build "$@" && _stop 1
		! "$scriptAbsoluteLocation" _testBuilt && _stop 1
	fi
	
	_setupCommands
	
	_tryExec "_setup_pre"
	
	_tryExec "_setup_ssh"
	
	_tryExec "_setup_prog"
	
	_setup_anchor
	
	_stop
}

# DANGER: Especially not expected to modify system program behavior (eg. not to modify "$HOME"/.ssh ).
# WARNING: Strictly expected to not modify anyting outside the script directory.
_setup_local() {
	export ub_setup_local='true'
	
	_setup
}

_test_package() {
	_getDep tar
	_getDep gzip
	
	_getDep xz
}

_package_prog() {
	true
}


_package_ubcp_copy_copy() {
	#cp -a "$1" "$2"
	if [[ "$ubPackage_enable_ubcp" != 'true' ]]
	then
		if [[ "$skimfast" != "true" ]]
		then
			rsync -av --progress --exclude "/ubcp/conemu" --exclude "/ubcp/cygwin" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		else
			rsync -a --exclude "/ubcp/conemu" --exclude "/ubcp/cygwin" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		fi
	else
		if [[ "$skimfast" != "true" ]]
		then
			rsync -av --progress --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		else
			rsync -a --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		fi
	fi
	
	
	rm -f "$safeTmp"/package/_local/package_ubcp-cygwinOnly.tar.gz
	rm -f "$safeTmp"/package/_local/package_ubcp-cygwinOnly.tar.xz
	rm -f "$safeTmp"/package/_local/package_ubcp-cygwinOnly.tar.flx
	rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
	rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.xz
	rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.flx
	
	return 0
}

# ATTENTION: Override with 'installation_prog.sh' or similar.
_package_ubcp_copy_prog() {
	false
	
	cd "$outerPWD"
	return 1
	_stop 1
}

_package_ubcp_copy() {
	mkdir -p "$safeTmp"/package/_local
	
	if [[ -e "$scriptLocal"/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLocal"/ubcp "$safeTmp"/package/_local/
		return 0
	fi
	if [[ -e "$scriptLib"/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	if [[ -e "$scriptAbsoluteFolder"/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptAbsoluteFolder"/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	
	
	if [[ -e "$scriptLib"/ubiquitous_bash/_local/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubiquitous_bash/_local/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	if [[ -e "$scriptLib"/ubiquitous_bash/_lib/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubiquitous_bash/_lib/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	if [[ -e "$scriptLib"/ubiquitous_bash/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubiquitous_bash/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	
	# ATTENTION: Override with 'installation_prog.sh' or similar.
	if _package_ubcp_copy_prog
	then
		return 0
	fi
	
	
	cd "$outerPWD"
	_stop 1
}

# ATTENTION: Override with 'ops' or similar ONLY if necessary.
_package_subdir() {
	#return 0
	
	# ATTENTION: Error message about 'cannot move' ... 'subdirectory of itself' ... is normal .
	mkdir -p "$safeTmp"/package/"$objectName"_tmp/
	( shopt -s dotglob ; mv "$safeTmp"/package/* "$safeTmp"/package/"$objectName"_tmp/ )
	mv "$safeTmp"/package/"$objectName"_tmp "$safeTmp"/package/"$objectName"
}

# WARNING Must define "_package_license" function in ops to include license files in package!
_package_procedure() {
	_start scriptLocal_mkdir_disable
	mkdir -p "$safeTmp"/package
	
	# May not have any effect - Cygwin symlinks should be transparent to 'tar' and similar.
	_force_cygwin_symlinks
	
	# WARNING: Largely due to presence of '.gitignore' files in 'ubcp' .
	export safeToDeleteGit="true"
	
	_package_prog
	
	_tryExec "_package_license"
	
	_tryExec "_package_cautossh"
	
	#cp -a "$scriptAbsoluteFolder"/.git "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/.gitignore "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/.gitmodules "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/COPYING "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/COPYING* "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/gpl.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/gpl-*.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/gpl-3.0.txt "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/agpl.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/agpl-*.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/agpl-3.0.txt "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/license.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/license*.txt "$safeTmp"/package/ > /dev/null 2>&1
	
	#scriptBasename=$(basename "$scriptAbsoluteLocation")
	#cp -a "$scriptAbsoluteLocation" "$safeTmp"/package/"$scriptBasename"
	cp -a "$scriptAbsoluteLocation" "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/ops "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/ops.sh "$safeTmp"/package/
	
	cp "$scriptAbsoluteFolder"/_* "$safeTmp"/package/
	cp "$scriptAbsoluteFolder"/*.sh "$safeTmp"/package/
	cp "$scriptAbsoluteFolder"/*.py "$safeTmp"/package/
	
	cp -a "$scriptLocal"/ops "$safeTmp"/package/
	cp -a "$scriptLocal"/ops.sh "$safeTmp"/package/
	
	#cp -a "$scriptAbsoluteFolder"/_bin "$safeTmp"
	#cp -a "$scriptAbsoluteFolder"/_config "$safeTmp"
	#cp -a "$scriptAbsoluteFolder"/_prog "$safeTmp"
	
	#cp -a "$scriptAbsoluteFolder"/_local "$safeTmp"/package/
	
	cp -a "$scriptAbsoluteFolder"/README.md "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/USAGE.html "$safeTmp"/package/
	
	cp -a "$scriptAbsoluteFolder"/README.sh "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/README.html "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/README.pdf "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/README.md "$safeTmp"/package/
	
	
	cp -a "$scriptAbsoluteFolder"/_config "$safeTmp"/package/
	
	
	cp -a "$scriptAbsoluteFolder"/_bin "$safeTmp"/package/
	
	
	cp "$scriptAbsoluteFolder"/fork "$safeTmp"/package/
	
	
	rm -f "$safeTmp"/package/devtask* > /dev/null 2>&1
	rm -f "$safeTmp"/package/__d_* > /dev/null 2>&1
	rm -f "$safeTmp"/package/_d_* > /dev/null 2>&1
	
	
	#if [[ "$ubPackage_enable_ubcp" == 'true' ]]
	#then
		#_package_ubcp_copy "$@"
	#fi
	
	_package_ubcp_copy "$@"
	if [[ "$ubPackage_enable_ubcp" != 'true' ]]
	then
		_safeRMR "$safeTmp"/package/_local/ubcp/conemu
		_safeRMR "$safeTmp"/package/_local/ubcp/cygwin
	fi
	
	cd "$safeTmp"/package/
	_package_subdir
	
	#! [[ "$ubPackage_enable_ubcp" == 'true' ]] && env GZIP=-9 tar -czvf "$scriptAbsoluteFolder"/package.tar.gz .
	! [[ "$ubPackage_enable_ubcp" == 'true' ]] && env XZ_OPT=-e9 tar -cJvf "$scriptAbsoluteFolder"/package.tar.xz .
	#[[ "$ubPackage_enable_ubcp" == 'true' ]] && env GZIP=-9 tar -czvf "$scriptAbsoluteFolder"/package_ubcp.tar.gz .
	#[[ "$ubPackage_enable_ubcp" == 'true' ]] && env XZ_OPT=-e9 tar -cJvf "$scriptAbsoluteFolder"/package_ubcp.tar.xz .
	[[ "$ubPackage_enable_ubcp" == 'true' ]] && env XZ_OPT="-5 -T0" tar -cJvf "$scriptAbsoluteFolder"/package_ubcp.tar.xz .
	
	if [[ "$ubPackage_enable_ubcp" == 'true' ]]
	then
		_messagePlain_request 'request: review contents of _local/ubcp/cygwin/home and similar directories'
	fi
	
	cd "$outerPWD"
	_stop
}

_package() {
	export ubPackage_enable_ubcp='false'
	"$scriptAbsoluteLocation" _package_procedure "$@"
	
	export ubPackage_enable_ubcp='true'
	"$scriptAbsoluteLocation" _package_procedure "$@"
}








_test_prog() {
    _wantGetDep dh_auto_configure

    _wantGetDep dh-exec

    _wantGetDep sbsign

    _wantGetDep kernel-wedge
}






# Attempts to reduce adding the necessary Debian packages, from ~5minutes , to much less . However, in practice, '_getMinimal_cloud' , is already very minimal.
# Relies on several assumptions:
#  _setupUbiquitous   has definitely always already been called
#  apt-fast   either is or is not available, hardcoded




_getMinimal_cloud_mirage335KernelBuild_backend() {
    _messagePlain_probe "$@"
    sudo -n env XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -q --install-recommends -y "$@"
}

_getMinimal_cloud_mirage335KernelBuild() {
    echo 'APT::AutoRemove::RecommendsImportant "true";
APT::AutoRemove::SuggestsImportant "true";' | sudo -n tee /etc/apt/apt.conf.d/99autoremove-recommends > /dev/null

    #dpkg --add-architecture i386
    #apt-get update
    #libc6:i386 lib32z1
    
    _getMinimal_cloud_mirage335KernelBuild_backend --reinstall wget

    ##xz btrfs-tools grub-mkstandalone mkfs.vfat mkswap mmd mcopy mksquashfs
    #gpg pigz curl gdisk lz4 mawk jq gawk build-essential autoconf pkg-config bsdutils findutils patch tar gzip bzip2 sed lua-lpeg axel aria2 gh rsync pv expect libfuse2 udftools debootstrap cifs-utils dos2unix xxd debhelper p7zip nsis jp2a btrfs-progs btrfs-compsize zstd zlib1g coreutils util-linux kpartx openssl growisofs udev gdisk parted bc e2fsprogs xz-utils libreadline8 mkisofs genisoimage byobu xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils
    ##dnsutils bind9-dnsutils bison libelf-dev elfutils flex libncurses-dev libudev-dev dwarves pahole cmake sockstat liblinear4 liblua5.3-0 nmap nmap-common socat dwarves pahole libssl-dev cpio libgtk2.0-0 libwxgtk3.0-gtk3-0v5 wipe iputils-ping nilfs-tools python3 sg3-utils cryptsetup php
    ##qemu-system-x86
    ##qemu-user qemu-utils
    #_getMinimal_cloud_mirage335KernelBuild_backend gpg pigz curl gdisk lz4 mawk jq gawk build-essential autoconf pkg-config bsdutils findutils patch tar gzip bzip2 sed lua-lpeg axel aria2 gh rsync pv expect libfuse2 udftools debootstrap cifs-utils dos2unix xxd debhelper p7zip nsis jp2a btrfs-progs btrfs-compsize zstd zlib1g coreutils util-linux kpartx openssl growisofs udev gdisk parted bc e2fsprogs xz-utils libreadline8 mkisofs genisoimage byobu xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils

    _getMinimal_cloud_mirage335KernelBuild_backend sudo gpg wget pigz dnsutils bind9-dnsutils curl gdisk parted lz4 mawk jq gawk build-essential bison libelf-dev elfutils flex libncurses-dev autoconf libudev-dev dwarves pahole cmake pkg-config bsdutils findutils patch tar gzip bzip2 flex sed sockstat liblinear4 liblua5.3-0 lua-lpeg nmap nmap-common socat axel aria2 gh rsync libssl-dev cpio pv expect libfuse2 cifs-utils dos2unix xxd debhelper p7zip iputils-ping btrfs-progs btrfs-compsize zstd zlib1g nilfs-tools coreutils python3 util-linux kpartx openssl udev cryptsetup bc e2fsprogs xz-utils libreadline8 byobu squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils trousers tpm-tools

    _messagePlain_probe apt-get remove --autoremove -y plasma-discover
    sudo -n env XZ_OPT="-T0" DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" remove --autoremove -y plasma-discover

    _messagePlain_probe _custom_splice_opensslConfig
	_here_opensslConfig_legacy | sudo -n tee /etc/ssl/openssl_legacy.cnf > /dev/null 2>&1

    if ! sudo -n grep 'openssl_legacy' /etc/ssl/openssl.cnf > /dev/null 2>&1
    then
        sudo -n cp -f /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.orig
        echo '


.include = /etc/ssl/openssl_legacy.cnf

' | sudo -n cat /etc/ssl/openssl.cnf.orig - | sudo -n tee /etc/ssl/openssl.cnf > /dev/null 2>&1
    fi

    true
}
# WARNING: Forces all workflows to use this specialized function by default . Beware the possibility of external assumptions breaking very long build jobs.
if [[ "$getfast" != "false" ]] || [[ "$getfast" == "" ]] || [[ "$getfast" == "true" ]]
then
    _getMinimal_cloud() {
        _getMinimal_cloud_mirage335KernelBuild "$@"
    }
fi






##### Core


_test_build_kernel() {
	_getDep wget
	_getDep axel
	
	_getDep gcc
	_getDep g++
	_getDep make
	
	_getDep ld
	
	_getDep patch
	
	_getDep gpg
	
	_getDep tar
	_getDep xz
	_getDep gzip
	_getDep bzip2
	
	_getDep pahole
	
	_getDep lz4
	_getDep lz4c
	
	_getDep bison
	_getDep flex
	
	_getDep libelf.so
	_getDep gelf.h
	_getDep eu-strip
	
	_getDep rsync
	
	_test_kernelConfig
}



# ATTRIBUTION-AI: ChatGPT o1 2025-01-11 , 2025-01-17 ... suggested Debian package postprocessing.
_supplement_kernel_debPkg-dpkg_sequence() {
	_messagePlain_nominal 'init: _supplement_kernel_debPkg-dpkg_sequence'

	local currentFile="$1"
	_messagePlain_probe_var currentFile

	local currentConfigDir="$2"
	_messagePlain_probe_var currentConfigDir
	
	_start
	mkdir -p "$safeTmp"/kernel-headers
	
	_messagePlain_probe_cmd dpkg-deb -R "$currentFile" "$safeTmp"/kernel-headers

	# ATTENTION: Usually there will be only one matching destination. Mostly, the for loop is used due to the especially unpredictable directory naming.
	local currentDestination
	for currentDestination in "$safeTmp"/kernel-headers/usr/src/linux-headers-*
	do
		_messagePlain_probe_cmd cp -a "$currentConfigDir"/.config "$currentDestination"/
	done


	sudo -n chown -R root:root "$safeTmp"/kernel-headers

	rm -f "$currentFile"
	_messagePlain_probe_cmd sudo -n dpkg-deb --build --root-owner-group "$safeTmp"/kernel-headers "$currentFile"

	sudo -n chown "$USER":"$USER" "$currentFile"

	sudo -n chown -R "$USER":"$USER" "$safeTmp"/kernel-headers

	_stop
}
_supplement_kernel_debPkg_sequence() {
	local functionEntryPWD
	functionEntryPWD="$PWD"

	_messagePlain_nominal 'init: _supplement_kernel_debPkg_sequence'
	
	local currentFile

	local currentExitStatus
	currentExitStatus=1
	
	# ATTENTION: Usually there will be only one matching filename. Most of the reason for using a for loop is unpredictable filenames, such as the apparently used "$currentKernel_version_$currentKernel_version" pattern, or the "$currentKernel_version"'_mainline', etc, patterns.
	# Expected to begin in the same directory as "make deb-pkg" , Debian package files expected at '../' .
	for currentFile in ../linux-headers-"$currentKernel_version"*.deb
	do
		_messagePlain_probe_cmd "$scriptAbsoluteLocation" _supplement_kernel_debPkg-dpkg_sequence "$currentFile" "$functionEntryPWD"
		currentExitStatus="$?"
	done

	cd "$functionEntryPWD"
	return "$currentExitStatus"
}
_supplement_kernel_debPkg() {
	"$scriptAbsoluteLocation" _supplement_kernel_debPkg_sequence "$@"
}



_fetchKernel-lts-legacyHTTPS() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/lts/*.tar.xz > /dev/null 2>&1
	_safeRMR "$scriptLocal"/lts
	
	mkdir -p "$scriptLocal"/lts
	cd "$scriptLocal"/lts
	
	#currentKernelURL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.61.tar.xz"
	export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep '6\.1\.' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
	export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
	export currentKernelPath="$scriptLocal"/lts/"$currentKernelName"
	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		wget "$currentKernelURL"
		tar xf "$currentKernelName"*
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/lts/
	cp "$scriptLib"/linux/lts/.config "$scriptLocal"/lts/"$currentKernelName"/
}

_fetchKernel-mainline-legacyHTTPS() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/mainline/*.tar.xz > /dev/null 2>&1
	_safeRMR "$scriptLocal"/mainline
	
	mkdir -p "$scriptLocal"/mainline
	cd "$scriptLocal"/mainline
	
	#currentKernelURL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.61.tar.xz"
	export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
	export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
	export currentKernelPath="$scriptLocal"/mainline/"$currentKernelName"
	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		wget "$currentKernelURL"
		tar xf "$currentKernelName"*
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/mainline/
	cp "$scriptLib"/linux/mainline/.config "$scriptLocal"/mainline/"$currentKernelName"/
}






_fetchKernel-lts() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/lts"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	! [[ "$current_keepFetch" == "true" ]] && _safeRMR "$scriptLocal"/lts"$currentKernelPlatform"

	mkdir -p "$scriptLocal"/lts"$currentKernelPlatform"
	cd "$scriptLocal"/lts"$currentKernelPlatform"


	if [[ "$forceKernel_lts" == "" ]]
	then
		# ATTENTION: Omit the trailing '.' if patchlevel is "" . Usually though, for a preferable well established LTS kernel, the patchlevel will not be empty.
		# WARNING: May not be tested with an empty patchlevel.
		#export currentKernel_MajorMinor='5.10.'
		#export currentKernel_MajorMinor='6.1.'
		export currentKernel_MajorMinor='6.6.'
		export currentKernel_MajorMinor_regex="linux-"$(echo "$currentKernel_MajorMinor" | sed 's/\./\\./g')

		# WARNING: Sorting the git tags has the benefit of depending on one rather than two upstream sources, at the risk that the git tags may not be as carefully curated. Not recommended as default.
		#git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
		#cd "$scriptLocal"/lts"$currentKernelPlatform"/linux
		#export currentKernel_patchLevel=$(git tag | grep '^v'"$currentKernel_MajorMinor_regex" | sed 's/v'"$currentKernel_MajorMinor_regex"'//g' | tr -dc '0-9\.\n' | sort -n | tail -n1)
		#export currentKernelName=linux-"$currentKernel_MajorMinor""$currentKernel_patchLevel"
		#cd "$scriptLocal"/lts"$currentKernelPlatform"


		export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep "$currentKernel_MajorMinor_regex" | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
		export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
		export currentKernelPath="$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"

		export currentKernel_patchLevel=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 3 -d '.')

		export currentKernel_version="$currentKernel_MajorMinor""$currentKernel_patchLevel"
	else
		export forceKernel_lts_regex=$(echo "$forceKernel_lts" | sed 's/\./\\./g')

		export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | grep "$forceKernel_lts_regex" | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
		export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
		export currentKernelPath="$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"

		export currentKernel_version=$(echo "$currentKernelName" | tr -dc '0-9\.\n')
	fi


	_messagePlain_probe_var currentKernelURL
	_messagePlain_probe_var currentKernelName
	_messagePlain_probe_var currentKernelPath

	_messagePlain_probe_var currentKernel_MajorMinor

	_messagePlain_probe_var currentKernel_version

	_messagePlain_probe v"$currentKernel_MajorMinor""$currentKernel_patchLevel"

	
	cd "$scriptLocal"/lts"$currentKernelPlatform"

	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		# DANGER: Do NOT obtain archive of source code from elsehwere (ie. kernel.org instead of git repository). Although officially should be identical, mismatch is theoretically possible.
		## ##wget "$currentKernelURL"
		## ##tar xf "$currentKernelName"*
		
		git config --global checkout.workers -1
		git config --global fetch.parallel 10

		if ! [[ -e "$scriptLocal"/lts"$currentKernelPlatform"/linux/ ]]
		then
			# https://codeandbitters.com/git-shallow-clones/
			#! git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			#! git clone --branch v"$currentKernel_MajorMinor""$currentKernel_patchLevel" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			! git clone --branch v"$currentKernel_version" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
		fi
		
		cd "$scriptLocal"/lts"$currentKernelPlatform"/linux
		#! git checkout v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageError 'fail: git: checkout: 'v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageFAIL && _stop 1
		! git checkout v"$currentKernel_version" && _messageError 'fail: git: checkout: 'v"$currentKernel_version" && _messageFAIL && _stop 1



		cd "$scriptLocal"/lts"$currentKernelPlatform"

		mv "$scriptLocal"/lts"$currentKernelPlatform"/linux "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"

		mv "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"/.git "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName".git
		( [[ "$skimfast" == "true" ]] || [[ $current_force_bindepOnly == "true" ]] ) && [[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-0 -T0"
		[[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-e9"
		[[ $current_force_bindepOnly != "true" ]] && env XZ_OPT="$current_XZ_OPT_kernelSource" tar -cJvf "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName".tar.xz ./"$currentKernelName"
		#[[ "$current_force_bindepOnly" =="true" ]] && export current_force_bindepOnly=false
		mv "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName".git "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"/.git
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/lts"$currentKernelPlatform"/
	cp -f "$scriptLib"/linux/lts"$currentKernelPlatform"/.config "$scriptLocal"/lts"$currentKernelPlatform"/"$currentKernelName"/

}
_fetchKernel-lts-server() {
	export currentKernelPlatform="-server"
	_fetchKernel-lts "$@"
	export currentKernelPlatform=""
}


_fetchKernel-mainline() {
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	rm -f "$scriptLocal"/mainline"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	! [[ "$current_keepFetch" == "true" ]] && _safeRMR "$scriptLocal"/mainline"$currentKernelPlatform"

	mkdir -p "$scriptLocal"/mainline"$currentKernelPlatform"
	cd "$scriptLocal"/mainline"$currentKernelPlatform"

	if [[ "$forceKernel_mainline" == "" ]]
	then
		export currentKernelURL=$(wget -q -O - 'https://kernel.org/' | grep https | grep 'tar\.xz' | head -n1 | sed 's/^.*https/https/' | sed 's/.tar.xz.*$/\.tar\.xz/' | tr -dc 'a-zA-Z0-9.:\=\_\-/%')
		export currentKernelName=$(_safeEcho_newline "$currentKernelURL" | sed 's/^.*\///' | sed 's/\.tar\.xz$//')
		export currentKernelPath="$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"

		export currentKernel_Major=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 1 -d '.')
		export currentKernel_Minor=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 2 -d '.')
		export currentKernel_patchLevel=$(echo "$currentKernelName" | tr -dc '0-9\.\n' | cut -f 3 -d '.')

		export currentKernel_MajorMinor="$currentKernel_Major"
		[[ "$currentKernel_Minor" != "" ]] && export currentKernel_MajorMinor="$currentKernel_Major"".""$currentKernel_Minor"
		[[ "$currentKernel_patchLevel" != "" ]] && export currentKernel_MajorMinor="$currentKernel_MajorMinor""."
		export currentKernel_MajorMinor_regex="linux-"$(echo "$currentKernel_MajorMinor" | sed 's/\./\\./g')

		export currentKernel_version="$currentKernel_MajorMinor""$currentKernel_patchLevel"	
	else
		export forceKernel_mainline_regex=$(echo "$forceKernel_mainline" | sed 's/\./\\./g')

		# WARNING: Sorting the git tags has the benefit of depending on one rather than two upstream sources, at the risk that the git tags may not be as carefully curated. Not recommended as default.
		# Specific, not latest, versions are expected always available from git tags . Robust for that usage.
		git config --global checkout.workers -1
		git config --global fetch.parallel 10
		export currentKernel_version=$(git ls-remote --tags git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git | sed 's/^.*refs\/tags\///g' | grep '^v'"$forceKernel_mainline_regex" | sed 's/^v//g' | sed 's/\^{}//g' | sort -V | tail -n1)
		export currentKernelName=linux-"$currentKernel_version"
		export currentKernelPath="$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"
	fi

	

	_messagePlain_probe_var currentKernelURL
	_messagePlain_probe_var currentKernelName
	_messagePlain_probe_var currentKernelPath

	_messagePlain_probe_var currentKernel_MajorMinor

	_messagePlain_probe_var currentKernel_version
	
	cd "$scriptLocal"/mainline"$currentKernelPlatform"

	
	if ! ls -1 "$currentKernelName"* > /dev/null 2>&1
	then
		# DANGER: Do NOT obtain archive of source code from elsehwere (ie. kernel.org instead of git repository). Although officially should be identical, mismatch is theoretically possible.
		## ##wget "$currentKernelURL"
		## ##tar xf "$currentKernelName"*
		
		git config --global checkout.workers -1
		git config --global fetch.parallel 10

		if ! [[ -e "$scriptLocal"/mainline"$currentKernelPlatform"/linux/ ]]
		then
			# https://codeandbitters.com/git-shallow-clones/
			#! git clone --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			#! git clone --branch v"$currentKernel_MajorMinor""$currentKernel_patchLevel" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
			! git clone --branch v"$currentKernel_version" --depth=1 --recursive git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && _messageError 'fail: git: clone' && _messageFAIL && _stop 1
		fi
		
		cd "$scriptLocal"/mainline"$currentKernelPlatform"/linux
		#! git checkout v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageError 'fail: git: checkout: 'v"$currentKernel_MajorMinor""$currentKernel_patchLevel" && _messageFAIL && _stop 1
		! git checkout v"$currentKernel_version" && _messageError 'fail: git: checkout: 'v"$currentKernel_version" && _messageFAIL && _stop 1



		cd "$scriptLocal"/mainline"$currentKernelPlatform"

		mv "$scriptLocal"/mainline"$currentKernelPlatform"/linux "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"

		mv "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"/.git "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName".git
		( [[ "$skimfast" == "true" ]] || [[ $current_force_bindepOnly == "true" ]] ) && [[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-0 -T0"
		[[ "$current_XZ_OPT_kernelSource" == "" ]] && export current_XZ_OPT_kernelSource="-e9"
		[[ $current_force_bindepOnly != "true" ]] && env XZ_OPT="$current_XZ_OPT_kernelSource" tar -cJvf "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName".tar.xz ./"$currentKernelName"
		#[[ "$current_force_bindepOnly" =="true" ]] && export current_force_bindepOnly=false
		mv "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName".git "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"/.git
	fi
	cd "$currentKernelName"
	
	
	mkdir -p "$scriptLib"/linux/mainline"$currentKernelPlatform"/
	cp -f "$scriptLib"/linux/mainline"$currentKernelPlatform"/.config "$scriptLocal"/mainline"$currentKernelPlatform"/"$currentKernelName"/

}
_fetchKernel-mainline-server() {
	export currentKernelPlatform="-server"
	_fetchKernel-mainline "$@"
	export currentKernelPlatform=""
}



_test_fetchKernel_updateInterval-setupUbiquitous() {
	! find "$scriptLocal"/.retest-setupUbiquitous"$1" -type f -mtime -9 2>/dev/null | grep '.retest-setupUbiquitous' > /dev/null 2>&1
	
	#return 0
	return
}


_fetchKernel() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	if _test_fetchKernel_updateInterval-setupUbiquitous
	then
		rm -f "$scriptLocal"/.retest-setupUbiquitous > /dev/null 2>&1
		touch "$scriptLocal"/.retest-setupUbiquitous
		date +%s > "$scriptLocal"/.retest-setupUbiquitous
		"$scriptAbsoluteLocation" _setupUbiquitous
		[[ ! -e "$HOME"/.ubcore/ubiquitous_bash/.git ]] && "$scriptAbsoluteLocation" _setupUbiquitous_nonet
	fi
	
	_test_build_kernel "$@"
	
	
	
	_fetchKernel-lts "$@"
	
	
	_fetchKernel-mainline "$@"
	
	
	
	
	
	
	cd "$functionEntryPWD"
	_stop
}


# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
_kernelScripts-disableDebug() {
	#scripts/config --disable DEBUG_INFO

	scripts/config --disable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
	
	scripts/config --undefine GDB_SCRIPTS
	scripts/config --undefine DEBUG_INFO
	scripts/config --undefine DEBUG_INFO_SPLIT
	scripts/config --undefine DEBUG_INFO_REDUCED
	scripts/config --undefine DEBUG_INFO_COMPRESSED
	scripts/config --set-val  DEBUG_INFO_NONE       y
	scripts/config --set-val  DEBUG_INFO_DWARF5     n
}


_rmCerts-kernel() {
	rm -f ./certs/.*cmd ./certs/.*d ./certs/*.cmd ./certs/*.d ./certs/*.o ./certs/*.a ./certs/*.order ./certs/*.pem ./certs/blacklist_hash_list ./certs/extract-cert ./certs/x509_certificate_list ./certs/x509_revocation_list ./certs/extra_certificates ./certs/*.priv ./certs/signing_key* ./certs/x509.genkey ./certs/*.a ./certs/*.elf ./certs/*.mod ./certs/*.mod.* ./certs/*.o.* ./certs/*.s ./certs/*.so ./certs/*.so.* ./certs/*.symvers
}

_buildKernel-lts() {
	_messageNormal "init: buildKernel-lts: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_desktop ./.config | tee "$scriptLocal"/lts/statement.sh.out.txt
	cp "$scriptLocal"/lts/*/.config "$scriptLocal"/lts/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
		_supplement_kernel_debPkg
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}
_buildKernel-lts-server() {
	_messageNormal "init: buildKernel-lts-server: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_server ./.config | tee "$scriptLocal"/lts-server/statement.sh.out.txt
	cp "$scriptLocal"/lts-server/*/.config "$scriptLocal"/lts-server/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
		_supplement_kernel_debPkg
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}

_buildKernel-mainline() {
	_messageNormal "init: buildKernel-mainline: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_desktop ./.config | tee "$scriptLocal"/mainline/statement.sh.out.txt
	cp "$scriptLocal"/mainline/*/.config "$scriptLocal"/mainline/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
		_supplement_kernel_debPkg
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}
_buildKernel-mainline-server() {
	_messageNormal "init: buildKernel-mainline-server: ""$currentKernelPath"
	make clean

	make olddefconfig

	# https://superuser.com/questions/925079/compile-linux-kernel-deb-pkg-target-without-generating-dbg-package
	_kernelScripts-disableDebug

	_kernelConfig_server ./.config | tee "$scriptLocal"/mainline-server/statement.sh.out.txt
	cp "$scriptLocal"/mainline-server/*/.config "$scriptLocal"/mainline-server/
	
	# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
	# MCORE2
	#export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	#export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"
	
	#make -j $(nproc)
	#[[ "$?" != "0" ]] && _messageFAIL
	
	local currentExitStatus
	currentExitStatus=0
	
	if [[ "$current_force_bindepOnly" != true ]]
	then
		make deb-pkg -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
		_supplement_kernel_debPkg
	else
		_messageError 'bad: current_force_bindepOnly'
		export current_force_bindepOnly=""
		unset current_force_bindepOnly
		#make bindeb-pkg -j $(nproc)
		make -j $(nproc)
		[[ "$?" != "0" ]] && currentExitStatus=1
	fi
	
	_rmCerts-kernel
	
	[[ "$currentExitStatus" != "0" ]] && _messageFAIL
	
	
	return 0
}




_menuconfigKernel-lts() {
	export currentKernelPath=$(ls -d -1 "$scriptLocal"/lts/linux-* | sort -V | head -n 1)
	cd "$currentKernelPath"

	_messageNormal "init: menuconfigKernel-lts: ""$currentKernelPath"
	make olddefconfig

	make menuconfig

	_kernelConfig_desktop ./.config | tee "$scriptLocal"/lts/statement.sh.out.txt
	cp "$scriptLocal"/lts/*/.config "$scriptLocal"/lts/
	
	return 0
}

_menuconfigKernel-mainline() {
	export currentKernelPath=$(ls -d -1 "$scriptLocal"/mainline/linux-* | sort -V | head -n 1)
	cd "$currentKernelPath"

	_messageNormal "init: menuconfigKernel-mainline: ""$currentKernelPath"
	make olddefconfig

	make menuconfig
	
	_kernelConfig_desktop ./.config | tee "$scriptLocal"/mainline/statement.sh.out.txt
	cp "$scriptLocal"/mainline/*/.config "$scriptLocal"/mainline/
	
	return 0
}



_build_cloud_prepare() {
	if _test_fetchKernel_updateInterval-setupUbiquitous
	then
		rm -f "$scriptLocal"/.retest-setupUbiquitous > /dev/null 2>&1
		touch "$scriptLocal"/.retest-setupUbiquitous
		date +%s > "$scriptLocal"/.retest-setupUbiquitous
		"$scriptAbsoluteLocation" _setupUbiquitous
		[[ ! -e "$HOME"/.ubcore/ubiquitous_bash/.git ]] && "$scriptAbsoluteLocation" _setupUbiquitous_nonet
	fi
	
	_test_build_kernel "$@"
}




_build_cloud_lts() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-lts "$@"
	_buildKernel-lts "$@"
	
	cd "$functionEntryPWD"
}

_build_cloud_mainline() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-mainline "$@"
	_buildKernel-mainline "$@"
	
	cd "$functionEntryPWD"
}

_build_cloud_mainline-server() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-mainline-server "$@"
	_buildKernel-mainline-server "$@"
	
	cd "$functionEntryPWD"
}
_build_cloud_lts-server() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_fetchKernel-lts-server "$@"
	_buildKernel-lts-server "$@"
	
	cd "$functionEntryPWD"
}

_build_cloud() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_prepare "$@"
	
	_build_cloud_lts "$@"
	
	_build_cloud_mainline "$@"
	
	cd "$functionEntryPWD"
	_stop
}






_export_cloud_prepare() {
	_messagePlain_nominal "init: _export_cloud_prepare"
	
	mkdir -p "$scriptLocal"/_export
	mkdir -p "$scriptLocal"/_tmp
}

_export_cloud_lts() {
	_export_cloud_prepare
	cd "$scriptLocal"/_tmp
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	if ls -1 "$scriptLocal"/lts"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	then
		_messageNormal '_export_cloud: lts"$currentKernelPlatform"'
		
		mkdir -p "$scriptLocal"/_tmp/lts"$currentKernelPlatform"
		
		# Export single compressed files NOT directory.
		cp "$scriptLocal"/lts"$currentKernelPlatform"/* "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/
		rsync --exclude '*.orig.tar.gz' "$scriptLocal"/lts"$currentKernelPlatform"/* "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/.
		rm -f "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/*.orig.tar.gz
		
		# Export '.config' from kernel .
		cp "$scriptLocal"/lts"$currentKernelPlatform"/*/.config "$scriptLocal"/_tmp/lts"$currentKernelPlatform"/
		
		
		_messagePlain_nominal '_export_cloud: lts"$currentKernelPlatform": debian'
		cd "$scriptLocal"/_tmp
		tar -czf linux-lts"$currentKernelPlatform"-amd64-debian.tar.gz ./lts"$currentKernelPlatform"/
		mv linux-lts"$currentKernelPlatform"-amd64-debian.tar.gz "$scriptLocal"/_export
		
		
		# Gentoo specific. Unusual. Strongly discouraged.
		#_messagePlain_nominal '_export_cloud: lts"$currentKernelPlatform": all'
		#cd "$scriptLocal"
		#tar -czf linux-lts"$currentKernelPlatform"-amd64-all.tar.gz ./lts"$currentKernelPlatform"/
		##env XZ_OPT=-e9 tar -cJf linux-lts"$currentKernelPlatform"-amd64-all.tar.xz ./lts"$currentKernelPlatform"/
		##env XZ_OPT=-5 tar -cJf linux-lts"$currentKernelPlatform"-amd64-all.tar.xz ./lts"$currentKernelPlatform"/
		#mv linux-lts"$currentKernelPlatform"-amd64-all.tar.gz "$scriptLocal"/_export
		
		
		_safeRMR "$scriptLocal"/_tmp/lts"$currentKernelPlatform"
		
		du -sh "$scriptLocal"/_export/linux-lts"$currentKernelPlatform"*
	else
		_messageError 'bad: missing: "$scriptLocal"/lts"$currentKernelPlatform"/*.tar.xz' && _messageFAIL && _stop 1
	fi
}
_export_cloud_lts-server() {
	export currentKernelPlatform="-server"
	_export_cloud_lts "$@"
	export currentKernelPlatform=""
}

_export_cloud_mainline() {
	_export_cloud_prepare
	cd "$scriptLocal"/_tmp
	# DANGER: NOTICE: Do NOT export without corresponding source code!
	if ls -1 "$scriptLocal"/mainline"$currentKernelPlatform"/*.tar.xz > /dev/null 2>&1
	then
		_messageNormal '_export_cloud: mainline"$currentKernelPlatform"'
		
		mkdir -p "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"
		
		# Export single compressed files NOT directory.
		cp "$scriptLocal"/mainline"$currentKernelPlatform"/* "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/
		rsync --exclude '*.orig.tar.gz' "$scriptLocal"/mainline"$currentKernelPlatform"/* "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/.
		rm -f "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/*.orig.tar.gz
		
		# Export '.config' from kernel .
		cp "$scriptLocal"/mainline"$currentKernelPlatform"/*/.config "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"/
		
		
		_messagePlain_nominal '_export_cloud: mainline"$currentKernelPlatform": debian'
		cd "$scriptLocal"/_tmp
		tar -czf linux-mainline"$currentKernelPlatform"-amd64-debian.tar.gz ./mainline"$currentKernelPlatform"/
		mv linux-mainline"$currentKernelPlatform"-amd64-debian.tar.gz "$scriptLocal"/_export
		
		
		# Gentoo specific. Unusual. Strongly discouraged.
		#_messagePlain_nominal '_export_cloud: mainline"$currentKernelPlatform": all'
		#cd "$scriptLocal"
		#tar -czf linux-mainline"$currentKernelPlatform"-amd64-all.tar.gz ./mainline"$currentKernelPlatform"/
		##env XZ_OPT=-e9 tar -cJf linux-mainline"$currentKernelPlatform"-amd64-all.tar.xz ./mainline"$currentKernelPlatform"/
		##env XZ_OPT=-5 tar -cJf linux-mainline"$currentKernelPlatform"-amd64-all.tar.xz ./mainline"$currentKernelPlatform"/
		#mv linux-mainline"$currentKernelPlatform"-amd64-all.tar.gz "$scriptLocal"/_export
		
		
		_safeRMR "$scriptLocal"/_tmp/mainline"$currentKernelPlatform"
		
		du -sh "$scriptLocal"/_export/linux-mainline"$currentKernelPlatform"*
	fi
}
_export_cloud_mainline-server() {
	export currentKernelPlatform="-server"
	_export_cloud_mainline "$@"
	export currentKernelPlatform=""
}



_export_cloud() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_messageNormal "init: _export_cloud"
	
	_export_cloud_lts
	
	_export_cloud_mainline
	
	echo "_"
	du -sh "$scriptLocal"/_export/*
	
	cd "$functionEntryPWD"
	_stop
}




# ATTENTION: Override with 'ops.sh' or similar!
_upload_cloud_lts() {
	_rclone_limited --progress copy "$scriptLocal"/_export/linux-lts-amd64-debian.tar.gz mega:/Public/mirage335KernelBuild/
}

# ATTENTION: Override with 'ops.sh' or similar!
_upload_cloud_mainline() {
	_rclone_limited --progress copy "$scriptLocal"/_export/linux-mainline-amd64-debian.tar.gz mega:/Public/mirage335KernelBuild/
}

_upload_cloud() {
	_upload_cloud_lts
	_upload_cloud_mainline
}


_create_lts() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_lts
	
	_export_cloud_lts
	
	_upload_cloud_lts
	
	cd "$functionEntryPWD"
	_stop
}

_create_mainline() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	_start
	
	_build_cloud_mainline
	
	_export_cloud_mainline
	
	_upload_cloud_mainline
	
	cd "$functionEntryPWD"
	_stop
}





_refresh_anchors() {
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_export_cloud
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_upload_cloud
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_prepare
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_build_cloud_mainline
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_export_cloud_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_export_cloud_mainline
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_upload_cloud_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_upload_cloud_mainline
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_create_lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_create_mainline
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_getMinimal_cloud
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_fetchKernel


	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_menuconfigKernel-lts
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_menuconfigKernel-mainline
}




#####Program

#Typically launches an application - ie. through virtualized container.
_launch() {
	false
	#"$@"
}

#Typically gathers command/variable scripts from other (ie. yaml) file types (ie. AppImage recipes).
_collect() {
	false
}

#Typical program entry point, absent any instancing support.
_enter() {
	_launch "$@"
}

#Typical program entry point.
_main() {
	_start
	
	_collect
	
	_enter "$@"
	
	_stop
}


_check_nv_sequence() {
    _start
    local currentExitStatus
    local functionEntryPWD="$PWD"

    _messagePlain_nominal 'kernel'

    export currentKernelPath=$(ls -d -1 "$scriptLocal"/"$2"/linux-* | sort -n | head -n 1)
    _messagePlain_probe_var currentKernelPath

    export currentKernelPath_version=$(echo "$currentKernelPath" | cut -f 2- -d\- | cut -f 1-3 -d. | cut -f 1 -d\- )
    _messagePlain_probe_var currentKernelPath_version

    cd "$currentKernelPath"

    #make olddefconfig
    #make prepare


    _messagePlain_nominal 'wget'

    cd "$safeTmp"
    wget https://raw.githubusercontent.com/soaringDistributions/ubDistBuild/main/_lib/setup/nvidia/_get_nvidia.sh
    ! [[ -e "$safeTmp"/_get_nvidia.sh ]] && _messagePlain_bad 'bad: missing: _get_nvidia.sh' && return 1
    chmod u+x "$safeTmp"/_get_nvidia.sh

    local currentVersion=$("$safeTmp"/_get_nvidia.sh _write_nvidia-"$1")
    _messagePlain_probe_var currentVersion

    ! "$safeTmp"/_get_nvidia.sh _fetch_nvidia-wget "$currentVersion" && return 1
    ! [[ -e "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run ]] && _messagePlain_bad 'bad: missing: NVIDIA-Linux-x86_64-"$currentVersion".run' && return 1


    if "$safeTmp"/_get_nvidia.sh _if_patch_nvidia "$currentVersion" "$currentKernelPath_version"
    then
        ! "$safeTmp"/_get_nvidia.sh _patch_nvidia "$currentVersion" "$currentKernelPath_version" && _messagePlain_bad 'bad: fail: patch' && return 1

        mkdir -p "$safeTmp"/tmp
        #_messagePlain_probe '"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom.run --extract-only'
        #"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom.run --tmpdir="$safeTmp"/tmp --extract-only
        ##mv -f "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"
        #cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom/kernel

        currentExitStatus=0
        ! sudo -n sh "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"-custom.run --tmpdir="$safeTmp"/tmp --ui=none --no-questions -j $(nproc) --no-cc-version-check -k "$currentKernelPath_version" --kernel-source-path "$currentKernelPath" -m=kernel && currentExitStatus=1
        cat /var/log/nvidia-installer.log
        [[ "$currentExitStatus" != "0" ]] && return 1
    else
        mkdir -p "$safeTmp"/tmp
        #_messagePlain_probe '"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --extract-only'
        #"$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --tmpdir="$safeTmp"/tmp --extract-only
        #cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel

        currentExitStatus=0
        ! sudo -n sh "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion".run --tmpdir="$safeTmp"/tmp --ui=none --no-questions -j $(nproc) --no-cc-version-check -k "$currentKernelPath_version" --kernel-source-path "$currentKernelPath" -m=kernel && currentExitStatus=1
        cat /var/log/nvidia-installer.log
        [[ "$currentExitStatus" != "0" ]] && return 1
    fi

    

    # DISABLED. Has been tested. May eventually be useful toward open-source kernel drivers, or maybe better logging.
    # https://github.com/NVIDIA/open-gpu-kernel-modules
    # Does NOT compile properly with Debian packages splitting the headers with 'common' packages.
    if false
    then
        _messagePlain_nominal 'make'

        export SYSSRC="$currentKernelPath"
        export IGNORE_CC_MISMATCH=1

        export IGNORE_MISSING_MODULE_SYMVERS=1


        cd "$safeTmp"/NVIDIA-Linux-x86_64-"$currentVersion"/kernel

        make clean

        _messagePlain_probe 'make -j $(nproc)'
        make -j $(nproc)
        currentExitStatus="$?"
    fi


    cd "$localFunctionEntryPWD"
    if [[ "$currentExitStatus" != "0" ]]
    then
        _messageFAIL
        _stop 1
        return 1
    fi
    _stop "$currentExitStatus"
}
_check_nv-mainline-series535p() {
    "$scriptAbsoluteLocation" _check_nv_sequence "series535p" "mainline" "$@"
}
_check_nv-mainline-legacy470() {
    "$scriptAbsoluteLocation" _check_nv_sequence "legacy470" "mainline" "$@"
}
_check_nv-lts-series535p() {
    "$scriptAbsoluteLocation" _check_nv_sequence "series535p" "lts" "$@"
}
_check_nv-lts-legacy470() {
    "$scriptAbsoluteLocation" _check_nv_sequence "legacy470" "lts" "$@"
}






_check_vbox_sequence() {
    local functionEntryPWD="$PWD"
    _start

    local currentExitStatus=0

    _messagePlain_nominal 'kernel'

    export currentKernelPath=$(ls -d -1 "$scriptLocal"/"$1"/linux-* | sort -n | head -n 1)
    _messagePlain_probe_var currentKernelPath


    #cd "$currentKernelPath"

    #make olddefconfig
    #make prepare


    _messagePlain_nominal 'dist-get'

    export getMost_backend="direct"
	_set_getMost_backend "$@"
	_set_getMost_backend_debian "$@"
	_test_getMost_backend "$@"
	
	_getMost_backend apt-get update

    ! _getMost_ubuntu24-VBoxManage && exit 1



    _messagePlain_nominal 'make'

    if [[ -e /usr/share/virtualbox/src/vboxhost ]]
    then
        cp -r /usr/share/virtualbox/src/vboxhost "$safeTmp"/vboxhost
        cd "$safeTmp"/vboxhost
        make clean
        make -C "$currentKernelPath" M=`pwd` -j $(nproc)
        [[ "$?" != "0" ]] && _messagePlain_bad 'bad: make -C "$currentKernelPath" M=`pwd` -j $(nproc)' && currentExitStatus=1
        #_stop "$?"

        ! [[ -e "$safeTmp"/vboxhost/vboxdrv/vboxdrv.ko ]] && _messagePlain_bad 'bad: missing: vboxdrv.ko' && currentExitStatus=1

        ! [[ -e "$safeTmp"/vboxhost/vboxnetadp/vboxnetadp.ko ]] && _messagePlain_warn 'warn: possibly cosmetic: missing: vboxnetadp.ko' #&& currentExitStatus=1
        ! [[ -e "$safeTmp"/vboxhost/vboxpci/vboxpci.ko ]] && _messagePlain_warn 'warn: possibly cosmetic: missing: vboxpci.ko' #&& currentExitStatus=1

        _messagePlain_probe_var currentExitStatus
        _messagePlain_good 'good: presumed adequate'
        [[ "$currentExitStatus" == "0" ]] && _stop 0
    fi



    _messageFAIL
    _stop 1
    return 1
}
_check_vbox-mainline() {
    "$scriptAbsoluteLocation" _check_vbox_sequence "mainline" "$@"
}
_check_vbox-lts() {
    "$scriptAbsoluteLocation" _check_vbox_sequence "lts" "$@"
}




#currentReversePort=""
#currentMatchingReversePorts=""
#currentReversePortOffset=""
#matchingOffsetPorts=""
#matchingReversePorts=""
#matchingEMBEDDED=""

#Creates "${matchingOffsetPorts}[@]" from "${matchingReversePorts}[@]".
#Intended for public server tunneling (ie. HTTPS).
# ATTENTION: Overload with 'ops' .
_offset_reversePorts() {
	local currentReversePort
	local currentMatchingReversePorts
	local currentReversePortOffset
	for currentReversePort in "${matchingReversePorts[@]}"
	do
		let currentReversePortOffset="$currentReversePort"+100
		currentMatchingReversePorts+=( "$currentReversePortOffset" )
	done
	matchingOffsetPorts=("${currentMatchingReversePorts[@]}")
	export matchingOffsetPorts
}


#####Network Specific Variables
#Statically embedded into monolithic ubiquitous_bash.sh/cautossh script by compile .

# WARNING Must use unique netName!
export netName=default
export gatewayName=gtw-"$netName"-"$netName"
export LOCALSSHPORT=22


#Optional equivalent to LOCALSSHPORT, also respected for tunneling ports from other services.
export LOCALLISTENPORT="$LOCALSSHPORT"

# ATTENTION: Mostly future proofing. Due to placement of autossh within a 'while true' loop, associated environment variables are expected to have minimal, if any, effect.
#Poll time must be double network timeouts.
export AUTOSSH_FIRST_POLL=45
export AUTOSSH_POLL=45
#export AUTOSSH_GATETIME=0
export AUTOSSH_GATETIME=15
#export AUTOSSH_PORT=0
#export AUTOSSH_DEBUG=1
#export AUTOSSH_LOGLEVEL=7

_get_reversePorts() {
	export matchingReversePorts
	matchingReversePorts=()
	export matchingEMBEDDED="false"

	local matched

	local testHostname
	testHostname="$1"
	[[ "$testHostname" == "" ]] && testHostname=$(hostname -s)

	if [[ "$testHostname" == 'hostnameA' ]] || [[ "$testHostname" == 'hostnameB' ]] || [[ "$testHostname" == '*' ]]
	then
		matchingReversePorts+=( '20001' )
		matched='true'
	fi
	if [[ "$testHostname" == 'hostnameC' ]] || [[ "$testHostname" == 'hostnameD' ]] || [[ "$testHostname" == '*' ]]
	then
		matchingReversePorts+=( '20002' )
		export matchingEMBEDDED='true'
		matched='true'
	fi
	if ! [[ "$matched" == 'true' ]] || [[ "$testHostname" == '*' ]]
	then
		matchingReversePorts+=( '20003' )
	fi

	export matchingReversePorts
}
_get_reversePorts
export reversePorts=("${matchingReversePorts[@]}")
export EMBEDDED="$matchingEMBEDDED"

_offset_reversePorts
export matchingOffsetPorts

export keepKeys_SSH='true'


_generate_lean-lib-python_here() {
	cat << 'CZXWXcRMTo8EmM8i4d'

# https://stackoverflow.com/questions/44834/can-someone-explain-all-in-python

# https://bruxy.regnet.cz/programming/bash-python/workshop_bash-python-en.html
# https://www.geeksforgeeks.org/how-to-run-bash-script-in-python/
# https://softwareengineering.stackexchange.com/questions/207613/encoding-a-bash-script-for-use-in-python

# https://www.codementor.io/@arpitbhayani/personalize-your-python-prompt-13ts4kw6za

# https://kimsereylam.com/python/2020/02/07/improve-your-python-shell-with-pythonrc.html




#os.system("python --version")
#print (sys.version_info)



#os.system("ubiquitous_bash.sh _getAbsoluteFolder .")



# https://www.geeksforgeeks.org/how-to-pass-multiple-arguments-to-function/

#def _bin(currentArgumentsString):
#	os.system("ubiquitous_bash.sh _bin " + currentArgumentsString)

#_bin("_getAbsoluteFolder .")

#_bin("_scope .")

#_bin("_bash -i")



#def _bash():
#	os.system("ubiquitous_bash.sh _bin _bash -i ")

#def _bash():
#	os.system("$HOME/.ubcore/ubiquitous_bash/ubcore.sh _bash -i ")

#_bash()





########################################


# WARNING: Python API documentation suggests significant possibility of incompatibility (perhaps return object type) 'if sys.hexversion < 0x03060000' or 'if sys.hexversion < 0x03000000'.
# CAUTION: Python API version compatibility may or may not be strictly enforced, due to lack of known failures, and/or usual expectations of problems from the multiple ways of doing things.
# Apparently reasonable expectations confirmed by exhaustive research may be met if python version is at least >0x20710f0 and <0x30703f0 .
#import sys
#if sys.hexversion < 0x03060000:
# https://stackoverflow.com/questions/446052/how-can-i-check-for-python-version-in-a-program-that-uses-new-language-features
#	exit(1)


#_messagePlain_request( 'request: user please install...' )
def _messagePlain_request(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[0;35m\x02 ' + currentMessage + ' \x01\033[0m\x02' )

#_messagePlain_nominal( 'init: _function' )
def _messagePlain_nominal(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[0;36m\x02 ' + currentMessage + ' \x01\033[0m\x02' )

#_messagePlain_probe( '_messagePlain_probe ( \'_messagePlain_probe\' ) ' )
def _messagePlain_probe(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[0;34m\x02 ' + currentMessage + ' \x01\033[0m\x02' )

#_messagePlain_good( 'good: success' )
def _messagePlain_good(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[0;32m\x02 ' + currentMessage + ' \x01\033[0m\x02' )

#_messagePlain_warn( 'warn: workaround' )
def _messagePlain_warn(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[1;33m\x02 ' + currentMessage + ' \x01\033[0m\x02' )

#_messagePlain_bad( 'bad: fail: missing' )
def _messagePlain_bad(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[0;31m\x02 ' + currentMessage + ' \x01\033[0m\x02' )

#_messageNormal( '_function_sequence: Stop' )
def _messageNormal(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[1;32;46m\x02 ' + currentMessage + ' \x01\033[0m\x02' )

#_messageError( 'FAIL: unknown app failure' )
def _messageERROR(currentMessage = '', currentContext = '(python)'):
	print ( '\x01\033[0;35;47m\x02' + currentContext + '\x01\033[0m\x02' + '\x01\033[1;33;41m\x02 ' + currentMessage + ' \x01\033[0m\x02' )


#_messageNormal( '_function_sequence: Start' )

#_messagePlain_nominal( 'init: _function' )
#_messagePlain_request( 'request: user please install...' )
#_messagePlain_probe( '_messagePlain_probe ( \'_messagePlain_probe\' ) ' )

#_messagePlain_good( 'good: success' )
#_messagePlain_warn( 'warn: workaround' )
#_messagePlain_bad( 'bad: fail: missing' )

#_messageERROR( 'FAIL: unknown app failure' )

#_messageNormal( '_function_sequence: Stop' )







import sys
# https://stackoverflow.com/questions/446052/how-can-i-check-for-python-version-in-a-program-that-uses-new-language-features
#if sys.hexversion < 0x03060000:
#	exit(1)
import string
import subprocess
import os
# WARNING: Procedures exclusively relying on python code are NOT intended or expected to be robust. Instead use '_getScriptAbsoluteLocation' within 'ubiquitous_bash.sh' as able.
# WARNING: Whether '__file__' has similar characteristics to "$0" as used within 'ubiquitous_bash' in all relevant cases is NOT determined and is NOT to be relied upon.
# WARNING: Historically 'python' has NOT had the API stability, reliability, or portability of 'bash'.
# https://stackoverflow.com/questions/4934806/how-can-i-find-scripts-directory
# https://stackoverflow.com/questions/3503879/assign-output-of-os-system-to-a-variable-and-prevent-it-from-being-displayed-on
#currentPathCheck = subprocess.Popen(['/bin/bash', '--noprofile', '--norc', '-c', 'type -p ubiquitous_bash.sh'], stdout=subprocess.PIPE, universal_newlines=True)
#print(os.path.dirname(os.path.realpath(__file__)))
#print(sys.path[0])
#os.path.abspath(os.path.dirname(os.path.realpath(__file__))).rstrip('\n')
#if True:
#currentProc = subprocess.Popen(['/bin/bash', '-c', 'ubiquitous_bash.sh _getAbsoluteFolder ' + __file__], stdout=subprocess.PIPE, universal_newlines=True)
#currentProc = subprocess.Popen(['/bin/bash', '--noprofile', '--norc', '-c', 'ubiquitous_bash.sh _getAbsoluteFolder ' + __file__], stdout=subprocess.PIPE, universal_newlines=True)
#currentProc = subprocess.Popen(['ubiquitous_bash.sh', '_getAbsoluteFolder', __file__], stdout=subprocess.PIPE, universal_newlines=True)
def _getScriptAbsoluteFolder():
	currentPathCheck = subprocess.Popen(['/bin/bash', '-c', 'type -p ubiquitous_bash.sh'], stdout=subprocess.PIPE, universal_newlines=True)
	currentPathCheck.communicate()
	currentPathCheck.wait()
	if currentPathCheck.returncode == 0:
		currentProc = subprocess.Popen(['ubiquitous_bash.sh', '_getAbsoluteFolder', __file__], stdout=subprocess.PIPE, universal_newlines=True)
		(currentOut, currentErr) = currentProc.communicate()
		currentProc.wait()
		currentOut = currentOut.rstrip('\n')
		return(currentOut.rstrip('\n'))
	else:
		return(os.path.abspath(os.path.dirname(os.path.realpath(__file__))).rstrip('\n'))

#print(_getScriptAbsoluteFolder())










import sys
#if sys.hexversion < 0x03060000:
#	exit(1)
import string
import subprocess
import os
#
#_bash()
# WARNING: CAUTION: DANGER: Beware '_getScriptAbsoluteLocation' will NOT be set correctly!
#_bash(['-c', '_getScriptAbsoluteLocation'], True, os.path.expanduser("~/core/infrastructure/ubiquitous_bash/ubiquitous_bash.sh"))
#_bash("-c '_getScriptAbsoluteLocation'", True, os.path.expanduser("~/core/infrastructure/ubiquitous_bash/ubiquitous_bash.sh"))
#
#_bash(['-c', 'echo test', 'xyz'])
#print(_bash(['-c', 'echo test', 'xyz'], False))
#print(_bash(['-c', '_false'], False))
#print(_bash(['-c', '_false'], False)[1])
#
#_bash('-i')
#_bash("-c '/bin/echo true'")
#_bash("-c 'echo true'")
# https://stackoverflow.com/questions/38821586/one-line-to-check-if-string-or-list-then-convert-to-list-in-python
# https://stackoverflow.com/questions/23883394/detect-if-python-script-is-run-from-an-ipython-shell-or-run-from-the-command-li
#sys.argv[1]
#os.system("$HOME/.ubcore/ubiquitous_bash/ubcore.sh _bash -i ")
#currentArguments = [currentArguments] if isinstance(currentArguments, str) else currentArguments
#print(['ubiquitous_bash.sh', '_bash'] + currentArguments)
# ATTENTION: WARNING: Enjoy this python code. The '_bash' and '_bin' function are quite possibly, even probably, and for actual reasons for every line of code being annoying, the worst python code that will ever be written by people. In plainer language, only mess with parts of this code for which you have stopped to fully understand exactly why every negation, if/else, return, print, etc, is in the exact order that it is.
def _bash(currentArguments = ['-i'], currentPrint = False, current_ubiquitous_bash = "ubiquitous_bash.sh", interactive=True):
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists(os.environ.get("scriptCall_bash_msw", "").replace('\\', '/')):
            current_ubiquitous_bash = os.environ.get("scriptCall_bash_msw", "").replace('\\', '/')
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists(os.environ.get("scriptAbsoluteLocation", "")):
            current_ubiquitous_bash = os.environ.get("scriptAbsoluteLocation", "")
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists(os.environ['HOME'] + "/.ubcore/ubiquitous_bash/ubcore.sh"):
            current_ubiquitous_bash = (os.environ['HOME'] + "/.ubcore/ubiquitous_bash/ubcore.sh")
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists("/cygdrive/c/core/infrastructure/ubiquitous_bash/ubcore.sh"):
            current_ubiquitous_bash = "/cygdrive/c/core/infrastructure/ubiquitous_bash/ubcore.sh"
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists("/cygdrive/c/core/infrastructure/ubiquitous_bash/lean.sh"):
            current_ubiquitous_bash = "/cygdrive/c/core/infrastructure/ubiquitous_bash/lean.sh"
    currentArguments = ['-i'] if currentArguments == '-i' else currentArguments
    if isinstance(currentArguments, str):
    # WARNING: Discouraged.
        if not ( ( currentArguments == '-i' ) or ( currentArguments == '' ) or ( interactive == True ) ):
            # ATTENTION: WARNING: Use of 'stdout=subprocess.PIPE' is NOT compatible with interactive shell!
            currentProc = subprocess.Popen(current_ubiquitous_bash + " _bash " + currentArguments, stdout=subprocess.PIPE, universal_newlines=True, shell=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
            currentOut = currentOut.rstrip('\n')
            if currentPrint == True:
                print(currentOut)
                return (currentOut), currentProc.returncode
        else:
            currentProc = subprocess.Popen(current_ubiquitous_bash + " _bash " + currentArguments, universal_newlines=True, shell=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
        return (currentOut), currentProc.returncode
    else:
        if not ( ( currentArguments == ['-i'] ) or ( currentArguments == [''] ) or ( interactive == True ) ):
            currentArguments = [currentArguments] if isinstance(currentArguments, str) else currentArguments
            # ATTENTION: WARNING: Use of 'stdout=subprocess.PIPE' is NOT compatible with interactive shell!
            currentProc = subprocess.Popen([current_ubiquitous_bash, '_bash'] + currentArguments, stdout=subprocess.PIPE, universal_newlines=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
            currentOut = currentOut.rstrip('\n')
            if currentPrint == True:
                print(currentOut)
                return (currentOut), currentProc.returncode
        else:
            if ( currentArguments == [''] ): currentArguments = ['-i']
            currentArguments = [currentArguments] if isinstance(currentArguments, str) else currentArguments
            currentProc = subprocess.Popen([current_ubiquitous_bash, '_bash'] + currentArguments, universal_newlines=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
        return (currentOut), currentProc.returncode





import sys
#if sys.hexversion < 0x03060000:
#	exit(1)
import string
import subprocess
import os
#
#_bin(['/bin/bash', '-i'])
#_bin(['_getScriptAbsoluteLocation'], True, os.path.expanduser("~/core/infrastructure/ubiquitous_bash/ubiquitous_bash.sh"))
#_bin(['_getScriptAbsoluteLocation'], True)
#_bin(['echo', 'test'], True, os.path.expanduser("~/core/infrastructure/ubiquitous_bash/ubiquitous_bash.sh"))
#print(_bin(['_false'], False, os.path.expanduser("~/core/infrastructure/ubiquitous_bash/ubiquitous_bash.sh"))[1])
#
#_bin('_true')
#_bin('_echo test')
#_bin('_bash')
#print( _bin('_false', False)[1] )
#_bin("_getScriptAbsoluteLocation", True, os.path.expanduser("~/core/infrastructure/ubiquitous_bash/ubiquitous_bash.sh"))
# ATTENTION: WARNING: Enjoy this python code. The '_bash' and '_bin' function are quite possibly, even probably, and for actual reasons for every line of code being annoying, the worst python code that will ever be written by people. In plainer language, only mess with parts of this code for which you have stopped to fully understand exactly why every negation, if/else, return, print, etc, is in the exact order that it is.
def _bin(currentArguments = [''], currentPrint = False, current_ubiquitous_bash = "ubiquitous_bash.sh", interactive=False):
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists(os.environ.get("scriptCall_bash_msw", "").replace('\\', '/')):
            current_ubiquitous_bash = os.environ.get("scriptCall_bash_msw", "").replace('\\', '/')
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists(os.environ.get("scriptAbsoluteLocation", "")):
            current_ubiquitous_bash = os.environ.get("scriptAbsoluteLocation", "")
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists(os.environ['HOME'] + "/.ubcore/ubiquitous_bash/ubcore.sh"):
            current_ubiquitous_bash = (os.environ['HOME'] + "/.ubcore/ubiquitous_bash/ubcore.sh")
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists("/cygdrive/c/core/infrastructure/ubiquitous_bash/ubcore.sh"):
            current_ubiquitous_bash = "/cygdrive/c/core/infrastructure/ubiquitous_bash/ubcore.sh"
    if current_ubiquitous_bash == "ubiquitous_bash.sh":
        if os.path.exists("/cygdrive/c/core/infrastructure/ubiquitous_bash/lean.sh"):
            current_ubiquitous_bash = "/cygdrive/c/core/infrastructure/ubiquitous_bash/lean.sh"
    # ATTENTION: Comment out next python line of code to test this code with an empty string.
    #./lean.py "_bin('', currentPrint=True)"
    currentArguments = [''] if currentArguments == '' else currentArguments
    if isinstance(currentArguments, str):
        # WARNING: Discouraged.
        if not ( ( ( currentArguments == '/bin/bash -i' ) or ( currentArguments == '/bin/bash' ) or ( currentArguments == '_bash' ) or ( currentArguments == '' ) ) or ( interactive == True ) ) :
            # ATTENTION: WARNING: Use of 'stdout=subprocess.PIPE' is NOT compatible with interactive shell!
            currentProc = subprocess.Popen(current_ubiquitous_bash + " _bin " + currentArguments, stdout=subprocess.PIPE, universal_newlines=True, shell=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
            currentOut = currentOut.rstrip('\n')
            if currentPrint == True:
                print(currentOut)
                return (currentOut), currentProc.returncode
        else:
            if ( currentArguments == '' ): currentArguments = '_bash'
            currentProc = subprocess.Popen(current_ubiquitous_bash + " _bin " + currentArguments, universal_newlines=True, shell=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
        return (currentOut), currentProc.returncode
    else:
        if not ( ( ( currentArguments == ['/bin/bash', '-i'] ) or ( currentArguments == ['/bin/bash'] ) or ( currentArguments == ['_bash'] ) or ( currentArguments == ['_bash', '-i'] ) or ( currentArguments == ['_qalculate', ''] ) or ( currentArguments == ['_qalculate'] ) or ( currentArguments == ['_octave', ''] ) or ( currentArguments == ['_octave'] ) or ( currentArguments == [''] ) ) or ( interactive == True ) ):
            currentArguments = [currentArguments] if isinstance(currentArguments, str) else currentArguments
            # ATTENTION: WARNING: Use of 'stdout=subprocess.PIPE' is NOT compatible with interactive shell!
            currentProc = subprocess.Popen([current_ubiquitous_bash, '_bin'] + currentArguments, stdout=subprocess.PIPE, universal_newlines=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
            currentOut = currentOut.rstrip('\n')
            if currentPrint == True:
                print(currentOut)
                return (currentOut), currentProc.returncode
        else:
            if ( currentArguments == [''] ): currentArguments = ['_bash']
            currentArguments = [currentArguments] if isinstance(currentArguments, str) else currentArguments
            currentProc = subprocess.Popen([current_ubiquitous_bash, '_bin'] + currentArguments, universal_newlines=True)
            (currentOut, currentErr) = currentProc.communicate()
            currentProc.wait()
        return (currentOut), currentProc.returncode

# ATTENTION: Only intended for indirect calls.
# https://stackoverflow.com/questions/5067604/determine-function-name-from-within-that-function-without-using-traceback
#	'there aren't enough important use cases given'
# https://www.tutorialspoint.com/How-can-I-remove-the-ANSI-escape-sequences-from-a-string-in-python
# https://docs.python.org/3/library/re.html
#return _bin(currentCommand + currentArguments + currentString, currentPrint)[0]
#return re.sub(r'(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]', '', _bin(currentCommand + currentArguments + currentString, currentPrint)[0])
def _bin_stringAfterArgs(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_false']):
	currentString = [currentString] if isinstance(currentString, str) else currentString
	currentArguments = [currentArguments] if isinstance(currentArguments, str) else currentArguments
	if currentPrint:
		return _bin(currentCommand + currentArguments + currentString, currentPrint)
	else:
		return re.sub(r'\n', '', re.sub(r'(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]', '', _bin(currentCommand + currentArguments + currentString, currentPrint)[0]))

#def _bash(currentArguments = [''], currentPrint = True, current_ubiquitous_bash = "ubiquitous_bash.sh"):
#	_bin(['/bin/bash', '-i'])



#if sys.hexversion < 0x03000000:
#	exit(1)
#_bin_alias = _bin


#_clc('1 + 2')
#_qalculate('1 + 2')
#_octave('1 + 2')
#print(_octave_solve('(y == x * 2, x)' ))

def _clc(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_clc']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def clc(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['clc']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def c(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['c']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def _solve(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_solve']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def solve(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['solve']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def nsolve(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['nsolve']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def _qalculate_solve(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_qalculate_solve']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def _qalculate_nsolve(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_qalculate_nsolve']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def _octave_solve(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_octave_solve']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def _octave_nsolve(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_octave_nsolve']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)


def _qalculate(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_qalculate']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)

def _octave(currentString = [], currentArguments = [], currentPrint = False, currentCommand = ['_octave']):
	return _bin_stringAfterArgs(currentString, currentArguments, currentPrint, currentCommand)








if sys.platform == 'win32':
    try:
        import pyreadline3 as readline
    except ImportError:
        readline = None
else:
    try:
        import readline # optional, will allow Up/Down/History in the console
    except ImportError:
        readline = None
import code

# ATTRIBUTION-AI: ChatGPT o3  2025-04-19
def _enable_readline():
    """
    Make sure arrow keys, history and TAB completion work in the
    interpreter that we embed with code.InteractiveConsole.
    """
    try:
        import readline, rlcompleter, atexit, os
        # basic key bindings
        readline.parse_and_bind('tab: complete')
        # persistent history file
        histfile = os.path.expanduser('~/.pyhistory')
        if os.path.exists(histfile):
            readline.read_history_file(histfile)
        atexit.register(readline.write_history_file, histfile)
    except ImportError:
        # readline (or pyreadline on Windows) is not available
        pass




#_python()
# https://stackoverflow.com/questions/5597836/embed-create-an-interactive-python-shell-inside-a-python-program
def _python():
    _enable_readline()
    variables = globals().copy()
    variables.update(locals())
    shell = code.InteractiveConsole(variables)
    # ATTRIBUTION-AI: ChatGPT 4.1  2025-04-19
    if os.name == 'nt':  # True on Windows
        print(" Press Ctrl+D twice (or Ctrl+Z then Enter) to exit this Python shell.")
    if os.name == 'posix':
        print(" Press Ctrl+D twice (or Ctrl+Z then Enter) to exit this Python shell.")
    # ATTRIBUTION: NOT AI !
    shell.interact()



import sys
import os
import socket
import string
import re

# ATTRIBUTION-AI: OpRt_.nvidia/llama-3.1-nemotron-ultra-253b-v1:free  2025-04-18  (partially)
# Determine if running on Windows
is_windows = os.name == 'nt'

# ATTRIBUTION-AI: OpRt_.nvidia/llama-3.1-nemotron-ultra-253b-v1:free  2025-04-18  (partially)
# Attempt to import colorama if on Windows
use_colorama = False
if is_windows:
    try:
        from colorama import init, Fore, Back, Style
        init(autoreset=True)
        use_colorama = True
    except ImportError:
        pass  # Silently proceed without colorama if import fails

# Color definitions (use ANSI if not on Windows or colorama is not used)
if use_colorama:
    # ATTRIBUTION-AI: OpRt_.nvidia/llama-3.1-nemotron-ultra-253b-v1:free  2025-04-18  (partially)  ( also the preceeding line  if use_colorama:  )
    class ubPythonPS1(object):
        def __init__(self):
            self.line = 0

        def __str__(self):
            self.line += 1
            user = os.getenv('USER', 'root')
            hostname = socket.gethostname()
            cloud_net_name = os.environ.get('prompt_cloudNetName', '')
            #py_version = f"v{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}"
            ## ATTRIBUTION-AI: OpRt_.nvidia/llama-3.1-nemotron-ultra-253b-v1:free  2025-04-19
            #py_version = f"v{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}" if not os.getenv('VIRTUAL_ENV_PROMPT') else os.getenv('VIRTUAL_ENV_PROMPT', '')
            # ATTRIBUTION-AI: ChatGPT o3  2025-04-19
            py_version = os.getenv("VIRTUAL_ENV_PROMPT") or f"Python-v{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}"
            cwd = os.path.expanduser(os.getcwd())

            home_dir = os.environ.get('HOME', os.environ.get('USERPROFILE', ''))
            if home_dir:
                cwd = re.sub(f'^{re.escape(home_dir)}', '~', cwd)

            # Color definitions (matched to ANSI colors)
            blue = Fore.BLUE
            red = Fore.RED
            green = Fore.GREEN  # Hostname color
            yellow = Fore.YELLOW
            magenta = Fore.MAGENTA  # Python version color
            cyan = Fore.CYAN
            white = Fore.WHITE
            reset = Style.RESET_ALL
            bg_white = Back.WHITE

            if self.line == 1:
                prompt = (
                    f"{blue}|{red}#{red}:{yellow}{user}{green}@{green}{hostname}{blue})-{cloud_net_name}({magenta}{bg_white}{py_version}{reset}{blue}){cyan}|\n"
                    #f"{blue}|{white}[{cwd}]\n"
                    f"{white}{cwd}\n"
                    f"{blue}|{cyan}{self.line}{blue}) {cyan}> {reset}"
                )
            else:
                prompt = (
                    f"{blue}|{red}#{red}:{yellow}{user}{green}@{green}{hostname}{blue})-{cloud_net_name}({magenta}{bg_white}{py_version}{reset}{blue}){cyan}|\n"
                    #f"{blue}|{white}[{cwd}]\n"
                    f"{white}{cwd}\n"
                    f"{blue}|{blue}{self.line}{blue}) {cyan}> {reset}"
                )
            return prompt

    sys.ps1 = ubPythonPS1()
    sys.ps2 = f"{Fore.CYAN}|...{Style.RESET_ALL} "
else:
    # ATTRIBUTION: NOT AI !
    #if sys.hexversion < 0x03060000:
    #	exit(1)
    # https://www.codementor.io/@arpitbhayani/personalize-your-python-prompt-13ts4kw6za
    # https://stackoverflow.com/questions/4271740/how-can-i-use-python-to-get-the-system-hostname
    # https://bugs.python.org/issue20359
    #os.environ['PWD']
    #os.path.expanduser(os.getcwd())
    #\033[0;35;47mpython-%d\033[0m
    #return "\033[92mIn [%d]:\033[0m " % (self.line)
    #return ">>> "
    #return "\033[1;94m|\033[91m#:\033[1;93m%s\033[1;92m@%s\033[1;94m)-%s(\033[1;95m\033[0;35;47mpython-%s\033[0m\033[1;94m)\033[1;96m|\n\033[1;94m|\033[1;97m[%s]\n\033[1;94m|\033[1;96m%d\033[1;94m) \033[1;96m>\033[0m " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion), re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)
    #return "\033[1;94m|\033[91m#:\033[1;93m%s\033[1;92m@%s\033[1;94m)-%s(\033[1;95m\033[0;35;47mpython-%s\033[0m\033[1;94m)\033[1;96m|\n\033[1;94m|\033[1;97m[%s]\n\033[1;94m|%d\033[1;94m) \033[1;96m>\033[0m " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion), re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)
    #os.environ['USER']
    #os.getenv('USER','root')
    class ubPythonPS1(object):
        def __init__(self):
            self.line = 0

        def __str__(self):
            self.line += 1
            if self.line == 1:
                #return "\x01\033[1;94m\x02|\x01\033[91m\x02#:\x01\033[1;93m\x02%s\x01\033[1;92m\x02@%s\x01\033[1;94m\x02)-%s(\x01\033[1;95m\x02\x01\033[0;35;47m\x02python-%s\x01\033[0m\x02\x01\033[1;94m\x02)\x01\033[1;96m\x02|\n\x01\033[1;94m\x02|\x01\033[1;97m\x02[%s]\n\x01\033[1;94m\x02|\x01\033[1;96m\x02%d\x01\033[1;94m\x02) \x01\033[1;96m\x02>\x01\033[0m\x02 " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion), re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)
                #return "\x01\033[1;94m\x02|\x01\033[91m\x02#:\x01\033[1;93m\x02%s\x01\033[1;92m\x02@%s\x01\033[1;94m\x02)-%s(\x01\033[1;95m\x02\x01\033[0;35;47m\x02python-%s\x01\033[0m\x02\x01\033[1;94m\x02)\x01\033[1;96m\x02|\n\x01\033[1;97m\x02%s\n\x01\033[1;94m\x02|\x01\033[1;96m\x02%d\x01\033[1;94m\x02) \x01\033[1;96m\x02>\x01\033[0m\x02 " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion), re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)
                # ATTRIBUTION-AI: OpRt_.nvidia/llama-3.1-nemotron-ultra-253b-v1:free  2025-04-19
                return "\x01\033[1;94m\x02|\x01\033[91m\x02#:\x01\033[1;93m\x02%s\x01\033[1;92m\x02@%s\x01\033[1;94m\x02)-%s(\x01\033[1;95m\x02\x01\033[0;35;47m\x02python-%s\x01\033[0m\x02\x01\033[1;94m\x02)\x01\033[1;96m\x02|\n\x01\033[1;97m\x02%s\n\x01\033[1;94m\x02|\x01\033[1;96m\x02%d\x01\033[1;94m\x02) \x01\033[1;96m\x02>\x01\033[0m\x02 " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion) if 'VIRTUAL_ENV_PROMPT' not in os.environ or not os.environ['VIRTUAL_ENV_PROMPT'] else os.environ['VIRTUAL_ENV_PROMPT'], re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)
            else:
                #return "\x01\033[1;94m\x02|\x01\033[91m\x02#:\x01\033[1;93m\x02%s\x01\033[1;92m\x02@%s\x01\033[1;94m\x02)-%s(\x01\033[1;95m\x02\x01\033[0;35;47m\x02python-%s\x01\033[0m\x02\x01\033[1;94m\x02)\x01\033[1;96m\x02|\n\x01\033[1;94m\x02|\x01\033[1;97m\x02[%s]\n\x01\033[1;94m\x02|%d\x01\033[1;94m\x02) \x01\033[1;96m\x02>\x01\033[0m\x02 " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion), re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)
                #return "\x01\033[1;94m\x02|\x01\033[91m\x02#:\x01\033[1;93m\x02%s\x01\033[1;92m\x02@%s\x01\033[1;94m\x02)-%s(\x01\033[1;95m\x02\x01\033[0;35;47m\x02python-%s\x01\033[0m\x02\x01\033[1;94m\x02)\x01\033[1;96m\x02|\n\x01\033[1;97m\x02%s\n\x01\033[1;94m\x02|%d\x01\033[1;94m\x02) \x01\033[1;96m\x02>\x01\033[0m\x02 " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion), re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)
                # ATTRIBUTION-AI: OpRt_.nvidia/llama-3.1-nemotron-ultra-253b-v1:free  2025-04-19
                return "\x01\033[1;94m\x02|\x01\033[91m\x02#:\x01\033[1;93m\x02%s\x01\033[1;92m\x02@%s\x01\033[1;94m\x02)-%s(\x01\033[1;95m\x02\x01\033[0;35;47m\x02python-%s\x01\033[0m\x02\x01\033[1;94m\x02)\x01\033[1;96m\x02|\n\x01\033[1;97m\x02%s\n\x01\033[1;94m\x02|%d\x01\033[1;94m\x02) \x01\033[1;96m\x02>\x01\033[0m\x02 " % (os.getenv('USER','root'), socket.gethostname(), os.environ.get('prompt_cloudNetName', ''), hex(sys.hexversion) if 'VIRTUAL_ENV_PROMPT' not in os.environ or not os.environ['VIRTUAL_ENV_PROMPT'] else os.environ['VIRTUAL_ENV_PROMPT'], re.sub('^%s' % os.environ['HOME'], '~', os.path.expanduser(os.getcwd()) ), self.line)

    sys.ps1 = ubPythonPS1()
    sys.ps2 = "\x01\033[0;96m\x02|...\x01\033[0m\x02 "


# ATTRIBUTION-AI: OpRt_.nvidia/llama-3.1-nemotron-ultra-253b-v1:free  2025-04-18 (only the next line  if is_windows and not use_colorama:  )
if is_windows and not use_colorama:
    # ATTRIBUTION: NOT AI !
    # https://www.codementor.io/@arpitbhayani/personalize-your-python-prompt-13ts4kw6za
    sys.ps1 = '>>> '
    sys.ps2 = '... '

#_python()

CZXWXcRMTo8EmM8i4d
}


_generate_lean-overrides-python_here() {
	cat << 'CZXWXcRMTo8EmM8i4d'

# WARNING: Strongly discouraged example.
# (strongly prefer to inherit a single os.environ['scriptAbsoluteFolder'] environment variable from being called by an 'ubiquitous_bash' script)
#exec(open(_getScriptAbsoluteFolder()+'/lean.py').read())











# ATTENTION: NOTICE: Environment variables from 'ubiquitous_bash' can be used to import other python scripts.
#exec(open(os.environ['scriptAbsoluteFolder']+'/lean.py').read())

#################################################
# ATTENTION: NOTICE: Add '_prog' script code here!

def _main():
	pass



# ATTENTION: NOTICE: Add '_prog' script code here!
#################################################


import sys
if sys.hexversion > 0x03000000:
	exec('_print = print')

import sys
import string
#./lean.py "_python(c('1 + 2'))" #FAIL
#python3 ./lean.py "_print(c('1 + 2'))"
#python2 ./lean.py "print(c('1 + 2'))"
#./lean.py "_print(c('1 + 2'))"
# https://www.tutorialspoint.com/python/python_command_line_arguments.htm
# https://www.programiz.com/python-programming/methods/built-in/exec
# https://www.geeksforgeeks.org/python-program-to-convert-a-list-to-string/
# https://www.geeksforgeeks.org/python-removing-first-element-of-list/
#print ( 'Argument List:', str(sys.argv) )
#eval( sys.argv[1] + ' ' + ' '.join( sys.argv[2:] ) )
#exec( sys.argv[1] )
#if (1 in sys.argv):
if len(sys.argv) > 1:
	if ( sys.argv[1].startswith('_') ) or ( sys.argv[1].startswith('print') ) :
		exec( sys.argv[1] )


_main()

CZXWXcRMTo8EmM8i4d
}




_generate_lean-python_prog() {
	[[ "$objectName" == "ubiquitous_bash" ]] && return 0
	
	return 1
}

_generate_lean-python() {
	! _generate_lean-python_prog && return 0
	
	echo '#!/usr/bin/env python3' > "$scriptAbsoluteFolder"/lean.py
	
	_generate_lean-lib-python_here "$@" >> "$scriptAbsoluteFolder"/lean.py
	
	_generate_lean-overrides-python_here "$@" >> "$scriptAbsoluteFolder"/lean.py
	
	chmod u+x "$scriptAbsoluteFolder"/lean.py
}






# 
# _python_hook_here() {
# 	cat << CZXWXcRMTo8EmM8i4d
# 	
# 	_setupUbiquitous_accessories_here-python_hook
# 	
# CZXWXcRMTo8EmM8i4d
# }
# 
# 
# _python_hook() {
# 	_messageNormal "init: _python_hook"
# 	local ubHome
# 	ubHome="$HOME"
# 	[[ "$1" != "" ]] && ubHome="$1"
# 	
# 	export ubcoreDir="$ubHome"/.ubcore
# 	
# 	_python_hook_here > "$ubcoreDir"/python_bash_rc
# }
# 
































_findUbiquitous() {
	export ubiquitousLibDir="$scriptAbsoluteFolder"
	export ubiquitiousLibDir="$ubiquitousLibDir"
	
	local scriptBasename=$(basename "$scriptAbsoluteFolder")
	if [[ "$scriptBasename" == "ubiquitous_bash" ]]
	then
		return 0
	fi
	
	if [[ -e "$ubiquitousLibDir"/_lib/ubiquitous_bash ]]
	then
		export ubiquitousLibDir="$ubiquitousLibDir"/_lib/ubiquitous_bash
		export ubiquitiousLibDir="$ubiquitousLibDir"
		return 0
	fi
	
	local ubiquitousLibDirDiscovery=$(find ./_lib -maxdepth 3 -type d -name 'ubiquitous_bash' | head -n 1)
	if [[ "$ubiquitousLibDirDiscovery" != "" ]] && [[ -e "$ubiquitousLibDirDiscovery" ]]
	then
		export ubiquitousLibDir="$ubiquitousLibDirDiscovery"
		export ubiquitiousLibDir="$ubiquitousLibDir"
		return 0
	fi
	
	return 1
}


#####Overrides

[[ "$isDaemon" == "true" ]] && echo "$$" | _prependDaemonPID

#May allow traps to work properly in simple scripts which do not include more comprehensive "_stop" or "_stop_emergency" implementations.
if ! type _stop > /dev/null 2>&1
then
	# ATTENTION: Consider carefully, override with "ops".
	# WARNING: Unfortunate, but apparently necessary, workaround for script termintaing while "sleep" or similar run under background.
	_stop_stty_echo() {
		#true
		
		stty echo --file=/dev/tty > /dev/null 2>&1
		
		#[[ "$ubFoundEchoStatus" != "" ]] && stty --file=/dev/tty "$ubFoundEchoStatus" 2> /dev/null

		return 0
	}
	_stop() {
		_stop_stty_echo
		
		if [[ "$1" != "" ]]
		then
			exit "$1"
		else
			exit 0
		fi
	}
fi
if ! type _stop_emergency > /dev/null 2>&1
then
	_stop_emergency() {
		_stop "$1"
	}
fi

#Traps, if script is not imported into existing shell, or bypass requested.
# WARNING Exact behavior of this system is critical to some use cases.
if [[ "$ub_import" != "true" ]] || [[ "$ub_import_param" == "--bypass" ]]
then
	trap 'excode=$?; _stop $excode; trap - EXIT; echo $excode' EXIT HUP QUIT PIPE 	# reset
	trap 'excode=$?; trap "" EXIT; _stop $excode; echo $excode' EXIT HUP QUIT PIPE 	# ignore
	
	# DANGER: Mechanism of workaround 'ub_trapSet_stop_emergency' is not fully understood, and was added undesirably late in development, with unknown effects. Nevertheless, a need for such functionality is expected to be encountered only rarely.
	# At least '_closeChRoot' , '_userChRoot' , '_userVBox' do not seem to have lost functionality.
	# DANGER: Any shell command matching ' _timeout.*&$ ' (backgrounding of _timeout) will probably be unable to reach '_stop' correctly, and may not remove temporary directories, etc.
	if [[ "$ub_trapSet_stop_emergency" != 'true' ]]
	then
		trap 'excode=$?; _stop_emergency $excode; trap - EXIT; echo $excode' INT TERM	# reset
		trap 'excode=$?; trap "" EXIT; _stop_emergency $excode; echo $excode' INT TERM	# ignore
		export ub_trapSet_stop_emergency='true'
	fi
fi

# DANGER: NEVER intended to be set in an end user shell for ANY reason.
# DANGER: Implemented to prevent 'compile.sh' from attempting to run functions from 'ops.sh'. No other valid use currently known or anticipated!
if [[ "$ub_ops_disable" != 'true' ]]
then
	# WARNING: CAUTION: Use sparingly and carefully . Allows a user to globally override functions for all 'ubiquitous_bash' scripts, projects, etc.
	if [[ -e "$HOME"/_bashrc ]]
	then
		. "$HOME"/_bashrc
	fi
	
	#Override functions with external definitions from a separate file if available.
	#if [[ -e "./ops" ]]
	#then
	#	. ./ops
	#fi

	#Override functions with external definitions from a separate file if available.
	# CAUTION: Recommend only "ops" or "ops.sh" . Using both can cause confusion.
	# ATTENTION: Recommend "ops.sh" only when unusually long. Specifically intended for "CoreAutoSSH" .
	if [[ -e "$objectDir"/ops ]]
	then
		. "$objectDir"/ops
	fi
	if [[ -e "$objectDir"/ops.sh ]]
	then
		. "$objectDir"/ops.sh
	fi
	if [[ -e "$scriptLocal"/ops ]]
	then
		. "$scriptLocal"/ops
	fi
	if [[ -e "$scriptLocal"/ops.sh ]]
	then
		. "$scriptLocal"/ops.sh
	fi
	if [[ -e "$scriptLocal"/ssh/ops ]]
	then
		. "$scriptLocal"/ssh/ops
	fi
	if [[ -e "$scriptLocal"/ssh/ops.sh ]]
	then
		. "$scriptLocal"/ssh/ops.sh
	fi

	#WILL BE OVERWRITTEN FREQUENTLY.
	#Intended for automatically generated shell code identifying usable resources, such as unused network ports. Do NOT use for serialization of internal variables (use $varStore for that).
	if [[ -e "$objectDir"/opsauto ]]
	then
		. "$objectDir"/opsauto
	fi
	if [[ -e "$scriptLocal"/opsauto ]]
	then
		. "$scriptLocal"/opsauto
	fi
	if [[ -e "$scriptLocal"/ssh/opsauto ]]
	then
		. "$scriptLocal"/ssh/opsauto
	fi
fi


# ATTENTION: May be redundantly redefined (ie. overloaded) if appropriate (eg. for use outside a 'ubiquitous_bash' environment).
_backend_override() {
	! type -f _backend > /dev/null 2>&1 && _backend() { "$@" ; unset -f _backend ; }
	_backend "$@"
}
## ...
## EXAMPLE
#! _openChRoot && _messageFAIL
## ...
#_backend() { _ubdistChRoot "$@" ; }
#_backend_override echo test
#unset -f _backend
## ...
#! _closeChRoot && _messageFAIL
## ...
## EXAMPLE
#_ubdistChRoot_backend_begin
#_backend_override echo test
#_ubdistChRoot_backend_end
## ...
## EXAMPLE
#_experiment() { _backend_override echo test ; }
#_ubdistChRoot_backend _experiment



#wsl '~/.ubcore/ubiquitous_bash/ubiquitous_bash.sh' '_wrap' kwrite './gpl-3.0.txt'
#wsl '~/.ubcore/ubiquitous_bash/ubiquitous_bash.sh' '_wrap' ldesk
_wrap() {
	[[ "$LANG" != "C" ]] && export LANG=C
	. "$HOME"/.ubcore/.ubcorerc
	
	_safe_declare_uid
	
	if uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1
	then
		local currentArg
		local currentResult
		processedArgs=()
		for currentArg in "$@"
		do
			currentResult=$(wslpath -u "$currentArg")
			if [[ -e "$currentResult" ]]
			then
				true
			else
				currentResult="$currentArg"
			fi
			
			processedArgs+=("$currentResult")
		done
		
		
		"${processedArgs[@]}"
		return
	fi
	
	"$@"
}

#Wrapper function to launch arbitrary commands within the ubiquitous_bash environment, including its PATH with scriptBin.
_bin() {
	# Less esoteric than calling '_bash _bash', but calling '_bin _bin' is still not useful, and filtered out for Python scripts which may call either 'ubiquitous_bash.sh' or '_bash.bat' interchangeably.
	#  CAUTION: Shifting redundant '_bash' parameters is necessary for some Python scripts.
	if [[ "$1" == ${FUNCNAME[0]} ]] && [[ "$2" == ${FUNCNAME[0]} ]]
	then
		shift
		shift
	else
		[[ "$1" == ${FUNCNAME[0]} ]] && shift
	fi

	_safe_declare_uid
	
	"$@"
}
#Mostly intended to launch bash prompt for MSW/Cygwin users.
_bash() {
	# CAUTION: NEVER call _bash _bash , etc . This is different from calling '_bash "$scriptAbsoluteLocation" _bash', or '_bash -c bash -i' (not that those are known workable or useful either), cannot possibly provide any useful functionality (since 'bash' called by '_bash' is in the same environment), will only cause issues for no benefit, so don't.
	# ATTENTION: In practice, this can happen incidentally, due to calling '_bash.bat' instead of 'ubiquitous_bash.sh' to call '_bash' function, since MSW would not be able to run 'ubiquitous_bash.sh' without an anchor batch script properly calling Cygwin bash.exe . Python scripts which may call either 'ubiquitous_bash.sh' or '_bash.bat' interchangeably benefit from this, because the '_bash' parameter does not need to change depending on Native/MSW or UNIX/Linux. Since there is no useful purpose to calling '_bash _bash', etc, simply always dismissing the redundant '_bash' parameter is reasonable.
	#  CAUTION: Shifting redundant '_bash' parameters is necessary for some Python scripts.
	if [[ "$1" == "_bash" ]] && [[ "$2" == "_bash" ]]
	then
		shift
		shift
	else
		[[ "$1" == "_bash" ]] && shift
	fi

	_safe_declare_uid
	
	local currentIsCygwin
	currentIsCygwin='false'
	[[ -e '/cygdrive' ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && _if_cygwin && currentIsCygwin='true'
	
	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	[[ "$currentIsCygwin" == 'true' ]] && echo -n '.'
	
	
	_visualPrompt
	[[ "$ub_scope_name" != "" ]] && _scopePrompt
	
	_safe_declare_uid


	## CAUTION: Usually STUPID AND DANGEROUS . No production use. Exclusively for 'ubiquitous_bash' itself development.
	## Proper use of embedded scripts, '--embed', etc, is provided by the '_scope' functions, etc, intended for such purposes in almost all cases.
	##
	## WARNING: May be untested. May break 'python', 'bash', 'octave', etc. May break any '.bashrc', '.ubcorerc', python hooks, other hooks, etc. May break '_setupUbiquitous'.
	## Bad idea. Very specialized. Broken inheritance.
	##
	## No known use.
	## Functions, etc, are NOT inherited by bash terminal from script.
	##
	#if [[ "$1" == "--norc" ]] && [[ "$2" == "-i" ]] && [[ "$scriptAbsoluteLocation" == *"ubcore.sh" ]]
	#then
		#bash "$@"
		#return
	#fi
	
	
	[[ "$1" == '-i' ]] && shift
	
	
	_safe_declare_uid
	
	if [[ "$currentIsCygwin" == 'true' ]] && grep ubcore "$HOME"/.bashrc > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" == *"lean.sh" ]]
	then
		export sessionid=""
		export scriptAbsoluteFolder=""
		export scriptAbsoluteLocation=""
		bash -i "$@"
		return
	elif  [[ "$currentIsCygwin" == 'true' ]] && grep ubcore "$HOME"/.bashrc > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" != *"lean.sh" ]]
	then
		bash -i "$@"
		return
	elif [[ "$currentIsCygwin" == 'true' ]] && ! grep ubcore "$HOME"/.bashrc > /dev/null 2>&1
	then
		bash --norc -i "$@"
		return
	else
		bash -i "$@"
		return
	fi
	
	bash -i "$@"
	return
	
	return 1
}

#Mostly if not entirely intended for end user convenience.
_python() {
	_safe_declare_uid
	
	if [[ -e "$safeTmp"/lean.py ]]
	then
		"$safeTmp"/lean.py '_python()'
		return
	fi
	if [[ -e "$scriptAbsoluteFolder"/lean.py ]]
	then
		"$scriptAbsoluteFolder"/lean.py '_python()'
		return
	fi
	if type -p 'lean.py' > /dev/null 2>&1
	then
		lean.py '_python()'
		return
	fi
	return 1
}

#Launch internal functions as commands, and other commands, as root.
_sudo() {
	_safe_declare_uid
	
	if ! _if_cygwin
	then
		sudo -n "$scriptAbsoluteLocation" _bin "$@"
		return
	fi
	if _if_cygwin
	then
		_sudo_cygwin "$@"
		return
	fi
	
	return 1
}

_true() {
	_safe_declare_uid
	
	#"$scriptAbsoluteLocation" _false && return 1
	#  ! "$scriptAbsoluteLocation" _bin true && return 1
	#"$scriptAbsoluteLocation" _bin false && return 1
	true
}
_false() {
	_safe_declare_uid
	
	false
}
_echo() {
	_safe_declare_uid
	
	echo "$@"
}

_diag() {
	_safe_declare_uid
	
	echo "$sessionid"
}

#Stop if script is imported, parameter not specified, and command not given.
if [[ "$ub_import" == "true" ]] && [[ "$ub_import_param" == "" ]] && [[ "$1" != '_'* ]]
then
	_messagePlain_warn 'import: missing: parameter, missing: command' | _user_log-ub
	ub_import=""
	return 1 > /dev/null 2>&1
	exit 1
fi

#Set "ubOnlyMain" in "ops" overrides as necessary.
if [[ "$ubOnlyMain" != "true" ]]
then
	
	#Launch command named by link name.
	if scriptLinkCommand=$(_getScriptLinkName)
	then
		if [[ "$scriptLinkCommand" == '_'* ]]
		then
			if [[ "$ubDEBUG" == "true" ]]
			then
				# ATTRIBUTION-AI: ChatGPT o3  2025-06-06
				exec 3>&2
				#export BASH_XTRACEFD=3
				set   -o functrace
				set   -o errtrace
				# May break _test_pipefail_sequence .
				#export SHELLOPTS
				trap '
  set -E +x
  call_line=${BASH_LINENO[0]}
  call_file=${BASH_SOURCE[1]}
  [[ $call_file == "$PWD/"* ]] && call_file=${call_file#"$PWD/"}
  func_name=${FUNCNAME[0]:-MAIN}

  if [[ "$call_line" != "0" ]] && [[ func_name != "MAIN()" ]]
  then
	# extract the source line and strip leading blanks
	call_text=$(sed -n "${call_line}{s/^[[:space:]]*//;p}" "$call_file")

	printf "<<<STEPOUT<<< RETURN %s() <- %s:%d : %s  status=%d\n" \
			"$func_name"        "$call_file" \
			"$call_line"        "$call_text" \
			"$?" >&3
  fi
  set -E -x
' RETURN
				set -E -x
				#set -x
			fi
			
			"$scriptLinkCommand" "$@"
			internalFunctionExitStatus="$?"

			if [[ "$ubDEBUG" == "true" ]] ; then set +x ; set +E ; set +o functrace ; set +o errtrace ; export -n SHELLOPTS 2>/dev/null || true ; trap '' RETURN ; trap - RETURN ; fi
			
			#Exit if not imported into existing shell, or bypass requested, else fall through to subsequent return.
			if [[ "$ub_import" != "true" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--compressed" ]]
			then
				#export noEmergency=true
				exit "$internalFunctionExitStatus"
			fi
			ub_import=""
			return "$internalFunctionExitStatus" > /dev/null 2>&1
			exit "$internalFunctionExitStatus"
		fi
	fi
	
	# NOTICE Launch internal functions as commands.
	#if [[ "$1" != "" ]] && [[ "$1" != "-"* ]] && [[ ! -e "$1" ]]
	#if [[ "$1" == '_'* ]] || [[ "$1" == "true" ]] || [[ "$1" == "false" ]]
	# && [[ "$1" != "_test" ]] && [[ "$1" != "_setup" ]] && [[ "$1" != "_build" ]] && [[ "$1" != "_vector" ]] && [[ "$1" != "_setupCommand" ]] && [[ "$1" != "_setupCommand_meta" ]] && [[ "$1" != "_setupCommands" ]] && [[ "$1" != "_find_setupCommands" ]] && [[ "$1" != "_setup_anchor" ]] && [[ "$1" != "_anchor" ]] && [[ "$1" != "_package" ]] && [[ "$1" != *"_prog" ]] && [[ "$1" != "_main" ]] && [[ "$1" != "_collect" ]] && [[ "$1" != "_enter" ]] && [[ "$1" != "_launch" ]] && [[ "$1" != "_default" ]] && [[ "$1" != "_experiment" ]]
	if [[ "$1" == '_'* ]] && type "$1" > /dev/null 2>&1 && [[ "$1" != "_test" ]] && [[ "$1" != "_setup" ]] && [[ "$1" != "_build" ]] && [[ "$1" != "_vector" ]] && [[ "$1" != "_setupCommand" ]] && [[ "$1" != "_setupCommand_meta" ]] && [[ "$1" != "_setupCommands" ]] && [[ "$1" != "_find_setupCommands" ]] && [[ "$1" != "_setup_anchor" ]] && [[ "$1" != "_anchor" ]] && [[ "$1" != "_package" ]] && [[ "$1" != *"_prog" ]] && [[ "$1" != "_main" ]] && [[ "$1" != "_collect" ]] && [[ "$1" != "_enter" ]] && [[ "$1" != "_launch" ]] && [[ "$1" != "_default" ]] && [[ "$1" != "_experiment" ]]
	then
		if [[ "$ubDEBUG" == "true" ]]
		then
			# ATTRIBUTION-AI: ChatGPT o3  2025-06-06
			exec 3>&2
			#export BASH_XTRACEFD=3
			set   -o functrace
			set   -o errtrace
			# May break _test_pipefail_sequence .
			#export SHELLOPTS
			trap '
  set -E +x
  call_line=${BASH_LINENO[0]}
  call_file=${BASH_SOURCE[1]}
  [[ $call_file == "$PWD/"* ]] && call_file=${call_file#"$PWD/"}
  func_name=${FUNCNAME[0]:-MAIN}

  if [[ "$call_line" != "0" ]] && [[ func_name != "MAIN()" ]]
  then
    # extract the source line and strip leading blanks
    call_text=$(sed -n "${call_line}{s/^[[:space:]]*//;p}" "$call_file")

    printf "<<<STEPOUT<<< RETURN %s() <- %s:%d : %s  status=%d\n" \
            "$func_name"        "$call_file" \
            "$call_line"        "$call_text" \
            "$?" >&3
  fi
' RETURN
			set -E -x
			#set -x
		fi
		
		"$@"
		internalFunctionExitStatus="$?"
		
		if [[ "$ubDEBUG" == "true" ]] ; then set +x ; set +E ; set +o functrace ; set +o errtrace ; export -n SHELLOPTS 2>/dev/null || true ; trap '' RETURN ; trap - RETURN ; fi
		
		#Exit if not imported into existing shell, or bypass requested, else fall through to subsequent return.
		if [[ "$ub_import" != "true" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--compressed" ]]
		then
			#export noEmergency=true
			exit "$internalFunctionExitStatus"
		fi
		ub_import=""
		return "$internalFunctionExitStatus" > /dev/null 2>&1
		exit "$internalFunctionExitStatus"
		#_stop "$?"
	fi
fi

[[ "$ubOnlyMain" == "true" ]] && export ubOnlyMain="false"

#Do not continue script execution through program code if critical global variables are not sane.
[[ ! -e "$scriptAbsoluteLocation" ]] && exit 1
[[ ! -e "$scriptAbsoluteFolder" ]] && exit 1
_failExec || exit 1

#Return if script is under import mode, and bypass is not requested.
# || [[ "$current_internal_CompressedScript" != "" ]] || [[ "$current_internal_CompressedScript_cksum" != "" ]] || [[ "$current_internal_CompressedScript_bytes" != "" ]]
if [[ "$ub_import" == "true" ]] && ! ( [[ "$ub_import_param" == "--bypass" ]] ) || [[ "$ub_import_param" == "--compressed" ]] || [[ "$ub_import_param" == "--parent" ]] || [[ "$ub_import_param" == "--profile" ]]
then
	return 0 > /dev/null 2>&1
	exit 0
fi


#####Entry

# WARNING: Do not add code directly here without disabling checksum!
# WARNING: Checksum may only be disabled either by override of 'generic/minimalheader.sh' or by adding appropriate '.nck' file !

#"$scriptAbsoluteLocation" _setup




if [[ "$1" == '_'* ]] && type "$1" > /dev/null 2>&1
then
	"$@"
	internalFunctionExitStatus="$?"
	return "$internalFunctionExitStatus" > /dev/null 2>&1
	exit "$internalFunctionExitStatus"
fi
if [[ "$1" != '_'* ]]
then
	_main "$@"
fi

