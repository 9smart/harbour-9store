#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys,os
import subprocess
import urllib
import urllib.request
#import requests
import pyotherside
from basedir import *
import logging
from distutils.version import LooseVersion, StrictVersion
from rpms import *
from sysinfo import *
"""
//定义发送消息规则
//0,开始下载
//1,下载完成，开始安装
//2,安装完成
//3,升级成功
//4,卸载完成
//-1,安装失败

"""
target=HOME+"/Downloads/"
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

def install(rpmpath,rpmname,version):
    p = subprocess.call(["xdg-open "+rpmpath], shell=True)
    #0则安装成功
    logging.debug(p)
    print("installed,",rpmpath)
    if 0 == p:
        pyotherside.send("status","2",rpmname,version)
        return True
    else:
        pyotherside.send("status","-1",rpmname,version)
        return False


def unistall(rpmname,version):
    p = subprocess.Popen("pkcon remove "+rpmname,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #0则安装成功
    retval = p.wait()
    print("removed,",rpmname)
    pyotherside.send("status","4",rpmname,version)
    return p.returncode

def unistallpkg(rpmname):
    p = subprocess.Popen("pkcon remove "+rpmname,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #0则安装成功
    retval = p.wait()
    return p.returncode

def openApp(rpmname):
    p = subprocess.Popen("dbus-launch --exit-with-session "+rpmname,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #0则安装成功
    retval = p.wait()
    return p.returncode

def isopened(rpmname):
    p = subprocess.Popen(["ps -ef|grep "+rpmname+"|grep -v grep |wc -l"], shell=True, stdout=subprocess.PIPE).communicate()[0]
    p = p.decode('utf-8').strip("\n")
    if int(p) > 0:
        return "yes"
    else:
        return "no"

def newdownload(downurl,rpmname,version):
    downname=rpmname+"-"+version+"."+getSysinfo().get("cpuModel")+".rpm";
    if os.path.exists(downname):
        #判断是否下载完
        content_length = GetUrlFileSize(downurl)
        localfile_length = os.path.getsize(downname)
        if content_length != 0 and int(content_length) == (localfile_length):
            #给一种下载的感觉
            pyotherside.send("progress",rpmname,20)
            pyotherside.send("progress",rpmname,50)
            pyotherside.send("progress",rpmname,100)
        else:
            #urllib.request.urlretrieve(downurl,target+downname, schedule)
            multidownload(downurl,downname,target+downname)
    else:
        #urllib.request.urlretrieve(downurl,target+downname, schedule)
        multidownload(downurl,downname,target+downname)
    install(target+downname,rpmname,version)

def multidownload(url,name,output):
    paxel( url, name,output, blocks=4 )

#显示下载进度
def schedule(a,b,c):
    """
    a:已经下载的数据块
    b:数据块的大小
    c:远程文件的大小
    """
    per = 100.0 * a * b / c
    if per > 100 :
        per = 100
    #print('%.2f%%' % per)
    pyotherside.send("progress",rpmname,per)


def versionCompare(rpmname,versioncode):
    dic = getAppinfo(rpmname)
    print("dic:",dic)
    if not dic.get("Name"):
        return "Install"
    tmpname = (dic.get("Name"),dic.get("Version"),dic.get("Release"))
    installedName = "-".join(tmpname)
    logging.debug("installed:"+installedName)
    serverName = rpmname+"-"+versioncode
    try:
        if LooseVersion(installedName) == LooseVersion(serverName):
            return "Uninstall"
        elif LooseVersion(installedName) < LooseVersion(serverName):
            return "Upgrade"
        else:
            return "Uninstall"
    except:
        if installedName == serverName:
            return "Uninstall"
        elif installedName < serverName:
            return "Upgrade"
        else:
            return "Uninstall"

def GetUrlFileSize(url):
    urlHandler = urllib.request.urlopen(url)
    headers = urlHandler.headers
    length = 0
    for header in headers:
        if header.find('Length') != -1:
            length = headers["content-length"]
            length = int(length)
    return length
