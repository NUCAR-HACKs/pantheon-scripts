import collections
import json
import sys

def parse_json(data):
    ret = {}
    interfaces = json.load(data)['lldp']['interface']
    for interface in interfaces:
        name = interface.keys()[0]
        mac = interface[name]['port']['id']['value']
        ret[name] = mac
    return ret

if __name__ == '__main__':
    for interface, mac in parse_json(sys.stdin).items():
        print interface, mac
