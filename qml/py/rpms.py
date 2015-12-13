#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
import datetime

app_dic={}



def getInstalled():
    app_list_tmp = subprocess.getoutput('rpm -qa').split("\n")
    for i in app_list_tmp:
        getAppinfo(i)


#根据传入的app名列表查询
def getListAppinfo(apps):
    app_dic.clear()
    for i in apps:
        getAppinfo(i)
    return app_dic

def getAppinfo(appname):
    p = subprocess.getoutput("rpm -qi  %s" % (appname,))
    infoList = p.split("\n")
    info = parseInfo(infoList)
    app_dic[info.get("Name")] = info

def parseInfo(infoList):
    ver_dic ={}
    for i in infoList:
        if i.startswith("Name"):
            ver_dic["Name"] = i.strip("Name").lstrip().lstrip(":").lstrip(" ").rstrip("\n")
        elif i.startswith("Version"):
            ver_dic["Version"] = i.strip("Version").lstrip().lstrip(":").lstrip(" ").rstrip("\n")
        elif i.startswith("Release"):
            ver_dic["Release"] = i.strip("Release").lstrip().lstrip(":").lstrip(" ").rstrip("\n")
        elif i.startswith("Architecture"):
            ver_dic["Architecture"] = i.strip("Architecture").lstrip().lstrip(":").lstrip(" ").rstrip("\n")
    return ver_dic
