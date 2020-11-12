#! /usr/bin/python3
import sys
import json 
import pandas as pd  
def main():
    df= pd.DataFrame()
    for line in sys.stdin:
        f= open(line.strip(),'r')
        x=json.load(f)
        entry = { "framework":x["framework"]}
        l=x["tests"][0]
        entry["language"]=l["default"]["language"]
        entry["alternative implementation"]="#".join(l.keys())

        df=df.append(entry,ignore_index=True)

        # for test ,l in x["tests"][0].items() : 
        #     entry = { }
        #     entry["test"] = test  
        #     entry["framework"] = l["framework"] if "framework" in l else None
        #     entry["classification"] = l["classification"] if "classification" in l else None
        #     entry["database"] = l["database"] if "database" in l else None
        #     entry["language"] = l["language"] if "language" in l else None
        #     entry["orm"] = l["orm"] if "orm" in l else None
        #     entry["webserver"] = l["webserver"] if "webserver" in l else None
        #     entry["display_name"] = l["display_name"] if "display_name" in l else None
        #     entry["platform"] = l["platform"] if "platform" in l else None
        #     df=df.append(entry,ignore_index=True)
        
    df.to_csv("metadata1.csv")
if __name__=="__main__":
    main()