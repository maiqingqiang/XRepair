@echo off 
title XRepair��Ϣ���д������(����ر�,�����޷�����ִ�ж�����Ϣ)
echo XRepair��Ϣ���д������(����ر�,�����޷�����ִ�ж�����Ϣ)...... 
php think queue:work --queue helloJobQueue --daemon
