# -*- coding: utf-8 -*-

import os
import sqlite3
import hashlib
from basedir import *
import datetime
import dbus
import json
import urllib.request,urllib.error,urllib.parse
#from basedir import XDG_DATA_HOME

#/usr/share/lipstick/notificationcategories
bus = dbus.SessionBus()
noobject = bus.get_object('org.freedesktop.Notifications','/org/freedesktop/Notifications')
interface = dbus.Interface(noobject,'org.freedesktop.Notifications')
#print(interface.GetCapabilities())
XDG_DATA_HOME="/home/nemo/.local/share"
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
notify_interface.Notify(self.app_name, 1, self.icon, self.summary, self.body,
                                    self.actions, self.hints, self.timeout)
"""
def notify(title):
    interface.Notify("9Store",
                 0,
                 "/usr/share/icons/hicolor/86x86/apps/harbour-9store.png",
                 str(title),
                 "9Store notification",
                 ["x-nemo-remote-action-harbour-9store"],
                 dbus.Dictionary({
                                     "desktop-entry":"harbour-9store.desktop",
                                     "x-nemo-preview-body": "9Store notification",
                                     "x-nemo-preview-summary":str(title) },
                                      signature='sv'),
                                      3600)

def getAuth():
    try:
        conn = sqlite3.connect(getDbname())
        cur = conn.cursor()
        cur.execute('SELECT * FROM LoginData')
        datas= cur.fetchone()[0]
        if not datas:
            return ""
        res = json.loads(datas)
        return res.get("user").get("auth")
    except Exception as e:
        return ""
    conn.close()

def saveNotifications(notice_list):
    try:
        conn = sqlite3.connect(getDbname())
        cur = conn.cursor()
        cur.execute('''CREATE TABLE IF NOT EXISTS NotificationData
                 (id VARCHAR(60) PRIMARY KEY, json text,status INTEGER DEFAULT 0) ''')
        sql = "insert OR IGNORE into NotificationData(id,json) values ('%s','%s')  "
        for i in notice_list:
            cur.execute(sql % (i["_id"],json.dumps(i)))
        conn.commit()
    except Exception as e:
        print(e)
    conn.close()

def query(url):
    headers = ("Referer","http://www.9smart.cn/")
    data = ""
    try:
        req = urllib.request.Request(url)
        response = urllib.request.urlopen(req)
        return response.read()
    except urllib.error.HTTPError as e:
        pass
    return data


def loadNotification(auth):
    url = api(auth)
    data = query(url)
    if not data:
        return
    jsondata = json.loads(data.decode('utf-8'))
    if jsondata["error"] == 0:
        notice_num = len(jsondata["notices"])
        if notice_num > 0:
            #保存到数据库
            saveNotifications(jsondata["notices"])
            notify("您有{0}条新消息".format(notice_num))
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
