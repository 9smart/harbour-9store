#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Created on 2015年12月16日

@author: 0312birdzhang
'''
import platform

def getSysinfo():
    phoneName = platform.uname().node
    osType = platform.uname().system
    cpuModel = platform.uname().processor
    return {
                "phoneName":phoneName,
                "osType" :osType,
                "cpuModel":cpuModel
                }
