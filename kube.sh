#!/bin/bash
crashpod=kubectl get pods --field-selector=status.phase=CrashLoopBackoff 
echo 'crashpod'

restartpod=kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
echo 'restartpod'

runpod=kubectl top pod POD_NAME --sort-by=cpu
echo 'runpod'

rpod=kubectl get pods --field-selector=status.phase=Running --sort-by=cpu
echo 'rpod'
