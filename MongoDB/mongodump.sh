#要求给mongodb做数据库备份
#考虑使用全量、增量、差异备份三个脚本
#考虑限制进程数量--threads和时间--maxTimeMS，启用压缩选项--gzip，避免服务器崩溃
#使用脚本前考虑先在测试环境中试运行，确保脚本正确运行，并考虑先进行服务器快照降低服务器崩溃的后果
#备份前检查服务器资源
#备份中注意监控服务器硬件使用情况

export MongoServerIP="127.0.0.1"
export MongoServerPort=27017
export MongoServerDatabase="test"
export MongoServerBackupPath="/home/mongodb/backup"
export MongoServerUser="root"
export MongoServerPassword="123456"
export MongoServerAuthDatabase="admin"
export MongoServerBackupNumProcesses="4"
export MongoServerBackupMaxTimeMS="3600000"
export MongoServerBackupName="mongodb_backup_$(date +%Y%m%d%H%M%S)"


function MongoDump_Full() {
    # 全量备份指定数据库
    if ! mongodump \
    --host "$MongoServerIP" \
    --port "$MongoServerPort" \
    --db "$MongoServerDatabase" \
    --out "$MongoServerBackupPath" \
    --username "$MongoServerUser" \
    --password "$MongoServerPassword" \
    --authenticationDatabase "$MongoServerAuthDatabase" \
    --threads "$MongoServerBackupNumProcesses" \
    --maxTimeMS "$MongoServerBackupMaxTimeMS" \
    --gzip; then
    echo "MongoDump_Full ERROR"
fi
}

function MongoDump_Incremental(){
    # 增量备份指定数据库
    
}

function MongoDump_Differential(){
    #差异备份
    
}

function MongoDump_Check(){
    #检查服务器资源
    free -m
    ps -ef | grep mongod
}
