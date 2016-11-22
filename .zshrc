# ORGANIZATION OF FILE
#
# 1) zsh configurations
#
# 2) exports
#       path
#       user config
#       android
#
# 3) aliases
#
# 4) functions


##############  BEGIN OF ZSH CONFIG #############################


# zsh config

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh
source /usr/local/bin/aws_zsh_completer.sh
plugins=(git osx brew)
export HELPDIR=/usr/local/share/zsh/help
export VIM_MODE_ON=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

##############  END OF ZSH CONFIG   #############################



##################  BEGIN EXPORT    #############################


#################   BEGIN SETTING BIGDATA ENV ######

# add HADOOP
export HADOOP_HOME=/usr/local/Cellar/hadoop/2.7.1/
export HADOOP_MAPRED_HOME=$HADOOP
export HADOOP_COMMON_HOME=$HADOOP
export HADOOP_HDFS_HOME=$HADOOP
export HADOOP_PREFIX=$HADOOP_HOME
export HADOOP_LOG_DIR=$HADOOP_HOME/libexec/logs
export HADOOP_CONF_DIR=$HADOOP_HOME/libexec/etc/hadoop
export YARN_HOME=HADOOP_HOME

# add mahout
export MAHOUT_HOME=/usr/local/Cellar/mahout/0.11.0/

# add Hive
export HIVE_HOME=/usr/local/Cellar/hive/2.1.2/libexec


####################    END OF SETTING MANPATH ##



#################   BEGIN SETTING PATH  #########

# export for PATH

# add basic PATH with "brew bin" path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# add java to PATH using jenv to manage jdk version dynamically
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="$HOME/.jenv/bin:$PATH"
export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'

# add tex to PATH
# because of SIP, we cannot create this soft link
#export PATH=/usr/texbin:$PATH
# Going to hard code the path. RIP sanity
export PATH="/usr/local/texlive/2014basic/bin/x86_64-darwin":$PATH

# add perl, CPAN to PATH
export PATH="/Users/vb/perl5/bin${PATH+:}${PATH}";

####################    END OF SETTING PATH #####


#################   BEGIN SETTING Perl env  #####

# export for Perl
export PERL5LIB="/Users/vb/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="/Users/vb/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base \"/Users/vb/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/Users/vb/perl5"

####################    END OF SETTING Perl #####


#################   BEGIN SETTING MANPATH #######

# export for man

# add tex man
export MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH

####################    END OF SETTING MANPATH ##


# export for user

export EDITOR=/usr/local/bin/vi
export PAGER=/usr/bin/less
##########    END OF SETTING usr config #########


##### BEGIN SETTING ANDROID SDK, NDK, HOME  #####

#export for android
export _ANDROID_SDK=/usr/local/android-sdk
export _ANDROID_NDK=/usr/local/android-ndk

# below are actually symlinks to the desired version
# use ch_sdk.sh and ch_ndk.sh to change verisons.
export ANDROID_SDK=$_ANDROID_SDK/sdk
export ANDROID_NDK=$_ANDROID_NDK/ndk
export ANDROID_HOME=$ANDROID_SDK

# add adb and fastboot to PATH
export PATH=$PATH:"$ANDROID_SDK/platform-tools"

#####   END OF SETTING ANDROID SDK, NDK, HOME  ##


############    END OF export   #################################



##########  BEGIN SETTING aliases   #############################


# aliases to uncomplicate life
alias cls="clear "
alias cl="clear "
alias clsl="clear ; ls -F "
alias cp="cp -v "
alias mv="mv -v "
alias ls="ls -G -F "
alias l="ls -F -1 "
alias ll="ls -l -F "
alias lh="ls -l -h -F "
alias tree="tree -C -h "
alias du="du -h "
alias df="df -h "
alias grep="grep_better" # alias to function. refer to function section.
alias grep.orig="/usr/bin/grep "
alias app="open -a "
alias cd..="cd .."

alias die="sudo shutdown -h now"
alias trash_clear="rm -rf ~/.Trash/*"
alias launch_root_atom="sudo -b ~/Applications/Atom.app/Contents/MacOS/Atom 2>/dev/null"
alias vi="mvim -v "
alias gvim="mvim "
alias sanitize_macosx='find . "-name" ".DS_Store" | xargs rm -f '

# aliases for common spelling mistakes
alias amke="make "
alias sl="ls -G -F "
alias suod="sudo "


########    END SETTING aliases #################################



############### BEGIN DEFINITION OF FUNCTIONS   #################


# my version of grep that prints \n after each result
#also retains colored output if piped. eg: grep_better foo | less
grep_better()
{
	/usr/bin/grep --color=always $@ | awk '{print $0,"\n"}'
}

# list binary
lb()
{
	ls -l -h -F `where $@`
}

# used rarely to capture temp of processor. outdated, may not work.
log_temp()
{
	while true;do
		date | awk '{print $1, $2, $3, $4;}' | tr '\n' ' '; gettemp
		sleep $1
	done >> ~/$2 &
	tail -f ~/$2 
}

# extract mp3 from mp4
mp4_to_mp3() {
    if [ $# -eq 0 ]; then
        echo "USAGE : mp4_to_mp3 <input mp4> [<output mp3>] [<bitrate>]"
        echo "Defaults : <output mp3> ==> inputfile.mp3\n\t<bitrate> ==> 320K"
    elif [ $# -eq 1 ]; then
        out=`echo $1 | sed 's/\.mp4$/\.mp3/'`
        ffmpeg -i $1 -b:a 320K $out
    elif [ $# -eq 2 ]; then
        ffmpeg -i $1 -b:a 320K $2
    else
        ffmpeg -i $1 -b:a $3 $2
    fi
}
m4a_to_mp3() {
    if [ $# -eq 0 ]; then
        echo "USAGE : m4a_to_mp3 <input m4a> [<output mp3>] [<bitrate>]"
        echo "Defaults : <output mp3> ==> inputfile.mp3\n\t<bitrate> ==> 320K"
    elif [ $# -eq 1 ]; then
        out=`echo $1 | sed 's/\.m4a$/\.mp3/'`
        ffmpeg -i $1 -b:a 320K $out
    elif [ $# -eq 2 ]; then
        ffmpeg -i $1 -b:a 320K $2
    else
        ffmpeg -i $1 -b:a $3 $2
    fi
}


#####   BEGIN DIRECTORY TRAVERSAL FUNCTIONS #####

# mkdir and cd to it
mkcd()
{
	mkdir -p $@
	cd $@
}

# mkdir the first arg, mv the remaining args to the newly created dir
mkmv()
{
	is_first=1
	for i in $@; do
		if [ $is_first -eq 1 ]; then
			mkdir -p $i
			is_first=0
		else
			mv $i $1
		fi
	done
}

# mkdir the first arg, cp the remaining args to the newly created dir
mkcp()
{
	is_first=1
	for i in $@; do
		if [ $is_first -eq 1 ]; then
			mkdir -p $i
			is_first=0
		else
			cp -r $i $1
		fi
	done
}

# traverse up the fs structure arg times
up()
{
        p=`pwd`
        for i in `seq $@`; do
                p=$p"/.."
        done
        p=$p"/"
        cd $p
        pwd
}

rm_ds_store()
{
    if [ $# -eq 0 ]; then
        echo "USAGE : rm_ds_store <dir_path> +"
        echo "Think REGEX '+'"
        return 1
    fi
    find $1 "-name" ".DS_Store" | xargs rm
}


######### END DIRECTORY TRAVERSAL FUNCTIONS #####


#########   BEGIN VM CONTROL FUNCTIONS    #######

# start up the vm with no GUI
arch-up()
{
	echo "starting VM"
	vmrun -T fusion start ~/Fusion\ VM/archLinux.vmwarevm nogui
	echo "VM UP"
	vmrun list
}

# startup the VM and login via SSH
arch-login()
{
	arch-up
	echo "Trying to ssh"
	sleep 3
    if [ $@ ]; then
	    ssh $@@vb-fusion.local
    else
        ssh vb-arch@vb-fusion.local
    fi
}

# suspend the VM
arch-suspend()
{
	echo "Shutting VM"
	vmrun -T fusion suspend ~/Fusion\ VM/ArchLinux.vmwarevm
	echo "VM DOWN"
	vmrun list
}

# shut down the VM
arch-down()
{
	echo "Shutting VM"
	vmrun -T fusion stop ~/Fusion\ VM/ArchLinux.vmwarevm
	echo "VM DOWN"
	vmrun list
}


invert_vm_ip()
{
    old=`cat /etc/hosts | /usr/bin/grep "vb-fusion" | awk '{print $1}'`
    new=""
    if [[ "$old" == "172.16.25.132" ]]; then
        new="172.16.25.131"
    fi
    if [[ "$old" == "172.16.25.131" ]]; then
        new="172.16.25.132"
    fi
    if [[ "$new" == "" ]]; then
        echo "Couldnot find correct ip"
        exit
    fi
    echo $old
    echo $new
    cmd="s/$old/$new"
    sed -e 's/'$old'/'$new'/' /etc/hosts >/tmp/sed_tmp_file
    sudo mv /tmp/sed_tmp_file /etc/hosts
}

# start apache httpd server
start_apache_srv()
{
    arch-up
    ssh root@vb-fusion.local "systemctl start httpd.service"
    mount_http_srv
}

# mount the Document Root of httpd on mac
mount_http_srv()
{
    sudo mount -o resvport,rw -t nfs vb-fusion.local:/srv/http /Volumes/vb-fusion-srv-http
}

# unmount Mac NFS, stop server
stop_apache_srv()
{
    umount_http_srv
    ssh root@vb-fusion.local "systemctl stop httpd.service"
}

umount_http_srv()
{
    sudo umount /Volumes/vb-fusion-srv-http
}


########    END VM CONTROL FUCNTIONS    #########

########    AWS Helper Fns              #########

aws_start_vm() {
    (_inst=`aws_get_instanceid_by_tag $@` && aws_startinstance_by_instanceid $_inst && aws_wait_till_state_by_instanceid $_inst running && aws_get_publicip_by_instanceid $_inst) | tail -1
}
aws_stop_vm() {
    (_inst=`aws_get_instanceid_by_tag $@` && aws_stopinstance_by_instanceid $_inst && aws_wait_till_state_by_instanceid $_inst stopped) | tail -1
}

aws_get_instanceid_by_tag()
{
    aws ec2 describe-instances \
    --query "Reservations[].Instances[?KeyName==\`"$@"\`].InstanceId" \
    --output text
}

aws_get_state_by_instanceid()
{
    aws ec2 describe-instances --instance-ids $instance_id \
    --query 'Reservations[*].Instances[*].State.Name' \
    --output text
}
aws_get_state_by_tag()
{
    instance_id=$(aws_get_instanceid_by_tag $@)
    if [ -z $instance_id ]; then
        echo "Instance Not Found."
    else
        res=$(aws_get_state_by_instanceid $instance_id)
        echo $res
    fi
}

aws_startinstance_by_instanceid()
{
    aws ec2 start-instances --instance-id $@ \
    --query "StartingInstances[*].[InstanceId, ':', PreviousState.Name, ':', \
    CurrentState.Name]" \
    --output text
}
aws_startinstance_by_tag()
{
    instance_id=$(aws_get_instanceid_by_tag $@)
    if [ -z $instance_id ]; then
        echo "Instance Not Found."
    else
        res=$(aws_startinstance_by_instanceid $instance_id)
        echo $res
    fi
}

aws_stopinstance_by_instanceid()
{
    aws ec2 stop-instances --instance-id $@ \
    --query "StoppingInstances[*].[InstanceId, ':', PreviousState.Name, ':', \
    CurrentState.Name]" \
    --output text
}
aws_stopinstance_by_tag()
{
    instance_id=$(aws_get_instanceid_by_tag $@)
    if [ -z $instance_id ]; then
        echo "Instance Not Found. Tag : "$@
    else
        res=$(aws_stopinstance_by_instanceid $instance_id)
        echo $res
    fi
}

aws_get_publicip_by_instanceid()
{
    aws ec2 describe-instances --instance-ids $instance_id \
    --query 'Reservations[*].Instances[*].PublicIpAddress' \
    --output text
}
aws_get_publicip_by_tag()
{
    instance_id=$(aws_get_instanceid_by_tag $@)
    if [ -z $instance_id ]; then
        echo "Instance Not Found."
    else
        publicip=$(aws_get_publicip_by_instanceid $instance_id)
        if [ -z $publicip ]; then
            echo "Public Ip Not Found."
        else
            echo $publicip
        fi
    fi
}

aws_wait_till_state_by_instanceid()
{
    # $1 instanceid
    # $2 final state

    state=$(aws_get_state_by_instanceid $1)
    while [ $state != $2 ]; do
        sleep 2
        state=$(aws_get_state_by_instanceid $1)
    done
    echo $state
}
aws_wait_till_state_by_tag()
{
    instance_id=$(aws_get_instanceid_by_tag $1)
    if [ -z $instance_id ]; then
        echo "Instance Not Found."
    else
        state=$(aws_wait_till_state_by_instanceid $instance_id $2)
        echo $state
    fi
}


########### END AWS Helper Fns          ###########


########    BEGIN AST CONTROL FUCNTIONS    #########

# mount the AST sparse disk image
#located at /Volumes/AST_HAMMERHEAD.dmg{.sparseimage}
mount_hammerhead()
{
    hdiutil attach ~/Software/AST_HAMMERHEAD.dmg.sparseimage -mountpoint /Volumes/AST_HAMMERHEAD ;
}

# unmount AST sparse disk image
umount_hammerhead()
{
    umount /Volumes/AST_HAMMERHEAD
}

# resize to required size
resize_hammerhead()
{
    hdiutil resize -size $@ ~/Software/AST_HAMMERHEAD.dmg.sparseimage
}

########    END AST CONTROL FUCNTIONS    #########


# SETTING UP SPARK AND cd to root of porject.
spark-up()
{
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/vb/Software/AMD-SPARK/spark-1.3.0/my_samples/
	export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
}


############## END DEFINITION OF FUNCTIONS  #####################


################# VIM MODE ######################################
if [ $VIM_MODE_ON -eq 1 ]; then
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

fpath=(/usr/local/share/zsh-completions $fpath)
fi

################# END OFVIM MODE ################################
