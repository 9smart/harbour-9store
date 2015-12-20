import subprocess
import datetime
import logging

app_dic={}
ver_dic ={}


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
    logging.debug(type(appname))
    #p = subprocess.getoutput("rpm -qi "+appname)
    p = subprocess.Popen(["rpm -qi "+appname], shell=True, stdout=subprocess.PIPE).communicate()[0]
    infoList = p.decode('utf-8').split("\n")
    return parseInfo(infoList)


def parseInfo(infoList):
    ver_dic.clear()
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
