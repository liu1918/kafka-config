action=$1
process="kafka.Kafka"
scriptName="kafka-server.sh"
result=`ps -ef | grep "$process" | grep -v "$scriptName" | grep -v grep`
base_dir=$(dirname $0)

case $action in
    "start")
        if [ -z "$result" ]
        then
            echo "Starting Kafka server..."            
            nohup $base_dir/kafka-server-start.sh $base_dir/../config/server.properties > /dev/null 2>&1 &
        else
            echo "Kafka server is already running."
            echo "$result"
        fi
        ;;
    "stop")
        if [ -z "$result" ]
        then
            echo "Kafka server is not running."
        else
            echo "Stopping Kafka server..."
            # echo "$result"
            $base_dir/kafka-server-stop.sh
        fi
        ;;
    "status")
        if [ -z "$result" ]
        then
            echo "Kafka server is not running."
        else
            echo "Kafka server is running."
            # echo "$result"
        fi
        ;;
    *)
        echo "Usage: $base_dir/$scriptName <start|stop|status>"
        ;;
esac