#!/bin/bash

url="http://fanyi.youdao.com/openapi.do?keyfrom=quanwei9958&key=2020891949&type=data&doctype=text&version=1.0&q=%1"
answer=`curl -G --data-urlencode $@ ${url} 2>/dev/null | grep result`
answer=${answer#result=}
echo $answer
