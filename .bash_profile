
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/amiteinav/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/amiteinav/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/amiteinav/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/amiteinav/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export JAVA_HOME=$(/usr/libexec/java_home)
export PROJECT_ID=amiteinav-sandbox
export DEVSHELL_PROJECT_ID=${PROJECT_ID}

alias lslrth="ls -hrtal"
alias list-instances='gcloud compute instances list'

export MYIP=`curl http://ip4.me/ -s | grep Monospace | awk -F"3>" '{print $2}' | awk -F"<" '{print $1}'`
export PATH=/var/root/Library/Python/2.7/bin:$PATH:/Users/amiteinav/Library/Python/2.7/bin:/Users/amiteinav/istio-0.5.1/bin:/Users/amiteinav/Documents/GitHub

export GIT=/Users/amiteinav/Documents/GitHub

#gcloud config configurations activate default