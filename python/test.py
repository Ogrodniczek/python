import os
import xml.dom.minidom
import xml.etree.ElementTree as ET

def main():
        parsed = xml.dom.minidom.parse('xmle/atryb.xml')
        tree = ET.ElementTree(file='xmle/atryb.xml')
        tree.getroot()
        root = tree.getroot()
        for child in root:
            if child == 'c':
                print ('abc')
            else:
                print ('cccc')
       
if __name__ == '__main__':
    main()
