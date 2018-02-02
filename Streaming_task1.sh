STREAMING TASK 1:
---------------------

STREAM THE TWITTERSOURCE DATA IN THE FORM OF JSON FORMAT :
-------------------------------------------------------------

create "kalyan-TwitterSource-hdfs-mongodb-agent.conf" file with bellow content

agent.sources = TwitterSource
agent.channels = MemChannel1 MemChannel2
agent.sinks = HDFS MongoDB
 
agent.sources.TwitterSource.type = com.orienit.kalyan.flume.source.KalyanTwitterSourceSource
agent.sources.TwitterSource.channels = MemChannel1 MemChannel2
agent.sources.TwitterSource.consumerKey = ***************
agent.sources.TwitterSource.consumerSecret = ***************
agent.sources.TwitterSource.accessToken = ***************
agent.sources.TwitterSource.accessTokenSecret = ***************
agent.sources.TwitterSource.keywords = hadoop, big data, analytics, bigdata, cloudera, data science, data scientiest, business intelligence, mapreduce, data warehouse, data warehousing, mahout, hbase, nosql, newsql, businessintelligence, cloudcomputing
 
agent.sinks.HDFS.type = hdfs
agent.sinks.HDFS.channel = MemChannel1
agent.sinks.HDFS.hdfs.path = hdfs://localhost:8020/user/flume/tweets
agent.sinks.HDFS.hdfs.fileType = DataStream
agent.sinks.HDFS.hdfs.writeFormat = Text
agent.sinks.HDFS.hdfs.batchSize = 100
agent.sinks.HDFS.hdfs.rollSize = 0
agent.sinks.HDFS.hdfs.rollCount = 100
agent.sinks.HDFS.hdfs.useLocalTimeStamp = true

agent.sinks.MongoDB.type = com.orienit.kalyan.flume.sink.KalyanMongoSink
agent.sinks.MongoDB.hostNames = localhost
agent.sinks.MongoDB.database = flume
agent.sinks.MongoDB.collection = TwitterSource
agent.sinks.MongoDB.batchSize = 10
agent.sinks.MongoDB.channel = MemChannel2

agent.channels.MemChannel1.type = memory
agent.channels.MemChannel1.capacity = 1000
agent.channels.MemChannel1.transactionCapacity = 100

agent.channels.MemChannel2.type = memory
agent.channels.MemChannel2.capacity = 1000
agent.channels.MemChannel2.transactionCapacity = 100


copy "kalyan-TwitterSource-hdfs-mongodb-agent" file into "$FLUME_HOME/conf" folder

copy "kalyan-flume-project-0.1.jar" to $FLUME_HOME/lib folder

EXECUTE BELOW COMMAND

$FLUME_HOME/bin/flume-ng agent -n agent --conf $FLUME_HOME/conf-f $FLUME_HOME/conf/kalyan-TwitterSource-hdfs-mongodb-agent-conf -Dflume.root.logger=DEBUG,console


VERIFY IN HDFS

user/flume/twitterdata.json

http://localhost:50075/browseDirectory.jsp?dir=%2Fuser%2Fflume&namenodeInfoPort=50070&nnaddr=127.0.0.1:8020





DOING `SENTIMENT ANALYSIS` ON THAT DATA USING HIVE:
------------------------------------------------------


mkdir ~/sentimentanalysis

DOWNLOAD SAMPLE TWITTERDATA FROM HDFS COPY TO '~/SENTIMENTANALYSIS' FOLDER

cat ~/sentimentanalysis/twitterdata

 ------  DISPLAYING JSON DATA
 
 hadoop fs -mkdir -p /user/flume/sentimentanalysis/
 
 hadoop fs -put ~/sentimentanalysis/twitterdata.json /user/flume/sentimentanalysis/
 
---------DISPLAYING IN HDFS /USER/FLUME/SENTIMENTANALYSIS/TWITTERDATA.JSON


create external table kalyan.twitter1(json string)
row format serde 'org.apache.hive.hcatalog.data.JsonSerDe' stored as textfile;
location '/user/flume/sentimentanalysis';

SELECT * FROM kalyan.twitter1;


 ------  DISPLAYING DATA OF TWITTERDATA.JSON
 
 Download `sentimentanalysis-hive.jar` file and copy to '~/sentimentanalysis' folder
 jar download link:
 
  ----------LOAD THE `SENTIMENTANALYSIS-HIVE.JAR` INTO HDFS
 
 hadoop fs -put ~/sentimentanalysis/sentimentanalysis-hive.jar /user/flume/sentimentanalysis/
  
------------  VERIFY DATA IN HDFS /USER/FLUME/SENTIMENTANALYSIS/SENTIMENTANALYSIS-HIVE.JAR

IN HIVE

hive>ADD JAR hdfs://localhost:8020/user/flume/sentimentanalysis/sentimentanalysis-hive.jar;

create temporary function sentiment AS 'com.orienit.kalyan.sentimentanalysis.hive.udf.SentimentUdf'


create function kalyan.sentiment AS 'com.orienit.kalyan.sentimentanalysis.hive.udf.SentimentUdf' USING JAR 'hdfs://localhost:8020/user/flume/sentimentanalysis/sentimentanalysis-hive.jar';




show functions;

---------DISPLAY SENTIMENT FUN

DESCRIBE FUNCTION EXTENDED sentiment;

select json, sentiment(json) FROM kalyan.twitter1;

create table if not exists kalyan.sentimenttwitterdata (json string, sentiment int) LOCATION '/user/flume/sentimentanalysis/output';





create table if not exists kalyan.sentimenttwitterdata (json string, sentiment int) LOCATION '/user/flume/sentimentanalysis/output';

insert overwrite table kalyan.sentimenttwitterdata SELECT json, sentiment(json) FROM kalyan.twitter1;

SELECT json, sentiment FROM kalyan.sentimenttwitterdata;

SELECT json, 
case 
when sentiment = 1 then "positive" 
when sentiment = 0 then "neutral" 
when sentiment = -1 then "negative" 
end
FROM kalyan.sentimenttwitterdata;


