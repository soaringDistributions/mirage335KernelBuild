<!-- scriptedIllustrator_markup_uk4uPhB663kVcygT0q 
#exit # scriptedIllustrator_markup_uk4uPhB663kVcygT0q 
# <html style="size: letter;"> <!-- scriptedIllustrator_markup_uk4uPhB663kVcygT0q
#!/usr/bin/env bash

# Dependencies.
# May need 'ubiquitous_bash.sh" in "$PATH".
# GNU Octave, Qalculate - usually dependency of 'calculator' scripts
# recode - usually dependency of 'markup documentation' scripts
# wkhtmltopdf - may be necessary for accurate conversion from HTML to PDF

# NOTICE: README !
# 
# 
# 
# NOTICE: README !

# CAUTION: As a user, you should have been provided a virtual machine or cloud services to run this script - 'ubiquitous bash' provides functions to ease the use of either and both. An SELinux, AppArmor, unprivileged ChRoot, or similar context may be acceptable as well. Routinely modifying, sharing, and running code, may otherwise put both users and organizations at possibly unnecessary risk.


# Copyright and related rights only waived via CC0 if all specified conditions are met.
# *) EITHER, a single file directly output from 'scriptedIllustrator' (which is GPLv3 licensed), OR, not otherwise claimed under other any copyright license.
# *) Is a documentation script including this message which also predominantly creates or represents markup (eg. 'scriptedIllustrator.sh', 'scriptedIllustrator.html', 'scriptedIllustrator.mediawiki.txt').
# *) NOT part of a program to compress, embed, and assemble, functions and other code (waiver does NOT apply to 'tinyCompiler_scriptedIllustrator.sh' ).

# To the extent possible, related software (ie. 'tinyCompiler_scriptedIllustrator.sh' from 'scriptedIllustrator') remains otherwise copyrighted (ie. GPLv3 license).
# Specifically, please do not use 'scriptedIllustrator' code to distribute unpublished proprietary means of creating 'current_internal_CompressedFunctions' .
# Specifically, please do not misconstrue this copyright waiver to negate any copyright claimed when such a documentation script is part of another project or another copyright notice is present (ie. 'otherwise claimed').

# 'For the avoidance of doubt, any information that you choose to store within your own copy' ... 'remains yours' ... 'using' ... 'to publish content doesn't change whatever rights you may have to that content.'
# Although this project has no relation to TiddlyWiki, as stated above, vaguely similar copyright principles are expected to apply. - https://tiddlywiki.com/static/License.html

#__README_uk4uPhB663kVcygT0q_README__


_document_collect() {
# NOTICE: COLLECT

# Not necessary. Warnings about 'command not found' to 'stderr' will be ignored by script pipelines.
#! type -p 'recode' > /dev/null 2>&1 && recode() { false; }


currentByte=8

RECODE_markup_html_pre_begin=$(_safeEcho "$markup_html_pre_begin" | recode ascii..html)


export current_lorem_ipsum='Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'


# NOTICE: COLLECT
}



_document_main() {
#a
#b
# NOTICE: DOCUMENT
#__HEADER_uk4uPhB663kVcygT0q_HEADER__
 '_heading1' 'Statement'
if false; then true; # -->
<!-- # --><h1>Statement</h1>
<!--
fi
 '_o_' '_kernelConfig_server "$scriptAbsoluteFolder"/.config'
if false; then true; # -->
<!-- # --><pre style="-webkit-print-color-adjust: exact;background-color:#848484;margin-top: 0px;margin-bottom: 0px;white-space: pre-wrap;">
<!-- # --><span style="color:#54ff54;background-color:#18b2b2;"> kernelConfig: server</span>
<!-- # --><span style="color:#54ff54;background-color:#18b2b2;"> kernelConfig: desktop</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: tradeoff-legacy</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> Carefully evaluate 'tradeoff-legacy' for specific use cases.</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: tradeoff-harden</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> Carefully evaluate 'tradeoff-harden' for specific use cases.</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_PAGE_TABLE_ISOLATION</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_RETPOLINE</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_RETHUNK</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_UNRET_ENTRY</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_CALL_DEPTH_TRACKING</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_IBPB_ENTRY</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_IBRS_ENTRY</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_SRSO</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_GDS</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_MDS</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_TAA</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_MMIO_STALE_DATA</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_L1TF</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_RETBLEED</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_SPECTRE_V1</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_SPECTRE_V2</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_SRBDS</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: MITIGATION_SSB</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_X86_SGX_kVM</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_INTEL_TDX_GUEST</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: TDX_GUEST_DRIVER</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_DEBUG_CREDENTIALS</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_UBSAN_LOCAL_BOUNDS</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_CFI_CLANG</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_GCC_PLUGINS</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_GCC_PLUGIN_LATENT_ENTROPY</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_GCC_PLUGIN_STRUCTLEAK</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_GCC_PLUGIN_STACKLEAK</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: CONFIG_GCC_PLUGIN_RANDSTRUCT</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    N: CONFIG_KEXEC</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CONFIG_EFI_DISABLE_PCI_DMA</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: virtualization-accessory</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: KVM_HYPERV</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: virtualbox</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: boot</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: arch-x64</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> request: -march=sandybridge -mtune=skylake</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> export KCFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> export KCPPFLAGS="-O2 -march=sandybridge -mtune=skylake -pipe"</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> hazard: MCORE2: CONFIG_MCORE2=y</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: accessory</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: build</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: latency</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CPU_FREQ_DEFAULT_GOV_ONDEMAND</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> hazard: CONFIG_PREEMPT: CONFIG_PREEMPT=y</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> hazard: CONFIG_PREEMPT_RT: </span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     N: CONFIG_DEBUG_NOTIFIERS</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: memory</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CONFIG_FRONTSWAP</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: integration</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> hazard: CONFIG_NTFS_RW: </span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CONFIG_GENTOO_LINUX</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CONFIG_GENTOO_LINUX_UDEV</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CONFIG_GENTOO_LINUX_PORTAGE</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CONFIG_GENTOO_LINUX_INIT_SCRIPT</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:    Y: CONFIG_GENTOO_LINUX_INIT_SYSTEMD</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: investigation</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:  M/Y: ACPI_HMAT</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:  M/Y: CONFIG_UCLAMP_TASK</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:  M/Y: CPU_IDLE_GOV_TEO</span>
<!-- # --><span style="color:#ffff54;background-color:#848484;"> warn: not:  M/Y: LOCK_EVENT_COUNTS</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: investigation: docker</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: investigation: prog</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: convenience</span>
<!-- # --><span style="color:#18b2b2;background-color:#848484;"> kernelConfig: special</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: X86_FRED</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: SLAB_BUCKETS</span>
<!-- # --><span style="color:#b21818;background-color:#848484;"> bad: not:     Y: BLK_DEV_WRITE_MOUNTED</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> request: make menuconfig</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> request: make -j $(nproc)</span>
<!-- # --><span style="color:#b218b2;background-color:#848484;"> request: make deb-pkg -j $(nproc)</span>
<!-- # --></pre>
<!--
fi
 '_heading1' 'Description'
if false; then true; # -->
<!-- # --><h1>Description</h1>
<!--
fi
_t '
scriptedIllustrator_markup_uk4uPhB663kVcygT0q --><!-- # --><pre style="margin-top: 0px;margin-bottom: 0px;white-space: pre-wrap;">Linux kernel &#39;mainline&#39; &#39;intel&#39; . Config file in this 
directory. 

May be exact duplicate of config from &#39;lts&#39; . 
<!-- # --></pre><!-- scriptedIllustrator_markup_uk4uPhB663kVcygT0q
'
 '_heading1' 'Reference'
if false; then true; # -->
<!-- # --><h1>Reference</h1>
<!--
fi
_t '
scriptedIllustrator_markup_uk4uPhB663kVcygT0q --><!-- # --><pre style="margin-top: 0px;margin-bottom: 0px;white-space: pre-wrap;"> 
<!-- # --></pre><!-- scriptedIllustrator_markup_uk4uPhB663kVcygT0q
'



#__FOOTER_uk4uPhB663kVcygT0q_FOOTER__
# NOTICE: DOCUMENT
#y
#z
echo -e '\n\n'
}



# NOTICE: Overrides - new functions .


# NOTICE: Overrides - new functions .


#####Functions. Some may be from 'ubiquitous bash' .
#_compressedFunctions_uk4uPhB663kVcygT0q_compressedFunctions_uk4uPhB663kVcygT0q_compressedFunctions_uk4uPhB663kVcygT0q_compressedFunctions
current_internal_CompressedFunctions_bytes="12375"
current_internal_CompressedFunctions_cksum="3023785929"
current_internal_CompressedFunctions="
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"
! echo "$current_internal_CompressedFunctions" | base64 -d | xz -d > /dev/null && exit 1
source <( echo "$current_internal_CompressedFunctions" | base64 -d | xz -d )
unset current_internal_CompressedFunctions ; unset current_internal_CompressedFunctions_cksum ; unset current_internal_CompressedFunctions_bytes
# https://github.com/mirage335/scriptedIllustrator
#_compressedFunctions_uk4uPhB663kVcygT0q_compressedFunctions_uk4uPhB663kVcygT0q_compressedFunctions_uk4uPhB663kVcygT0q_compressedFunctions
! _tiny_criticalDep && exit 1

# Special Global Variables
_tiny_set_strings


#####Import ( 'ubiquitous bash' ) .
# WARNING: Do NOT invoke complicated 'ubiquitous bash' functions directly (ie. call "ubiquitous_bash.sh" as a binary from PATH instead) .
# WARNING: If '--call' parameter is changed, 'trap' conflict may occur in some functions (ie. ( '_test_default' ) .
# Keeps "$scriptAbsoluteLocation" pointing to this script file (not 'ubiquitous_bash.sh' ), intentionally.
# Import of 'ubiquitous_bash.sh' intended ONLY to provide most recent 'message' and similar functions.
#_messagePlain_probe() { return; }
! type -p "ubiquitous_bash.sh" > /dev/null 2>&1 && exit 1
current_script_path=$(type -p "ubiquitous_bash.sh")
[[ ! -e "$current_script_path" ]] && exit 1
! ls -l "$current_script_path" 2>/dev/null | grep 'ubiquitous_bash.sh$' > /dev/null 2>&1 && exit 1
export importScriptLocation=$(_getScriptAbsoluteLocation)
export importScriptFolder=$(_getScriptAbsoluteFolder)
. "$current_script_path" --call
[[ "$ubiquitousBashID" != "uk4uPhB663kVcygT0q" ]] && exit 1
unset current_script_path
#_messagePlain_probe "$scriptAbsoluteLocation"
#exit 0



#a
#b
#c
#__HEADER-scriptCode_uk4uPhB663kVcygT0q_HEADER-scriptCode__
#1
#2
#3



#8
#9
#0
#__FOOTER-scriptCode_uk4uPhB663kVcygT0q_FOOTER-scriptCode__
#x
#y
#z

# NOTICE: Overrides ( 'ops.sh' equivalent ).

_default() {
	local current_deleteScriptLocal
	current_deleteScriptLocal="false"
	[[ ! -e "$scriptLocal" ]] && current_deleteScriptLocal="true"
	
	"$scriptAbsoluteLocation" DOCUMENT > "$scriptAbsoluteLocation".out.txt
	
	_scribble_markdown "$@"
	_scribble_html "$@"
	_scribble_html_presentation "$@"
	_scribble_pdf "$@"
	
	
	local currentScriptBasename
	currentScriptBasename=$(basename "$scriptAbsoluteLocation" | sed 's/\.[^.]*$//')
	
	
	#"$scriptAbsoluteFolder"/"$currentScriptBasename".html _test
	
	[[ "$current_deleteScriptLocal" == "true" ]] && rmdir "$scriptLocal" > /dev/null 2>&1
}

# NOTICE: Overrides ( 'ops.sh' equivalent ).


_test() {
	"$scriptAbsoluteLocation" _test_default "$@"
}

if ! [[ "$1" == '_'* ]] && [[ "$1" == 'DOCUMENT' ]]
then
	_document_collect
	_document_main
fi

! [[ "$1" == '_'* ]] && [[ "$1" == 'DOCUMENT' ]] && exit 0
if [[ "$1" == '_'* ]]
then
	"$@"
	exit "$?"
fi



_default "$@"






exit 0
# Append base64 encoded attachment file here.
__ATTACHMENT_uk4uPhB663kVcygT0q_ATTACHMENT__


filename.html # scriptedIllustrator_markup_uk4uPhB663kVcygT0q --> </html>
