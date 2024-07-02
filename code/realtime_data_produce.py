import json
import datetime
import random
import boto3

sessioncred = boto3.Session()
credentials = sessioncred.get_credentials()

session=boto3.Session(aws_access_key_id=credentials.access_key,aws_secret_access_key=credentials.secret_key, region_name='us-east-2')

client = session.client('kinesis')


def getData(dataName, lowVal, highVal):
   data = {}
   data["datasetName"] = dataName
   data["datasetValue"] = random.randint(lowVal, highVal) 
   return data

temp=0;

while temp<1000:
   rnd = random.random()
   if (rnd < 0.01):
      data = json.dumps(getData("DemoData", 100, 120))  
      client.put_record(StreamName="realtime_data_stream", Data=data, PartitionKey="1")
      print('*************************** anomaly *********************** ' + data)
   else:
      data = json.dumps(getData("DemoData", 10, 20))  
      client.put_record(StreamName="realtime_data_stream", Data=data, PartitionKey="1")
      print(data)
   temp=temp+1
