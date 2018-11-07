#!/usr/bin/env python

"""
$Id: $

     /$$$$$$            /$$       /$$                     /$$$$$$$$                    
    /$$__  $$          | $$      | $$                    | $$_____/                    
   | $$  \__/  /$$$$$$ | $$  /$$$$$$$  /$$$$$$  /$$$$$$$ | $$       /$$   /$$  /$$$$$$ 
   | $$ /$$$$ /$$__  $$| $$ /$$__  $$ /$$__  $$| $$__  $$| $$$$$   | $$  | $$ /$$__  $$
   | $$|_  $$| $$  \ $$| $$| $$  | $$| $$$$$$$$| $$  \ $$| $$__/   | $$  | $$| $$$$$$$$
   | $$  \ $$| $$  | $$| $$| $$  | $$| $$_____/| $$  | $$| $$      | $$  | $$| $$_____/
   |  $$$$$$/|  $$$$$$/| $$|  $$$$$$$|  $$$$$$$| $$  | $$| $$$$$$$$|  $$$$$$$|  $$$$$$$
    \______/  \______/ |__/ \_______/ \_______/|__/  |__/|________/ \____  $$ \_______/
                                                                     /$$  | $$          
                                                                    |  $$$$$$/          
                                                                     \______/           
                                                                                                                                                                                                      


Web Server Sunucularýna Http Vurur.

This tool is meant for research purposes only
and any malicious usage of this tool is prohibited.

@author Jan Seidl <http://wroot.org/>

@date 2014-02-18
@version 2.1

@TODO Test in python 3.x

LICENSE:
This software is distributed under the GNU General Public License version 3 (GPLv3)

LEGAL NOTICE:
THIS SOFTWARE IS PROVIDED FOR EDUCATIONAL USE ONLY!
IF YOU ENGAGE IN ANY ILLEGAL ACTIVITY
THE AUTHOR DOES NOT TAKE ANY RESPONSIBILITY FOR IT.
BY USING THIS SOFTWARE YOU AGREE WITH THESE TERMS.
"""

from multiprocessing import Process, Manager, Pool
import urlparse, ssl
import sys, getopt, random, time, os

# Python version-specific 
if  sys.version_info < (3,0):
    # Python 2.x
    import httplib
    HTTPSCLIENT = httpslib
else:
    # Python 3.x
    import http.client
    HTTPSCLIENT = https.client

####
# Config
####
DEBUG = False
SSLVERIFY = True

####
# Constants
####
METHOD_GET  = 'get'
METHOD_POST = 'post'
METHOD_RAND = 'random'

JOIN_TIMEOUT=1.0

DEFAULT_WORKERS=10
DEFAULT_SOCKETS=500000

AKINCI_BANNER = 'AKINCI v2.1 by Akýncý <akýncý@gmail.com>'