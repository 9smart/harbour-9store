#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Created on 2015年12月15日

@author: zhangdebo
'''
import os
import sqlite3
import hashlib
from basedir import *
import datetime
import dbus
import json
import urllib.request,urllib.error,urllib.parse
from basedir import XDG_DATA_HOME

#/usr/share/lipstick/notificationcategories
bus = dbus.SessionBus()
noobject = bus.get_object('org.freedesktop.Notifications','/org/freedesktop/Notifications')
interface = dbus.Interface(noobject,'org.freedesktop.Notifications')
#print(interface.GetCapabilities())

__appName="harbour-9store"

DbPath=os.path.join(XDG_DATA_HOME, __appName,__appName, "QML","OfflineStorage","Databases","")

def getDbname():
    h = hashlib.md5()
    h.update("9store".encode(encoding='utf-8', errors='strict'))
    dbname=h.hexdigest()
    return DbPath+dbname+".sqlite"


def parseTime(year,month,day):
    return datetime.datetime(year,month,day)

"""
提醒
notify_interface.Notify(self.app_name, 1, self.icon, self.summary, self.body,
                                    self.actions, self.hints, self.timeout)
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


def getAuth():
    print("dbname:",getDbname())
    try:
        conn = sqlite3.connect(getDbname())
        cur = conn.cursor()
        cur.execute('SELECT * FROM LoginData')
        datas= cur.fetchone()[0]
        if not datas:
            return ""
        res = json.loads(datas)
        print("datas:",type(datas))
        print(res.get("user").get("auth"))
        return res.get("user").get("auth")
    except Exception as e:
        print(e)
        return ""
    conn.close()

def query(url):
    headers = ("Referer","http://www.9smart.cn/")
    data = ""
    try:
        req = urllib.request.Request(url)
        response = urllib.request.urlopen(req)
        return response.read()
    except urllib.error.HTTPError as e:
        print("error:",e)
        pass
    return data


"""
    {
        error:0,
        notices:[通知列表],
        pager:{分页信息}
    }
"""
def loadNotification(auth):
    url = api(auth)
    print("url:",url)
    data = query(url)
    if not data:
        return
    jsondata = json.load(data)
    if jsondata.error == 0:
        notice_num = len(jsondata.notices)
        notify("您有{0}条消息".format(notice_num))
    else:
        pass



def  api(auth):
    return "http://api.9smart.cn/notices?auth={0} ".format(auth)


def mymain():
    auth = getAuth()
    if len(auth) < 2:
        return
    loadNotification(auth)

#测试代码

if __name__ == "__main__":
    mymain()
