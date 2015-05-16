#!/bin/bash
databasepath='/home/yonhom/sqlite/dict'
sqlite3 $databasepath "create table if not exists dict (key text,value text,time int default 1,createtime datetime);"
value=`sqlite3 $databasepath "select value from dict where key='$@'"`
if [ $value ]; then
    echo $value
    sqlite3 $databasepath "update dict set time=(select time from dict where key='$@')+1 where key='$@'" &
else
    url="http://fanyi.youdao.com/openapi.do?keyfrom=quanwei9958&key=2020891949&type=data&doctype=text&version=1.0&q=%1"
    answer=`curl -G --data-urlencode $@ ${url} 2>/dev/null|grep result`
    answer=${answer#result=}
    echo $answer
    time=`date`
    sqlite3 $databasepath "insert into dict(key,value,createtime) values('$@','$answer','$time')" &
fi
