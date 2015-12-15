#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Created on 2015年11月5日

@author: 0312birdzhang
'''
import time
import os
import threading
import sqlite3
import hashlib
from basedir import *
import datetime
import dbus

#/usr/share/lipstick/notificationcategories
bus = dbus.SessionBus()
object = bus.get_object('org.freedesktop.Notifications','/org/freedesktop/Notifications')
interface = dbus.Interface(object,'org.freedesktop.Notifications')
#print(interface.GetCapabilities())


__appName="harbour-9store"

DbPath=os.path.join(XDG_DATA_HOME, __appName,__appName, "QML","OfflineStorage","Databases")

##########################
#初始化sched模块的scheduler类
##########################
s = sched.scheduler(time.time,time.sleep)

#h = hashlib.new('days')
#dbname=h.hexdigest()
##########################
#调度函数定义
##########################

def getDbname():
    h = hashlib.md5()
    h.update("days".encode(encoding='utf_8', errors='strict'))
    dbname=h.hexdigest()
    return DbPath+"/"+dbname+".sqlite"


def parseTime(year,month,day):
    return datetime.datetime(year,month,day)

"""
提醒
"""
def notify(title):
    interface.Notify("9Store",
                 0,
                 "/usr/share/icons/hicolor/86x86/apps/harbour-9store.png",
                 str(title),
                 "9Store notification",
                 dbus.Array(),
                 dbus.Dictionary({"category":"x-nemo.messaging.9store",
				 "x-nemo-preview-body": "9Store notification",
                                  "x-nemo-preview-summary":str(title) },
                                  signature='sv'),
                 0)

def diffDays(date):
    now = datetime.datetime.now()
    diff = now - date
    days = diff.days
    if days > 0 and days < 2:
        return True
    else:
        return False
    
def getDatas():
    try:
        conn = sqlite3.connect(getDbname())
        cur = conn.cursor()
        cur.execute('SELECT * FROM day')
        for i in cur.fetchall():
            date = parseTime(int(i[3]),int(i[4]),int(i[5]))
            if diffDays(date):
                notify(i[1])
    except Exception as e:
        return
    conn.close()    

###############################################################
#定义执行函数，并通过enter函数加入调度事件
#enter四个参数分别为：间隔事件、优先级（用于同时间到达的两个事件同时执行时定序）,
#被调用触发的函数，给他的参数（注意：一定要以tuple给如，如果只有一个参数就(xx,)）
###############################################################

def perform(inc):
    """
    实现一天周期执行任务
    """
    s.enter(inc,0,perform,(inc,))
    getDatas()

#######################
#主函数入口
#######################
def mymain(inc=43200):
    """
    入口主函数
    """
    start = time.time()
    s.enter(1,1,perform,(inc,))                             #调度设置
    t=threading.Thread(target=s.run)                                        #通过构造函数例化线程
    t.start()                                                                                    #线程启动
    t.join()                                                                                     #阻塞线程

#########################
#测试代码
if __name__ == "__main__":
    mymain()
    

