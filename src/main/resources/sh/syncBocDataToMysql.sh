basepath=$(cd `dirname $0`; pwd)
echo $basepath
kjbpath=$(cd `dirname $0`; pwd)/Templates/programsSqlServer/syncBocDataToMysql.kjb
echo $kjbpath
logpath=$(cd `dirname $0`; pwd)/logs/syncBocDataToMysql`date '+%Y%m%d%H%M%S'`.log
echo $logpath
$basepath/kitchen.sh -file:$kjbpath -level:Basic > $logpath
