#!/bin/bash  
#author         : darkhex
#version        : 0.1
#usage          : chmod +x && ./.sh
#OS             : OSX 10.10.5, bash 4.3
#description    : Script should help to manage docker images
#============================================================================
boot2docker start && eval "$(boot2docker shellinit)"

#for test
#script=`basename $0` 
#cp $script /usr/local/bin
while true; do
echo """Please, choose a task:
b) build_docker
s) search_docker
h) print_help
r) run_docker
save) save_docker
e) enter_docker
log) history docker's images
q) exit"""
read MENUENTRY
case $MENUENTRY in
b) build_docker(){
docker images
echo "Please choose direcory with config"
read config_build_docker
echo "Please create a name for new docker"
read config_name_docker
echo "Please create a tag for new Docker"
read tag
docker build -t "$config_name_docker:$tag" $config_build_docker
docker push $config_name_docker
echo "Create $config_name_docker success" || echo "Error"
}
build_docker
;;
s) search_docker() {
echo "You choose search docker images"
read docker_search_name
docker search $docker_search_name
echo "Download latest version?"
read -r -p "Are you sure? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    docker pull $docker_search_name:latest && echo "Success" && docker images 
else
    docker search $docker_search_name
fi
}
search_docker
;;
h) echo "You choose help"
    print_help() {
    echo "Usage: docker-bash <CONTAINER_ID> [COMMAND...]"

    echo
    echo "Usage: $ME [OPTION...]"
    echo
    echo "Options:"
    echo "         -s     Save"
    echo "         -b     build"
    echo "         -b build_docker"
    echo   "        -s search_docker"
    echo   "        -h    print_help"
    echo   "        -r   run_docker"
    echo   "         -s   save_docker"
    echo   "        -e   enter_docker"
    echo   "        - log history docker images"
} 
print_help    
;;
r) echo "You choose run docker"
run_docker(){
docker images
echo "Please select image"
read run_docker
docker run -ti $run_docker /bin/bash
}
;;
save) echo "You choose save docker"
save_docker(){
echo "What's CONTAINER will be save?"
read docker_save_container
save  $docker_save_container    
}
save_docker
;;
d) echo "You choose remove docker"
docker images | awk {'print $1'}
echo "What's CONTAINER will be to removed?"
read docker_removed
remove_docker(){
#remove
docker rmi $docker_removed
#docker rmi $(docker images | grep -v 'ubuntu\|my-image' | awk {'print $3'}) | tee /tmp/$img.logs_docker
}
;;
log) echo "Do you want to see logs of the container?"
echo "LOGGING AND HISTORY"
echo "Running images:"
docker ps 
#last 3 commands
echo "last commands"
docker ps -a | head -n4
#run additional
#docker ps -a | head -n2 | awk '{print $1}'| grep -v CONTAINER | tee lol | xargs docker logs $lol
#top
docker images | awk {'print $1'}
docker top 
;;
q) echo "Good luck!" 
exit 0
;;
*) echo "Wrong option";
echo "For help, use: h";
;;
esac
done
exit 0