@echo off 
title XRepair消息队列处理程序(请勿关闭,否则无法正常执行队列消息)
echo XRepair消息队列处理程序(请勿关闭,否则无法正常执行队列消息)...... 
php think queue:work --queue helloJobQueue --daemon
