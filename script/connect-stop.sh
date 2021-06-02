SIGNAL=${SIGNAL:-TERM}
PIDS=$(ps ax | grep -i 'cli\.ConnectDistributed' | grep java | grep -v grep | awk '{print $1}')

if [ -z "$PIDS" ]; then
  echo "No connect distributed to stop"
  exit 1
else
  kill -s $SIGNAL $PIDS
fi

