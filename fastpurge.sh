fastpurge_install_dir="fastpurge-cli"
case "$1" in

	help)
            echo "Usage: ./fastpurge.sh install/<cp-code>"
	    echo "eg. ./fastpurge.sh install OR ./fastpurge.sh 809166" 
            ;;

	install)
            if [ ! -d "$fastpurge_install_dir" ]
            then
                mkdir $fastpurge_install_dir
                cd $fastpurge_install_dir
                PATH=$PATH:.
                if [ ! -f akamai ]
                then
                wget https://github.com/akamai/cli/releases/download/1.1.2/akamai-1.1.2-linuxamd64
                if [ $? -ne 0 ]
                        then
                                echo "Unable to download akamai cli"
                        else
                                echo "Downloaded Akamai Cli from github"
                                mv akamai-1.1.2-linuxamd64 akamai
                                chmod a+x akamai
                                echo "Installing Akamai Purge"
                                akamai install purge
                        fi
                fi
	
             fi
	     ;;
	  ''|*[!0-9]*) 
		            echo "Usage: ./fastpurge.sh install"
            echo "OR"
            echo "       ./fastpurge.sh <cpcodenumber>"
		;;
 	   *)
        		cd $fastpurge_install_dir
        		PATH=$PATH:.
        		echo "Purging Cache for cpcode $1"
        		akamai purge --edgerc ./.edgerc --section default delete --production --cpcode $1
        		exit 0
             
esac
