action=$1
process="kafka.connect.cli.ConnectDistributed"
scriptName="kafka-connect.sh"
result=`ps -ef | grep "$process" | grep -v "$scriptName" | grep -v grep`
base_dir=$(dirname $0)

case $action in
    "start")
        if [ -z "$result" ]
        then
            echo "Starting Kafka connect distributed..."            
            nohup $base_dir/connect-distributed.sh $base_dir/../config/connect-distributed.properties > $base_dir/../logs/kafka-connect.log 2>&1 &
        else
            echo "Kafka connect distributed is already running."
            echo "$result"
        fi
        ;;
    "stop")
        if [ -z "$result" ]
        then
            echo "Kafka connect distributed is not running."
        else
            echo "Stopping Kafka connect distributed..."
            # echo "$result"
            ps -ef | grep "$process" | grep -v "$scriptName" | grep -v grep | awk '{print $2}' | xargs kill
        fi
        ;;
    "status")
        if [ -z "$result" ]
        then
            echo "Kafka connect distributed is not running."
        else
            echo "Kafka connect distributed is running."
            # echo "$result"
        fi
        ;;
    *)
        echo "Usage: $base_dir/$scriptName <start|stop|status>"
        ;;
esac